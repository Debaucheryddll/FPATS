import pytest

migen = pytest.importorskip("migen")
from migen import Module, Signal, If, run_simulation
from misoc.interconnect.csr import AutoCSR, CSRStorage, CSRStatus

# ===== 这些 import 路径按你工程实际情况二选一即可 =====
try:
    from gateware.logic.scan_tracking import ScanTrackingController
    from gateware.logic.KalmanTargets import KalmanTargets
    from gateware.logic.pid import PID
except Exception:
    from scan_tracking import ScanTrackingController
    from KalmanTargets import KalmanTargets
    from pid import PID


def signed(v: int, bits: int) -> int:
    """Convert migen readback int to signed."""
    if v & (1 << (bits - 1)):
        return v - (1 << bits)
    return v


class DummyAnalog(Module):
    """替代 PitayaAnalog：只保留你 connect_everything 用到的端口名。"""
    def __init__(self, width=14):
        self.adc_a = Signal((width, True))
        self.adc_b = Signal((width, True))
        self.dac_a = Signal((width, True))


class DummyErrCalc(Module, AutoCSR):
    """
    替代 ErrorSignalCalculator：只提供你连线用到的 csr_power_signal.status
    这里用 power_reg 作为“内部功率”，并映射到 CSRStatus.status。
    """
    def __init__(self, power_bits=16):
        self.power_reg = Signal(power_bits)  # TB 里直接 yield 赋值
        self.csr_power_signal = CSRStatus(power_bits, name="csr_power_signal")
        self.comb += self.csr_power_signal.status.eq(self.power_reg)


class LimitSimple(Module):
    """
    轻量限幅器：接口名和 LimitCSR 保持一致：x/y。
    只做饱和，不做 CSR。
    """
    def __init__(self, width=14, guard=5):
        self.x = Signal((width + guard, True))
        self.y = Signal((width, True))
        max_pos = (1 << (width - 1)) - 1
        max_neg = (-1 * max_pos) - 1
        self.comb += If(self.x > max_pos, self.y.eq(max_pos)).Elif(
            self.x < max_neg, self.y.eq(max_neg)
        ).Else(self.y.eq(self.x))


class LogicMini(Module, AutoCSR):
    """
    只保留 linien_module.LinienLogic 里与本测试相关的 3 个对象：
    pid_only_mode / pid / limit_fast1
    """
    def __init__(self, width=14, signal_width=25):
        self.pid_only_mode = CSRStorage(1, name="pid_only_mode")
        self.submodules.pid = PID(width=signal_width)
        self.submodules.limit_fast1 = LimitSimple(width=width, guard=5)


class DUT(Module, AutoCSR):
    """
    复刻 linien_module.connect_everything() 中与 scan_tracker->PID->DAC 相关的真实连线。
    """
    def __init__(self, width=14, signal_width=25):
        s = signal_width - width  # 和 linien_module 一致

        self.submodules.analog = DummyAnalog(width=width)
        self.submodules.err_calc = DummyErrCalc(power_bits=16)
        self.submodules.kalman_targets = KalmanTargets(width=signal_width)
        self.submodules.scan_tracker = ScanTrackingController(width=signal_width)
        self.submodules.logic = LogicMini(width=width, signal_width=signal_width)

        # ---- 复刻 linien_module 的 4 路输入连线（寄存器/功率 -> scan_tracker）----
        self.comb += [
            self.scan_tracker.kalman_est_time.eq(self.kalman_targets.x_target_cmd.storage),
            self.scan_tracker.kalman_est_uncertainty.eq(self.kalman_targets.t_target_cmd.storage),
            self.scan_tracker.power_level.eq(self.err_calc.csr_power_signal.status),
            self.scan_tracker.power_threshold_acquire.eq(self.kalman_targets.power_threshold_target_cmd.storage),
        ]

        # ---- 复刻 linien_module 的 PID 路由与 DAC 连线 ----
        self.comb += self.logic.pid.running.eq(1)

        pid_out = Signal((width, True))
        self.comb += [
            If(
                self.logic.pid_only_mode.storage,
                self.logic.pid.input.eq(self.scan_tracker.time_command_out << s),
            ).Else(
                self.logic.pid.input.eq(0)
            ),
            pid_out.eq(self.logic.pid.pid_out >> s),
        ]

        self.comb += [
            self.logic.limit_fast1.x.eq(pid_out),
            self.analog.dac_a.eq(self.logic.limit_fast1.y),
        ]


@pytest.mark.slow
def test_scantracker_pid_to_dac_compact():
    WIDTH = 14
    SIGNAL_WIDTH = 25
    s = SIGNAL_WIDTH - WIDTH

    dut = DUT(width=WIDTH, signal_width=SIGNAL_WIDTH)

    def snapshot(tag, cyc):
        x = (yield dut.kalman_targets.x_target_cmd.storage)
        u = (yield dut.kalman_targets.t_target_cmd.storage)
        pth = (yield dut.kalman_targets.power_threshold_target_cmd.storage)
        pwr = (yield dut.err_calc.csr_power_signal.status)
        fsm = (yield dut.scan_tracker.fsm_state_status.status)
        t_out = (yield dut.scan_tracker.time_command_out_status.status)
        dac = (yield dut.analog.dac_a)
        print(
            f"[{cyc:04d}] {tag} | "
            f"x_cmd={x}, unc={u}, pwr={pwr}, pth={pth} | "
            f"fsm={fsm}, t_out={t_out}, dac={signed(dac, WIDTH)}"
        )

    def tb():
        cyc = 0
        prev_fsm = None

        # ===== 0) 配置 PID：让 dac ≈ time_command_out（在你的 shift/缩放方式下）=====
        # 由于：pid_out(到DAC前) = (pid.pid_out >> s)
        # 且 P 通道：output_p = (error * kp) >> (coeff_width-2)  (coeff_width默认14 -> >>12)
        # 选择 kp=4096 (=2^12)，使整体近似抵消缩放：dac ≈ time_command_out（在小信号不溢出的前提下）
        yield dut.logic.pid_only_mode.storage.eq(1)
        yield dut.logic.pid.setpoint.storage.eq(0)
        yield dut.logic.pid.kp.storage.eq(4096)
        yield dut.logic.pid.ki.storage.eq(0)
        yield dut.logic.pid.kd.storage.eq(0)
        yield dut.logic.pid.reset.storage.eq(1)
        yield
        cyc += 1
        yield dut.logic.pid.reset.storage.eq(0)

        # ===== 1) PS 写入 3 个 KalmanTargets 寄存器 + 初始功率 =====
        # 初始让功率不足 -> BROAD_SEARCH
        yield dut.kalman_targets.x_target_cmd.storage.eq(500)            # 先给个目标
        yield dut.kalman_targets.t_target_cmd.storage.eq(10000)          # 不确定度大
        yield dut.kalman_targets.power_threshold_target_cmd.storage.eq(1000)
        yield dut.err_calc.power_reg.eq(0)

        yield
        cyc += 1
        snapshot_msg = f"PS wrote regs (x/t/pth) & set power low (pid_only=1, kp=4096, shift={s})"
        print(f"[{cyc:04d}] {snapshot_msg}")
        yield from snapshot("after PS write", cyc)

        # ===== 2) 观察 FSM 变化（只在变化时打印）=====
        # 跑一小段让状态机稳定在 BROAD
        for _ in range(20):
            fsm = (yield dut.scan_tracker.fsm_state_status.status)
            if prev_fsm is None:
                prev_fsm = fsm
            elif fsm != prev_fsm:
                print(f"[{cyc:04d}] FSM changed: {prev_fsm} -> {fsm}")
                yield from snapshot("on fsm change", cyc)
                prev_fsm = fsm
            yield
            cyc += 1

        # ===== 3) 提高功率 + 降低不确定度 -> 期望进入 LOCKED =====
        yield dut.err_calc.power_reg.eq(2000)     # power > threshold
        yield dut.kalman_targets.t_target_cmd.storage.eq(100)  # unc < 500
        yield
        cyc += 1
        print(f"[{cyc:04d}] Raised power & reduced uncertainty (expect LOCKED soon)")
        yield from snapshot("after power/unc change", cyc)

        # 等待直到 LOCKED (=2) 或超时
        locked = False
        for _ in range(200):
            fsm = (yield dut.scan_tracker.fsm_state_status.status)
            if prev_fsm is None:
                prev_fsm = fsm
            elif fsm != prev_fsm:
                print(f"[{cyc:04d}] FSM changed: {prev_fsm} -> {fsm}")
                yield from snapshot("on fsm change", cyc)
                prev_fsm = fsm

            if fsm == 2:
                locked = True
                print(f"[{cyc:04d}] Reached LOCKED")
                yield from snapshot("LOCKED", cyc)
                break

            yield
            cyc += 1

        assert locked, "Timeout waiting for scan_tracker to reach LOCKED"

        # ===== 4) LOCKED 时：t_out 应跟随 x_cmd；PID/DAC 应跟随 t_out（有少量拍延迟）=====
        # 先等几拍让 PID 打完拍（pid_sum 是 sync） :contentReference[oaicite:5]{index=5}
        for _ in range(5):
            yield
            cyc += 1

        # 在当前 x_cmd=500 时，期望 dac ≈ 500
        dac_now = signed((yield dut.analog.dac_a), WIDTH)
        t_now = (yield dut.scan_tracker.time_command_out_status.status)
        print(f"[{cyc:04d}] LOCK steady: expect dac≈t_out (t_out={t_now}, dac={dac_now})")
        assert abs(dac_now - t_now) <= 2

        # ===== 5) step x_cmd：验证“scan_tracker->PID->DAC”链路实时生效 =====
        old = (yield dut.kalman_targets.x_target_cmd.storage)
        new = 1500
        yield dut.kalman_targets.x_target_cmd.storage.eq(new)
        yield
        cyc += 1
        print(f"[{cyc:04d}] PS step x_target_cmd: {old} -> {new}")

        # 观察几拍：scan_tracker(打一拍) + PID(打一拍) 后应到新值
        reached = False
        for k in range(10):
            yield
            cyc += 1
            t_out = (yield dut.scan_tracker.time_command_out_status.status)
            dac = signed((yield dut.analog.dac_a), WIDTH)
            if (t_out == new) and (abs(dac - new) <= 2):
                print(f"[{cyc:04d}] Step applied (after {k+1} cycles): t_out={t_out}, dac={dac}")
                reached = True
                break

        assert reached, "x_cmd step did not propagate to t_out & dac within expected cycles"

    run_simulation(dut, tb(), vcd_name="test_scantracker_pid_dac.vcd")
