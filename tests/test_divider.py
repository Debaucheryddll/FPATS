import pytest
from migen import Module, Signal, run_simulation

# 导入我们刚刚设计的新除法器
# 假设您把它放在了 'gateware/logic/pipelined_divider.py'
from gateware.logic.divider import PipelinedDivider

# --- 1. 定义测试参数 ---
TEST_WIDTH = 25  # 我们测试25位宽度的除法器

# --- 2. 计算硬件的预期延迟 ---
# 根据 PipelinedDivider 的实现：
# 延迟 = width + 1 (width个流水线级 + 1个输出锁存级)
SIM_LATENCY = TEST_WIDTH + 1  # 预期 26 个时钟周期
SIM_TIMEOUT = SIM_LATENCY + 10  # 设置一个 36 周期的超时


# --- 3. 创建“测试员”：Migen仿真测试平台 (Testbench) ---

def tb(dut):
    """
    这个'tb' (testbench) 函数是“测试员”。
    'dut' (Device Under Test) 就是我们正在测试的 PipelinedDivider  模块

    它将测试【有符号整数除法】
    """

    # 这是一个辅助函数，用于执行一次完整的除法测试
    # 【注意】: 这是一个“传统”生成器 (def + yield)，不是“异步”的 (async def)
    def run_test_case(num, den, expected_q, expected_r, case_name):
        print(f"\n【测试 {case_name}】: {num} / {den}")

        # 1. 设置输入
        yield dut.num.eq(num)
        yield dut.den.eq(den)

        # 2. 脉冲 'start' 信号，启动流水线
        yield dut.start.eq(1)
        yield
        yield dut.start.eq(0)

        # 3. 等待 'done' 信号，或等待超时
        done_signal = 0
        for i in range(SIM_TIMEOUT):
            # 顺便测试 busy 信号
            if i > 0 and i < SIM_LATENCY:
                assert (yield dut.busy), f"Case {case_name}: 'busy' 信号在第 {i} 周期没有拉高！"

            if (yield dut.done):
                done_signal = 1
                break  # 成功！
            yield

        # 4. 读取输出
        quotient = (yield dut.quotient)
        remainder = (yield dut.remainder)

        print(f"  硬件 商 (int)  = {quotient}")
        print(f"  硬件 余数 (int) = {remainder}")
        print(f"  预期 商 (int)  = {expected_q}")
        print(f"  预期 余数 (int) = {expected_r}")

        # 5. 【断言】检查结果
        assert done_signal, f"Case {case_name}: 超时！'done' 信号未拉高"

        assert quotient == expected_q, f"Case {case_name}: 商不匹配！"
        assert remainder == expected_r, f"Case {case_name}: 余数不匹配！"

        # 检查 'busy' 信号是否在 'done' 之后被正确清零
        yield
        assert not (yield dut.busy), f"Case {case_name}: 'busy' 信号在 'done' 之后没有清零！"

    # --- 【测试开始】 ---

    # 硬件除法器  实现的是“截断除法”（向零取整）
    # 10 // 3 = 3, 10 % 3 = 1
    yield from run_test_case(num=10, den=3, expected_q=3, expected_r=1, case_name="正数 / 正数")

    # -10 // 3 = -3, -10 % 3 = -1
    yield from run_test_case(num=-10, den=3, expected_q=-3, expected_r=-1, case_name="负数 / 正数")

    # 10 // -3 = -3, 10 % -3 = 1
    yield from run_test_case(num=10, den=-3, expected_q=-3, expected_r=1, case_name="正数 / 负数")

    # -10 // -3 = 3, -10 % -3 = -1
    yield from run_test_case(num=-10, den=-3, expected_q=3, expected_r=-1, case_name="负数 / 负数")

    # 0 // 5 = 0, 0 % 5 = 0
    yield from run_test_case(num=0, den=5, expected_q=0, expected_r=0, case_name="0 / 正数")

    # 【你之前的失败案例】
    # 2475 // 10713 = 0, 2475 % 10713 = 2475
    yield from run_test_case(num=2475, den=10713, expected_q=0, expected_r=2475, case_name="User Case (小数)")

    print("\n【测试成功】PipelinedDivider (整数版)  工作正常！")


# --- 4. 启动测试 ---
def test_integer_divider(plt):  # plt fixture 仍然保留

    # 1. 创建我们的“除法器”实例
    dut = PipelinedDivider(width=TEST_WIDTH)

    # 2. 运行仿真！
    #    生成 vcd 波形文件，以便在 GTKWave 等工具中进行可视化调试
    run_simulation(dut, tb(dut), vcd_name="integer_divider_test.vcd")