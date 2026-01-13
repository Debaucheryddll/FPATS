from migen import *
from misoc.interconnect.csr import AutoCSR, CSRStatus


FPGA_CLOCK_FREQ = 125000000
FP_WIDTH = 28
FP_FRAC_BITS = 10

# --- 转换物理常量为定点数 ---
# 示例：40 ns/s 转换速率 (注意：这个值非常小，可能为 0)
SLEW_RATE_VAL = 40.0
# 5 ns 范围
FULL_RANGE_VAL = 5.0
# 500 fs 不确定性
LOCK_UNCERTAINTY_VAL = 500.0
class ScanTrackingController(Module, AutoCSR):
    """
    扫描跟踪控制器 (Migen FPGA 模块)

    实现了Nature_1.pdf中描述的卡尔曼辅助捕获状态机和斜坡发生器，适用于Zynq设备的PL（FPGA）端。
    接收PS（通过AXI）的引导信息（中心时间、不确定性），输出TPFC的高速时间命令。
    """

    def __init__(self, clock_freq = FPGA_CLOCK_FREQ, slew_rate_ns_per_sec = SLEW_RATE_VAL,
                 full_range_ns = FULL_RANGE_VAL, lock_uncertainty_fs = LOCK_UNCERTAINTY_VAL,
                 narrow_search_timeout_s=1.0, width = 25):
        # --- 信号接口 (Signal Interface) ---

        # 来自PS（通过AXI）的输入（卡尔曼滤波器指导）
        self.kalman_est_time = Signal((width, True))  # 估计的时间偏移 (fs，有符号)
        self.kalman_est_uncertainty = Signal(width)  # 估计的不确定性 (fs，无符号)

        # 来自PL/ADC的输入（定时鉴别器）
        self.power_level = Signal(width)  # 瞬时功率电平
        self.power_threshold_acquire = Signal(width)  # 采集功率阈值（来自CSR）

        # 输出到TPFC执行器
        self.time_command_out = Signal((width, True))  # 最终的时间命令 (fs，有符号)

        # 输出到PS（通过AXI/中断）
        self.fsm_state = Signal(2)  # 0=BROAD_SEARCH, 1=NARROW_SEARCH, 2=LOCKED

        self.signal_in = []
        self.signal_out = [self.time_command_out]
        self.state_in = []
        self.state_out = []

        # --- CSR 映射 ---
        self.fsm_state_status = CSRStatus(
            2, name="fsm_state"
        )
        self.time_command_out_status = CSRStatus(
            width, name="time_command_out"
        )

        # --- 内部逻辑 (Internal Logic) ---
        current_output_time = Signal((width, True), reset=0)  # 内部当前输出时间寄存器
        sweep_direction = Signal(reset=1)  # 扫描方向，1=向上，0=向下

        sweep_center = Signal((width, True))   # 扫描中心（组合逻辑）
        sweep_span = Signal((width, True))     # 扫描范围（组合逻辑，有符号）

        # 常量转换
        FULL_RANGE_FS = int(full_range_ns * 1e6)
        LOCK_UNCERTAINTY_FS = int(lock_uncertainty_fs)
        NARROW_SEARCH_TIMEOUT_CYCLES = int(narrow_search_timeout_s * clock_freq)
        self.narrow_search_timeout_counter = Signal(max=NARROW_SEARCH_TIMEOUT_CYCLES + 1)

        # 斜坡步长计算（确保至少为1）
        step_per_cycle = max(1, int(slew_rate_ns_per_sec * 1e6 / clock_freq))

        # 状态机 (FSM)
        fsm = FSM(reset_state="BROAD_SEARCH")
        self.submodules += fsm

        # --- FSM 状态 0: 全局搜索 (BROAD_SEARCH) ---
        fsm.act("BROAD_SEARCH",
                self.fsm_state.eq(0),
                sweep_center.eq(0),
                sweep_span.eq(FULL_RANGE_FS // 2),
                If(self.power_level > self.power_threshold_acquire,
                   NextState("NARROW_SEARCH")
                   )
                )

        # --- FSM 状态 1: 精细搜索 (NARROW_SEARCH) ---
        fsm.act("NARROW_SEARCH",
                self.fsm_state.eq(1),
                sweep_center.eq(self.kalman_est_time),
                sweep_span.eq(self.kalman_est_uncertainty * 3),
                If((self.kalman_est_uncertainty < LOCK_UNCERTAINTY_FS) &
                   (self.power_level > self.power_threshold_acquire),  # 同时满足不确定性和功率条件才锁定
                   NextState("LOCKED")
                ).Elif(self.narrow_search_timeout_counter >= NARROW_SEARCH_TIMEOUT_CYCLES,
                   NextState("BROAD_SEARCH")
                )
        )

        # --- FSM 状态 2: 锁定 (LOCKED) ---
        fsm.act("LOCKED",
                self.fsm_state.eq(2),
                sweep_center.eq(0),
                sweep_span.eq(0)
                )

        # 三角波斜坡发生器逻辑（同步逻辑）
        self.sync += [
            If((fsm.ongoing("BROAD_SEARCH")) | (fsm.ongoing("NARROW_SEARCH")),
               If(sweep_direction == 1,
                  current_output_time.eq(current_output_time + step_per_cycle),
                  If(current_output_time >= (sweep_center + sweep_span) - step_per_cycle,
                     current_output_time.eq(sweep_center + sweep_span),
                     sweep_direction.eq(0)
                     )
                  ).Else(
                   current_output_time.eq(current_output_time - step_per_cycle),
                   If(current_output_time <= (sweep_center - sweep_span) + step_per_cycle,
                      current_output_time.eq(sweep_center - sweep_span),
                      sweep_direction.eq(1)
                      )
               )
               ).Elif(fsm.ongoing("LOCKED"),
                      current_output_time.eq(self.kalman_est_time)
                      ).Else(
                current_output_time.eq(0),
                sweep_direction.eq(1)
            ),

            # 超时计数器逻辑
            If(fsm.ongoing("NARROW_SEARCH"),
                If(self.power_level > self.power_threshold_acquire,
                    self.narrow_search_timeout_counter.eq(0)
                ).Elif(self.narrow_search_timeout_counter < NARROW_SEARCH_TIMEOUT_CYCLES,
                    self.narrow_search_timeout_counter.eq(self.narrow_search_timeout_counter + 1)
                )
            ).Else(
                self.narrow_search_timeout_counter.eq(0)
            )
        ]

        # 最终输出（组合逻辑）
        self.comb += [
            self.time_command_out.eq(current_output_time),
            self.fsm_state_status.status.eq(self.fsm_state),
            self.time_command_out_status.status.eq(self.time_command_out),
        ]