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
    """严格复刻 linien_module.py 中这四条连接的最小 DUT。"""
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
def test_pl_ps_register_path_kalman_targets_to_scan_tracker_verbose():
    WIDTH = 25
    dut = DUT(width=WIDTH)

    def tb(d):
        cycle = 0

        def sgn(x, bits=WIDTH):
            """把无符号读数解释成有符号（便于看 time 值是否为负）"""
            if x >= (1 << (bits - 1)):
                return x - (1 << bits)
            return x

        def peek():
            """读取一组关键中间量并以 dict 返回"""
            return {
                # KalmanTargets CSRs
                "x_cmd": (yield d.kalman_targets.x_target_cmd.storage),
                "t_cmd": (yield d.kalman_targets.t_target_cmd.storage),
                "pth_cmd": (yield d.kalman_targets.power_threshold_target_cmd.storage),

                # Dummy err_calc power path
                "power_reg": (yield d.err_calc.power_reg),
                "power_csr": (yield d.err_calc.csr_power_signal.status),

                # scan_tracker inputs (after wiring)
                "k_time_in": (yield d.scan_tracker.kalman_est_time),
                "k_unc_in": (yield d.scan_tracker.kalman_est_uncertainty),
                "p_in": (yield d.scan_tracker.power_level),
                "pth_in": (yield d.scan_tracker.power_threshold_acquire),

                # scan_tracker outputs (CSRStatus)
                "fsm": (yield d.scan_tracker.fsm_state_status.status),
                "t_out_raw": (yield d.scan_tracker.time_command_out_status.status),
            }

        def log(tag):
            nonlocal cycle
            v = (yield from peek())
            print(
                f"[{cycle:04d}] {tag:>18} | "
                f"x_cmd={v['x_cmd']}, t_cmd={v['t_cmd']}, pth_cmd={v['pth_cmd']} | "
                f"power_reg={v['power_reg']}, power_csr={v['power_csr']} | "
                f"in(time={v['k_time_in']}, unc={v['k_unc_in']}, p={v['p_in']}, pth={v['pth_in']}) | "
                f"fsm={v['fsm']} | t_out={v['t_out_raw']} (signed {sgn(v['t_out_raw'])})"
            )

        def step(n=1, tag=None):
            """推进 n 个周期，并可选打印"""
            nonlocal cycle
            for i in range(n):
                yield
                cycle += 1
                if tag is not None and (i == n - 1):
                    yield from log(tag)

        print("\n========== CSR wiring verbose test start ==========")

        # ------------------ STEP 0: 初始写入 ------------------
        yield d.kalman_targets.power_threshold_target_cmd.storage.eq(1000)
        yield d.err_calc.power_reg.eq(0)
        yield d.kalman_targets.t_target_cmd.storage.eq(10000)
        yield d.kalman_targets.x_target_cmd.storage.eq(12345)

        yield from step(1, tag="after init set")
        # 再多走几拍让 FSM 稳一下
        yield from step(4, tag="expect BROAD")

        v = (yield from peek())
        assert v["fsm"] == 0, f"Expected BROAD (0), got fsm={v['fsm']}"

        # ------------------ STEP 1: 功率超过阈值 -> NARROW ------------------
        yield d.err_calc.power_reg.eq(2000)
        yield from step(1, tag="power raised")
        yield from step(6, tag="expect NARROW")

        v = (yield from peek())
        assert v["fsm"] == 1, f"Expected NARROW (1), got fsm={v['fsm']}"

        # ------------------ STEP 2: 不确定度仍大 -> 不应 LOCK ------------------
        yield d.kalman_targets.t_target_cmd.storage.eq(10000)
        yield from step(1, tag="unc large set")
        yield from step(6, tag="still not LOCK")

        v = (yield from peek())
        assert v["fsm"] != 2, f"Should NOT be LOCKED, got fsm={v['fsm']}"

        # ------------------ STEP 3: 不确定度变小 + 功率足够 -> LOCK ------------------
        yield d.kalman_targets.t_target_cmd.storage.eq(100)
        yield from step(1, tag="unc small set")
        yield from step(10, tag="expect LOCKED")

        v = (yield from peek())
        assert v["fsm"] == 2, f"Expected LOCKED (2), got fsm={v['fsm']}"

        # ------------------ STEP 4: LOCKED 时输出应跟随 x_target_cmd ------------------
        yield from step(1, tag="LOCK observe 1")
        yield from step(1, tag="LOCK observe 2")
        yield from step(1, tag="LOCK observe 3")

        v = (yield from peek())
        assert v["t_out_raw"] == 12345, f"LOCKED output should be 12345, got {v['t_out_raw']}"

        # ------------------ STEP 5: 改写 x_target_cmd，看输出几拍内是否跟随 ------------------
        print("\n--- rewrite x_target_cmd: 12345 -> 22222, watch propagation ---")
        yield d.kalman_targets.x_target_cmd.storage.eq(22222)

        # 先推进 1 拍并打印 CSR 和 scan_tracker 输入
        yield from step(1, tag="after x_cmd=22222 (1cy)")

        # 再连续看 5 拍，看 t_out 什么时候更新
        for k in range(5):
            yield from step(1, tag=f"propagate watch {k+1}/5")

        v = (yield from peek())
        # 这里用“最终必须变成 22222”，避免 1 拍采样导致误判
        assert v["t_out_raw"] == 22222, f"Expected t_out become 22222, got {v['t_out_raw']}"

        # ------------------ STEP 6: threshold 通路只验证“输入确实更新” ------------------
        print("\n--- raise threshold to 30000: verify pth_in follows CSR (FSM may stay LOCKED by design) ---")
        yield d.kalman_targets.power_threshold_target_cmd.storage.eq(30000)
        yield from step(1, tag="after pth=30000")
        yield from step(3, tag="pth stable")

        v = (yield from peek())
        assert v["pth_cmd"] == 30000 and v["pth_in"] == 30000, \
            f"Threshold did not propagate: pth_cmd={v['pth_cmd']}, pth_in={v['pth_in']}"

        print("========== CSR wiring verbose test PASS ==========\n")

    run_simulation(dut, tb(dut), vcd_name="test_kalman_targets_scan_tracking_verbose.vcd")
