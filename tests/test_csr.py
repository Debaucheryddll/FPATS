import pytest
from migen import Module, Signal, run_simulation
from misoc.interconnect.csr import AutoCSR, CSRStatus

from gateware.logic.KalmanTargets import KalmanTargets
from gateware.logic.scan_tracking import ScanTrackingController


class DummyErrCalc(Module, AutoCSR):
    """
    只为了提供 err_calc.csr_power_signal.status 这个“变量名/层级”，
    用一个可控的内部信号 power_reg 去驱动 CSRStatus。
    """
    def __init__(self, width=25):
        self.power_reg = Signal(width)                 # testbench 可写
        self.csr_power_signal = CSRStatus(width, name="power_signal")
        self.comb += self.csr_power_signal.status.eq(self.power_reg)


class DUT(Module):
    def __init__(self, width=25):
        self.submodules.kalman_targets = KalmanTargets(width=width)
        self.submodules.err_calc = DummyErrCalc(width=width)
        self.submodules.scan_tracker = ScanTrackingController(width=width)

        # --- 连接 ScanTrackingController 的输入 ---（完全照你的写法）
        self.comb += [
            # 1. 连接来自 PS (Kalman) 的估计值 (Q15.10)
            self.scan_tracker.kalman_est_time.eq(self.kalman_targets.x_target_cmd.storage),

            # 2. 连接 Kalman 的不确定性 (Q15.10)
            self.scan_tracker.kalman_est_uncertainty.eq(self.kalman_targets.t_target_cmd.storage),

            # 3. 连接 PL 的实时功率
            self.scan_tracker.power_level.eq(self.err_calc.csr_power_signal.status),

            # 4. 连接功率阈值 (来自 PS)
            self.scan_tracker.power_threshold_acquire.eq(self.kalman_targets.power_threshold_target_cmd.storage),
        ]


@pytest.mark.slow
def test_pl_ps_register_path_kalman_targets_to_scan_tracker():
    WIDTH = 25
    dut = DUT(width=WIDTH)

    def tb(d):
        # ---------- 初始：功率不足 -> 应处于 BROAD_SEARCH ----------
        yield d.kalman_targets.power_threshold_target_cmd.storage.eq(1000)
        yield d.err_calc.power_reg.eq(0)
        yield d.kalman_targets.t_target_cmd.storage.eq(10000)   # 不确定度大
        yield d.kalman_targets.x_target_cmd.storage.eq(12345)
        for _ in range(5):
            yield
        assert (yield d.scan_tracker.fsm_state_status.status) == 0  # BROAD_SEARCH

        # ---------- 功率超过阈值 -> 应进入 NARROW_SEARCH ----------
        yield d.err_calc.power_reg.eq(2000)  # power_level > threshold
        for _ in range(5):
            yield
        assert (yield d.scan_tracker.fsm_state_status.status) == 1  # NARROW_SEARCH

        # ---------- 不确定度仍大 -> 不应 LOCK ----------
        yield d.kalman_targets.t_target_cmd.storage.eq(10000)  # >500
        for _ in range(5):
            yield
        assert (yield d.scan_tracker.fsm_state_status.status) != 2  # not LOCKED

        # ---------- 让不确定度变小（<500）且功率仍足够 -> 应 LOCK ----------
        yield d.kalman_targets.t_target_cmd.storage.eq(100)    # <500fs 门限
        for _ in range(10):
            yield
        assert (yield d.scan_tracker.fsm_state_status.status) == 2  # LOCKED

        # ---------- LOCKED 时：time_command_out 应跟随 x_target_cmd ----------
        for _ in range(3):
            assert (yield d.scan_tracker.time_command_out_status.status) == 12345
            yield

        # 改写 x_target_cmd，输出应随之改变（证明寄存器传递“实时生效”）
        yield d.kalman_targets.x_target_cmd.storage.eq(22222)

        # 先确认 CSRStorage 本身已经变了
        yield
        assert (yield d.kalman_targets.x_target_cmd.storage) == 22222

        # 再确认 comb 连接到 scan_tracker 的输入也变了
        assert (yield d.scan_tracker.kalman_est_time) == 22222

        # 再给同步寄存器 current_output_time 1~2 拍去采样
        for _ in range(2):
            yield

        assert (yield d.scan_tracker.time_command_out_status.status) == 22222

        # ---------- 再测试 threshold 通路确实生效 ----------
        # 提高阈值到高于当前功率，应该从 LOCKED 掉出去（至少不能继续满足进入 LOCK 的条件）
        yield d.kalman_targets.power_threshold_target_cmd.storage.eq(30000)
        for _ in range(20):
            yield
        # 这里不强制断言必须回到哪个状态（因为实现可能需要先跳回 NARROW/BROAD），
        # 但至少不应继续稳定保持 LOCKED（如果一直 LOCKED，说明阈值通路可能没连上/没用到）
        assert (yield d.scan_tracker.fsm_state_status.status) != 2

    run_simulation(dut, tb(dut), vcd_name="test_kalman_targets_scan_tracking.vcd")
