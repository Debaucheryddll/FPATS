# 鏂囦欢: linien-server/linien_server/tracking/tpfc_tracker.py

import logging
import threading
import time
import numpy as np


# 鍏叡鐨勫伐鍏峰嚱鏁扮敤浜庡畾鐐规暟杞崲
from linien_server.tracking.fixed_point_utils import FixedPointConverter
# 瀵煎叆鎮ㄧ殑鍗″皵鏇兼护娉㈠櫒绫?
from linien_server.kalman_filter import KalmanFilterTimeFrequency

logger = logging.getLogger(__name__)


class TPFCTrackerService(threading.Thread):
    """
    鐙珛鐨?TPFC 璺熻釜鏈嶅姟锛屽懆鏈熸€ф墽琛屽崱灏旀浖婊ゆ尝骞舵洿鏂?PID 鐩爣銆?
    """
    def __init__(self, device, kalman_params, loop_interval_s=0.001):
        # loop_interval_s 鍐冲畾浜?Kalman Filter 鐨勬洿鏂伴鐜囷紙渚嬪 1000 Hz锛?
        super().__init__()
        self.device = device
        self.loop_interval = loop_interval_s
        self.params = dict(kalman_params)
        self.params.setdefault("dt", self.loop_interval)

        self._stop_event = threading.Event()
        # 鍏充簬瀵勫瓨鍣ㄨ鍐欐搷浣滃湪registers涓繘琛屽畾涔夛紝鍦ㄥ崱灏旀浖绾跨▼涓彧闇€瑕佽皟鐢ㄥ嵆鍙?
        self.registers = device

        # --- III. 鍗″皵鏇兼护娉㈠櫒瀹炰緥鍖?---
        self.kf = KalmanFilterTimeFrequency(
            **self.params             # 浣跨敤鍙傛暟浼犻€掓潵閰嶇疆
        )

        # --- IV. 瀹氱偣鏁拌浆鎹㈠弬鏁?(闇€涓?FPGA 浣嶅涓€鑷? ---
        self.FP_WIDTH = 25
        self.FP_FRAC_BITS = 10
        # 瀹為檯鏍″噯鍥犲瓙搴旈€氳繃瀹為獙纭畾
        self.scale_factor_E = 1.0  # 璇樊淇″彿瀹氱偣鏁板埌鏃堕棿(s)鐨勮浆鎹㈠洜瀛?
        self.scale_factor_P = 1.0  # 鍔熺巼瀹氱偣鏁板埌鍔熺巼(W)鐨勮浆鎹㈠洜瀛?
        self._initialized_from_fpga = False

    def stop(self):
        self._stop_event.set()

    def read_scan_tracking_status(self) -> dict[str, int]:
        """Return PL scan-tracking status (FSM + time-command output).

        The values originate from the ``ScanTrackingController`` CSRs exposed as
        ``scan_tracker_fsm_state`` and ``scan_tracker_time_command_out`` in the
        CSR map. This allows PS-side services or diagnostics to observe PL scan
        behavior without touching the gateware directly.
        """

        return self.registers.read_scan_tracker_status()


    def run(self):
        logger.info(f"TPFC 璺熻釜鏈嶅姟鍚姩锛屾洿鏂伴鐜? {1 / self.loop_interval} Hz")
        while not self._stop_event.is_set():
            start_time = time.time()
            try:
                self.process_tracking_step()
            except Exception as e:
                logger.error(f"TPFC 璺熻釜寰幆涓彂鐢熼敊璇? {e}")

            # 鎺у埗寰幆閫熺巼
            elapsed_time = time.time() - start_time
            sleep_time = self.loop_interval - elapsed_time
            if sleep_time > 0:
                time.sleep(sleep_time)

    def _read_measurements(self):
        """浠?CSR 璇诲彇骞惰浆鎹㈣宸?鍔熺巼娴嬮噺鍊硷紝杩斿洖娴偣鐗╃悊閲忋€?"""

        raw_e = self.registers.read_error_signal()
        raw_p = self.registers.read_power_signal()

        z_measurement = FixedPointConverter.fixed_to_float(
            raw_e, self.FP_WIDTH, self.FP_FRAC_BITS
        ) * self.scale_factor_E
        P_received_power = FixedPointConverter.fixed_to_unsigned_float(
            raw_p, self.FP_WIDTH, self.FP_FRAC_BITS
        ) * self.scale_factor_P

        return z_measurement, P_received_power


    def process_tracking_step(self):
        """鎵ц涓€娆″畬鏁寸殑璇?婊ゆ尝-鍐欏惊鐜?"""
        # 1. 璇诲彇 FPGA 杈撳叆
        # raw_e = self.csr_error_signal.read()
        try:
            z_measurement, P_received_power = self._read_measurements()
        except Exception:  # 璇诲彇鎴栬浆鎹㈠紓甯告椂璺宠繃鏈懆鏈?
            logger.exception("璇诲彇璇樊/鍔熺巼瀵勫瓨鍣ㄥけ璐ワ紝璺宠繃鏈懆鏈熴€?)
            return
        logger.debug(
            "TPFC 娴嬮噺璇诲彇: z=%s, P=%s",
            z_measurement,
            P_received_power,
        )

        # 淇濇姢锛氬鏋滄祴閲忔垨鍔熺巼鍊间负 NaN/Inf锛屽垯涓嶆洿鏂版护娉㈠櫒锛岄伩鍏嶇牬鍧忕姸鎬佺煩闃?
        if not np.isfinite(z_measurement) or not np.isfinite(P_received_power):
            logger.warning(
                "妫€娴嬪埌闈炴湁闄愭祴閲忓€?z=%s, P=%s)锛岃烦杩囨湰鍛ㄦ湡銆?,
                z_measurement,
                P_received_power,
            )
            return
        if not self._initialized_from_fpga:
            # 浣跨敤 FPGA 璇樊淇″彿浣滀负鍒濆鏃堕棿鍋忕Щ浼拌锛岀瓑寰呬笅涓€鍛ㄦ湡鍐嶉娴?鏇存柊
            self.kf.x[0, 0] = z_measurement
            self._initialized_from_fpga = True
            logger.info(
                "TPFC Kalman 鍒濆鐘舵€佸凡鏍规嵁 FPGA 璇樊淇″彿鍒濆鍖? z=%s",
                z_measurement,
            )
            return

        # 3. 鍗″皵鏇兼护娉㈣繍绠?
        self.kf.predict()
        self.kf.update(z_measurement, P_received_power)

        # 4. 鎻愬彇 PID 鎵€闇€鐨勬渶浼樹及璁″€?
        estimated_X_offset = self.kf.x[0, 0]  # 鏈€浼樻椂闂村亸绉讳及璁?(s)
        estimated_F_offset = self.kf.x[1, 0]  # 鏈€浼橀鐜囧亸绉讳及璁?(Hz)

        time_variance = max(self.kf.P[0, 0], 0)  # 鎻愬彇鏃堕棿鍋忕Щ鐨勬柟宸苟瑁佸壀璐熷€?
        time_uncertainty = np.sqrt(time_variance)  # 鍗曚綅锛氱
        if time_uncertainty > 0:
            min_time_uncertainty = 1 / (1 << self.FP_FRAC_BITS)
            time_uncertainty = max(time_uncertainty, min_time_uncertainty)
        power_threshold = self.kf.power_threshold
        logger.debug(
            "TPFC 浼拌鍊? x_offset=%s, f_offset=%s, time_uncertainty=%s, power_threshold=%s",
            estimated_X_offset,
            estimated_F_offset,
            time_uncertainty,
            power_threshold,
        )

        # 5. 杞崲涓?FPGA 瀹氱偣鏁?(鍐欏叆鐩爣鍊?
        # 纭繚杈撳嚭鐨勫畾鐐规暟鑳借 PID 姝ｇ‘瑙ｆ瀽
        raw_x_target = FixedPointConverter.float_to_fixed(
            estimated_X_offset, self.FP_WIDTH, self.FP_FRAC_BITS
        )
        raw_f_target = FixedPointConverter.float_to_fixed(
            estimated_F_offset, self.FP_WIDTH, self.FP_FRAC_BITS
        )
        raw_time_uncertain_target = FixedPointConverter.float_to_fixed(
            time_uncertainty, self.FP_WIDTH, self.FP_FRAC_BITS
        )
        raw_power_threshold_target = FixedPointConverter.float_to_fixed(
            power_threshold, self.FP_WIDTH, self.FP_FRAC_BITS
        )
        signed_x_target = FixedPointConverter.fixed_to_signed_int(
            raw_x_target, self.FP_WIDTH
        )
        signed_f_target = FixedPointConverter.fixed_to_signed_int(
            raw_f_target, self.FP_WIDTH
        )
        signed_time_uncertain_target = FixedPointConverter.fixed_to_signed_int(
            raw_time_uncertain_target, self.FP_WIDTH
        )
        signed_power_threshold_target = FixedPointConverter.fixed_to_signed_int(
            raw_power_threshold_target, self.FP_WIDTH
        )
        logger.debug(
            "TPFC 瀹氱偣鏁扮洰鏍? x=%s, f=%s, time_uncertainty=%s, power_threshold=%s",
            signed_x_target,
            signed_f_target,
            signed_time_uncertain_target,
            signed_power_threshold_target,
        )
        # 6. 鍐欏叆 CSR Storage锛屾洿鏂?PID 鐨勭洰鏍囪瀹氬€?
        self.registers.write_kalman_targets(
            raw_x_target,
            raw_f_target,
            raw_time_uncertain_target,
            raw_power_threshold_target,
        )
