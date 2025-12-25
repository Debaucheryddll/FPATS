import pytest
from migen import Module, Signal, run_simulation
from misoc.interconnect.csr import AutoCSR, CSRStatus

from gateware.logic.KalmanTargets import KalmanTargets
from gateware.logic.scan_tracking import ScanTrackingController


class DummyErrCalc(Module, AutoCSR):
    """提供 err_calc.csr_power_signal.status 这个层级/变量名。"""
    def __init__(self, width=25):
        self.power_reg = Signal(width)
        self.csr_power_signal = CSRStatus(width, name="power_signal")
        self.comb += self.csr_power_signal.status.eq(self.power_reg)


class DUT(Module):
    def __init__(self, width=25):
        self.submodules.kalman_targets = KalmanTargets(width=width)
        self.submodules.err_calc = DummyErrCalc(width=width)
        self.submodules.scan_tracker = ScanTrackingController(width=width)

        # --- 连接 ScanTrackingController 的输入 ---
        self.comb += [
            self.scan_tracker.kalman_est_time.eq(self.kalman_targets.x_target_cmd.storage),
            self.scan_tracker.kalman_est_uncertainty.eq(self.kalman_targets.t_target_cmd.storage),
            self.scan_tracker.power_level.eq(self.err_calc.csr_power_signal.status),
            self.scan_tracker.power_threshold_acquire.eq(self.kalman_targets.power_threshold_target_cmd.storage),
        ]


@pytest.mark.slow
def test_pl_ps_register_path_kalman_targets_to_scan_tracker_keylog():
    WIDTH = 25
    dut = DUT(width=WIDTH)

    def tb(d):
        cycle = 0
        fsm_name = {0: "BROAD_SEARCH", 1: "NARROW_SEARCH", 2: "LOCKED"}

        def step(n=1):
            nonlocal cycle
            for _ in range(n):
                yield
                cycle += 1

        def rd_all():
            """只读关键量（寄存器 + FSM + time_cmd 输出 + pth_in）"""
            return {
                "x_cmd": (yield d.kalman_targets.x_target_cmd.storage),
                "t_cmd": (yield d.kalman_targets.t_target_cmd.storage),
                "pth_cmd": (yield d.kalman_targets.power_threshold_target_cmd.storage),
                "power": (yield d.err_calc.power_reg),
                "fsm": (yield d.scan_tracker.fsm_state_status.status),
                "t_out": (yield d.scan_tracker.time_command_out_status.status),
                "pth_in": (yield d.scan_tracker.power_threshold_acquire),
            }

        def log_regs(tag):
            v = (yield from rd_all())
            print(
                f"[{cycle:04d}] {tag} | x_cmd={v['x_cmd']} t_cmd={v['t_cmd']} "
                f"pth_cmd={v['pth_cmd']} power={v['power']} | "
                f"fsm={fsm_name.get(v['fsm'], v['fsm'])} t_out={v['t_out']}"
            )

        def wait_fsm(target, timeout=200):
            """等待 FSM 到达 target；中途如果发生 FSM 变化就打印一次"""
            nonlocal cycle
            last = (yield d.scan_tracker.fsm_state_status.status)
            for _ in range(timeout):
                yield
                cycle += 1
                cur = (yield d.scan_tracker.fsm_state_status.status)
                if cur != last:
                    v = (yield from rd_all())
                    print(
                        f"[{cycle:04d}] FSM: {fsm_name.get(last,last)} -> {fsm_name.get(cur,cur)} | "
                        f"x_cmd={v['x_cmd']} t_cmd={v['t_cmd']} pth={v['pth_cmd']} power={v['power']} | "
                        f"t_out={v['t_out']}"
                    )
                    last = cur
                if cur == target:
                    return
            raise AssertionError(f"Timeout waiting FSM={target} ({fsm_name.get(target,target)})")

        def wait_time_out(target_val, timeout=50):
            """等待 time_command_out 输出更新为 target_val，返回用了几拍"""
            nonlocal cycle  # ★关键：使用外层 tb() 里的 cycle
            start_cycle = cycle
            for _ in range(timeout):
                v = (yield from rd_all())
                if v["t_out"] == target_val:
                    return cycle - start_cycle
                yield
                cycle += 1
            raise AssertionError(f"Timeout waiting t_out={target_val}")

        print("\n=== CSR keylog test start ===")

        # ------------------ STEP 0: 初始写入 ------------------
        yield d.kalman_targets.power_threshold_target_cmd.storage.eq(1000)
        yield d.err_calc.power_reg.eq(0)
        yield d.kalman_targets.t_target_cmd.storage.eq(10000)
        yield d.kalman_targets.x_target_cmd.storage.eq(12345)
        yield from step(2)  # 给它两拍稳定
        yield from log_regs("PS wrote regs (init)")

        # 期望 BROAD
        v = (yield from rd_all())
        assert v["fsm"] == 0, f"Expected BROAD_SEARCH(0), got {v['fsm']}"

        # ------------------ STEP 1: 功率超过阈值 -> NARROW ------------------
        yield d.err_calc.power_reg.eq(2000)
        yield from step(1)
        yield from log_regs("PS wrote power=2000")
        yield from wait_fsm(1, timeout=200)  # 等到 NARROW
        v = (yield from rd_all())
        assert v["fsm"] == 1

        # ------------------ STEP 2: 不确定度仍大 -> 不应 LOCK ------------------
        yield d.kalman_targets.t_target_cmd.storage.eq(10000)
        yield from step(1)
        yield from log_regs("PS wrote unc=10000 (keep NARROW)")
        yield from step(20)
        v = (yield from rd_all())
        assert v["fsm"] != 2, "Should NOT be LOCKED when uncertainty is large"

        # ------------------ STEP 3: 不确定度变小 + 功率足够 -> LOCK ------------------
        yield d.kalman_targets.t_target_cmd.storage.eq(100)
        yield from step(1)
        yield from log_regs("PS wrote unc=100 (try LOCK)")
        yield from wait_fsm(2, timeout=400)  # 等到 LOCKED
        v = (yield from rd_all())
        assert v["fsm"] == 2

        # LOCKED 后输出应跟随 x_cmd（允许内部1~几拍对齐，先等它稳定为 12345）
        _ = yield from wait_time_out(12345, timeout=50)
        yield from log_regs("LOCKED output aligned to x_cmd=12345")

        # ------------------ STEP 4: 改写 x_target_cmd，看输出传播延迟 ------------------
        yield d.kalman_targets.x_target_cmd.storage.eq(22222)
        yield from step(1)
        yield from log_regs("PS rewrote x_cmd=22222 (watch t_out)")
        latency = yield from wait_time_out(22222, timeout=50)
        print(f"[{cycle:04d}] PROPAGATION: t_out updated to 22222 after {latency} cycle(s)")

        # ------------------ STEP 5: threshold 通路：只验证 pth_in 跟随 ------------------
        yield d.kalman_targets.power_threshold_target_cmd.storage.eq(30000)
        yield from step(2)
        v = (yield from rd_all())
        print(f"[{cycle:04d}] THRESHOLD: pth_cmd={v['pth_cmd']} pth_in={v['pth_in']}")
        assert v["pth_cmd"] == 30000 and v["pth_in"] == 30000, "Threshold did not propagate"

        print("=== CSR keylog test PASS ===\n")

    run_simulation(dut, tb(dut), vcd_name="test_kalman_targets_scan_tracking_keylog.vcd")