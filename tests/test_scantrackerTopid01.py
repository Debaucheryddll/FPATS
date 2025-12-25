import pytest
import numpy as np

migen = pytest.importorskip("migen")
from migen import Module, Signal, If, Mux
from migen.sim import run_simulation
from misoc.interconnect.csr import AutoCSR, CSRStatus, CSRStorage

from gateware.logic.scan_tracking import ScanTrackingController
from gateware.logic.KalmanTargets import KalmanTargets
from gateware.logic.pid import PID


class DummyErrCalc(Module, AutoCSR):
    """
    只为了复用你 linien_module.py 里的变量名:
      self.err_calc.csr_power_signal.status
    用一个可写的 power_reg 去驱动 CSRStatus。
    """
    def __init__(self, width=25):
        self.power_reg = Signal(width)
        self.csr_power_signal = CSRStatus(width, name="power_signal")
        self.sync += self.csr_power_signal.status.eq(self.power_reg)


class SimpleLogic(Module, AutoCSR):
    def __init__(self, signal_width=25):
        self.pid_only_mode = CSRStorage(1, name="pid_only_mode")
        self.submodules.pid = PID(width=signal_width)  # 用你上传的 pid.py (coeff_width=14 默认)


class DUT(Module):
    def __init__(self, width=14, signal_width=25):
        self.width = width
        self.signal_width = signal_width
        self.s = signal_width - width  # 与 linien_module.py 一致 (25-14=11)

        self.submodules.kalman_targets = KalmanTargets(width=signal_width)
        self.submodules.err_calc = DummyErrCalc(width=signal_width)
        self.submodules.scan_tracker = ScanTrackingController(width=signal_width)
        self.submodules.logic = SimpleLogic(signal_width=signal_width)

        # “DAC输出”观测点（对应你 linien_module.py 的 self.analog.dac_a）
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

        # ===== 用“软件限幅”模拟 limit_fast1，再接到 dac_a =====
        max_dac = (1 << (width - 1)) - 1
        min_dac = - (1 << (width - 1))
        self.comb += self.dac_a.eq(
            Mux(pid_out_to_dac_domain > max_dac, max_dac,
                Mux(pid_out_to_dac_domain < min_dac, min_dac,
                    pid_out_to_dac_domain))
        )


@pytest.mark.slow
def test_scantracker_pid_to_dac_closed_loop(verbose=True):
    """
    目标：看到 PID 把“时间偏差(残差)”从大值逐步调到 0。
    残差写入：kalman_targets.x_target_cmd.storage
    PID输入：  scan_tracker.time_command_out << s
    PID输出：  dac_a (14bit signed)
    """

    width = 14
    signal_width = 25
    dut = DUT(width=width, signal_width=signal_width)

    # --------- 被控对象(plant)参数： residual <- residual - plant_gain * dac ---------
    plant_gain = 0.05  # 越小越慢、越平滑；太大可能振荡/一下到0
    residual0 = 6000.0  # 初始偏差（建议 <= 8191 避免 <<s 后被截断）

    # --------- PID 参数（pid.py: output_p = (error*kp)>>(coeff_width-2) ; coeff_width=14 -> >>12）---------
    KP_UNITY = 1 << 12   # 约等于“P增益=1”
    KI = 0               # 先用纯P看收敛过程（想更稳态逼近可加小KI）
    KD = 0

    def tb(d):
        # ===== 1) 配置：让 scan_tracker 很快进入 LOCKED =====
        yield d.kalman_targets.power_threshold_target_cmd.storage.eq(1000)
        yield d.err_calc.power_reg.eq(2000)                # power > threshold
        yield d.kalman_targets.t_target_cmd.storage.eq(100)  # uncertainty < 500 -> 满足 LOCK 条件

        # ===== 2) 配置 PID（目标=0）=====
        yield d.logic.pid_only_mode.storage.eq(1)
        yield d.logic.pid.setpoint.storage.eq(0)
        yield d.logic.pid.kp.storage.eq(KP_UNITY)
        yield d.logic.pid.ki.storage.eq(KI)
        yield d.logic.pid.kd.storage.eq(KD)

        # 清一次积分寄存器（即使 KI=0 也建议）
        yield d.logic.pid.reset.storage.eq(1)
        yield
        yield d.logic.pid.reset.storage.eq(0)

        if verbose:
            print("=== PID test start ===")
            print(f"Write regs: pth={1000}, power={2000}, unc={100}, pid_only_mode=1")
            print(f"PID cfg: setpoint=0, kp={KP_UNITY}, ki={KI}, kd={KD}")
            print(f"Initial residual = {residual0:.2f}")

        residual = residual0
        last_fsm = None
        converged_at = None

        # 记录曲线
        rec_residual = []
        rec_dac = []
        rec_fsm = []
        rec_timecmd = []

        time_hist = []
        dac_hist = []
        align_delay = None  # 自动检测出来的 delay（0~4）
        align_window = 60  # 用多少个样本来估计（建议 40~100）

        # 跑足够长看到收敛
        for k in range(250):
            # “PS写入”当前残差 -> x_target_cmd
            yield d.kalman_targets.x_target_cmd.storage.eq(int(round(residual)))

            # 推进一个时钟周期，让链路更新
            yield

            fsm = (yield d.scan_tracker.fsm_state_status.status)
            time_cmd = (yield d.scan_tracker.time_command_out_status.status)
            dac = (yield d.dac_a)

            time_hist.append(time_cmd)
            dac_hist.append(dac)

            if align_delay is None and fsm == 2 and len(time_hist) >= align_window:
                best_d = None
                best_err = 1e18
                # 试 0~4 拍对齐
                for dly in range(0, 5):
                    errs = []
                    # 对齐方式：dac[i] 对比 time[i-dly]
                    for i in range(dly, len(time_hist)):
                        errs.append(abs(dac_hist[i] - time_hist[i - dly]))
                    mean_err = sum(errs) / len(errs)
                    if mean_err < best_err:
                        best_err = mean_err
                        best_d = dly
                align_delay = best_d
                if verbose:
                    print(f"[{k:04d}] Auto-alignment: best_delay={align_delay} cycles, mean_abs_err={best_err:.3f}")

            # 状态变化只打印关键事件
            if last_fsm is None:
                last_fsm = fsm
            elif fsm != last_fsm:
                if verbose:
                    print(f"[{k:04d}] FSM: {last_fsm} -> {fsm} (time_cmd={time_cmd}, dac={dac}, x_cmd={int(round(residual))})")
                last_fsm = fsm

            # 只在 LOCKED(2) 时模拟闭环（更贴近你的使用逻辑）
            if fsm == 2:
                residual = residual - plant_gain * float(dac)

            # 记录
            rec_residual.append(residual)
            rec_dac.append(dac)
            rec_fsm.append(fsm)
            rec_timecmd.append(time_cmd)

            # 每隔一段打印一次“收敛过程关键点”
            if verbose and (k in (0, 2, 5, 10, 20, 50, 100, 150, 200, 249)):
                print(f"[{k:04d}] LOCK={int(fsm==2)} | residual≈{residual:8.2f} | time_cmd={time_cmd:6d} | dac={dac:6d}")


            if converged_at is None and fsm == 2 and abs(residual) < 5.0:
                converged_at = k
                if verbose:
                    print(f"[{k:04d}] Converged: |residual| < 5")

        if verbose:
            print(f"Final residual ≈ {residual:.3f}, converged_at={converged_at}")
            print("=== PID test end ===")

        # 断言：最终偏差应足够接近 0（这里给宽松阈值）
        assert abs(residual) < 50.0, f"residual not reduced enough, final={residual}"

    run_simulation(dut, tb(dut), vcd_name="scantracker_pid_dac_closed_loop.vcd")
