"""Tests for PS/PL register-style communication without real hardware.

This file uses simple fakes instead of a Red Pitaya to illustrate how CSR
helpers shuttle data between the processing system (PS) and programmable logic
(PL). Each test emits prints to spell out the path a value takes so test output
can be read as a mini walkthrough.
"""

import sys
from pathlib import Path

import importlib_metadata
import pytest

PROJECT_ROOT = Path(__file__).resolve().parents[1]
sys.path.append(str(PROJECT_ROOT / "linien-server"))

importlib_metadata.version = lambda _name: "0.0.test"  # type: ignore[assignment]

from linien_server.csr import PythonCSR
from linien_server.registers import Registers


class FakeRP:
    """Minimal Red Pitaya stub that stores words in an in-memory map."""

    def __init__(self):
        self.memory: dict[int, int] = {}

    def write(self, addr: int, value: int) -> None:
        self.memory[addr] = value

    def read(self, addr: int) -> int:
        return self.memory.get(addr, 0)


class FakeAcquisition:
    """Acquisition stub exposing CSR accessors backed by ``FakeRP``."""

    def __init__(self, rp: FakeRP | None = None) -> None:
        self.rp = rp or FakeRP()
        self.csr = PythonCSR(self.rp)

    def exposed_set_csr(self, key: str, value: int) -> None:
        self.csr.set(key, value)

    def exposed_get_csr(self, key: str) -> int:
        return self.csr.get(key)


def make_registers(acquisition: FakeAcquisition) -> Registers:
    """Create a ``Registers`` instance that only uses CSR helpers.

    The real constructor wires callbacks and RPyC connections; for these
    unit tests we only need the CSR helpers, so we bypass ``__init__`` and
    inject the fake acquisition object directly.
    """

    registers = object.__new__(Registers)
    registers.acquisition = acquisition
    return registers


@pytest.fixture()
def fake_stack():
    rp = FakeRP()
    acquisition = FakeAcquisition(rp)
    return rp, acquisition, make_registers(acquisition)


def write_pl_side_value(rp: FakeRP, csr: PythonCSR, name: str, value: int) -> None:
    """Simulate PL logic writing to a read-only CSR via raw addresses."""

    map_idx, addr, width, _wr = csr.map[name]
    base_addr = csr.offset + (map_idx << 11) + (addr << 2)
    byte_len = (width + 7) // 8

    for i in range(byte_len):
        shift = 8 * (byte_len - i - 1)
        rp.write(base_addr + (i << 2), (value >> shift) & 0xFF)


def test_scan_tracker_status_reads_pl_values_without_hardware(fake_stack):
    """Show that PL-written CSRs can be observed from the PS side."""

    rp, _acquisition, registers = fake_stack

    write_pl_side_value(rp, registers.acquisition.csr, "scan_tracker_fsm_state", 0x2)
    write_pl_side_value(
        rp, registers.acquisition.csr, "scan_tracker_time_command_out", 0x1A5
    )

    print("PL wrote fsm_state=0x2 and time_command_out=0x1A5 via raw CSR writes")

    status = registers.read_scan_tracker_status()
    print(
        "PS read scan tracker status -> fsm_state=0x%(fsm_state)x, time_command_out=0x%(time_command_out)x"
        % status
    )

    assert status["fsm_state"] == 0x2
    assert status["time_command_out"] == 0x1A5


def test_ps_writes_visible_in_fake_pl_memory(fake_stack):
    """Demonstrate that PS CSR writes update the fake PL memory map."""

    rp, _acquisition, registers = fake_stack

    print("PS writes logic_sweep_run=1 through Registers helper")
    registers.write_csr("logic_sweep_run", 1)

    map_idx, addr, _width, _wr = registers.acquisition.csr.map["logic_sweep_run"]
    base_addr = registers.acquisition.csr.offset + (map_idx << 11) + (addr << 2)

    pl_value = rp.read(base_addr)
    ps_echo = registers.read_csr("logic_sweep_run")
    print(f"PL memory now stores {pl_value} at base address 0x{base_addr:x}")
    print(f"PS re-reads CSR and sees {ps_echo}")

    assert pl_value == 1
    assert ps_echo == 1


def test_kalman_roundtrip_from_pl_to_ps_and_back(fake_stack):
    """Exercise a PL→PS→PL loop using the Kalman target CSRs.

    The fake PL first writes raw error/power samples into the error calculator
    CSRs. The PS reads those samples, runs a tiny Kalman-style update locally,
    then writes the resulting targets back into the Kalman target CSR bank. The
    final assertions look directly at the fake PL memory to confirm that the
    PS writes landed where the PL would read them.
    """

    rp, _acquisition, registers = fake_stack

    # 1) PL produces an error measurement and drops it into the error calculator
    #    CSR bank, mimicking "err_calc" hardware feeding the Kalman filter.
    write_pl_side_value(rp, registers.acquisition.csr, "err_calc_error_signal", 0x15)
    print("PL wrote err_calc_error_signal=0x15")

    # 2) PS samples that CSR just like the tracker service would.
    error_sample = registers.read_error_signal()
    print(f"PS sampled error={error_sample}")

    # 3) PL produces the matching power measurement next. We write this after
    #    reading the error to avoid the overlapping CSR bytes that the map uses
    #    for these two signals.
    write_pl_side_value(rp, registers.acquisition.csr, "err_calc_power_signal", 0x40)
    power_sample = registers.read_power_signal()
    print(f"PL wrote err_calc_power_signal=0x40, PS read power={power_sample}")

    # 4) Run a toy Kalman step: update mean with a simple gain and derive a
    #    power threshold. This stands in for the real tracker math while keeping
    #    the test deterministic and hardware free.
    kalman_gain = 0.25
    prior_mean = 0x100
    posterior_mean = prior_mean + kalman_gain * (error_sample - prior_mean)
    power_threshold = power_sample + 5

    x_target = int(round(posterior_mean))
    f_target = x_target + 2  # arbitrary offset to show multiple channels
    time_uncertainty = 3
    print(
        "PS Kalman step -> x_target=%#x, f_target=%#x, time_uncertainty=%d, power_threshold=%d"
        % (x_target, f_target, time_uncertainty, power_threshold)
    )

    # 5) PS pushes the computed setpoints back into the PL via the Kalman target
    #    CSRs one by one. We read each back immediately because successive writes
    #    reuse overlapping CSR byte lanes in this minimal map.
    def read_pl_word(csr_name: str) -> int:
        map_idx, addr, width, _wr = registers.acquisition.csr.map[csr_name]
        base_addr = registers.acquisition.csr.offset + (map_idx << 11) + (addr << 2)
        byte_len = (width + 7) // 8

        value = 0
        for i in range(byte_len):
            value |= rp.read(base_addr + (i << 2)) << 8 * (byte_len - i - 1)
        return value

    for csr_name, value in (
        ("kalman_targets_x_target_cmd", x_target),
        ("kalman_targets_f_target_cmd", f_target),
        ("kalman_targets_t_target_cmd", time_uncertainty),
        ("kalman_targets_power_threshold_target_cmd", power_threshold),
    ):
        registers.write_csr(csr_name, value)
        ps_echo = registers.read_csr(csr_name)
        pl_echo = read_pl_word(csr_name)
        print(f"PS wrote {csr_name}={value}, PS reads back {ps_echo}, PL mirror sees {pl_echo}")
        assert ps_echo == value
        assert pl_echo == value