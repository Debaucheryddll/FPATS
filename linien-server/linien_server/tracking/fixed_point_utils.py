# 文件: linien-server/linien_server/tracking/fixed_point_utils.py

class FixedPointConverter:
    """
    用于在 FPGA 的定点数 (Fixed-Point) 和 Python 浮点数 (Float) 之间进行转换的工具。
    所有转换均假设使用二的补码 (Two's Complement) 表示有符号数。
    """

    @staticmethod
    def fixed_to_float(raw_value: int, width: int, fractional_bits: int) -> float:
        """
        将 FPGA 传来的原始定点数 (整数) 转换为浮点数。

        参数:
            raw_value (int): 从 CSRStatus 读取的原始整数值。
            width (int): 寄存器的总位宽 (W)。
            fractional_bits (int): 小数部分占用的位数 (F)。

        返回:
            float: 对应的浮点数值。
        """

        # 1. 检查符号位 (最高位)
        sign_bit = 1 << (width - 1)

        if (raw_value & sign_bit) != 0:
            # 2. 如果为负数，计算二的补码的十进制值
            # 负数 = raw_value - 2^W
            signed_value = raw_value - (1 << width)
        else:
            # 3. 如果为正数或零，直接使用原始值
            signed_value = raw_value

        # 4. 转换为浮点数: (Signed Value) / 2^F
        return signed_value / (1 << fractional_bits)

    @staticmethod
    def float_to_fixed(float_value: float, width: int, fractional_bits: int) -> int:
        """
        将浮点数转换为 FPGA 可识别的原始定点数 (整数)。

        参数:
            float_value (float): 待转换的浮点数值 (例如 Kalman 的输出)。
            width (int): 寄存器的总位宽 (W)。
            fractional_bits (int): 小数部分占用的位数 (F)。

        返回:
            int: 对应的二的补码表示的整数值，可写入 CSRStorage。
        """

        # 1. 将浮点数乘以 2^F 得到整数部分 (取整)
        scaling_factor = 1 << fractional_bits
        scaled_value = int(round(float_value * scaling_factor))

        # 2. 截断到 W 位，处理溢出和二的补码
        # 结果应在 [-2^(W-1), 2^(W-1) - 1] 范围内

        # 使用 Python 的位运算来模拟定点数的环绕特性 (Two's Complement Wrap)
        # 例如，Python 中 (-1) % (2**32) 结果为 2**32 - 1

        # 3. 结果对 2^W 取模，得到最终的原始整数表示
        mask = (1 << width)
        raw_fixed_point = scaled_value % mask

        # 如果输入值非常大导致溢出，它也会正确地在 W 位环绕
        return raw_fixed_point