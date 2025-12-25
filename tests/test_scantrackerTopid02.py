import pytest
import numpy as np
import matplotlib
matplotlib.use("Agg")   # ★ pytest/无GUI环境用 Agg，避免 plt.show() 卡住
import matplotlib.pyplot as plt

migen = pytest.importorskip("migen")
from migen import Module, Signal, If, Mux
from migen.sim import run_simulation
from misoc.interconnect.csr import AutoCSR, CSRStatus, CSRStorage

from gateware.logic.scan_tracking import ScanTrackingController
from gateware.logic.KalmanTargets import KalmanTargets
from gateware.logic.pid import PID


class DummyErrCalc(Module, AutoCSR):
    def __init__(self, width=25):
        self.power_reg = Signal(width)
        self.csr_power_signal = CSRStatus(width, name="power_signal")
        self.sync += self.csr_power_signal.status.eq(self.power_reg)


class SimpleLogic(Module, AutoCSR):
    def __init__(self, signal_width=25):
        self.pid_only_mode = CSRStorage(1, name="pid_only_mode")
        self.submodules.pid = PID(width=signal_width)


class DUT(Module):
    def __init__(self, width=14, signal_width=25):
        self.width = width
        self.signal_width = signal_width
        self.s = signal_width - width

        self.submodules.kalman_targets = KalmanTargets(width=signal_width)
        self.submodules.err_calc = DummyErrCalc(width=signal_width)
        self.submodules.scan_tracker = ScanTrackingController(width=signal_width)
        self.submodules.logic = SimpleLogic(signal_width=signal_width)

        self.dac_a = Signal((width, True))

        self.comb += [
            self.scan_tracker.kalman_est_time.eq(self.kalman_targets.x_target_cmd.storage),
            self.scan_tracker.kalman_est_uncertainty.eq(self.kalman_targets.t_target_cmd.storage),
            self.scan_tracker.power_level.eq(self.err_calc.csr_power_signal.status),
            self.scan_tracker.power_threshold_acquire.eq(self.kalman_targets.power_threshold_target_cmd.storage),
        ]

        self.comb += self.logic.pid.running.eq(1)

        pid_out_to_dac_domain = Signal((width, True))
        self.comb += [
            If(
                self.logic.pid_only_mode.storage,
                self.logic.pid.input.eq(self.scan_tracker.time_command_out << self.s),
            ).Else(
                self.logic.pid.input.eq(0)
            ),
            pid_out_to_dac_domain.eq(self.logic.pid.pid_out >> self.s),
        ]

        # 软件限幅模拟 limit_fast1
        max_dac = (1 << (width - 1)) - 1
        min_dac = - (1 << (width - 1))
        self.comb += self.dac_a.eq(
            Mux(pid_out_to_dac_domain > max_dac, max_dac,
                Mux(pid_out_to_dac_domain < min_dac, min_dac,
                    pid_out_to_dac_domain))
        )


@pytest.mark.slow
def test_scantracker_pid_to_dac_closed_loop_plot(verbose=True):
    width = 14
    signal_width = 25
    dut = DUT(width=width, signal_width=signal_width)

    plant_gain = 0.05
    residual0 = 6000.0

    KP_UNITY = 1 << 12
    KI = 0
    KD = 0

    # ====== ★ 记录数组（放在 tb 外层，仿真后可访问）======
    rec_k = []
    rec_residual = []
    rec_dac = []
    rec_timecmd = []
    rec_fsm = []
    rec_xcmd = []

    def tb(d):
        # 1) 让 scan_tracker 快速进入 LOCKED
        yield d.kalman_targets.power_threshold_target_cmd.storage.eq(1000)
        yield d.err_calc.power_reg.eq(2000)
        yield d.kalman_targets.t_target_cmd.storage.eq(100)

        # 2) PID配置
        yield d.logic.pid_only_mode.storage.eq(1)
        yield d.logic.pid.setpoint.storage.eq(0)
        yield d.logic.pid.kp.storage.eq(KP_UNITY)
        yield d.logic.pid.ki.storage.eq(KI)
        yield d.logic.pid.kd.storage.eq(KD)

        yield d.logic.pid.reset.storage.eq(1)
        yield
        yield d.logic.pid.reset.storage.eq(0)

        if verbose:
            print("=== PID test start ===")
            print(f"PID cfg: setpoint=0, kp={KP_UNITY}, ki={KI}, kd={KD}")
            print(f"plant_gain={plant_gain}, initial residual={residual0}")

        residual = residual0
        locked_first_k = None

        for k in range(250):
            x_cmd = int(round(residual))
            yield d.kalman_targets.x_target_cmd.storage.eq(x_cmd)
            yield  # 推进 1 拍

            fsm = (yield d.scan_tracker.fsm_state_status.status)
            time_cmd = (yield d.scan_tracker.time_command_out_status.status)
            dac = (yield d.dac_a)

            # 只在 LOCKED 才闭环更新 residual
            if fsm == 2:
                if locked_first_k is None:
                    locked_first_k = k
                residual = residual - plant_gain * float(dac)

            # ★ 记录
            rec_k.append(k)
            rec_residual.append(residual)
            rec_dac.append(dac)
            rec_timecmd.append(time_cmd)
            rec_fsm.append(fsm)
            rec_xcmd.append(x_cmd)

        # 断言：最终 residual 足够小
        assert abs(residual) < 50.0, f"residual not reduced enough, final={residual}"

    run_simulation(dut, tb(dut), vcd_name="scantracker_pid_dac_closed_loop.vcd")

    # ====== 仿真后绘图（保存为PNG）======
    k = np.array(rec_k)
    residual = np.array(rec_residual, dtype=float)
    dac = np.array(rec_dac, dtype=float)
    time_cmd = np.array(rec_timecmd, dtype=float)
    fsm = np.array(rec_fsm, dtype=int)

    # 找到进入 LOCKED 的起点（如果没进入则为 None）
    lock_idx = np.where(fsm == 2)[0]
    lock_start = int(lock_idx[0]) if len(lock_idx) else None

    def add_lock_marker():
        if lock_start is not None:
            plt.axvline(lock_start, linestyle="--")
            plt.text(lock_start, plt.ylim()[1]*0.9, "LOCKED", rotation=90, va="top")

    # 1) residual 曲线
    plt.figure(figsize=(10, 4.5))
    plt.plot(k, residual)
    plt.xlabel("Cycle")
    plt.ylabel("Residual (arb units)")
    plt.title("Closed-loop residual convergence (should approach 0)")
    plt.grid(True)
    add_lock_marker()
    plt.tight_layout()
    plt.savefig("pid_closed_loop_residual.png", dpi=200)

    # 2) DAC 输出
    plt.figure(figsize=(10, 4.5))
    plt.plot(k, dac)
    plt.xlabel("Cycle")
    plt.ylabel("DAC output (14-bit signed)")
    plt.title("PID output to DAC")
    plt.grid(True)
    add_lock_marker()
    plt.tight_layout()
    plt.savefig("pid_closed_loop_dac.png", dpi=200)

    # 3) time_command_out
    plt.figure(figsize=(10, 4.5))
    plt.plot(k, time_cmd)
    plt.xlabel("Cycle")
    plt.ylabel("time_command_out")
    plt.title("ScanTracker time_command_out (PID input source)")
    plt.grid(True)
    add_lock_marker()
    plt.tight_layout()
    plt.savefig("pid_closed_loop_time_cmd.png", dpi=200)

    # 4) FSM 状态
    plt.figure(figsize=(10, 3.2))
    plt.plot(k, fsm)
    plt.xlabel("Cycle")
    plt.ylabel("FSM state (0/1/2)")
    plt.title("ScanTracker FSM (0=BROAD, 1=NARROW, 2=LOCKED)")
    plt.grid(True)
    add_lock_marker()
    plt.tight_layout()
    plt.savefig("pid_closed_loop_fsm.png", dpi=200)

    print("Saved plots: pid_closed_loop_residual.png, pid_closed_loop_dac.png, pid_closed_loop_time_cmd.png, pid_closed_loop_fsm.png")
