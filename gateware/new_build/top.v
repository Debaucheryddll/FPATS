/* Machine-generated using Migen */
module top(
	inout [53:0] cpu_mio,
	inout cpu_ps_clk,
	inout cpu_ps_porb,
	inout cpu_ps_srstb,
	inout cpu_ddr_vrn,
	inout cpu_ddr_vrp,
	inout [14:0] cpu_DDR_addr,
	inout [2:0] cpu_DDR_ba,
	inout cpu_DDR_cas_n,
	inout cpu_DDR_ck_n,
	inout cpu_DDR_ck_p,
	inout cpu_DDR_cke,
	inout cpu_DDR_cs_n,
	inout [3:0] cpu_DDR_dm,
	inout [31:0] cpu_DDR_dq,
	inout [3:0] cpu_DDR_dqs_n,
	inout [3:0] cpu_DDR_dqs_p,
	inout cpu_DDR_odt,
	inout cpu_DDR_ras_n,
	inout cpu_DDR_reset_n,
	inout cpu_DDR_we_n,
	input clk125_p,
	input clk125_n,
	output [1:0] adc_clk,
	output adc_cdcs,
	input [15:0] adc_data_a,
	input [15:0] adc_data_b,
	output [13:0] dac_data,
	output dac_wrt,
	output dac_sel,
	output dac_rst,
	output dac_clk,
	input [4:0] xadc_p,
	input [4:0] xadc_n,
	output pwm,
	output pwm_1,
	output pwm_2,
	output pwm_3,
	inout [7:0] exp_p,
	inout [7:0] exp_n,
	output user_led,
	output user_led_1,
	output user_led_2,
	output user_led_3,
	output user_led_4,
	output user_led_5,
	output user_led_6,
	output user_led_7
);

wire [3:0] ps_fclk;
wire [3:0] ps_frstn;
wire ps_sys_rstn;
wire ps_sys_clk;
wire [31:0] ps_sys_addr;
wire [31:0] ps_sys_wdata;
wire [3:0] ps_sys_sel;
wire ps_sys_wen;
wire ps_sys_ren;
wire [31:0] ps_sys_rdata;
wire ps_sys_err;
wire ps_sys_ack;
wire ps_axi_arvalid;
wire ps_axi_awvalid;
wire ps_axi_bready;
wire ps_axi_rready;
wire ps_axi_wlast;
wire ps_axi_wvalid;
wire [11:0] ps_axi_arid;
wire [11:0] ps_axi_awid;
wire [11:0] ps_axi_wid;
wire [1:0] ps_axi_arburst;
wire [1:0] ps_axi_arlock;
wire [2:0] ps_axi_arsize;
wire [1:0] ps_axi_awburst;
wire [1:0] ps_axi_awlock;
wire [2:0] ps_axi_awsize;
wire [2:0] ps_axi_arprot;
wire [2:0] ps_axi_awprot;
wire [31:0] ps_axi_araddr;
wire [31:0] ps_axi_awaddr;
wire [31:0] ps_axi_wdata;
wire [3:0] ps_axi_arcache;
wire [3:0] ps_axi_arlen;
wire [3:0] ps_axi_arqos;
wire [3:0] ps_axi_awcache;
wire [3:0] ps_axi_awlen;
wire [3:0] ps_axi_awqos;
wire [3:0] ps_axi_wstrb;
wire ps_axi_aclk;
wire ps_axi_arready;
wire ps_axi_awready;
wire ps_axi_bvalid;
wire ps_axi_rlast;
wire ps_axi_rvalid;
wire ps_axi_wready;
wire [11:0] ps_axi_bid;
wire [11:0] ps_axi_rid;
wire [1:0] ps_axi_bresp;
wire [1:0] ps_axi_rresp;
wire [31:0] ps_axi_rdata;
wire ps_axi_arstn;
wire sys_quad_clk;
wire sys_double_clk;
wire sys_clk;
wire sys_rst;
wire sys_slow_clk;
wire sys_ps_clk;
wire sys_ps_rst;
wire clk_adci;
wire clk_adcb;
wire [5:0] clk;
wire clk_fb;
wire clk_fbb;
wire locked;
reg linien_logic_pid_only_mode_storage_full = 1'd0;
wire linien_logic_pid_only_mode_storage;
reg linien_logic_pid_only_mode_re = 1'd0;
reg [8:0] linien_logic_chain_a_factor_storage_full = 9'd128;
wire [8:0] linien_logic_chain_a_factor_storage;
reg linien_logic_chain_a_factor_re = 1'd0;
reg [8:0] linien_logic_chain_b_factor_storage_full = 9'd128;
wire [8:0] linien_logic_chain_b_factor_storage;
reg linien_logic_chain_b_factor_re = 1'd0;
reg [13:0] linien_logic_chain_a_offset_storage_full = 14'd0;
wire [13:0] linien_logic_chain_a_offset_storage;
reg linien_logic_chain_a_offset_re = 1'd0;
reg [13:0] linien_logic_chain_b_offset_storage_full = 14'd0;
wire [13:0] linien_logic_chain_b_offset_storage;
reg linien_logic_chain_b_offset_re = 1'd0;
reg [13:0] linien_logic_combined_offset_storage_full = 14'd0;
wire [13:0] linien_logic_combined_offset_storage;
reg linien_logic_combined_offset_re = 1'd0;
reg [13:0] linien_logic_out_offset_storage_full = 14'd0;
wire [13:0] linien_logic_out_offset_storage;
reg linien_logic_out_offset_re = 1'd0;
reg [4:0] linien_logic_slow_decimation_storage_full = 5'd0;
wire [4:0] linien_logic_slow_decimation_storage;
reg linien_logic_slow_decimation_re = 1'd0;
reg [14:0] linien_logic_csrstorage0_storage_full = 15'd0;
wire [14:0] linien_logic_csrstorage0_storage;
reg linien_logic_csrstorage0_re = 1'd0;
reg [14:0] linien_logic_csrstorage1_storage_full = 15'd0;
wire [14:0] linien_logic_csrstorage1_storage;
reg linien_logic_csrstorage1_re = 1'd0;
reg [14:0] linien_logic_csrstorage2_storage_full = 15'd0;
wire [14:0] linien_logic_csrstorage2_storage;
reg linien_logic_csrstorage2_re = 1'd0;
reg [13:0] linien_logic_status = 14'd0;
reg signed [13:0] linien_logic_chain_a_offset_signed = 14'sd0;
reg signed [13:0] linien_logic_chain_b_offset_signed = 14'sd0;
reg signed [13:0] linien_logic_modulate_x = 14'sd0;
wire signed [13:0] linien_logic_modulate_y;
reg [13:0] linien_logic_amp_storage_full = 14'd0;
wire [13:0] linien_logic_amp_storage;
reg linien_logic_amp_re = 1'd0;
reg [31:0] linien_logic_freq_storage_full = 32'd0;
wire [31:0] linien_logic_freq_storage;
reg linien_logic_freq_re = 1'd0;
wire [13:0] linien_logic_phase;
reg linien_logic_sync_phase = 1'd0;
reg [31:0] linien_logic_z = 32'd0;
reg linien_logic_stop = 1'd0;
reg signed [14:0] linien_logic_cordic_xi0;
reg signed [14:0] linien_logic_cordic_yi0;
reg signed [14:0] linien_logic_cordic_zi0;
wire signed [14:0] linien_logic_cordic_xo;
wire signed [14:0] linien_logic_cordic_yo;
wire signed [14:0] linien_logic_cordic_zo;
wire linien_logic_cordic_new_in;
wire linien_logic_cordic_new_out;
wire signed [16:0] linien_logic_cordic_x0;
reg signed [16:0] linien_logic_cordic_x1 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x2 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x3 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x4 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x5 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x6 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x7 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x8 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x9 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x10 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x11 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x12 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x13 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x14 = 17'sd0;
reg signed [16:0] linien_logic_cordic_x15 = 17'sd0;
wire signed [16:0] linien_logic_cordic_y0;
reg signed [16:0] linien_logic_cordic_y1 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y2 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y3 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y4 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y5 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y6 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y7 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y8 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y9 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y10 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y11 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y12 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y13 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y14 = 17'sd0;
reg signed [16:0] linien_logic_cordic_y15 = 17'sd0;
wire signed [16:0] linien_logic_cordic_z0;
reg signed [16:0] linien_logic_cordic_z1 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z2 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z3 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z4 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z5 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z6 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z7 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z8 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z9 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z10 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z11 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z12 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z13 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z14 = 17'sd0;
reg signed [16:0] linien_logic_cordic_z15 = 17'sd0;
wire linien_logic_cordic_dir0;
wire linien_logic_cordic_dir1;
wire linien_logic_cordic_dir2;
wire linien_logic_cordic_dir3;
wire linien_logic_cordic_dir4;
wire linien_logic_cordic_dir5;
wire linien_logic_cordic_dir6;
wire linien_logic_cordic_dir7;
wire linien_logic_cordic_dir8;
wire linien_logic_cordic_dir9;
wire linien_logic_cordic_dir10;
wire linien_logic_cordic_dir11;
wire linien_logic_cordic_dir12;
wire linien_logic_cordic_dir13;
wire linien_logic_cordic_dir14;
wire signed [14:0] linien_logic_cordic_xi1;
reg signed [14:0] linien_logic_cordic_yi1 = 15'sd0;
wire signed [14:0] linien_logic_cordic_zi1;
wire linien_logic_cordic_q;
reg signed [24:0] linien_logic_limit_error_signal_limitcsr_y = 25'sd0;
reg linien_logic_limit_error_signal_limitcsr_error = 1'd0;
reg signed [28:0] linien_logic_limit_error_signal_x = 29'sd0;
reg [24:0] linien_logic_limit_error_signal_min_storage_full = 25'd16777216;
wire [24:0] linien_logic_limit_error_signal_min_storage;
reg linien_logic_limit_error_signal_min_re = 1'd0;
reg [24:0] linien_logic_limit_error_signal_max_storage_full = 25'd16777215;
wire [24:0] linien_logic_limit_error_signal_max_storage;
reg linien_logic_limit_error_signal_max_re = 1'd0;
wire signed [28:0] linien_logic_limit_error_signal_limit_x;
reg signed [28:0] linien_logic_limit_error_signal_limit_y;
reg signed [28:0] linien_logic_limit_error_signal_limit_max = 29'sd0;
reg signed [28:0] linien_logic_limit_error_signal_limit_min = 29'sd0;
reg linien_logic_limit_error_signal_limit_railed;
reg signed [13:0] linien_logic_limit_fast1_limitcsr_y = 14'sd0;
reg linien_logic_limit_fast1_limitcsr_error = 1'd0;
wire signed [18:0] linien_logic_limit_fast1_x;
reg [13:0] linien_logic_limit_fast1_min_storage_full = 14'd8192;
wire [13:0] linien_logic_limit_fast1_min_storage;
reg linien_logic_limit_fast1_min_re = 1'd0;
reg [13:0] linien_logic_limit_fast1_max_storage_full = 14'd8191;
wire [13:0] linien_logic_limit_fast1_max_storage;
reg linien_logic_limit_fast1_max_re = 1'd0;
wire signed [18:0] linien_logic_limit_fast1_limit_x;
reg signed [18:0] linien_logic_limit_fast1_limit_y;
reg signed [18:0] linien_logic_limit_fast1_limit_max = 19'sd0;
reg signed [18:0] linien_logic_limit_fast1_limit_min = 19'sd0;
reg linien_logic_limit_fast1_limit_railed;
reg signed [13:0] linien_logic_limit_fast2_limitcsr_y = 14'sd0;
reg linien_logic_limit_fast2_limitcsr_error = 1'd0;
reg signed [18:0] linien_logic_limit_fast2_x = 19'sd0;
reg [13:0] linien_logic_limit_fast2_min_storage_full = 14'd8192;
wire [13:0] linien_logic_limit_fast2_min_storage;
reg linien_logic_limit_fast2_min_re = 1'd0;
reg [13:0] linien_logic_limit_fast2_max_storage_full = 14'd8191;
wire [13:0] linien_logic_limit_fast2_max_storage;
reg linien_logic_limit_fast2_max_re = 1'd0;
wire signed [18:0] linien_logic_limit_fast2_limit_x;
reg signed [18:0] linien_logic_limit_fast2_limit_y;
reg signed [18:0] linien_logic_limit_fast2_limit_max = 19'sd0;
reg signed [18:0] linien_logic_limit_fast2_limit_min = 19'sd0;
reg linien_logic_limit_fast2_limit_railed;
reg signed [24:0] linien_logic_input;
wire linien_logic_running;
reg [24:0] linien_logic_setpoint_storage_full = 25'd0;
wire [24:0] linien_logic_setpoint_storage;
reg linien_logic_setpoint_re = 1'd0;
wire signed [24:0] linien_logic_setpoint_signed;
reg signed [25:0] linien_logic_error;
reg [13:0] linien_logic_kp_storage_full = 14'd0;
wire [13:0] linien_logic_kp_storage;
reg linien_logic_kp_re = 1'd0;
wire signed [13:0] linien_logic_kp_signed;
wire signed [38:0] linien_logic_kp_mult;
wire signed [24:0] linien_logic_output_p;
reg [13:0] linien_logic_ki_storage_full = 14'd0;
wire [13:0] linien_logic_ki_storage;
reg linien_logic_ki_re = 1'd0;
reg linien_logic_reset_storage_full = 1'd0;
wire linien_logic_reset_storage;
reg linien_logic_reset_re = 1'd0;
wire signed [13:0] linien_logic_ki_signed;
wire signed [39:0] linien_logic_ki_mult;
reg signed [42:0] linien_logic_int_reg = 43'sd0;
wire signed [43:0] linien_logic_int_sum;
wire signed [24:0] linien_logic_int_out;
reg [13:0] linien_logic_kd_storage_full = 14'd0;
wire [13:0] linien_logic_kd_storage;
reg linien_logic_kd_re = 1'd0;
wire signed [13:0] linien_logic_kd_signed;
wire signed [40:0] linien_logic_kd_mult;
reg signed [33:0] linien_logic_kd_reg = 34'sd0;
reg signed [33:0] linien_logic_kd_reg_r = 34'sd0;
reg signed [33:0] linien_logic_output_d = 34'sd0;
reg signed [83:0] linien_logic_pid_sum = 84'sd0;
reg signed [24:0] linien_logic_pid_out;
wire signed [13:0] linien_logic_control_signal;
wire signed [13:0] linien_analog_adc_a;
wire signed [13:0] linien_analog_adc_b;
wire signed [13:0] linien_analog_dac_a;
wire signed [13:0] linien_analog_dac_b;
reg [15:0] linien_analog_adca = 16'd0;
reg [15:0] linien_analog_adcb = 16'd0;
reg [13:0] linien_analog_daca = 14'd0;
reg [13:0] linien_analog_dacb = 14'd0;
wire [7:0] linien_xadc_alarm;
wire linien_xadc_ot;
wire signed [11:0] linien_xadc_adc0;
wire signed [11:0] linien_xadc_adc1;
wire signed [11:0] linien_xadc_adc2;
wire signed [11:0] linien_xadc_adc3;
reg [11:0] linien_xadc_temp_status = 12'd0;
reg [11:0] linien_xadc_v_status = 12'd0;
reg [11:0] linien_xadc_a_status = 12'd0;
reg [11:0] linien_xadc_b_status = 12'd0;
reg [11:0] linien_xadc_c_status = 12'd0;
reg [11:0] linien_xadc_d_status = 12'd0;
wire linien_xadc_busy;
wire [6:0] linien_xadc_channel;
wire linien_xadc_eoc;
wire linien_xadc_eos;
wire [15:0] linien_xadc_data;
wire linien_xadc_drdy;
reg [14:0] linien_deltasigma0_data = 15'd0;
wire linien_deltasigma0_out;
wire [15:0] linien_deltasigma0_delta;
reg [15:0] linien_deltasigma0_sigma = 16'd0;
wire [14:0] linien_deltasigma1_data;
wire linien_deltasigma1_out;
wire [15:0] linien_deltasigma1_delta;
reg [15:0] linien_deltasigma1_sigma = 16'd0;
wire [14:0] linien_deltasigma2_data;
wire linien_deltasigma2_out;
wire [15:0] linien_deltasigma2_delta;
reg [15:0] linien_deltasigma2_sigma = 16'd0;
wire [14:0] linien_deltasigma3_data;
wire linien_deltasigma3_out;
wire [15:0] linien_deltasigma3_delta;
reg [15:0] linien_deltasigma3_sigma = 16'd0;
wire [7:0] linien_gpio_n_i;
reg [7:0] linien_gpio_n_o = 8'd0;
wire [7:0] linien_gpio_n_status;
reg [7:0] linien_gpio_n_outs_storage_full = 8'd0;
wire [7:0] linien_gpio_n_outs_storage;
reg linien_gpio_n_outs_re = 1'd0;
reg [7:0] linien_gpio_n_oes_storage_full = 8'd0;
wire [7:0] linien_gpio_n_oes_storage;
reg linien_gpio_n_oes_re = 1'd0;
wire linien_gpio_n_tstriple0_o;
wire linien_gpio_n_tstriple0_oe;
wire linien_gpio_n_tstriple0_i;
wire linien_gpio_n_tstriple1_o;
wire linien_gpio_n_tstriple1_oe;
wire linien_gpio_n_tstriple1_i;
wire linien_gpio_n_tstriple2_o;
wire linien_gpio_n_tstriple2_oe;
wire linien_gpio_n_tstriple2_i;
wire linien_gpio_n_tstriple3_o;
wire linien_gpio_n_tstriple3_oe;
wire linien_gpio_n_tstriple3_i;
wire linien_gpio_n_tstriple4_o;
wire linien_gpio_n_tstriple4_oe;
wire linien_gpio_n_tstriple4_i;
wire linien_gpio_n_tstriple5_o;
wire linien_gpio_n_tstriple5_oe;
wire linien_gpio_n_tstriple5_i;
wire linien_gpio_n_tstriple6_o;
wire linien_gpio_n_tstriple6_oe;
wire linien_gpio_n_tstriple6_i;
wire linien_gpio_n_tstriple7_o;
wire linien_gpio_n_tstriple7_oe;
wire linien_gpio_n_tstriple7_i;
wire [7:0] linien_gpio_p_i;
reg [7:0] linien_gpio_p_o = 8'd0;
wire [7:0] linien_gpio_p_status;
reg [7:0] linien_gpio_p_outs_storage_full = 8'd0;
wire [7:0] linien_gpio_p_outs_storage;
reg linien_gpio_p_outs_re = 1'd0;
reg [7:0] linien_gpio_p_oes_storage_full = 8'd0;
wire [7:0] linien_gpio_p_oes_storage;
reg linien_gpio_p_oes_re = 1'd0;
wire linien_gpio_p_tstriple0_o;
wire linien_gpio_p_tstriple0_oe;
wire linien_gpio_p_tstriple0_i;
wire linien_gpio_p_tstriple1_o;
wire linien_gpio_p_tstriple1_oe;
wire linien_gpio_p_tstriple1_i;
wire linien_gpio_p_tstriple2_o;
wire linien_gpio_p_tstriple2_oe;
wire linien_gpio_p_tstriple2_i;
wire linien_gpio_p_tstriple3_o;
wire linien_gpio_p_tstriple3_oe;
wire linien_gpio_p_tstriple3_i;
wire linien_gpio_p_tstriple4_o;
wire linien_gpio_p_tstriple4_oe;
wire linien_gpio_p_tstriple4_i;
wire linien_gpio_p_tstriple5_o;
wire linien_gpio_p_tstriple5_oe;
wire linien_gpio_p_tstriple5_i;
wire linien_gpio_p_tstriple6_o;
wire linien_gpio_p_tstriple6_oe;
wire linien_gpio_p_tstriple6_i;
wire linien_gpio_p_tstriple7_o;
wire linien_gpio_p_tstriple7_oe;
wire linien_gpio_p_tstriple7_i;
reg [63:0] linien_dna_status = 64'd288230376151711744;
wire linien_dna_do;
reg [7:0] linien_dna_cnt = 8'd0;
wire signed [13:0] linien_fast_a_adc;
wire signed [24:0] linien_fast_a_out_i;
wire signed [24:0] linien_fast_a_out_q;
reg [1:0] linien_fast_a_y_tap_storage_full = 2'd0;
wire [1:0] linien_fast_a_y_tap_storage;
reg linien_fast_a_y_tap_re = 1'd0;
reg linien_fast_a_invert_storage_full = 1'd0;
wire linien_fast_a_invert_storage;
reg linien_fast_a_invert_re = 1'd0;
wire signed [24:0] linien_fast_a_x0;
reg signed [24:0] linien_fast_a_dx = 25'sd0;
reg signed [24:0] linien_fast_a_dy = 25'sd0;
wire signed [13:0] linien_fast_a_x1;
wire signed [13:0] linien_fast_a_i;
wire signed [13:0] linien_fast_a_q0;
reg [31:0] linien_fast_a_delay_storage_full = 32'd0;
wire [31:0] linien_fast_a_delay_storage;
reg linien_fast_a_delay_re = 1'd0;
reg [3:0] linien_fast_a_multiplier_storage_full = 4'd1;
wire [3:0] linien_fast_a_multiplier_storage;
reg linien_fast_a_multiplier_re = 1'd0;
wire [13:0] linien_fast_a_phase;
reg signed [14:0] linien_fast_a_xi0;
reg signed [14:0] linien_fast_a_yi0;
reg signed [14:0] linien_fast_a_zi0;
wire signed [14:0] linien_fast_a_xo;
wire signed [14:0] linien_fast_a_yo;
wire signed [14:0] linien_fast_a_zo;
wire linien_fast_a_new_in;
wire linien_fast_a_new_out;
wire signed [16:0] linien_fast_a_x2;
reg signed [16:0] linien_fast_a_x3 = 17'sd0;
reg signed [16:0] linien_fast_a_x4 = 17'sd0;
reg signed [16:0] linien_fast_a_x5 = 17'sd0;
reg signed [16:0] linien_fast_a_x6 = 17'sd0;
reg signed [16:0] linien_fast_a_x7 = 17'sd0;
reg signed [16:0] linien_fast_a_x8 = 17'sd0;
reg signed [16:0] linien_fast_a_x9 = 17'sd0;
reg signed [16:0] linien_fast_a_x10 = 17'sd0;
reg signed [16:0] linien_fast_a_x11 = 17'sd0;
reg signed [16:0] linien_fast_a_x12 = 17'sd0;
reg signed [16:0] linien_fast_a_x13 = 17'sd0;
reg signed [16:0] linien_fast_a_x14 = 17'sd0;
reg signed [16:0] linien_fast_a_x15 = 17'sd0;
reg signed [16:0] linien_fast_a_x16 = 17'sd0;
reg signed [16:0] linien_fast_a_x17 = 17'sd0;
wire signed [16:0] linien_fast_a_y0;
reg signed [16:0] linien_fast_a_y1 = 17'sd0;
reg signed [16:0] linien_fast_a_y2 = 17'sd0;
reg signed [16:0] linien_fast_a_y3 = 17'sd0;
reg signed [16:0] linien_fast_a_y4 = 17'sd0;
reg signed [16:0] linien_fast_a_y5 = 17'sd0;
reg signed [16:0] linien_fast_a_y6 = 17'sd0;
reg signed [16:0] linien_fast_a_y7 = 17'sd0;
reg signed [16:0] linien_fast_a_y8 = 17'sd0;
reg signed [16:0] linien_fast_a_y9 = 17'sd0;
reg signed [16:0] linien_fast_a_y10 = 17'sd0;
reg signed [16:0] linien_fast_a_y11 = 17'sd0;
reg signed [16:0] linien_fast_a_y12 = 17'sd0;
reg signed [16:0] linien_fast_a_y13 = 17'sd0;
reg signed [16:0] linien_fast_a_y14 = 17'sd0;
reg signed [16:0] linien_fast_a_y15 = 17'sd0;
wire signed [16:0] linien_fast_a_z0;
reg signed [16:0] linien_fast_a_z1 = 17'sd0;
reg signed [16:0] linien_fast_a_z2 = 17'sd0;
reg signed [16:0] linien_fast_a_z3 = 17'sd0;
reg signed [16:0] linien_fast_a_z4 = 17'sd0;
reg signed [16:0] linien_fast_a_z5 = 17'sd0;
reg signed [16:0] linien_fast_a_z6 = 17'sd0;
reg signed [16:0] linien_fast_a_z7 = 17'sd0;
reg signed [16:0] linien_fast_a_z8 = 17'sd0;
reg signed [16:0] linien_fast_a_z9 = 17'sd0;
reg signed [16:0] linien_fast_a_z10 = 17'sd0;
reg signed [16:0] linien_fast_a_z11 = 17'sd0;
reg signed [16:0] linien_fast_a_z12 = 17'sd0;
reg signed [16:0] linien_fast_a_z13 = 17'sd0;
reg signed [16:0] linien_fast_a_z14 = 17'sd0;
reg signed [16:0] linien_fast_a_z15 = 17'sd0;
wire linien_fast_a_dir0;
wire linien_fast_a_dir1;
wire linien_fast_a_dir2;
wire linien_fast_a_dir3;
wire linien_fast_a_dir4;
wire linien_fast_a_dir5;
wire linien_fast_a_dir6;
wire linien_fast_a_dir7;
wire linien_fast_a_dir8;
wire linien_fast_a_dir9;
wire linien_fast_a_dir10;
wire linien_fast_a_dir11;
wire linien_fast_a_dir12;
wire linien_fast_a_dir13;
wire linien_fast_a_dir14;
wire signed [14:0] linien_fast_a_xi1;
reg signed [14:0] linien_fast_a_yi1 = 15'sd0;
wire signed [14:0] linien_fast_a_zi1;
wire linien_fast_a_q1;
reg signed [16:0] linien_fast_a_ya = 17'sd0;
reg signed [24:0] linien_fast_a_limitcsr0_limitcsr0_y0 = 25'sd0;
reg linien_fast_a_limitcsr0_limitcsr0_error0 = 1'd0;
wire signed [25:0] linien_fast_a_limitcsr0_x0;
reg [24:0] linien_fast_a_limitcsr0_min_storage_full0 = 25'd16777216;
wire [24:0] linien_fast_a_limitcsr0_min_storage0;
reg linien_fast_a_limitcsr0_min_re0 = 1'd0;
reg [24:0] linien_fast_a_limitcsr0_max_storage_full0 = 25'd16777215;
wire [24:0] linien_fast_a_limitcsr0_max_storage0;
reg linien_fast_a_limitcsr0_max_re0 = 1'd0;
wire signed [25:0] linien_fast_a_limitcsr0_limit_x0;
reg signed [25:0] linien_fast_a_limitcsr0_limit_y0;
reg signed [25:0] linien_fast_a_limitcsr0_limit_max0 = 26'sd0;
reg signed [25:0] linien_fast_a_limitcsr0_limit_min0 = 26'sd0;
reg linien_fast_a_limitcsr0_limit_railed0;
wire signed [24:0] linien_fast_a_iir0_x0;
reg signed [24:0] linien_fast_a_iir0_y0 = 25'sd0;
wire linien_fast_a_iir0_hold0;
wire linien_fast_a_iir0_clear0;
reg linien_fast_a_iir0_error0 = 1'd0;
reg [26:0] linien_fast_a_iir0_storage_full0 = 27'd0;
wire [26:0] linien_fast_a_iir0_storage0;
reg linien_fast_a_iir0_re0 = 1'd0;
reg signed [24:0] linien_fast_a_iir0_a10 = 25'sd0;
reg [24:0] linien_fast_a_iir0_csrstorage0_storage_full0 = 25'd0;
wire [24:0] linien_fast_a_iir0_csrstorage0_storage0;
reg linien_fast_a_iir0_csrstorage0_re0 = 1'd0;
reg signed [24:0] linien_fast_a_iir0_b00 = 25'sd0;
reg [24:0] linien_fast_a_iir0_csrstorage1_storage_full0 = 25'd0;
wire [24:0] linien_fast_a_iir0_csrstorage1_storage0;
reg linien_fast_a_iir0_csrstorage1_re0 = 1'd0;
reg signed [24:0] linien_fast_a_iir0_b10 = 25'sd0;
reg [24:0] linien_fast_a_iir0_csrstorage2_storage_full0 = 25'd0;
wire [24:0] linien_fast_a_iir0_csrstorage2_storage0;
reg linien_fast_a_iir0_csrstorage2_re0 = 1'd0;
reg signed [49:0] linien_fast_a_iir0_z0r0 = 50'sd0;
reg signed [24:0] linien_fast_a_iir0_y_lim0;
wire signed [49:0] linien_fast_a_iir0_y_next0;
reg [2:0] linien_fast_a_iir0_y_pat0 = 3'd7;
reg signed [24:0] linien_fast_a_iir0_y1 = 25'sd0;
wire linien_fast_a_iir0_railed0;
reg signed [49:0] linien_fast_a_iir0_zr0 = 50'sd0;
wire signed [49:0] linien_fast_a_iir0_z0;
reg signed [49:0] linien_fast_a_iir0_zr1 = 50'sd0;
wire signed [49:0] linien_fast_a_iir0_z1;
reg signed [49:0] linien_fast_a_iir0_zr2 = 50'sd0;
wire signed [49:0] linien_fast_a_iir0_z2;
wire signed [24:0] linien_fast_a_iir0_x1;
reg signed [24:0] linien_fast_a_iir0_y2 = 25'sd0;
wire linien_fast_a_iir0_hold1;
wire linien_fast_a_iir0_clear1;
reg linien_fast_a_iir0_error1 = 1'd0;
reg [26:0] linien_fast_a_iir0_storage_full1 = 27'd0;
wire [26:0] linien_fast_a_iir0_storage1;
reg linien_fast_a_iir0_re1 = 1'd0;
reg signed [24:0] linien_fast_a_iir0_a11 = 25'sd0;
reg [24:0] linien_fast_a_iir0_csrstorage0_storage_full1 = 25'd0;
wire [24:0] linien_fast_a_iir0_csrstorage0_storage1;
reg linien_fast_a_iir0_csrstorage0_re1 = 1'd0;
reg signed [24:0] linien_fast_a_iir0_a2 = 25'sd0;
reg [24:0] linien_fast_a_iir0_csrstorage1_storage_full1 = 25'd0;
wire [24:0] linien_fast_a_iir0_csrstorage1_storage1;
reg linien_fast_a_iir0_csrstorage1_re1 = 1'd0;
reg signed [24:0] linien_fast_a_iir0_b01 = 25'sd0;
reg [24:0] linien_fast_a_iir0_csrstorage2_storage_full1 = 25'd0;
wire [24:0] linien_fast_a_iir0_csrstorage2_storage1;
reg linien_fast_a_iir0_csrstorage2_re1 = 1'd0;
reg signed [24:0] linien_fast_a_iir0_b11 = 25'sd0;
reg [24:0] linien_fast_a_iir0_csrstorage3_storage_full = 25'd0;
wire [24:0] linien_fast_a_iir0_csrstorage3_storage;
reg linien_fast_a_iir0_csrstorage3_re = 1'd0;
reg signed [24:0] linien_fast_a_iir0_b2 = 25'sd0;
reg [24:0] linien_fast_a_iir0_csrstorage4_storage_full = 25'd0;
wire [24:0] linien_fast_a_iir0_csrstorage4_storage;
reg linien_fast_a_iir0_csrstorage4_re = 1'd0;
reg signed [49:0] linien_fast_a_iir0_z0r1 = 50'sd0;
reg signed [24:0] linien_fast_a_iir0_y_lim1;
wire signed [49:0] linien_fast_a_iir0_y_next1;
reg [2:0] linien_fast_a_iir0_y_pat1 = 3'd7;
reg signed [24:0] linien_fast_a_iir0_y3 = 25'sd0;
wire linien_fast_a_iir0_railed1;
reg signed [49:0] linien_fast_a_iir0_zr3 = 50'sd0;
wire signed [49:0] linien_fast_a_iir0_z3;
reg signed [49:0] linien_fast_a_iir0_zr4 = 50'sd0;
wire signed [49:0] linien_fast_a_iir0_z4;
reg signed [49:0] linien_fast_a_iir0_zr5 = 50'sd0;
wire signed [49:0] linien_fast_a_iir0_z5;
reg signed [49:0] linien_fast_a_iir0_zr6 = 50'sd0;
wire signed [49:0] linien_fast_a_iir0_z6;
reg signed [49:0] linien_fast_a_iir0_zr7 = 50'sd0;
wire signed [49:0] linien_fast_a_iir0_z7;
reg signed [24:0] linien_fast_a_limitcsr0_limitcsr0_y1 = 25'sd0;
reg linien_fast_a_limitcsr0_limitcsr0_error1 = 1'd0;
wire signed [27:0] linien_fast_a_limitcsr0_x1;
reg [24:0] linien_fast_a_limitcsr0_min_storage_full1 = 25'd16777216;
wire [24:0] linien_fast_a_limitcsr0_min_storage1;
reg linien_fast_a_limitcsr0_min_re1 = 1'd0;
reg [24:0] linien_fast_a_limitcsr0_max_storage_full1 = 25'd16777215;
wire [24:0] linien_fast_a_limitcsr0_max_storage1;
reg linien_fast_a_limitcsr0_max_re1 = 1'd0;
wire signed [27:0] linien_fast_a_limitcsr0_limit_x1;
reg signed [27:0] linien_fast_a_limitcsr0_limit_y1;
reg signed [27:0] linien_fast_a_limitcsr0_limit_max1 = 28'sd0;
reg signed [27:0] linien_fast_a_limitcsr0_limit_min1 = 28'sd0;
reg linien_fast_a_limitcsr0_limit_railed1;
reg signed [24:0] linien_fast_a_limitcsr1_limitcsr1_y0 = 25'sd0;
reg linien_fast_a_limitcsr1_limitcsr1_error0 = 1'd0;
wire signed [25:0] linien_fast_a_limitcsr1_x0;
reg [24:0] linien_fast_a_limitcsr1_min_storage_full0 = 25'd16777216;
wire [24:0] linien_fast_a_limitcsr1_min_storage0;
reg linien_fast_a_limitcsr1_min_re0 = 1'd0;
reg [24:0] linien_fast_a_limitcsr1_max_storage_full0 = 25'd16777215;
wire [24:0] linien_fast_a_limitcsr1_max_storage0;
reg linien_fast_a_limitcsr1_max_re0 = 1'd0;
wire signed [25:0] linien_fast_a_limitcsr1_limit_x0;
reg signed [25:0] linien_fast_a_limitcsr1_limit_y0;
reg signed [25:0] linien_fast_a_limitcsr1_limit_max0 = 26'sd0;
reg signed [25:0] linien_fast_a_limitcsr1_limit_min0 = 26'sd0;
reg linien_fast_a_limitcsr1_limit_railed0;
wire signed [24:0] linien_fast_a_iir1_x0;
reg signed [24:0] linien_fast_a_iir1_y0 = 25'sd0;
wire linien_fast_a_iir1_hold0;
wire linien_fast_a_iir1_clear0;
reg linien_fast_a_iir1_error0 = 1'd0;
reg [26:0] linien_fast_a_iir1_storage_full0 = 27'd0;
wire [26:0] linien_fast_a_iir1_storage0;
reg linien_fast_a_iir1_re0 = 1'd0;
reg signed [24:0] linien_fast_a_iir1_a10 = 25'sd0;
reg [24:0] linien_fast_a_iir1_csrstorage3_storage_full = 25'd0;
wire [24:0] linien_fast_a_iir1_csrstorage3_storage;
reg linien_fast_a_iir1_csrstorage3_re = 1'd0;
reg signed [24:0] linien_fast_a_iir1_b00 = 25'sd0;
reg [24:0] linien_fast_a_iir1_csrstorage4_storage_full = 25'd0;
wire [24:0] linien_fast_a_iir1_csrstorage4_storage;
reg linien_fast_a_iir1_csrstorage4_re = 1'd0;
reg signed [24:0] linien_fast_a_iir1_b10 = 25'sd0;
reg [24:0] linien_fast_a_iir1_csrstorage5_storage_full0 = 25'd0;
wire [24:0] linien_fast_a_iir1_csrstorage5_storage0;
reg linien_fast_a_iir1_csrstorage5_re0 = 1'd0;
reg signed [49:0] linien_fast_a_iir1_z0r0 = 50'sd0;
reg signed [24:0] linien_fast_a_iir1_y_lim0;
wire signed [49:0] linien_fast_a_iir1_y_next0;
reg [2:0] linien_fast_a_iir1_y_pat0 = 3'd7;
reg signed [24:0] linien_fast_a_iir1_y1 = 25'sd0;
wire linien_fast_a_iir1_railed0;
reg signed [49:0] linien_fast_a_iir1_zr0 = 50'sd0;
wire signed [49:0] linien_fast_a_iir1_z0;
reg signed [49:0] linien_fast_a_iir1_zr1 = 50'sd0;
wire signed [49:0] linien_fast_a_iir1_z1;
reg signed [49:0] linien_fast_a_iir1_zr2 = 50'sd0;
wire signed [49:0] linien_fast_a_iir1_z2;
wire signed [24:0] linien_fast_a_iir1_x1;
reg signed [24:0] linien_fast_a_iir1_y2 = 25'sd0;
wire linien_fast_a_iir1_hold1;
wire linien_fast_a_iir1_clear1;
reg linien_fast_a_iir1_error1 = 1'd0;
reg [26:0] linien_fast_a_iir1_storage_full1 = 27'd0;
wire [26:0] linien_fast_a_iir1_storage1;
reg linien_fast_a_iir1_re1 = 1'd0;
reg signed [24:0] linien_fast_a_iir1_a11 = 25'sd0;
reg [24:0] linien_fast_a_iir1_csrstorage5_storage_full1 = 25'd0;
wire [24:0] linien_fast_a_iir1_csrstorage5_storage1;
reg linien_fast_a_iir1_csrstorage5_re1 = 1'd0;
reg signed [24:0] linien_fast_a_iir1_a2 = 25'sd0;
reg [24:0] linien_fast_a_iir1_csrstorage6_storage_full = 25'd0;
wire [24:0] linien_fast_a_iir1_csrstorage6_storage;
reg linien_fast_a_iir1_csrstorage6_re = 1'd0;
reg signed [24:0] linien_fast_a_iir1_b01 = 25'sd0;
reg [24:0] linien_fast_a_iir1_csrstorage7_storage_full = 25'd0;
wire [24:0] linien_fast_a_iir1_csrstorage7_storage;
reg linien_fast_a_iir1_csrstorage7_re = 1'd0;
reg signed [24:0] linien_fast_a_iir1_b11 = 25'sd0;
reg [24:0] linien_fast_a_iir1_csrstorage8_storage_full = 25'd0;
wire [24:0] linien_fast_a_iir1_csrstorage8_storage;
reg linien_fast_a_iir1_csrstorage8_re = 1'd0;
reg signed [24:0] linien_fast_a_iir1_b2 = 25'sd0;
reg [24:0] linien_fast_a_iir1_csrstorage9_storage_full = 25'd0;
wire [24:0] linien_fast_a_iir1_csrstorage9_storage;
reg linien_fast_a_iir1_csrstorage9_re = 1'd0;
reg signed [49:0] linien_fast_a_iir1_z0r1 = 50'sd0;
reg signed [24:0] linien_fast_a_iir1_y_lim1;
wire signed [49:0] linien_fast_a_iir1_y_next1;
reg [2:0] linien_fast_a_iir1_y_pat1 = 3'd7;
reg signed [24:0] linien_fast_a_iir1_y3 = 25'sd0;
wire linien_fast_a_iir1_railed1;
reg signed [49:0] linien_fast_a_iir1_zr3 = 50'sd0;
wire signed [49:0] linien_fast_a_iir1_z3;
reg signed [49:0] linien_fast_a_iir1_zr4 = 50'sd0;
wire signed [49:0] linien_fast_a_iir1_z4;
reg signed [49:0] linien_fast_a_iir1_zr5 = 50'sd0;
wire signed [49:0] linien_fast_a_iir1_z5;
reg signed [49:0] linien_fast_a_iir1_zr6 = 50'sd0;
wire signed [49:0] linien_fast_a_iir1_z6;
reg signed [49:0] linien_fast_a_iir1_zr7 = 50'sd0;
wire signed [49:0] linien_fast_a_iir1_z7;
reg signed [24:0] linien_fast_a_limitcsr1_limitcsr1_y1 = 25'sd0;
reg linien_fast_a_limitcsr1_limitcsr1_error1 = 1'd0;
wire signed [27:0] linien_fast_a_limitcsr1_x1;
reg [24:0] linien_fast_a_limitcsr1_min_storage_full1 = 25'd16777216;
wire [24:0] linien_fast_a_limitcsr1_min_storage1;
reg linien_fast_a_limitcsr1_min_re1 = 1'd0;
reg [24:0] linien_fast_a_limitcsr1_max_storage_full1 = 25'd16777215;
wire [24:0] linien_fast_a_limitcsr1_max_storage1;
reg linien_fast_a_limitcsr1_max_re1 = 1'd0;
wire signed [27:0] linien_fast_a_limitcsr1_limit_x1;
reg signed [27:0] linien_fast_a_limitcsr1_limit_y1;
reg signed [27:0] linien_fast_a_limitcsr1_limit_max1 = 28'sd0;
reg signed [27:0] linien_fast_a_limitcsr1_limit_min1 = 28'sd0;
reg linien_fast_a_limitcsr1_limit_railed1;
wire signed [13:0] linien_fast_b_adc;
wire signed [24:0] linien_fast_b_out_i;
wire signed [24:0] linien_fast_b_out_q;
reg [1:0] linien_fast_b_y_tap_storage_full = 2'd0;
wire [1:0] linien_fast_b_y_tap_storage;
reg linien_fast_b_y_tap_re = 1'd0;
reg linien_fast_b_invert_storage_full = 1'd0;
wire linien_fast_b_invert_storage;
reg linien_fast_b_invert_re = 1'd0;
wire signed [24:0] linien_fast_b_x0;
reg signed [24:0] linien_fast_b_dx = 25'sd0;
reg signed [24:0] linien_fast_b_dy = 25'sd0;
wire signed [13:0] linien_fast_b_x1;
wire signed [13:0] linien_fast_b_i;
wire signed [13:0] linien_fast_b_q0;
reg [31:0] linien_fast_b_delay_storage_full = 32'd0;
wire [31:0] linien_fast_b_delay_storage;
reg linien_fast_b_delay_re = 1'd0;
reg [3:0] linien_fast_b_multiplier_storage_full = 4'd1;
wire [3:0] linien_fast_b_multiplier_storage;
reg linien_fast_b_multiplier_re = 1'd0;
wire [13:0] linien_fast_b_phase;
reg signed [14:0] linien_fast_b_xi0;
reg signed [14:0] linien_fast_b_yi0;
reg signed [14:0] linien_fast_b_zi0;
wire signed [14:0] linien_fast_b_xo;
wire signed [14:0] linien_fast_b_yo;
wire signed [14:0] linien_fast_b_zo;
wire linien_fast_b_new_in;
wire linien_fast_b_new_out;
wire signed [16:0] linien_fast_b_x2;
reg signed [16:0] linien_fast_b_x3 = 17'sd0;
reg signed [16:0] linien_fast_b_x4 = 17'sd0;
reg signed [16:0] linien_fast_b_x5 = 17'sd0;
reg signed [16:0] linien_fast_b_x6 = 17'sd0;
reg signed [16:0] linien_fast_b_x7 = 17'sd0;
reg signed [16:0] linien_fast_b_x8 = 17'sd0;
reg signed [16:0] linien_fast_b_x9 = 17'sd0;
reg signed [16:0] linien_fast_b_x10 = 17'sd0;
reg signed [16:0] linien_fast_b_x11 = 17'sd0;
reg signed [16:0] linien_fast_b_x12 = 17'sd0;
reg signed [16:0] linien_fast_b_x13 = 17'sd0;
reg signed [16:0] linien_fast_b_x14 = 17'sd0;
reg signed [16:0] linien_fast_b_x15 = 17'sd0;
reg signed [16:0] linien_fast_b_x16 = 17'sd0;
reg signed [16:0] linien_fast_b_x17 = 17'sd0;
wire signed [16:0] linien_fast_b_y0;
reg signed [16:0] linien_fast_b_y1 = 17'sd0;
reg signed [16:0] linien_fast_b_y2 = 17'sd0;
reg signed [16:0] linien_fast_b_y3 = 17'sd0;
reg signed [16:0] linien_fast_b_y4 = 17'sd0;
reg signed [16:0] linien_fast_b_y5 = 17'sd0;
reg signed [16:0] linien_fast_b_y6 = 17'sd0;
reg signed [16:0] linien_fast_b_y7 = 17'sd0;
reg signed [16:0] linien_fast_b_y8 = 17'sd0;
reg signed [16:0] linien_fast_b_y9 = 17'sd0;
reg signed [16:0] linien_fast_b_y10 = 17'sd0;
reg signed [16:0] linien_fast_b_y11 = 17'sd0;
reg signed [16:0] linien_fast_b_y12 = 17'sd0;
reg signed [16:0] linien_fast_b_y13 = 17'sd0;
reg signed [16:0] linien_fast_b_y14 = 17'sd0;
reg signed [16:0] linien_fast_b_y15 = 17'sd0;
wire signed [16:0] linien_fast_b_z0;
reg signed [16:0] linien_fast_b_z1 = 17'sd0;
reg signed [16:0] linien_fast_b_z2 = 17'sd0;
reg signed [16:0] linien_fast_b_z3 = 17'sd0;
reg signed [16:0] linien_fast_b_z4 = 17'sd0;
reg signed [16:0] linien_fast_b_z5 = 17'sd0;
reg signed [16:0] linien_fast_b_z6 = 17'sd0;
reg signed [16:0] linien_fast_b_z7 = 17'sd0;
reg signed [16:0] linien_fast_b_z8 = 17'sd0;
reg signed [16:0] linien_fast_b_z9 = 17'sd0;
reg signed [16:0] linien_fast_b_z10 = 17'sd0;
reg signed [16:0] linien_fast_b_z11 = 17'sd0;
reg signed [16:0] linien_fast_b_z12 = 17'sd0;
reg signed [16:0] linien_fast_b_z13 = 17'sd0;
reg signed [16:0] linien_fast_b_z14 = 17'sd0;
reg signed [16:0] linien_fast_b_z15 = 17'sd0;
wire linien_fast_b_dir0;
wire linien_fast_b_dir1;
wire linien_fast_b_dir2;
wire linien_fast_b_dir3;
wire linien_fast_b_dir4;
wire linien_fast_b_dir5;
wire linien_fast_b_dir6;
wire linien_fast_b_dir7;
wire linien_fast_b_dir8;
wire linien_fast_b_dir9;
wire linien_fast_b_dir10;
wire linien_fast_b_dir11;
wire linien_fast_b_dir12;
wire linien_fast_b_dir13;
wire linien_fast_b_dir14;
wire signed [14:0] linien_fast_b_xi1;
reg signed [14:0] linien_fast_b_yi1 = 15'sd0;
wire signed [14:0] linien_fast_b_zi1;
wire linien_fast_b_q1;
reg signed [16:0] linien_fast_b_ya = 17'sd0;
reg signed [24:0] linien_fast_b_limitcsr0_limitcsr0_y0 = 25'sd0;
reg linien_fast_b_limitcsr0_limitcsr0_error0 = 1'd0;
wire signed [25:0] linien_fast_b_limitcsr0_x0;
reg [24:0] linien_fast_b_limitcsr0_min_storage_full0 = 25'd16777216;
wire [24:0] linien_fast_b_limitcsr0_min_storage0;
reg linien_fast_b_limitcsr0_min_re0 = 1'd0;
reg [24:0] linien_fast_b_limitcsr0_max_storage_full0 = 25'd16777215;
wire [24:0] linien_fast_b_limitcsr0_max_storage0;
reg linien_fast_b_limitcsr0_max_re0 = 1'd0;
wire signed [25:0] linien_fast_b_limitcsr0_limit_x0;
reg signed [25:0] linien_fast_b_limitcsr0_limit_y0;
reg signed [25:0] linien_fast_b_limitcsr0_limit_max0 = 26'sd0;
reg signed [25:0] linien_fast_b_limitcsr0_limit_min0 = 26'sd0;
reg linien_fast_b_limitcsr0_limit_railed0;
wire signed [24:0] linien_fast_b_iir0_x0;
reg signed [24:0] linien_fast_b_iir0_y0 = 25'sd0;
wire linien_fast_b_iir0_hold0;
wire linien_fast_b_iir0_clear0;
reg linien_fast_b_iir0_error0 = 1'd0;
reg [26:0] linien_fast_b_iir0_storage_full0 = 27'd0;
wire [26:0] linien_fast_b_iir0_storage0;
reg linien_fast_b_iir0_re0 = 1'd0;
reg signed [24:0] linien_fast_b_iir0_a10 = 25'sd0;
reg [24:0] linien_fast_b_iir0_csrstorage0_storage_full0 = 25'd0;
wire [24:0] linien_fast_b_iir0_csrstorage0_storage0;
reg linien_fast_b_iir0_csrstorage0_re0 = 1'd0;
reg signed [24:0] linien_fast_b_iir0_b00 = 25'sd0;
reg [24:0] linien_fast_b_iir0_csrstorage1_storage_full0 = 25'd0;
wire [24:0] linien_fast_b_iir0_csrstorage1_storage0;
reg linien_fast_b_iir0_csrstorage1_re0 = 1'd0;
reg signed [24:0] linien_fast_b_iir0_b10 = 25'sd0;
reg [24:0] linien_fast_b_iir0_csrstorage2_storage_full0 = 25'd0;
wire [24:0] linien_fast_b_iir0_csrstorage2_storage0;
reg linien_fast_b_iir0_csrstorage2_re0 = 1'd0;
reg signed [49:0] linien_fast_b_iir0_z0r0 = 50'sd0;
reg signed [24:0] linien_fast_b_iir0_y_lim0;
wire signed [49:0] linien_fast_b_iir0_y_next0;
reg [2:0] linien_fast_b_iir0_y_pat0 = 3'd7;
reg signed [24:0] linien_fast_b_iir0_y1 = 25'sd0;
wire linien_fast_b_iir0_railed0;
reg signed [49:0] linien_fast_b_iir0_zr0 = 50'sd0;
wire signed [49:0] linien_fast_b_iir0_z0;
reg signed [49:0] linien_fast_b_iir0_zr1 = 50'sd0;
wire signed [49:0] linien_fast_b_iir0_z1;
reg signed [49:0] linien_fast_b_iir0_zr2 = 50'sd0;
wire signed [49:0] linien_fast_b_iir0_z2;
wire signed [24:0] linien_fast_b_iir0_x1;
reg signed [24:0] linien_fast_b_iir0_y2 = 25'sd0;
wire linien_fast_b_iir0_hold1;
wire linien_fast_b_iir0_clear1;
reg linien_fast_b_iir0_error1 = 1'd0;
reg [26:0] linien_fast_b_iir0_storage_full1 = 27'd0;
wire [26:0] linien_fast_b_iir0_storage1;
reg linien_fast_b_iir0_re1 = 1'd0;
reg signed [24:0] linien_fast_b_iir0_a11 = 25'sd0;
reg [24:0] linien_fast_b_iir0_csrstorage0_storage_full1 = 25'd0;
wire [24:0] linien_fast_b_iir0_csrstorage0_storage1;
reg linien_fast_b_iir0_csrstorage0_re1 = 1'd0;
reg signed [24:0] linien_fast_b_iir0_a2 = 25'sd0;
reg [24:0] linien_fast_b_iir0_csrstorage1_storage_full1 = 25'd0;
wire [24:0] linien_fast_b_iir0_csrstorage1_storage1;
reg linien_fast_b_iir0_csrstorage1_re1 = 1'd0;
reg signed [24:0] linien_fast_b_iir0_b01 = 25'sd0;
reg [24:0] linien_fast_b_iir0_csrstorage2_storage_full1 = 25'd0;
wire [24:0] linien_fast_b_iir0_csrstorage2_storage1;
reg linien_fast_b_iir0_csrstorage2_re1 = 1'd0;
reg signed [24:0] linien_fast_b_iir0_b11 = 25'sd0;
reg [24:0] linien_fast_b_iir0_csrstorage3_storage_full = 25'd0;
wire [24:0] linien_fast_b_iir0_csrstorage3_storage;
reg linien_fast_b_iir0_csrstorage3_re = 1'd0;
reg signed [24:0] linien_fast_b_iir0_b2 = 25'sd0;
reg [24:0] linien_fast_b_iir0_csrstorage4_storage_full = 25'd0;
wire [24:0] linien_fast_b_iir0_csrstorage4_storage;
reg linien_fast_b_iir0_csrstorage4_re = 1'd0;
reg signed [49:0] linien_fast_b_iir0_z0r1 = 50'sd0;
reg signed [24:0] linien_fast_b_iir0_y_lim1;
wire signed [49:0] linien_fast_b_iir0_y_next1;
reg [2:0] linien_fast_b_iir0_y_pat1 = 3'd7;
reg signed [24:0] linien_fast_b_iir0_y3 = 25'sd0;
wire linien_fast_b_iir0_railed1;
reg signed [49:0] linien_fast_b_iir0_zr3 = 50'sd0;
wire signed [49:0] linien_fast_b_iir0_z3;
reg signed [49:0] linien_fast_b_iir0_zr4 = 50'sd0;
wire signed [49:0] linien_fast_b_iir0_z4;
reg signed [49:0] linien_fast_b_iir0_zr5 = 50'sd0;
wire signed [49:0] linien_fast_b_iir0_z5;
reg signed [49:0] linien_fast_b_iir0_zr6 = 50'sd0;
wire signed [49:0] linien_fast_b_iir0_z6;
reg signed [49:0] linien_fast_b_iir0_zr7 = 50'sd0;
wire signed [49:0] linien_fast_b_iir0_z7;
reg signed [24:0] linien_fast_b_limitcsr0_limitcsr0_y1 = 25'sd0;
reg linien_fast_b_limitcsr0_limitcsr0_error1 = 1'd0;
wire signed [27:0] linien_fast_b_limitcsr0_x1;
reg [24:0] linien_fast_b_limitcsr0_min_storage_full1 = 25'd16777216;
wire [24:0] linien_fast_b_limitcsr0_min_storage1;
reg linien_fast_b_limitcsr0_min_re1 = 1'd0;
reg [24:0] linien_fast_b_limitcsr0_max_storage_full1 = 25'd16777215;
wire [24:0] linien_fast_b_limitcsr0_max_storage1;
reg linien_fast_b_limitcsr0_max_re1 = 1'd0;
wire signed [27:0] linien_fast_b_limitcsr0_limit_x1;
reg signed [27:0] linien_fast_b_limitcsr0_limit_y1;
reg signed [27:0] linien_fast_b_limitcsr0_limit_max1 = 28'sd0;
reg signed [27:0] linien_fast_b_limitcsr0_limit_min1 = 28'sd0;
reg linien_fast_b_limitcsr0_limit_railed1;
reg signed [24:0] linien_fast_b_limitcsr1_limitcsr1_y0 = 25'sd0;
reg linien_fast_b_limitcsr1_limitcsr1_error0 = 1'd0;
wire signed [25:0] linien_fast_b_limitcsr1_x0;
reg [24:0] linien_fast_b_limitcsr1_min_storage_full0 = 25'd16777216;
wire [24:0] linien_fast_b_limitcsr1_min_storage0;
reg linien_fast_b_limitcsr1_min_re0 = 1'd0;
reg [24:0] linien_fast_b_limitcsr1_max_storage_full0 = 25'd16777215;
wire [24:0] linien_fast_b_limitcsr1_max_storage0;
reg linien_fast_b_limitcsr1_max_re0 = 1'd0;
wire signed [25:0] linien_fast_b_limitcsr1_limit_x0;
reg signed [25:0] linien_fast_b_limitcsr1_limit_y0;
reg signed [25:0] linien_fast_b_limitcsr1_limit_max0 = 26'sd0;
reg signed [25:0] linien_fast_b_limitcsr1_limit_min0 = 26'sd0;
reg linien_fast_b_limitcsr1_limit_railed0;
wire signed [24:0] linien_fast_b_iir1_x0;
reg signed [24:0] linien_fast_b_iir1_y0 = 25'sd0;
wire linien_fast_b_iir1_hold0;
wire linien_fast_b_iir1_clear0;
reg linien_fast_b_iir1_error0 = 1'd0;
reg [26:0] linien_fast_b_iir1_storage_full0 = 27'd0;
wire [26:0] linien_fast_b_iir1_storage0;
reg linien_fast_b_iir1_re0 = 1'd0;
reg signed [24:0] linien_fast_b_iir1_a10 = 25'sd0;
reg [24:0] linien_fast_b_iir1_csrstorage3_storage_full = 25'd0;
wire [24:0] linien_fast_b_iir1_csrstorage3_storage;
reg linien_fast_b_iir1_csrstorage3_re = 1'd0;
reg signed [24:0] linien_fast_b_iir1_b00 = 25'sd0;
reg [24:0] linien_fast_b_iir1_csrstorage4_storage_full = 25'd0;
wire [24:0] linien_fast_b_iir1_csrstorage4_storage;
reg linien_fast_b_iir1_csrstorage4_re = 1'd0;
reg signed [24:0] linien_fast_b_iir1_b10 = 25'sd0;
reg [24:0] linien_fast_b_iir1_csrstorage5_storage_full0 = 25'd0;
wire [24:0] linien_fast_b_iir1_csrstorage5_storage0;
reg linien_fast_b_iir1_csrstorage5_re0 = 1'd0;
reg signed [49:0] linien_fast_b_iir1_z0r0 = 50'sd0;
reg signed [24:0] linien_fast_b_iir1_y_lim0;
wire signed [49:0] linien_fast_b_iir1_y_next0;
reg [2:0] linien_fast_b_iir1_y_pat0 = 3'd7;
reg signed [24:0] linien_fast_b_iir1_y1 = 25'sd0;
wire linien_fast_b_iir1_railed0;
reg signed [49:0] linien_fast_b_iir1_zr0 = 50'sd0;
wire signed [49:0] linien_fast_b_iir1_z0;
reg signed [49:0] linien_fast_b_iir1_zr1 = 50'sd0;
wire signed [49:0] linien_fast_b_iir1_z1;
reg signed [49:0] linien_fast_b_iir1_zr2 = 50'sd0;
wire signed [49:0] linien_fast_b_iir1_z2;
wire signed [24:0] linien_fast_b_iir1_x1;
reg signed [24:0] linien_fast_b_iir1_y2 = 25'sd0;
wire linien_fast_b_iir1_hold1;
wire linien_fast_b_iir1_clear1;
reg linien_fast_b_iir1_error1 = 1'd0;
reg [26:0] linien_fast_b_iir1_storage_full1 = 27'd0;
wire [26:0] linien_fast_b_iir1_storage1;
reg linien_fast_b_iir1_re1 = 1'd0;
reg signed [24:0] linien_fast_b_iir1_a11 = 25'sd0;
reg [24:0] linien_fast_b_iir1_csrstorage5_storage_full1 = 25'd0;
wire [24:0] linien_fast_b_iir1_csrstorage5_storage1;
reg linien_fast_b_iir1_csrstorage5_re1 = 1'd0;
reg signed [24:0] linien_fast_b_iir1_a2 = 25'sd0;
reg [24:0] linien_fast_b_iir1_csrstorage6_storage_full = 25'd0;
wire [24:0] linien_fast_b_iir1_csrstorage6_storage;
reg linien_fast_b_iir1_csrstorage6_re = 1'd0;
reg signed [24:0] linien_fast_b_iir1_b01 = 25'sd0;
reg [24:0] linien_fast_b_iir1_csrstorage7_storage_full = 25'd0;
wire [24:0] linien_fast_b_iir1_csrstorage7_storage;
reg linien_fast_b_iir1_csrstorage7_re = 1'd0;
reg signed [24:0] linien_fast_b_iir1_b11 = 25'sd0;
reg [24:0] linien_fast_b_iir1_csrstorage8_storage_full = 25'd0;
wire [24:0] linien_fast_b_iir1_csrstorage8_storage;
reg linien_fast_b_iir1_csrstorage8_re = 1'd0;
reg signed [24:0] linien_fast_b_iir1_b2 = 25'sd0;
reg [24:0] linien_fast_b_iir1_csrstorage9_storage_full = 25'd0;
wire [24:0] linien_fast_b_iir1_csrstorage9_storage;
reg linien_fast_b_iir1_csrstorage9_re = 1'd0;
reg signed [49:0] linien_fast_b_iir1_z0r1 = 50'sd0;
reg signed [24:0] linien_fast_b_iir1_y_lim1;
wire signed [49:0] linien_fast_b_iir1_y_next1;
reg [2:0] linien_fast_b_iir1_y_pat1 = 3'd7;
reg signed [24:0] linien_fast_b_iir1_y3 = 25'sd0;
wire linien_fast_b_iir1_railed1;
reg signed [49:0] linien_fast_b_iir1_zr3 = 50'sd0;
wire signed [49:0] linien_fast_b_iir1_z3;
reg signed [49:0] linien_fast_b_iir1_zr4 = 50'sd0;
wire signed [49:0] linien_fast_b_iir1_z4;
reg signed [49:0] linien_fast_b_iir1_zr5 = 50'sd0;
wire signed [49:0] linien_fast_b_iir1_z5;
reg signed [49:0] linien_fast_b_iir1_zr6 = 50'sd0;
wire signed [49:0] linien_fast_b_iir1_z6;
reg signed [49:0] linien_fast_b_iir1_zr7 = 50'sd0;
wire signed [49:0] linien_fast_b_iir1_z7;
reg signed [24:0] linien_fast_b_limitcsr1_limitcsr1_y1 = 25'sd0;
reg linien_fast_b_limitcsr1_limitcsr1_error1 = 1'd0;
wire signed [27:0] linien_fast_b_limitcsr1_x1;
reg [24:0] linien_fast_b_limitcsr1_min_storage_full1 = 25'd16777216;
wire [24:0] linien_fast_b_limitcsr1_min_storage1;
reg linien_fast_b_limitcsr1_min_re1 = 1'd0;
reg [24:0] linien_fast_b_limitcsr1_max_storage_full1 = 25'd16777215;
wire [24:0] linien_fast_b_limitcsr1_max_storage1;
reg linien_fast_b_limitcsr1_max_re1 = 1'd0;
wire signed [27:0] linien_fast_b_limitcsr1_limit_x1;
reg signed [27:0] linien_fast_b_limitcsr1_limit_y1;
reg signed [27:0] linien_fast_b_limitcsr1_limit_max1 = 28'sd0;
reg signed [27:0] linien_fast_b_limitcsr1_limit_min1 = 28'sd0;
reg linien_fast_b_limitcsr1_limit_railed1;
wire signed [24:0] linien_i_a;
wire signed [24:0] linien_q_a;
wire signed [24:0] linien_i_b;
wire signed [24:0] linien_q_b;
reg signed [24:0] linien_out_e = 25'sd0;
wire signed [24:0] linien_power_signal_out;
wire [24:0] linien_csr_out_e_status;
wire [24:0] linien_csr_power_signal_out_status;
wire signed [24:0] linien_mag_a;
wire signed [24:0] linien_mag_b;
wire signed [24:0] linien_mag_a_scaled;
wire signed [24:0] linien_mag_b_scaled;
reg signed [24:0] linien_cordic_a_xi0;
reg signed [24:0] linien_cordic_a_yi0;
reg signed [24:0] linien_cordic_a_zi0;
wire signed [24:0] linien_cordic_a_xo;
wire signed [24:0] linien_cordic_a_yo;
wire signed [24:0] linien_cordic_a_zo;
wire linien_cordic_a_new_in;
wire linien_cordic_a_new_out;
wire signed [24:0] linien_cordic_a_x0;
wire signed [24:0] linien_cordic_a_x1;
wire signed [24:0] linien_cordic_a_x2;
wire signed [24:0] linien_cordic_a_x3;
wire signed [24:0] linien_cordic_a_x4;
wire signed [24:0] linien_cordic_a_x5;
wire signed [24:0] linien_cordic_a_x6;
wire signed [24:0] linien_cordic_a_x7;
wire signed [24:0] linien_cordic_a_x8;
wire signed [24:0] linien_cordic_a_x9;
wire signed [24:0] linien_cordic_a_x10;
wire signed [24:0] linien_cordic_a_x11;
wire signed [24:0] linien_cordic_a_x12;
wire signed [24:0] linien_cordic_a_x13;
wire signed [24:0] linien_cordic_a_x14;
wire signed [24:0] linien_cordic_a_x15;
wire signed [24:0] linien_cordic_a_x16;
wire signed [24:0] linien_cordic_a_x17;
wire signed [24:0] linien_cordic_a_x18;
wire signed [24:0] linien_cordic_a_x19;
wire signed [24:0] linien_cordic_a_x20;
wire signed [24:0] linien_cordic_a_x21;
wire signed [24:0] linien_cordic_a_x22;
wire signed [24:0] linien_cordic_a_x23;
wire signed [24:0] linien_cordic_a_x24;
wire signed [24:0] linien_cordic_a_x25;
wire signed [24:0] linien_cordic_a_y0;
wire signed [24:0] linien_cordic_a_y1;
wire signed [24:0] linien_cordic_a_y2;
wire signed [24:0] linien_cordic_a_y3;
wire signed [24:0] linien_cordic_a_y4;
wire signed [24:0] linien_cordic_a_y5;
wire signed [24:0] linien_cordic_a_y6;
wire signed [24:0] linien_cordic_a_y7;
wire signed [24:0] linien_cordic_a_y8;
wire signed [24:0] linien_cordic_a_y9;
wire signed [24:0] linien_cordic_a_y10;
wire signed [24:0] linien_cordic_a_y11;
wire signed [24:0] linien_cordic_a_y12;
wire signed [24:0] linien_cordic_a_y13;
wire signed [24:0] linien_cordic_a_y14;
wire signed [24:0] linien_cordic_a_y15;
wire signed [24:0] linien_cordic_a_y16;
wire signed [24:0] linien_cordic_a_y17;
wire signed [24:0] linien_cordic_a_y18;
wire signed [24:0] linien_cordic_a_y19;
wire signed [24:0] linien_cordic_a_y20;
wire signed [24:0] linien_cordic_a_y21;
wire signed [24:0] linien_cordic_a_y22;
wire signed [24:0] linien_cordic_a_y23;
wire signed [24:0] linien_cordic_a_y24;
wire signed [24:0] linien_cordic_a_y25;
wire signed [24:0] linien_cordic_a_z0;
wire signed [24:0] linien_cordic_a_z1;
wire signed [24:0] linien_cordic_a_z2;
wire signed [24:0] linien_cordic_a_z3;
wire signed [24:0] linien_cordic_a_z4;
wire signed [24:0] linien_cordic_a_z5;
wire signed [24:0] linien_cordic_a_z6;
wire signed [24:0] linien_cordic_a_z7;
wire signed [24:0] linien_cordic_a_z8;
wire signed [24:0] linien_cordic_a_z9;
wire signed [24:0] linien_cordic_a_z10;
wire signed [24:0] linien_cordic_a_z11;
wire signed [24:0] linien_cordic_a_z12;
wire signed [24:0] linien_cordic_a_z13;
wire signed [24:0] linien_cordic_a_z14;
wire signed [24:0] linien_cordic_a_z15;
wire signed [24:0] linien_cordic_a_z16;
wire signed [24:0] linien_cordic_a_z17;
wire signed [24:0] linien_cordic_a_z18;
wire signed [24:0] linien_cordic_a_z19;
wire signed [24:0] linien_cordic_a_z20;
wire signed [24:0] linien_cordic_a_z21;
wire signed [24:0] linien_cordic_a_z22;
wire signed [24:0] linien_cordic_a_z23;
wire signed [24:0] linien_cordic_a_z24;
wire signed [24:0] linien_cordic_a_z25;
wire linien_cordic_a_dir0;
wire linien_cordic_a_dir1;
wire linien_cordic_a_dir2;
wire linien_cordic_a_dir3;
wire linien_cordic_a_dir4;
wire linien_cordic_a_dir5;
wire linien_cordic_a_dir6;
wire linien_cordic_a_dir7;
wire linien_cordic_a_dir8;
wire linien_cordic_a_dir9;
wire linien_cordic_a_dir10;
wire linien_cordic_a_dir11;
wire linien_cordic_a_dir12;
wire linien_cordic_a_dir13;
wire linien_cordic_a_dir14;
wire linien_cordic_a_dir15;
wire linien_cordic_a_dir16;
wire linien_cordic_a_dir17;
wire linien_cordic_a_dir18;
wire linien_cordic_a_dir19;
wire linien_cordic_a_dir20;
wire linien_cordic_a_dir21;
wire linien_cordic_a_dir22;
wire linien_cordic_a_dir23;
wire linien_cordic_a_dir24;
wire signed [24:0] linien_cordic_a_xi1;
wire signed [24:0] linien_cordic_a_yi1;
reg signed [24:0] linien_cordic_a_zi1 = 25'sd0;
wire linien_cordic_a_q;
reg signed [24:0] linien_cordic_b_xi0;
reg signed [24:0] linien_cordic_b_yi0;
reg signed [24:0] linien_cordic_b_zi0;
wire signed [24:0] linien_cordic_b_xo;
wire signed [24:0] linien_cordic_b_yo;
wire signed [24:0] linien_cordic_b_zo;
wire linien_cordic_b_new_in;
wire linien_cordic_b_new_out;
wire signed [24:0] linien_cordic_b_x0;
wire signed [24:0] linien_cordic_b_x1;
wire signed [24:0] linien_cordic_b_x2;
wire signed [24:0] linien_cordic_b_x3;
wire signed [24:0] linien_cordic_b_x4;
wire signed [24:0] linien_cordic_b_x5;
wire signed [24:0] linien_cordic_b_x6;
wire signed [24:0] linien_cordic_b_x7;
wire signed [24:0] linien_cordic_b_x8;
wire signed [24:0] linien_cordic_b_x9;
wire signed [24:0] linien_cordic_b_x10;
wire signed [24:0] linien_cordic_b_x11;
wire signed [24:0] linien_cordic_b_x12;
wire signed [24:0] linien_cordic_b_x13;
wire signed [24:0] linien_cordic_b_x14;
wire signed [24:0] linien_cordic_b_x15;
wire signed [24:0] linien_cordic_b_x16;
wire signed [24:0] linien_cordic_b_x17;
wire signed [24:0] linien_cordic_b_x18;
wire signed [24:0] linien_cordic_b_x19;
wire signed [24:0] linien_cordic_b_x20;
wire signed [24:0] linien_cordic_b_x21;
wire signed [24:0] linien_cordic_b_x22;
wire signed [24:0] linien_cordic_b_x23;
wire signed [24:0] linien_cordic_b_x24;
wire signed [24:0] linien_cordic_b_x25;
wire signed [24:0] linien_cordic_b_y0;
wire signed [24:0] linien_cordic_b_y1;
wire signed [24:0] linien_cordic_b_y2;
wire signed [24:0] linien_cordic_b_y3;
wire signed [24:0] linien_cordic_b_y4;
wire signed [24:0] linien_cordic_b_y5;
wire signed [24:0] linien_cordic_b_y6;
wire signed [24:0] linien_cordic_b_y7;
wire signed [24:0] linien_cordic_b_y8;
wire signed [24:0] linien_cordic_b_y9;
wire signed [24:0] linien_cordic_b_y10;
wire signed [24:0] linien_cordic_b_y11;
wire signed [24:0] linien_cordic_b_y12;
wire signed [24:0] linien_cordic_b_y13;
wire signed [24:0] linien_cordic_b_y14;
wire signed [24:0] linien_cordic_b_y15;
wire signed [24:0] linien_cordic_b_y16;
wire signed [24:0] linien_cordic_b_y17;
wire signed [24:0] linien_cordic_b_y18;
wire signed [24:0] linien_cordic_b_y19;
wire signed [24:0] linien_cordic_b_y20;
wire signed [24:0] linien_cordic_b_y21;
wire signed [24:0] linien_cordic_b_y22;
wire signed [24:0] linien_cordic_b_y23;
wire signed [24:0] linien_cordic_b_y24;
wire signed [24:0] linien_cordic_b_y25;
wire signed [24:0] linien_cordic_b_z0;
wire signed [24:0] linien_cordic_b_z1;
wire signed [24:0] linien_cordic_b_z2;
wire signed [24:0] linien_cordic_b_z3;
wire signed [24:0] linien_cordic_b_z4;
wire signed [24:0] linien_cordic_b_z5;
wire signed [24:0] linien_cordic_b_z6;
wire signed [24:0] linien_cordic_b_z7;
wire signed [24:0] linien_cordic_b_z8;
wire signed [24:0] linien_cordic_b_z9;
wire signed [24:0] linien_cordic_b_z10;
wire signed [24:0] linien_cordic_b_z11;
wire signed [24:0] linien_cordic_b_z12;
wire signed [24:0] linien_cordic_b_z13;
wire signed [24:0] linien_cordic_b_z14;
wire signed [24:0] linien_cordic_b_z15;
wire signed [24:0] linien_cordic_b_z16;
wire signed [24:0] linien_cordic_b_z17;
wire signed [24:0] linien_cordic_b_z18;
wire signed [24:0] linien_cordic_b_z19;
wire signed [24:0] linien_cordic_b_z20;
wire signed [24:0] linien_cordic_b_z21;
wire signed [24:0] linien_cordic_b_z22;
wire signed [24:0] linien_cordic_b_z23;
wire signed [24:0] linien_cordic_b_z24;
wire signed [24:0] linien_cordic_b_z25;
wire linien_cordic_b_dir0;
wire linien_cordic_b_dir1;
wire linien_cordic_b_dir2;
wire linien_cordic_b_dir3;
wire linien_cordic_b_dir4;
wire linien_cordic_b_dir5;
wire linien_cordic_b_dir6;
wire linien_cordic_b_dir7;
wire linien_cordic_b_dir8;
wire linien_cordic_b_dir9;
wire linien_cordic_b_dir10;
wire linien_cordic_b_dir11;
wire linien_cordic_b_dir12;
wire linien_cordic_b_dir13;
wire linien_cordic_b_dir14;
wire linien_cordic_b_dir15;
wire linien_cordic_b_dir16;
wire linien_cordic_b_dir17;
wire linien_cordic_b_dir18;
wire linien_cordic_b_dir19;
wire linien_cordic_b_dir20;
wire linien_cordic_b_dir21;
wire linien_cordic_b_dir22;
wire linien_cordic_b_dir23;
wire linien_cordic_b_dir24;
wire signed [24:0] linien_cordic_b_xi1;
wire signed [24:0] linien_cordic_b_yi1;
reg signed [24:0] linien_cordic_b_zi1 = 25'sd0;
wire linien_cordic_b_q;
wire signed [24:0] linien_numerator;
wire signed [24:0] linien_denominator;
wire linien_safe_to_divide;
wire linien_divider_start;
wire linien_divider_busy;
reg linien_divider_done = 1'd0;
wire signed [24:0] linien_divider_num;
wire signed [24:0] linien_divider_den;
reg signed [24:0] linien_divider_quotient = 25'sd0;
wire [24:0] linien_divider_n_abs;
wire [24:0] linien_divider_d_abs;
wire linien_divider_n_sign;
wire linien_divider_d_sign;
wire linien_divider_q_sign;
reg [25:0] linien_divider_r0 = 26'd0;
reg [25:0] linien_divider_r1 = 26'd0;
reg [25:0] linien_divider_r2 = 26'd0;
reg [25:0] linien_divider_r3 = 26'd0;
reg [25:0] linien_divider_r4 = 26'd0;
reg [25:0] linien_divider_r5 = 26'd0;
reg [25:0] linien_divider_r6 = 26'd0;
reg [25:0] linien_divider_r7 = 26'd0;
reg [25:0] linien_divider_r8 = 26'd0;
reg [25:0] linien_divider_r9 = 26'd0;
reg [25:0] linien_divider_r10 = 26'd0;
reg [25:0] linien_divider_r11 = 26'd0;
reg [25:0] linien_divider_r12 = 26'd0;
reg [25:0] linien_divider_r13 = 26'd0;
reg [25:0] linien_divider_r14 = 26'd0;
reg [25:0] linien_divider_r15 = 26'd0;
reg [25:0] linien_divider_r16 = 26'd0;
reg [25:0] linien_divider_r17 = 26'd0;
reg [25:0] linien_divider_r18 = 26'd0;
reg [25:0] linien_divider_r19 = 26'd0;
reg [25:0] linien_divider_r20 = 26'd0;
reg [25:0] linien_divider_r21 = 26'd0;
reg [25:0] linien_divider_r22 = 26'd0;
reg [25:0] linien_divider_r23 = 26'd0;
reg [25:0] linien_divider_r24 = 26'd0;
reg [25:0] linien_divider_r25 = 26'd0;
reg [25:0] linien_divider_r26 = 26'd0;
reg [25:0] linien_divider_r27 = 26'd0;
reg [25:0] linien_divider_r28 = 26'd0;
reg [25:0] linien_divider_r29 = 26'd0;
reg [25:0] linien_divider_r30 = 26'd0;
reg [25:0] linien_divider_r31 = 26'd0;
reg [25:0] linien_divider_r32 = 26'd0;
reg [25:0] linien_divider_r33 = 26'd0;
reg [25:0] linien_divider_r34 = 26'd0;
reg [25:0] linien_divider_r35 = 26'd0;
reg [34:0] linien_divider_quo0 = 35'd0;
reg [34:0] linien_divider_quo1 = 35'd0;
reg [34:0] linien_divider_quo2 = 35'd0;
reg [34:0] linien_divider_quo3 = 35'd0;
reg [34:0] linien_divider_quo4 = 35'd0;
reg [34:0] linien_divider_quo5 = 35'd0;
reg [34:0] linien_divider_quo6 = 35'd0;
reg [34:0] linien_divider_quo7 = 35'd0;
reg [34:0] linien_divider_quo8 = 35'd0;
reg [34:0] linien_divider_quo9 = 35'd0;
reg [34:0] linien_divider_quo10 = 35'd0;
reg [34:0] linien_divider_quo11 = 35'd0;
reg [34:0] linien_divider_quo12 = 35'd0;
reg [34:0] linien_divider_quo13 = 35'd0;
reg [34:0] linien_divider_quo14 = 35'd0;
reg [34:0] linien_divider_quo15 = 35'd0;
reg [34:0] linien_divider_quo16 = 35'd0;
reg [34:0] linien_divider_quo17 = 35'd0;
reg [34:0] linien_divider_quo18 = 35'd0;
reg [34:0] linien_divider_quo19 = 35'd0;
reg [34:0] linien_divider_quo20 = 35'd0;
reg [34:0] linien_divider_quo21 = 35'd0;
reg [34:0] linien_divider_quo22 = 35'd0;
reg [34:0] linien_divider_quo23 = 35'd0;
reg [34:0] linien_divider_quo24 = 35'd0;
reg [34:0] linien_divider_quo25 = 35'd0;
reg [34:0] linien_divider_quo26 = 35'd0;
reg [34:0] linien_divider_quo27 = 35'd0;
reg [34:0] linien_divider_quo28 = 35'd0;
reg [34:0] linien_divider_quo29 = 35'd0;
reg [34:0] linien_divider_quo30 = 35'd0;
reg [34:0] linien_divider_quo31 = 35'd0;
reg [34:0] linien_divider_quo32 = 35'd0;
reg [34:0] linien_divider_quo33 = 35'd0;
reg [34:0] linien_divider_quo34 = 35'd0;
reg [34:0] linien_divider_quo35 = 35'd0;
reg [34:0] linien_divider_q0 = 35'd0;
reg [34:0] linien_divider_q1 = 35'd0;
reg [34:0] linien_divider_q2 = 35'd0;
reg [34:0] linien_divider_q3 = 35'd0;
reg [34:0] linien_divider_q4 = 35'd0;
reg [34:0] linien_divider_q5 = 35'd0;
reg [34:0] linien_divider_q6 = 35'd0;
reg [34:0] linien_divider_q7 = 35'd0;
reg [34:0] linien_divider_q8 = 35'd0;
reg [34:0] linien_divider_q9 = 35'd0;
reg [34:0] linien_divider_q10 = 35'd0;
reg [34:0] linien_divider_q11 = 35'd0;
reg [34:0] linien_divider_q12 = 35'd0;
reg [34:0] linien_divider_q13 = 35'd0;
reg [34:0] linien_divider_q14 = 35'd0;
reg [34:0] linien_divider_q15 = 35'd0;
reg [34:0] linien_divider_q16 = 35'd0;
reg [34:0] linien_divider_q17 = 35'd0;
reg [34:0] linien_divider_q18 = 35'd0;
reg [34:0] linien_divider_q19 = 35'd0;
reg [34:0] linien_divider_q20 = 35'd0;
reg [34:0] linien_divider_q21 = 35'd0;
reg [34:0] linien_divider_q22 = 35'd0;
reg [34:0] linien_divider_q23 = 35'd0;
reg [34:0] linien_divider_q24 = 35'd0;
reg [34:0] linien_divider_q25 = 35'd0;
reg [34:0] linien_divider_q26 = 35'd0;
reg [34:0] linien_divider_q27 = 35'd0;
reg [34:0] linien_divider_q28 = 35'd0;
reg [34:0] linien_divider_q29 = 35'd0;
reg [34:0] linien_divider_q30 = 35'd0;
reg [34:0] linien_divider_q31 = 35'd0;
reg [34:0] linien_divider_q32 = 35'd0;
reg [34:0] linien_divider_q33 = 35'd0;
reg [34:0] linien_divider_q34 = 35'd0;
reg [34:0] linien_divider_q35 = 35'd0;
reg [24:0] linien_divider_d0 = 25'd0;
reg [24:0] linien_divider_d1 = 25'd0;
reg [24:0] linien_divider_d2 = 25'd0;
reg [24:0] linien_divider_d3 = 25'd0;
reg [24:0] linien_divider_d4 = 25'd0;
reg [24:0] linien_divider_d5 = 25'd0;
reg [24:0] linien_divider_d6 = 25'd0;
reg [24:0] linien_divider_d7 = 25'd0;
reg [24:0] linien_divider_d8 = 25'd0;
reg [24:0] linien_divider_d9 = 25'd0;
reg [24:0] linien_divider_d10 = 25'd0;
reg [24:0] linien_divider_d11 = 25'd0;
reg [24:0] linien_divider_d12 = 25'd0;
reg [24:0] linien_divider_d13 = 25'd0;
reg [24:0] linien_divider_d14 = 25'd0;
reg [24:0] linien_divider_d15 = 25'd0;
reg [24:0] linien_divider_d16 = 25'd0;
reg [24:0] linien_divider_d17 = 25'd0;
reg [24:0] linien_divider_d18 = 25'd0;
reg [24:0] linien_divider_d19 = 25'd0;
reg [24:0] linien_divider_d20 = 25'd0;
reg [24:0] linien_divider_d21 = 25'd0;
reg [24:0] linien_divider_d22 = 25'd0;
reg [24:0] linien_divider_d23 = 25'd0;
reg [24:0] linien_divider_d24 = 25'd0;
reg [24:0] linien_divider_d25 = 25'd0;
reg [24:0] linien_divider_d26 = 25'd0;
reg [24:0] linien_divider_d27 = 25'd0;
reg [24:0] linien_divider_d28 = 25'd0;
reg [24:0] linien_divider_d29 = 25'd0;
reg [24:0] linien_divider_d30 = 25'd0;
reg [24:0] linien_divider_d31 = 25'd0;
reg [24:0] linien_divider_d32 = 25'd0;
reg [24:0] linien_divider_d33 = 25'd0;
reg [24:0] linien_divider_d34 = 25'd0;
reg [24:0] linien_divider_d35 = 25'd0;
reg linien_divider_v0 = 1'd0;
reg linien_divider_v1 = 1'd0;
reg linien_divider_v2 = 1'd0;
reg linien_divider_v3 = 1'd0;
reg linien_divider_v4 = 1'd0;
reg linien_divider_v5 = 1'd0;
reg linien_divider_v6 = 1'd0;
reg linien_divider_v7 = 1'd0;
reg linien_divider_v8 = 1'd0;
reg linien_divider_v9 = 1'd0;
reg linien_divider_v10 = 1'd0;
reg linien_divider_v11 = 1'd0;
reg linien_divider_v12 = 1'd0;
reg linien_divider_v13 = 1'd0;
reg linien_divider_v14 = 1'd0;
reg linien_divider_v15 = 1'd0;
reg linien_divider_v16 = 1'd0;
reg linien_divider_v17 = 1'd0;
reg linien_divider_v18 = 1'd0;
reg linien_divider_v19 = 1'd0;
reg linien_divider_v20 = 1'd0;
reg linien_divider_v21 = 1'd0;
reg linien_divider_v22 = 1'd0;
reg linien_divider_v23 = 1'd0;
reg linien_divider_v24 = 1'd0;
reg linien_divider_v25 = 1'd0;
reg linien_divider_v26 = 1'd0;
reg linien_divider_v27 = 1'd0;
reg linien_divider_v28 = 1'd0;
reg linien_divider_v29 = 1'd0;
reg linien_divider_v30 = 1'd0;
reg linien_divider_v31 = 1'd0;
reg linien_divider_v32 = 1'd0;
reg linien_divider_v33 = 1'd0;
reg linien_divider_v34 = 1'd0;
reg linien_divider_v35 = 1'd0;
wire [34:0] linien_divider_n_abs_scaled;
wire [25:0] linien_divider_r_sub0;
wire linien_divider_sub_success0;
wire [25:0] linien_divider_r_sub1;
wire linien_divider_sub_success1;
wire [25:0] linien_divider_r_sub2;
wire linien_divider_sub_success2;
wire [25:0] linien_divider_r_sub3;
wire linien_divider_sub_success3;
wire [25:0] linien_divider_r_sub4;
wire linien_divider_sub_success4;
wire [25:0] linien_divider_r_sub5;
wire linien_divider_sub_success5;
wire [25:0] linien_divider_r_sub6;
wire linien_divider_sub_success6;
wire [25:0] linien_divider_r_sub7;
wire linien_divider_sub_success7;
wire [25:0] linien_divider_r_sub8;
wire linien_divider_sub_success8;
wire [25:0] linien_divider_r_sub9;
wire linien_divider_sub_success9;
wire [25:0] linien_divider_r_sub10;
wire linien_divider_sub_success10;
wire [25:0] linien_divider_r_sub11;
wire linien_divider_sub_success11;
wire [25:0] linien_divider_r_sub12;
wire linien_divider_sub_success12;
wire [25:0] linien_divider_r_sub13;
wire linien_divider_sub_success13;
wire [25:0] linien_divider_r_sub14;
wire linien_divider_sub_success14;
wire [25:0] linien_divider_r_sub15;
wire linien_divider_sub_success15;
wire [25:0] linien_divider_r_sub16;
wire linien_divider_sub_success16;
wire [25:0] linien_divider_r_sub17;
wire linien_divider_sub_success17;
wire [25:0] linien_divider_r_sub18;
wire linien_divider_sub_success18;
wire [25:0] linien_divider_r_sub19;
wire linien_divider_sub_success19;
wire [25:0] linien_divider_r_sub20;
wire linien_divider_sub_success20;
wire [25:0] linien_divider_r_sub21;
wire linien_divider_sub_success21;
wire [25:0] linien_divider_r_sub22;
wire linien_divider_sub_success22;
wire [25:0] linien_divider_r_sub23;
wire linien_divider_sub_success23;
wire [25:0] linien_divider_r_sub24;
wire linien_divider_sub_success24;
wire [25:0] linien_divider_r_sub25;
wire linien_divider_sub_success25;
wire [25:0] linien_divider_r_sub26;
wire linien_divider_sub_success26;
wire [25:0] linien_divider_r_sub27;
wire linien_divider_sub_success27;
wire [25:0] linien_divider_r_sub28;
wire linien_divider_sub_success28;
wire [25:0] linien_divider_r_sub29;
wire linien_divider_sub_success29;
wire [25:0] linien_divider_r_sub30;
wire linien_divider_sub_success30;
wire [25:0] linien_divider_r_sub31;
wire linien_divider_sub_success31;
wire [25:0] linien_divider_r_sub32;
wire linien_divider_sub_success32;
wire [25:0] linien_divider_r_sub33;
wire linien_divider_sub_success33;
wire [25:0] linien_divider_r_sub34;
wire linien_divider_sub_success34;
wire [24:0] linien_divider_q_final_trunc;
wire linien_start_pulse;
reg linien_safe_to_divide_reg = 1'd0;
reg signed [24:0] linien_denominator_reg = 25'sd0;
reg [24:0] linien_x_target_cmd_storage_full = 25'd0;
wire [24:0] linien_x_target_cmd_storage;
reg linien_x_target_cmd_re = 1'd0;
reg [24:0] linien_f_target_cmd_storage_full = 25'd0;
wire [24:0] linien_f_target_cmd_storage;
reg linien_f_target_cmd_re = 1'd0;
reg [24:0] linien_t_target_cmd_storage_full = 25'd0;
wire [24:0] linien_t_target_cmd_storage;
reg linien_t_target_cmd_re = 1'd0;
reg [24:0] linien_power_threshold_target_cmd_storage_full = 25'd0;
wire [24:0] linien_power_threshold_target_cmd_storage;
reg linien_power_threshold_target_cmd_re = 1'd0;
wire signed [24:0] linien_kalman_est_time;
wire [24:0] linien_kalman_est_uncertainty;
wire [24:0] linien_power_level;
wire [24:0] linien_power_threshold_acquire;
wire signed [24:0] linien_time_command_out;
reg [1:0] linien_fsm_state;
wire [1:0] linien_fsm_state_status_status;
wire [24:0] linien_time_command_out_status_status;
reg signed [24:0] linien_current_output_time = 25'sd0;
reg linien_sweep_direction = 1'd1;
reg signed [24:0] linien_sweep_center;
reg signed [24:0] linien_sweep_span;
reg [26:0] linien_narrow_search_timeout_counter = 27'd0;
reg linien_is_ongoing0;
reg linien_is_ongoing1;
reg linien_is_ongoing2;
reg linien_is_ongoing3;
reg linien_scopegen_gpio_trigger = 1'd0;
reg linien_scopegen_sweep_trigger = 1'd0;
reg linien_scopegen_automatically_rearm = 1'd0;
reg linien_scopegen_automatically_trigger = 1'd0;
reg linien_scopegen_automatic_trigger_signal = 1'd0;
reg linien_scopegen_storage_full = 1'd0;
wire linien_scopegen_storage;
reg linien_scopegen_re = 1'd0;
wire linien_scopegen_scope_sys_rstn;
wire linien_scopegen_scope_sys_clk;
wire [31:0] linien_scopegen_scope_sys_addr;
wire [31:0] linien_scopegen_scope_sys_wdata;
wire [3:0] linien_scopegen_scope_sys_sel;
wire linien_scopegen_scope_sys_wen;
wire linien_scopegen_scope_sys_ren;
wire [31:0] linien_scopegen_scope_sys_rdata;
wire linien_scopegen_scope_sys_err;
wire linien_scopegen_scope_sys_ack;
wire linien_scopegen_asg_sys_rstn;
wire linien_scopegen_asg_sys_clk;
wire [31:0] linien_scopegen_asg_sys_addr;
wire [31:0] linien_scopegen_asg_sys_wdata;
wire [3:0] linien_scopegen_asg_sys_sel;
wire linien_scopegen_asg_sys_wen;
wire linien_scopegen_asg_sys_ren;
reg [31:0] linien_scopegen_asg_sys_rdata = 32'd0;
reg linien_scopegen_asg_sys_err = 1'd0;
reg linien_scopegen_asg_sys_ack = 1'd0;
reg signed [24:0] linien_scopegen_adc_a = 25'sd0;
reg signed [24:0] linien_scopegen_adc_a_q = 25'sd0;
reg signed [24:0] linien_scopegen_adc_b = 25'sd0;
reg signed [24:0] linien_scopegen_adc_b_q = 25'sd0;
wire signed [24:0] linien_scopegen_dac_a;
wire signed [24:0] linien_scopegen_dac_b;
reg signed [13:0] linien_scopegen_asg_a = 14'sd0;
reg signed [13:0] linien_scopegen_asg_b = 14'sd0;
reg linien_scopegen_asg_trig = 1'd0;
wire linien_scopegen_writing_data_now;
wire signed [13:0] linien_scopegen_scope_written_data;
wire [13:0] linien_scopegen_scope_position;
wire signed [13:0] linien_sine_source_output;
reg [31:0] linien_sine_source_phase = 32'd0;
wire [9:0] linien_sine_source_index;
wire [24:0] linien_sig_status0;
wire linien_csr0_x_clr_re;
wire linien_csr0_x_clr_r;
reg linien_csr0_x_clr_w = 1'd0;
reg [24:0] linien_max_status0 = 25'd0;
reg [24:0] linien_min_status0 = 25'd0;
wire [24:0] linien_sig_status1;
wire linien_csr1_out_i_clr_re;
wire linien_csr1_out_i_clr_r;
reg linien_csr1_out_i_clr_w = 1'd0;
reg [24:0] linien_max_status1 = 25'd0;
reg [24:0] linien_min_status1 = 25'd0;
wire [24:0] linien_sig_status2;
wire linien_csr2_out_q_clr_re;
wire linien_csr2_out_q_clr_r;
reg linien_csr2_out_q_clr_w = 1'd0;
reg [24:0] linien_max_status2 = 25'd0;
reg [24:0] linien_min_status2 = 25'd0;
wire [24:0] linien_sig_status3;
wire linien_csr3_x_clr_re;
wire linien_csr3_x_clr_r;
reg linien_csr3_x_clr_w = 1'd0;
reg [24:0] linien_max_status3 = 25'd0;
reg [24:0] linien_min_status3 = 25'd0;
wire [24:0] linien_sig_status4;
wire linien_csr4_out_i_clr_re;
wire linien_csr4_out_i_clr_r;
reg linien_csr4_out_i_clr_w = 1'd0;
reg [24:0] linien_max_status4 = 25'd0;
reg [24:0] linien_min_status4 = 25'd0;
wire [24:0] linien_sig_status5;
wire linien_csr5_out_q_clr_re;
wire linien_csr5_out_q_clr_r;
reg linien_csr5_out_q_clr_w = 1'd0;
reg [24:0] linien_max_status5 = 25'd0;
reg [24:0] linien_min_status5 = 25'd0;
wire [24:0] linien_sig_status6;
wire linien_out_e_clr_re;
wire linien_out_e_clr_r;
reg linien_out_e_clr_w = 1'd0;
reg [24:0] linien_max_status6 = 25'd0;
reg [24:0] linien_min_status6 = 25'd0;
wire [24:0] linien_sig_status7;
wire linien_power_signal_out_clr_re;
wire linien_power_signal_out_clr_r;
reg linien_power_signal_out_clr_w = 1'd0;
reg [24:0] linien_max_status7 = 25'd0;
reg [24:0] linien_min_status7 = 25'd0;
wire [24:0] linien_sig_status8;
wire linien_dac_a_clr_re;
wire linien_dac_a_clr_r;
reg linien_dac_a_clr_w = 1'd0;
reg [24:0] linien_max_status8 = 25'd0;
reg [24:0] linien_min_status8 = 25'd0;
wire [24:0] linien_sig_status9;
wire linien_dac_b_clr_re;
wire linien_dac_b_clr_r;
reg linien_dac_b_clr_w = 1'd0;
reg [24:0] linien_max_status9 = 25'd0;
reg [24:0] linien_min_status9 = 25'd0;
wire [13:0] linien_sig_status10;
wire linien_control_signal_clr_re;
wire linien_control_signal_clr_r;
reg linien_control_signal_clr_w = 1'd0;
reg [13:0] linien_max_status10 = 14'd0;
reg [13:0] linien_min_status10 = 14'd0;
wire [24:0] linien_sig_status11;
wire linien_time_command_out_clr_re;
wire linien_time_command_out_clr_r;
reg linien_time_command_out_clr_w = 1'd0;
reg [24:0] linien_max_status11 = 25'd0;
reg [24:0] linien_min_status11 = 25'd0;
wire [8:0] linien_state;
reg [8:0] linien_state_status = 9'd0;
wire linien_state_clr_re;
wire linien_state_clr_r;
reg linien_state_clr_w = 1'd0;
reg [8:0] linien_csrstorage0_storage_full = 9'd0;
wire [8:0] linien_csrstorage0_storage;
reg linien_csrstorage0_re = 1'd0;
reg [8:0] linien_csrstorage1_storage_full = 9'd0;
wire [8:0] linien_csrstorage1_storage;
reg linien_csrstorage1_re = 1'd0;
reg [8:0] linien_csrstorage2_storage_full = 9'd0;
wire [8:0] linien_csrstorage2_storage;
reg linien_csrstorage2_re = 1'd0;
reg [8:0] linien_csrstorage3_storage_full = 9'd0;
wire [8:0] linien_csrstorage3_storage;
reg linien_csrstorage3_re = 1'd0;
reg [8:0] linien_csrstorage4_storage_full = 9'd0;
wire [8:0] linien_csrstorage4_storage;
reg linien_csrstorage4_re = 1'd0;
reg [8:0] linien_csrstorage5_storage_full = 9'd0;
wire [8:0] linien_csrstorage5_storage;
reg linien_csrstorage5_re = 1'd0;
reg [8:0] linien_csrstorage6_storage_full = 9'd0;
wire [8:0] linien_csrstorage6_storage;
reg linien_csrstorage6_re = 1'd0;
reg [8:0] linien_csrstorage7_storage_full = 9'd0;
wire [8:0] linien_csrstorage7_storage;
reg linien_csrstorage7_re = 1'd0;
reg [3:0] linien_csrstorage8_storage_full = 4'd0;
wire [3:0] linien_csrstorage8_storage;
reg linien_csrstorage8_re = 1'd0;
reg [3:0] linien_csrstorage9_storage_full = 4'd0;
wire [3:0] linien_csrstorage9_storage;
reg linien_csrstorage9_re = 1'd0;
reg [3:0] linien_csrstorage10_storage_full = 4'd0;
wire [3:0] linien_csrstorage10_storage;
reg linien_csrstorage10_re = 1'd0;
reg [3:0] linien_csrstorage11_storage_full = 4'd0;
wire [3:0] linien_csrstorage11_storage;
reg linien_csrstorage11_re = 1'd0;
reg [3:0] linien_csrstorage12_storage_full = 4'd0;
wire [3:0] linien_csrstorage12_storage;
reg linien_csrstorage12_re = 1'd0;
reg [3:0] linien_csrstorage13_storage_full = 4'd0;
wire [3:0] linien_csrstorage13_storage;
reg linien_csrstorage13_re = 1'd0;
reg [3:0] linien_csrstorage14_storage_full = 4'd0;
wire [3:0] linien_csrstorage14_storage;
reg linien_csrstorage14_re = 1'd0;
reg [3:0] linien_csrstorage15_storage_full = 4'd0;
wire [3:0] linien_csrstorage15_storage;
reg linien_csrstorage15_re = 1'd0;
wire [13:0] linien_interface0_bank_bus_adr;
wire linien_interface0_bank_bus_we;
wire [7:0] linien_interface0_bank_bus_dat_w;
reg [7:0] linien_interface0_bank_bus_dat_r = 8'd0;
wire linien_csrbank0_dna7_re;
wire [7:0] linien_csrbank0_dna7_r;
wire [7:0] linien_csrbank0_dna7_w;
wire linien_csrbank0_dna6_re;
wire [7:0] linien_csrbank0_dna6_r;
wire [7:0] linien_csrbank0_dna6_w;
wire linien_csrbank0_dna5_re;
wire [7:0] linien_csrbank0_dna5_r;
wire [7:0] linien_csrbank0_dna5_w;
wire linien_csrbank0_dna4_re;
wire [7:0] linien_csrbank0_dna4_r;
wire [7:0] linien_csrbank0_dna4_w;
wire linien_csrbank0_dna3_re;
wire [7:0] linien_csrbank0_dna3_r;
wire [7:0] linien_csrbank0_dna3_w;
wire linien_csrbank0_dna2_re;
wire [7:0] linien_csrbank0_dna2_r;
wire [7:0] linien_csrbank0_dna2_w;
wire linien_csrbank0_dna1_re;
wire [7:0] linien_csrbank0_dna1_r;
wire [7:0] linien_csrbank0_dna1_w;
wire linien_csrbank0_dna0_re;
wire [7:0] linien_csrbank0_dna0_r;
wire [7:0] linien_csrbank0_dna0_w;
wire linien_csrbank0_sel;
wire [13:0] linien_interface1_bank_bus_adr;
wire linien_interface1_bank_bus_we;
wire [7:0] linien_interface1_bank_bus_dat_w;
reg [7:0] linien_interface1_bank_bus_dat_r = 8'd0;
wire linien_csrbank1_out_e3_re;
wire linien_csrbank1_out_e3_r;
wire linien_csrbank1_out_e3_w;
wire linien_csrbank1_out_e2_re;
wire [7:0] linien_csrbank1_out_e2_r;
wire [7:0] linien_csrbank1_out_e2_w;
wire linien_csrbank1_out_e1_re;
wire [7:0] linien_csrbank1_out_e1_r;
wire [7:0] linien_csrbank1_out_e1_w;
wire linien_csrbank1_out_e0_re;
wire [7:0] linien_csrbank1_out_e0_r;
wire [7:0] linien_csrbank1_out_e0_w;
wire linien_csrbank1_power_signal_out3_re;
wire linien_csrbank1_power_signal_out3_r;
wire linien_csrbank1_power_signal_out3_w;
wire linien_csrbank1_power_signal_out2_re;
wire [7:0] linien_csrbank1_power_signal_out2_r;
wire [7:0] linien_csrbank1_power_signal_out2_w;
wire linien_csrbank1_power_signal_out1_re;
wire [7:0] linien_csrbank1_power_signal_out1_r;
wire [7:0] linien_csrbank1_power_signal_out1_w;
wire linien_csrbank1_power_signal_out0_re;
wire [7:0] linien_csrbank1_power_signal_out0_r;
wire [7:0] linien_csrbank1_power_signal_out0_w;
wire linien_csrbank1_out_e_max3_re;
wire linien_csrbank1_out_e_max3_r;
wire linien_csrbank1_out_e_max3_w;
wire linien_csrbank1_out_e_max2_re;
wire [7:0] linien_csrbank1_out_e_max2_r;
wire [7:0] linien_csrbank1_out_e_max2_w;
wire linien_csrbank1_out_e_max1_re;
wire [7:0] linien_csrbank1_out_e_max1_r;
wire [7:0] linien_csrbank1_out_e_max1_w;
wire linien_csrbank1_out_e_max0_re;
wire [7:0] linien_csrbank1_out_e_max0_r;
wire [7:0] linien_csrbank1_out_e_max0_w;
wire linien_csrbank1_out_e_min3_re;
wire linien_csrbank1_out_e_min3_r;
wire linien_csrbank1_out_e_min3_w;
wire linien_csrbank1_out_e_min2_re;
wire [7:0] linien_csrbank1_out_e_min2_r;
wire [7:0] linien_csrbank1_out_e_min2_w;
wire linien_csrbank1_out_e_min1_re;
wire [7:0] linien_csrbank1_out_e_min1_r;
wire [7:0] linien_csrbank1_out_e_min1_w;
wire linien_csrbank1_out_e_min0_re;
wire [7:0] linien_csrbank1_out_e_min0_r;
wire [7:0] linien_csrbank1_out_e_min0_w;
wire linien_csrbank1_power_signal_out_max3_re;
wire linien_csrbank1_power_signal_out_max3_r;
wire linien_csrbank1_power_signal_out_max3_w;
wire linien_csrbank1_power_signal_out_max2_re;
wire [7:0] linien_csrbank1_power_signal_out_max2_r;
wire [7:0] linien_csrbank1_power_signal_out_max2_w;
wire linien_csrbank1_power_signal_out_max1_re;
wire [7:0] linien_csrbank1_power_signal_out_max1_r;
wire [7:0] linien_csrbank1_power_signal_out_max1_w;
wire linien_csrbank1_power_signal_out_max0_re;
wire [7:0] linien_csrbank1_power_signal_out_max0_r;
wire [7:0] linien_csrbank1_power_signal_out_max0_w;
wire linien_csrbank1_power_signal_out_min3_re;
wire linien_csrbank1_power_signal_out_min3_r;
wire linien_csrbank1_power_signal_out_min3_w;
wire linien_csrbank1_power_signal_out_min2_re;
wire [7:0] linien_csrbank1_power_signal_out_min2_r;
wire [7:0] linien_csrbank1_power_signal_out_min2_w;
wire linien_csrbank1_power_signal_out_min1_re;
wire [7:0] linien_csrbank1_power_signal_out_min1_r;
wire [7:0] linien_csrbank1_power_signal_out_min1_w;
wire linien_csrbank1_power_signal_out_min0_re;
wire [7:0] linien_csrbank1_power_signal_out_min0_r;
wire [7:0] linien_csrbank1_power_signal_out_min0_w;
wire linien_csrbank1_sel;
wire [13:0] linien_interface2_bank_bus_adr;
wire linien_interface2_bank_bus_we;
wire [7:0] linien_interface2_bank_bus_dat_w;
reg [7:0] linien_interface2_bank_bus_dat_r = 8'd0;
wire linien_csrbank2_y_tap0_re;
wire [1:0] linien_csrbank2_y_tap0_r;
wire [1:0] linien_csrbank2_y_tap0_w;
wire linien_csrbank2_invert0_re;
wire linien_csrbank2_invert0_r;
wire linien_csrbank2_invert0_w;
wire linien_csrbank2_demod_delay3_re;
wire [7:0] linien_csrbank2_demod_delay3_r;
wire [7:0] linien_csrbank2_demod_delay3_w;
wire linien_csrbank2_demod_delay2_re;
wire [7:0] linien_csrbank2_demod_delay2_r;
wire [7:0] linien_csrbank2_demod_delay2_w;
wire linien_csrbank2_demod_delay1_re;
wire [7:0] linien_csrbank2_demod_delay1_r;
wire [7:0] linien_csrbank2_demod_delay1_w;
wire linien_csrbank2_demod_delay0_re;
wire [7:0] linien_csrbank2_demod_delay0_r;
wire [7:0] linien_csrbank2_demod_delay0_w;
wire linien_csrbank2_demod_multiplier0_re;
wire [3:0] linien_csrbank2_demod_multiplier0_r;
wire [3:0] linien_csrbank2_demod_multiplier0_w;
wire linien_csrbank2_x_limit_1_min3_re;
wire linien_csrbank2_x_limit_1_min3_r;
wire linien_csrbank2_x_limit_1_min3_w;
wire linien_csrbank2_x_limit_1_min2_re;
wire [7:0] linien_csrbank2_x_limit_1_min2_r;
wire [7:0] linien_csrbank2_x_limit_1_min2_w;
wire linien_csrbank2_x_limit_1_min1_re;
wire [7:0] linien_csrbank2_x_limit_1_min1_r;
wire [7:0] linien_csrbank2_x_limit_1_min1_w;
wire linien_csrbank2_x_limit_1_min0_re;
wire [7:0] linien_csrbank2_x_limit_1_min0_r;
wire [7:0] linien_csrbank2_x_limit_1_min0_w;
wire linien_csrbank2_x_limit_1_max3_re;
wire linien_csrbank2_x_limit_1_max3_r;
wire linien_csrbank2_x_limit_1_max3_w;
wire linien_csrbank2_x_limit_1_max2_re;
wire [7:0] linien_csrbank2_x_limit_1_max2_r;
wire [7:0] linien_csrbank2_x_limit_1_max2_w;
wire linien_csrbank2_x_limit_1_max1_re;
wire [7:0] linien_csrbank2_x_limit_1_max1_r;
wire [7:0] linien_csrbank2_x_limit_1_max1_w;
wire linien_csrbank2_x_limit_1_max0_re;
wire [7:0] linien_csrbank2_x_limit_1_max0_r;
wire [7:0] linien_csrbank2_x_limit_1_max0_w;
wire linien_csrbank2_iir_c_1_z03_re;
wire [2:0] linien_csrbank2_iir_c_1_z03_r;
wire [2:0] linien_csrbank2_iir_c_1_z03_w;
wire linien_csrbank2_iir_c_1_z02_re;
wire [7:0] linien_csrbank2_iir_c_1_z02_r;
wire [7:0] linien_csrbank2_iir_c_1_z02_w;
wire linien_csrbank2_iir_c_1_z01_re;
wire [7:0] linien_csrbank2_iir_c_1_z01_r;
wire [7:0] linien_csrbank2_iir_c_1_z01_w;
wire linien_csrbank2_iir_c_1_z00_re;
wire [7:0] linien_csrbank2_iir_c_1_z00_r;
wire [7:0] linien_csrbank2_iir_c_1_z00_w;
wire linien_csrbank2_iir_c_1_a13_re;
wire linien_csrbank2_iir_c_1_a13_r;
wire linien_csrbank2_iir_c_1_a13_w;
wire linien_csrbank2_iir_c_1_a12_re;
wire [7:0] linien_csrbank2_iir_c_1_a12_r;
wire [7:0] linien_csrbank2_iir_c_1_a12_w;
wire linien_csrbank2_iir_c_1_a11_re;
wire [7:0] linien_csrbank2_iir_c_1_a11_r;
wire [7:0] linien_csrbank2_iir_c_1_a11_w;
wire linien_csrbank2_iir_c_1_a10_re;
wire [7:0] linien_csrbank2_iir_c_1_a10_r;
wire [7:0] linien_csrbank2_iir_c_1_a10_w;
wire linien_csrbank2_iir_c_1_b03_re;
wire linien_csrbank2_iir_c_1_b03_r;
wire linien_csrbank2_iir_c_1_b03_w;
wire linien_csrbank2_iir_c_1_b02_re;
wire [7:0] linien_csrbank2_iir_c_1_b02_r;
wire [7:0] linien_csrbank2_iir_c_1_b02_w;
wire linien_csrbank2_iir_c_1_b01_re;
wire [7:0] linien_csrbank2_iir_c_1_b01_r;
wire [7:0] linien_csrbank2_iir_c_1_b01_w;
wire linien_csrbank2_iir_c_1_b00_re;
wire [7:0] linien_csrbank2_iir_c_1_b00_r;
wire [7:0] linien_csrbank2_iir_c_1_b00_w;
wire linien_csrbank2_iir_c_1_b13_re;
wire linien_csrbank2_iir_c_1_b13_r;
wire linien_csrbank2_iir_c_1_b13_w;
wire linien_csrbank2_iir_c_1_b12_re;
wire [7:0] linien_csrbank2_iir_c_1_b12_r;
wire [7:0] linien_csrbank2_iir_c_1_b12_w;
wire linien_csrbank2_iir_c_1_b11_re;
wire [7:0] linien_csrbank2_iir_c_1_b11_r;
wire [7:0] linien_csrbank2_iir_c_1_b11_w;
wire linien_csrbank2_iir_c_1_b10_re;
wire [7:0] linien_csrbank2_iir_c_1_b10_r;
wire [7:0] linien_csrbank2_iir_c_1_b10_w;
wire linien_csrbank2_iir_d_1_z03_re;
wire [2:0] linien_csrbank2_iir_d_1_z03_r;
wire [2:0] linien_csrbank2_iir_d_1_z03_w;
wire linien_csrbank2_iir_d_1_z02_re;
wire [7:0] linien_csrbank2_iir_d_1_z02_r;
wire [7:0] linien_csrbank2_iir_d_1_z02_w;
wire linien_csrbank2_iir_d_1_z01_re;
wire [7:0] linien_csrbank2_iir_d_1_z01_r;
wire [7:0] linien_csrbank2_iir_d_1_z01_w;
wire linien_csrbank2_iir_d_1_z00_re;
wire [7:0] linien_csrbank2_iir_d_1_z00_r;
wire [7:0] linien_csrbank2_iir_d_1_z00_w;
wire linien_csrbank2_iir_d_1_a13_re;
wire linien_csrbank2_iir_d_1_a13_r;
wire linien_csrbank2_iir_d_1_a13_w;
wire linien_csrbank2_iir_d_1_a12_re;
wire [7:0] linien_csrbank2_iir_d_1_a12_r;
wire [7:0] linien_csrbank2_iir_d_1_a12_w;
wire linien_csrbank2_iir_d_1_a11_re;
wire [7:0] linien_csrbank2_iir_d_1_a11_r;
wire [7:0] linien_csrbank2_iir_d_1_a11_w;
wire linien_csrbank2_iir_d_1_a10_re;
wire [7:0] linien_csrbank2_iir_d_1_a10_r;
wire [7:0] linien_csrbank2_iir_d_1_a10_w;
wire linien_csrbank2_iir_d_1_a23_re;
wire linien_csrbank2_iir_d_1_a23_r;
wire linien_csrbank2_iir_d_1_a23_w;
wire linien_csrbank2_iir_d_1_a22_re;
wire [7:0] linien_csrbank2_iir_d_1_a22_r;
wire [7:0] linien_csrbank2_iir_d_1_a22_w;
wire linien_csrbank2_iir_d_1_a21_re;
wire [7:0] linien_csrbank2_iir_d_1_a21_r;
wire [7:0] linien_csrbank2_iir_d_1_a21_w;
wire linien_csrbank2_iir_d_1_a20_re;
wire [7:0] linien_csrbank2_iir_d_1_a20_r;
wire [7:0] linien_csrbank2_iir_d_1_a20_w;
wire linien_csrbank2_iir_d_1_b03_re;
wire linien_csrbank2_iir_d_1_b03_r;
wire linien_csrbank2_iir_d_1_b03_w;
wire linien_csrbank2_iir_d_1_b02_re;
wire [7:0] linien_csrbank2_iir_d_1_b02_r;
wire [7:0] linien_csrbank2_iir_d_1_b02_w;
wire linien_csrbank2_iir_d_1_b01_re;
wire [7:0] linien_csrbank2_iir_d_1_b01_r;
wire [7:0] linien_csrbank2_iir_d_1_b01_w;
wire linien_csrbank2_iir_d_1_b00_re;
wire [7:0] linien_csrbank2_iir_d_1_b00_r;
wire [7:0] linien_csrbank2_iir_d_1_b00_w;
wire linien_csrbank2_iir_d_1_b13_re;
wire linien_csrbank2_iir_d_1_b13_r;
wire linien_csrbank2_iir_d_1_b13_w;
wire linien_csrbank2_iir_d_1_b12_re;
wire [7:0] linien_csrbank2_iir_d_1_b12_r;
wire [7:0] linien_csrbank2_iir_d_1_b12_w;
wire linien_csrbank2_iir_d_1_b11_re;
wire [7:0] linien_csrbank2_iir_d_1_b11_r;
wire [7:0] linien_csrbank2_iir_d_1_b11_w;
wire linien_csrbank2_iir_d_1_b10_re;
wire [7:0] linien_csrbank2_iir_d_1_b10_r;
wire [7:0] linien_csrbank2_iir_d_1_b10_w;
wire linien_csrbank2_iir_d_1_b23_re;
wire linien_csrbank2_iir_d_1_b23_r;
wire linien_csrbank2_iir_d_1_b23_w;
wire linien_csrbank2_iir_d_1_b22_re;
wire [7:0] linien_csrbank2_iir_d_1_b22_r;
wire [7:0] linien_csrbank2_iir_d_1_b22_w;
wire linien_csrbank2_iir_d_1_b21_re;
wire [7:0] linien_csrbank2_iir_d_1_b21_r;
wire [7:0] linien_csrbank2_iir_d_1_b21_w;
wire linien_csrbank2_iir_d_1_b20_re;
wire [7:0] linien_csrbank2_iir_d_1_b20_r;
wire [7:0] linien_csrbank2_iir_d_1_b20_w;
wire linien_csrbank2_y_limit_1_min3_re;
wire linien_csrbank2_y_limit_1_min3_r;
wire linien_csrbank2_y_limit_1_min3_w;
wire linien_csrbank2_y_limit_1_min2_re;
wire [7:0] linien_csrbank2_y_limit_1_min2_r;
wire [7:0] linien_csrbank2_y_limit_1_min2_w;
wire linien_csrbank2_y_limit_1_min1_re;
wire [7:0] linien_csrbank2_y_limit_1_min1_r;
wire [7:0] linien_csrbank2_y_limit_1_min1_w;
wire linien_csrbank2_y_limit_1_min0_re;
wire [7:0] linien_csrbank2_y_limit_1_min0_r;
wire [7:0] linien_csrbank2_y_limit_1_min0_w;
wire linien_csrbank2_y_limit_1_max3_re;
wire linien_csrbank2_y_limit_1_max3_r;
wire linien_csrbank2_y_limit_1_max3_w;
wire linien_csrbank2_y_limit_1_max2_re;
wire [7:0] linien_csrbank2_y_limit_1_max2_r;
wire [7:0] linien_csrbank2_y_limit_1_max2_w;
wire linien_csrbank2_y_limit_1_max1_re;
wire [7:0] linien_csrbank2_y_limit_1_max1_r;
wire [7:0] linien_csrbank2_y_limit_1_max1_w;
wire linien_csrbank2_y_limit_1_max0_re;
wire [7:0] linien_csrbank2_y_limit_1_max0_r;
wire [7:0] linien_csrbank2_y_limit_1_max0_w;
wire linien_csrbank2_x_limit_2_min3_re;
wire linien_csrbank2_x_limit_2_min3_r;
wire linien_csrbank2_x_limit_2_min3_w;
wire linien_csrbank2_x_limit_2_min2_re;
wire [7:0] linien_csrbank2_x_limit_2_min2_r;
wire [7:0] linien_csrbank2_x_limit_2_min2_w;
wire linien_csrbank2_x_limit_2_min1_re;
wire [7:0] linien_csrbank2_x_limit_2_min1_r;
wire [7:0] linien_csrbank2_x_limit_2_min1_w;
wire linien_csrbank2_x_limit_2_min0_re;
wire [7:0] linien_csrbank2_x_limit_2_min0_r;
wire [7:0] linien_csrbank2_x_limit_2_min0_w;
wire linien_csrbank2_x_limit_2_max3_re;
wire linien_csrbank2_x_limit_2_max3_r;
wire linien_csrbank2_x_limit_2_max3_w;
wire linien_csrbank2_x_limit_2_max2_re;
wire [7:0] linien_csrbank2_x_limit_2_max2_r;
wire [7:0] linien_csrbank2_x_limit_2_max2_w;
wire linien_csrbank2_x_limit_2_max1_re;
wire [7:0] linien_csrbank2_x_limit_2_max1_r;
wire [7:0] linien_csrbank2_x_limit_2_max1_w;
wire linien_csrbank2_x_limit_2_max0_re;
wire [7:0] linien_csrbank2_x_limit_2_max0_r;
wire [7:0] linien_csrbank2_x_limit_2_max0_w;
wire linien_csrbank2_iir_c_2_z03_re;
wire [2:0] linien_csrbank2_iir_c_2_z03_r;
wire [2:0] linien_csrbank2_iir_c_2_z03_w;
wire linien_csrbank2_iir_c_2_z02_re;
wire [7:0] linien_csrbank2_iir_c_2_z02_r;
wire [7:0] linien_csrbank2_iir_c_2_z02_w;
wire linien_csrbank2_iir_c_2_z01_re;
wire [7:0] linien_csrbank2_iir_c_2_z01_r;
wire [7:0] linien_csrbank2_iir_c_2_z01_w;
wire linien_csrbank2_iir_c_2_z00_re;
wire [7:0] linien_csrbank2_iir_c_2_z00_r;
wire [7:0] linien_csrbank2_iir_c_2_z00_w;
wire linien_csrbank2_iir_c_2_a13_re;
wire linien_csrbank2_iir_c_2_a13_r;
wire linien_csrbank2_iir_c_2_a13_w;
wire linien_csrbank2_iir_c_2_a12_re;
wire [7:0] linien_csrbank2_iir_c_2_a12_r;
wire [7:0] linien_csrbank2_iir_c_2_a12_w;
wire linien_csrbank2_iir_c_2_a11_re;
wire [7:0] linien_csrbank2_iir_c_2_a11_r;
wire [7:0] linien_csrbank2_iir_c_2_a11_w;
wire linien_csrbank2_iir_c_2_a10_re;
wire [7:0] linien_csrbank2_iir_c_2_a10_r;
wire [7:0] linien_csrbank2_iir_c_2_a10_w;
wire linien_csrbank2_iir_c_2_b03_re;
wire linien_csrbank2_iir_c_2_b03_r;
wire linien_csrbank2_iir_c_2_b03_w;
wire linien_csrbank2_iir_c_2_b02_re;
wire [7:0] linien_csrbank2_iir_c_2_b02_r;
wire [7:0] linien_csrbank2_iir_c_2_b02_w;
wire linien_csrbank2_iir_c_2_b01_re;
wire [7:0] linien_csrbank2_iir_c_2_b01_r;
wire [7:0] linien_csrbank2_iir_c_2_b01_w;
wire linien_csrbank2_iir_c_2_b00_re;
wire [7:0] linien_csrbank2_iir_c_2_b00_r;
wire [7:0] linien_csrbank2_iir_c_2_b00_w;
wire linien_csrbank2_iir_c_2_b13_re;
wire linien_csrbank2_iir_c_2_b13_r;
wire linien_csrbank2_iir_c_2_b13_w;
wire linien_csrbank2_iir_c_2_b12_re;
wire [7:0] linien_csrbank2_iir_c_2_b12_r;
wire [7:0] linien_csrbank2_iir_c_2_b12_w;
wire linien_csrbank2_iir_c_2_b11_re;
wire [7:0] linien_csrbank2_iir_c_2_b11_r;
wire [7:0] linien_csrbank2_iir_c_2_b11_w;
wire linien_csrbank2_iir_c_2_b10_re;
wire [7:0] linien_csrbank2_iir_c_2_b10_r;
wire [7:0] linien_csrbank2_iir_c_2_b10_w;
wire linien_csrbank2_iir_d_2_z03_re;
wire [2:0] linien_csrbank2_iir_d_2_z03_r;
wire [2:0] linien_csrbank2_iir_d_2_z03_w;
wire linien_csrbank2_iir_d_2_z02_re;
wire [7:0] linien_csrbank2_iir_d_2_z02_r;
wire [7:0] linien_csrbank2_iir_d_2_z02_w;
wire linien_csrbank2_iir_d_2_z01_re;
wire [7:0] linien_csrbank2_iir_d_2_z01_r;
wire [7:0] linien_csrbank2_iir_d_2_z01_w;
wire linien_csrbank2_iir_d_2_z00_re;
wire [7:0] linien_csrbank2_iir_d_2_z00_r;
wire [7:0] linien_csrbank2_iir_d_2_z00_w;
wire linien_csrbank2_iir_d_2_a13_re;
wire linien_csrbank2_iir_d_2_a13_r;
wire linien_csrbank2_iir_d_2_a13_w;
wire linien_csrbank2_iir_d_2_a12_re;
wire [7:0] linien_csrbank2_iir_d_2_a12_r;
wire [7:0] linien_csrbank2_iir_d_2_a12_w;
wire linien_csrbank2_iir_d_2_a11_re;
wire [7:0] linien_csrbank2_iir_d_2_a11_r;
wire [7:0] linien_csrbank2_iir_d_2_a11_w;
wire linien_csrbank2_iir_d_2_a10_re;
wire [7:0] linien_csrbank2_iir_d_2_a10_r;
wire [7:0] linien_csrbank2_iir_d_2_a10_w;
wire linien_csrbank2_iir_d_2_a23_re;
wire linien_csrbank2_iir_d_2_a23_r;
wire linien_csrbank2_iir_d_2_a23_w;
wire linien_csrbank2_iir_d_2_a22_re;
wire [7:0] linien_csrbank2_iir_d_2_a22_r;
wire [7:0] linien_csrbank2_iir_d_2_a22_w;
wire linien_csrbank2_iir_d_2_a21_re;
wire [7:0] linien_csrbank2_iir_d_2_a21_r;
wire [7:0] linien_csrbank2_iir_d_2_a21_w;
wire linien_csrbank2_iir_d_2_a20_re;
wire [7:0] linien_csrbank2_iir_d_2_a20_r;
wire [7:0] linien_csrbank2_iir_d_2_a20_w;
wire linien_csrbank2_iir_d_2_b03_re;
wire linien_csrbank2_iir_d_2_b03_r;
wire linien_csrbank2_iir_d_2_b03_w;
wire linien_csrbank2_iir_d_2_b02_re;
wire [7:0] linien_csrbank2_iir_d_2_b02_r;
wire [7:0] linien_csrbank2_iir_d_2_b02_w;
wire linien_csrbank2_iir_d_2_b01_re;
wire [7:0] linien_csrbank2_iir_d_2_b01_r;
wire [7:0] linien_csrbank2_iir_d_2_b01_w;
wire linien_csrbank2_iir_d_2_b00_re;
wire [7:0] linien_csrbank2_iir_d_2_b00_r;
wire [7:0] linien_csrbank2_iir_d_2_b00_w;
wire linien_csrbank2_iir_d_2_b13_re;
wire linien_csrbank2_iir_d_2_b13_r;
wire linien_csrbank2_iir_d_2_b13_w;
wire linien_csrbank2_iir_d_2_b12_re;
wire [7:0] linien_csrbank2_iir_d_2_b12_r;
wire [7:0] linien_csrbank2_iir_d_2_b12_w;
wire linien_csrbank2_iir_d_2_b11_re;
wire [7:0] linien_csrbank2_iir_d_2_b11_r;
wire [7:0] linien_csrbank2_iir_d_2_b11_w;
wire linien_csrbank2_iir_d_2_b10_re;
wire [7:0] linien_csrbank2_iir_d_2_b10_r;
wire [7:0] linien_csrbank2_iir_d_2_b10_w;
wire linien_csrbank2_iir_d_2_b23_re;
wire linien_csrbank2_iir_d_2_b23_r;
wire linien_csrbank2_iir_d_2_b23_w;
wire linien_csrbank2_iir_d_2_b22_re;
wire [7:0] linien_csrbank2_iir_d_2_b22_r;
wire [7:0] linien_csrbank2_iir_d_2_b22_w;
wire linien_csrbank2_iir_d_2_b21_re;
wire [7:0] linien_csrbank2_iir_d_2_b21_r;
wire [7:0] linien_csrbank2_iir_d_2_b21_w;
wire linien_csrbank2_iir_d_2_b20_re;
wire [7:0] linien_csrbank2_iir_d_2_b20_r;
wire [7:0] linien_csrbank2_iir_d_2_b20_w;
wire linien_csrbank2_y_limit_2_min3_re;
wire linien_csrbank2_y_limit_2_min3_r;
wire linien_csrbank2_y_limit_2_min3_w;
wire linien_csrbank2_y_limit_2_min2_re;
wire [7:0] linien_csrbank2_y_limit_2_min2_r;
wire [7:0] linien_csrbank2_y_limit_2_min2_w;
wire linien_csrbank2_y_limit_2_min1_re;
wire [7:0] linien_csrbank2_y_limit_2_min1_r;
wire [7:0] linien_csrbank2_y_limit_2_min1_w;
wire linien_csrbank2_y_limit_2_min0_re;
wire [7:0] linien_csrbank2_y_limit_2_min0_r;
wire [7:0] linien_csrbank2_y_limit_2_min0_w;
wire linien_csrbank2_y_limit_2_max3_re;
wire linien_csrbank2_y_limit_2_max3_r;
wire linien_csrbank2_y_limit_2_max3_w;
wire linien_csrbank2_y_limit_2_max2_re;
wire [7:0] linien_csrbank2_y_limit_2_max2_r;
wire [7:0] linien_csrbank2_y_limit_2_max2_w;
wire linien_csrbank2_y_limit_2_max1_re;
wire [7:0] linien_csrbank2_y_limit_2_max1_r;
wire [7:0] linien_csrbank2_y_limit_2_max1_w;
wire linien_csrbank2_y_limit_2_max0_re;
wire [7:0] linien_csrbank2_y_limit_2_max0_r;
wire [7:0] linien_csrbank2_y_limit_2_max0_w;
wire linien_csrbank2_x_max3_re;
wire linien_csrbank2_x_max3_r;
wire linien_csrbank2_x_max3_w;
wire linien_csrbank2_x_max2_re;
wire [7:0] linien_csrbank2_x_max2_r;
wire [7:0] linien_csrbank2_x_max2_w;
wire linien_csrbank2_x_max1_re;
wire [7:0] linien_csrbank2_x_max1_r;
wire [7:0] linien_csrbank2_x_max1_w;
wire linien_csrbank2_x_max0_re;
wire [7:0] linien_csrbank2_x_max0_r;
wire [7:0] linien_csrbank2_x_max0_w;
wire linien_csrbank2_x_min3_re;
wire linien_csrbank2_x_min3_r;
wire linien_csrbank2_x_min3_w;
wire linien_csrbank2_x_min2_re;
wire [7:0] linien_csrbank2_x_min2_r;
wire [7:0] linien_csrbank2_x_min2_w;
wire linien_csrbank2_x_min1_re;
wire [7:0] linien_csrbank2_x_min1_r;
wire [7:0] linien_csrbank2_x_min1_w;
wire linien_csrbank2_x_min0_re;
wire [7:0] linien_csrbank2_x_min0_r;
wire [7:0] linien_csrbank2_x_min0_w;
wire linien_csrbank2_out_i_max3_re;
wire linien_csrbank2_out_i_max3_r;
wire linien_csrbank2_out_i_max3_w;
wire linien_csrbank2_out_i_max2_re;
wire [7:0] linien_csrbank2_out_i_max2_r;
wire [7:0] linien_csrbank2_out_i_max2_w;
wire linien_csrbank2_out_i_max1_re;
wire [7:0] linien_csrbank2_out_i_max1_r;
wire [7:0] linien_csrbank2_out_i_max1_w;
wire linien_csrbank2_out_i_max0_re;
wire [7:0] linien_csrbank2_out_i_max0_r;
wire [7:0] linien_csrbank2_out_i_max0_w;
wire linien_csrbank2_out_i_min3_re;
wire linien_csrbank2_out_i_min3_r;
wire linien_csrbank2_out_i_min3_w;
wire linien_csrbank2_out_i_min2_re;
wire [7:0] linien_csrbank2_out_i_min2_r;
wire [7:0] linien_csrbank2_out_i_min2_w;
wire linien_csrbank2_out_i_min1_re;
wire [7:0] linien_csrbank2_out_i_min1_r;
wire [7:0] linien_csrbank2_out_i_min1_w;
wire linien_csrbank2_out_i_min0_re;
wire [7:0] linien_csrbank2_out_i_min0_r;
wire [7:0] linien_csrbank2_out_i_min0_w;
wire linien_csrbank2_out_q_max3_re;
wire linien_csrbank2_out_q_max3_r;
wire linien_csrbank2_out_q_max3_w;
wire linien_csrbank2_out_q_max2_re;
wire [7:0] linien_csrbank2_out_q_max2_r;
wire [7:0] linien_csrbank2_out_q_max2_w;
wire linien_csrbank2_out_q_max1_re;
wire [7:0] linien_csrbank2_out_q_max1_r;
wire [7:0] linien_csrbank2_out_q_max1_w;
wire linien_csrbank2_out_q_max0_re;
wire [7:0] linien_csrbank2_out_q_max0_r;
wire [7:0] linien_csrbank2_out_q_max0_w;
wire linien_csrbank2_out_q_min3_re;
wire linien_csrbank2_out_q_min3_r;
wire linien_csrbank2_out_q_min3_w;
wire linien_csrbank2_out_q_min2_re;
wire [7:0] linien_csrbank2_out_q_min2_r;
wire [7:0] linien_csrbank2_out_q_min2_w;
wire linien_csrbank2_out_q_min1_re;
wire [7:0] linien_csrbank2_out_q_min1_r;
wire [7:0] linien_csrbank2_out_q_min1_w;
wire linien_csrbank2_out_q_min0_re;
wire [7:0] linien_csrbank2_out_q_min0_r;
wire [7:0] linien_csrbank2_out_q_min0_w;
wire linien_csrbank2_dx_sel0_re;
wire [3:0] linien_csrbank2_dx_sel0_r;
wire [3:0] linien_csrbank2_dx_sel0_w;
wire linien_csrbank2_dy_sel0_re;
wire [3:0] linien_csrbank2_dy_sel0_r;
wire [3:0] linien_csrbank2_dy_sel0_w;
wire linien_csrbank2_sel;
wire [13:0] linien_interface3_bank_bus_adr;
wire linien_interface3_bank_bus_we;
wire [7:0] linien_interface3_bank_bus_dat_w;
reg [7:0] linien_interface3_bank_bus_dat_r = 8'd0;
wire linien_csrbank3_y_tap0_re;
wire [1:0] linien_csrbank3_y_tap0_r;
wire [1:0] linien_csrbank3_y_tap0_w;
wire linien_csrbank3_invert0_re;
wire linien_csrbank3_invert0_r;
wire linien_csrbank3_invert0_w;
wire linien_csrbank3_demod_delay3_re;
wire [7:0] linien_csrbank3_demod_delay3_r;
wire [7:0] linien_csrbank3_demod_delay3_w;
wire linien_csrbank3_demod_delay2_re;
wire [7:0] linien_csrbank3_demod_delay2_r;
wire [7:0] linien_csrbank3_demod_delay2_w;
wire linien_csrbank3_demod_delay1_re;
wire [7:0] linien_csrbank3_demod_delay1_r;
wire [7:0] linien_csrbank3_demod_delay1_w;
wire linien_csrbank3_demod_delay0_re;
wire [7:0] linien_csrbank3_demod_delay0_r;
wire [7:0] linien_csrbank3_demod_delay0_w;
wire linien_csrbank3_demod_multiplier0_re;
wire [3:0] linien_csrbank3_demod_multiplier0_r;
wire [3:0] linien_csrbank3_demod_multiplier0_w;
wire linien_csrbank3_x_limit_1_min3_re;
wire linien_csrbank3_x_limit_1_min3_r;
wire linien_csrbank3_x_limit_1_min3_w;
wire linien_csrbank3_x_limit_1_min2_re;
wire [7:0] linien_csrbank3_x_limit_1_min2_r;
wire [7:0] linien_csrbank3_x_limit_1_min2_w;
wire linien_csrbank3_x_limit_1_min1_re;
wire [7:0] linien_csrbank3_x_limit_1_min1_r;
wire [7:0] linien_csrbank3_x_limit_1_min1_w;
wire linien_csrbank3_x_limit_1_min0_re;
wire [7:0] linien_csrbank3_x_limit_1_min0_r;
wire [7:0] linien_csrbank3_x_limit_1_min0_w;
wire linien_csrbank3_x_limit_1_max3_re;
wire linien_csrbank3_x_limit_1_max3_r;
wire linien_csrbank3_x_limit_1_max3_w;
wire linien_csrbank3_x_limit_1_max2_re;
wire [7:0] linien_csrbank3_x_limit_1_max2_r;
wire [7:0] linien_csrbank3_x_limit_1_max2_w;
wire linien_csrbank3_x_limit_1_max1_re;
wire [7:0] linien_csrbank3_x_limit_1_max1_r;
wire [7:0] linien_csrbank3_x_limit_1_max1_w;
wire linien_csrbank3_x_limit_1_max0_re;
wire [7:0] linien_csrbank3_x_limit_1_max0_r;
wire [7:0] linien_csrbank3_x_limit_1_max0_w;
wire linien_csrbank3_iir_c_1_z03_re;
wire [2:0] linien_csrbank3_iir_c_1_z03_r;
wire [2:0] linien_csrbank3_iir_c_1_z03_w;
wire linien_csrbank3_iir_c_1_z02_re;
wire [7:0] linien_csrbank3_iir_c_1_z02_r;
wire [7:0] linien_csrbank3_iir_c_1_z02_w;
wire linien_csrbank3_iir_c_1_z01_re;
wire [7:0] linien_csrbank3_iir_c_1_z01_r;
wire [7:0] linien_csrbank3_iir_c_1_z01_w;
wire linien_csrbank3_iir_c_1_z00_re;
wire [7:0] linien_csrbank3_iir_c_1_z00_r;
wire [7:0] linien_csrbank3_iir_c_1_z00_w;
wire linien_csrbank3_iir_c_1_a13_re;
wire linien_csrbank3_iir_c_1_a13_r;
wire linien_csrbank3_iir_c_1_a13_w;
wire linien_csrbank3_iir_c_1_a12_re;
wire [7:0] linien_csrbank3_iir_c_1_a12_r;
wire [7:0] linien_csrbank3_iir_c_1_a12_w;
wire linien_csrbank3_iir_c_1_a11_re;
wire [7:0] linien_csrbank3_iir_c_1_a11_r;
wire [7:0] linien_csrbank3_iir_c_1_a11_w;
wire linien_csrbank3_iir_c_1_a10_re;
wire [7:0] linien_csrbank3_iir_c_1_a10_r;
wire [7:0] linien_csrbank3_iir_c_1_a10_w;
wire linien_csrbank3_iir_c_1_b03_re;
wire linien_csrbank3_iir_c_1_b03_r;
wire linien_csrbank3_iir_c_1_b03_w;
wire linien_csrbank3_iir_c_1_b02_re;
wire [7:0] linien_csrbank3_iir_c_1_b02_r;
wire [7:0] linien_csrbank3_iir_c_1_b02_w;
wire linien_csrbank3_iir_c_1_b01_re;
wire [7:0] linien_csrbank3_iir_c_1_b01_r;
wire [7:0] linien_csrbank3_iir_c_1_b01_w;
wire linien_csrbank3_iir_c_1_b00_re;
wire [7:0] linien_csrbank3_iir_c_1_b00_r;
wire [7:0] linien_csrbank3_iir_c_1_b00_w;
wire linien_csrbank3_iir_c_1_b13_re;
wire linien_csrbank3_iir_c_1_b13_r;
wire linien_csrbank3_iir_c_1_b13_w;
wire linien_csrbank3_iir_c_1_b12_re;
wire [7:0] linien_csrbank3_iir_c_1_b12_r;
wire [7:0] linien_csrbank3_iir_c_1_b12_w;
wire linien_csrbank3_iir_c_1_b11_re;
wire [7:0] linien_csrbank3_iir_c_1_b11_r;
wire [7:0] linien_csrbank3_iir_c_1_b11_w;
wire linien_csrbank3_iir_c_1_b10_re;
wire [7:0] linien_csrbank3_iir_c_1_b10_r;
wire [7:0] linien_csrbank3_iir_c_1_b10_w;
wire linien_csrbank3_iir_d_1_z03_re;
wire [2:0] linien_csrbank3_iir_d_1_z03_r;
wire [2:0] linien_csrbank3_iir_d_1_z03_w;
wire linien_csrbank3_iir_d_1_z02_re;
wire [7:0] linien_csrbank3_iir_d_1_z02_r;
wire [7:0] linien_csrbank3_iir_d_1_z02_w;
wire linien_csrbank3_iir_d_1_z01_re;
wire [7:0] linien_csrbank3_iir_d_1_z01_r;
wire [7:0] linien_csrbank3_iir_d_1_z01_w;
wire linien_csrbank3_iir_d_1_z00_re;
wire [7:0] linien_csrbank3_iir_d_1_z00_r;
wire [7:0] linien_csrbank3_iir_d_1_z00_w;
wire linien_csrbank3_iir_d_1_a13_re;
wire linien_csrbank3_iir_d_1_a13_r;
wire linien_csrbank3_iir_d_1_a13_w;
wire linien_csrbank3_iir_d_1_a12_re;
wire [7:0] linien_csrbank3_iir_d_1_a12_r;
wire [7:0] linien_csrbank3_iir_d_1_a12_w;
wire linien_csrbank3_iir_d_1_a11_re;
wire [7:0] linien_csrbank3_iir_d_1_a11_r;
wire [7:0] linien_csrbank3_iir_d_1_a11_w;
wire linien_csrbank3_iir_d_1_a10_re;
wire [7:0] linien_csrbank3_iir_d_1_a10_r;
wire [7:0] linien_csrbank3_iir_d_1_a10_w;
wire linien_csrbank3_iir_d_1_a23_re;
wire linien_csrbank3_iir_d_1_a23_r;
wire linien_csrbank3_iir_d_1_a23_w;
wire linien_csrbank3_iir_d_1_a22_re;
wire [7:0] linien_csrbank3_iir_d_1_a22_r;
wire [7:0] linien_csrbank3_iir_d_1_a22_w;
wire linien_csrbank3_iir_d_1_a21_re;
wire [7:0] linien_csrbank3_iir_d_1_a21_r;
wire [7:0] linien_csrbank3_iir_d_1_a21_w;
wire linien_csrbank3_iir_d_1_a20_re;
wire [7:0] linien_csrbank3_iir_d_1_a20_r;
wire [7:0] linien_csrbank3_iir_d_1_a20_w;
wire linien_csrbank3_iir_d_1_b03_re;
wire linien_csrbank3_iir_d_1_b03_r;
wire linien_csrbank3_iir_d_1_b03_w;
wire linien_csrbank3_iir_d_1_b02_re;
wire [7:0] linien_csrbank3_iir_d_1_b02_r;
wire [7:0] linien_csrbank3_iir_d_1_b02_w;
wire linien_csrbank3_iir_d_1_b01_re;
wire [7:0] linien_csrbank3_iir_d_1_b01_r;
wire [7:0] linien_csrbank3_iir_d_1_b01_w;
wire linien_csrbank3_iir_d_1_b00_re;
wire [7:0] linien_csrbank3_iir_d_1_b00_r;
wire [7:0] linien_csrbank3_iir_d_1_b00_w;
wire linien_csrbank3_iir_d_1_b13_re;
wire linien_csrbank3_iir_d_1_b13_r;
wire linien_csrbank3_iir_d_1_b13_w;
wire linien_csrbank3_iir_d_1_b12_re;
wire [7:0] linien_csrbank3_iir_d_1_b12_r;
wire [7:0] linien_csrbank3_iir_d_1_b12_w;
wire linien_csrbank3_iir_d_1_b11_re;
wire [7:0] linien_csrbank3_iir_d_1_b11_r;
wire [7:0] linien_csrbank3_iir_d_1_b11_w;
wire linien_csrbank3_iir_d_1_b10_re;
wire [7:0] linien_csrbank3_iir_d_1_b10_r;
wire [7:0] linien_csrbank3_iir_d_1_b10_w;
wire linien_csrbank3_iir_d_1_b23_re;
wire linien_csrbank3_iir_d_1_b23_r;
wire linien_csrbank3_iir_d_1_b23_w;
wire linien_csrbank3_iir_d_1_b22_re;
wire [7:0] linien_csrbank3_iir_d_1_b22_r;
wire [7:0] linien_csrbank3_iir_d_1_b22_w;
wire linien_csrbank3_iir_d_1_b21_re;
wire [7:0] linien_csrbank3_iir_d_1_b21_r;
wire [7:0] linien_csrbank3_iir_d_1_b21_w;
wire linien_csrbank3_iir_d_1_b20_re;
wire [7:0] linien_csrbank3_iir_d_1_b20_r;
wire [7:0] linien_csrbank3_iir_d_1_b20_w;
wire linien_csrbank3_y_limit_1_min3_re;
wire linien_csrbank3_y_limit_1_min3_r;
wire linien_csrbank3_y_limit_1_min3_w;
wire linien_csrbank3_y_limit_1_min2_re;
wire [7:0] linien_csrbank3_y_limit_1_min2_r;
wire [7:0] linien_csrbank3_y_limit_1_min2_w;
wire linien_csrbank3_y_limit_1_min1_re;
wire [7:0] linien_csrbank3_y_limit_1_min1_r;
wire [7:0] linien_csrbank3_y_limit_1_min1_w;
wire linien_csrbank3_y_limit_1_min0_re;
wire [7:0] linien_csrbank3_y_limit_1_min0_r;
wire [7:0] linien_csrbank3_y_limit_1_min0_w;
wire linien_csrbank3_y_limit_1_max3_re;
wire linien_csrbank3_y_limit_1_max3_r;
wire linien_csrbank3_y_limit_1_max3_w;
wire linien_csrbank3_y_limit_1_max2_re;
wire [7:0] linien_csrbank3_y_limit_1_max2_r;
wire [7:0] linien_csrbank3_y_limit_1_max2_w;
wire linien_csrbank3_y_limit_1_max1_re;
wire [7:0] linien_csrbank3_y_limit_1_max1_r;
wire [7:0] linien_csrbank3_y_limit_1_max1_w;
wire linien_csrbank3_y_limit_1_max0_re;
wire [7:0] linien_csrbank3_y_limit_1_max0_r;
wire [7:0] linien_csrbank3_y_limit_1_max0_w;
wire linien_csrbank3_x_limit_2_min3_re;
wire linien_csrbank3_x_limit_2_min3_r;
wire linien_csrbank3_x_limit_2_min3_w;
wire linien_csrbank3_x_limit_2_min2_re;
wire [7:0] linien_csrbank3_x_limit_2_min2_r;
wire [7:0] linien_csrbank3_x_limit_2_min2_w;
wire linien_csrbank3_x_limit_2_min1_re;
wire [7:0] linien_csrbank3_x_limit_2_min1_r;
wire [7:0] linien_csrbank3_x_limit_2_min1_w;
wire linien_csrbank3_x_limit_2_min0_re;
wire [7:0] linien_csrbank3_x_limit_2_min0_r;
wire [7:0] linien_csrbank3_x_limit_2_min0_w;
wire linien_csrbank3_x_limit_2_max3_re;
wire linien_csrbank3_x_limit_2_max3_r;
wire linien_csrbank3_x_limit_2_max3_w;
wire linien_csrbank3_x_limit_2_max2_re;
wire [7:0] linien_csrbank3_x_limit_2_max2_r;
wire [7:0] linien_csrbank3_x_limit_2_max2_w;
wire linien_csrbank3_x_limit_2_max1_re;
wire [7:0] linien_csrbank3_x_limit_2_max1_r;
wire [7:0] linien_csrbank3_x_limit_2_max1_w;
wire linien_csrbank3_x_limit_2_max0_re;
wire [7:0] linien_csrbank3_x_limit_2_max0_r;
wire [7:0] linien_csrbank3_x_limit_2_max0_w;
wire linien_csrbank3_iir_c_2_z03_re;
wire [2:0] linien_csrbank3_iir_c_2_z03_r;
wire [2:0] linien_csrbank3_iir_c_2_z03_w;
wire linien_csrbank3_iir_c_2_z02_re;
wire [7:0] linien_csrbank3_iir_c_2_z02_r;
wire [7:0] linien_csrbank3_iir_c_2_z02_w;
wire linien_csrbank3_iir_c_2_z01_re;
wire [7:0] linien_csrbank3_iir_c_2_z01_r;
wire [7:0] linien_csrbank3_iir_c_2_z01_w;
wire linien_csrbank3_iir_c_2_z00_re;
wire [7:0] linien_csrbank3_iir_c_2_z00_r;
wire [7:0] linien_csrbank3_iir_c_2_z00_w;
wire linien_csrbank3_iir_c_2_a13_re;
wire linien_csrbank3_iir_c_2_a13_r;
wire linien_csrbank3_iir_c_2_a13_w;
wire linien_csrbank3_iir_c_2_a12_re;
wire [7:0] linien_csrbank3_iir_c_2_a12_r;
wire [7:0] linien_csrbank3_iir_c_2_a12_w;
wire linien_csrbank3_iir_c_2_a11_re;
wire [7:0] linien_csrbank3_iir_c_2_a11_r;
wire [7:0] linien_csrbank3_iir_c_2_a11_w;
wire linien_csrbank3_iir_c_2_a10_re;
wire [7:0] linien_csrbank3_iir_c_2_a10_r;
wire [7:0] linien_csrbank3_iir_c_2_a10_w;
wire linien_csrbank3_iir_c_2_b03_re;
wire linien_csrbank3_iir_c_2_b03_r;
wire linien_csrbank3_iir_c_2_b03_w;
wire linien_csrbank3_iir_c_2_b02_re;
wire [7:0] linien_csrbank3_iir_c_2_b02_r;
wire [7:0] linien_csrbank3_iir_c_2_b02_w;
wire linien_csrbank3_iir_c_2_b01_re;
wire [7:0] linien_csrbank3_iir_c_2_b01_r;
wire [7:0] linien_csrbank3_iir_c_2_b01_w;
wire linien_csrbank3_iir_c_2_b00_re;
wire [7:0] linien_csrbank3_iir_c_2_b00_r;
wire [7:0] linien_csrbank3_iir_c_2_b00_w;
wire linien_csrbank3_iir_c_2_b13_re;
wire linien_csrbank3_iir_c_2_b13_r;
wire linien_csrbank3_iir_c_2_b13_w;
wire linien_csrbank3_iir_c_2_b12_re;
wire [7:0] linien_csrbank3_iir_c_2_b12_r;
wire [7:0] linien_csrbank3_iir_c_2_b12_w;
wire linien_csrbank3_iir_c_2_b11_re;
wire [7:0] linien_csrbank3_iir_c_2_b11_r;
wire [7:0] linien_csrbank3_iir_c_2_b11_w;
wire linien_csrbank3_iir_c_2_b10_re;
wire [7:0] linien_csrbank3_iir_c_2_b10_r;
wire [7:0] linien_csrbank3_iir_c_2_b10_w;
wire linien_csrbank3_iir_d_2_z03_re;
wire [2:0] linien_csrbank3_iir_d_2_z03_r;
wire [2:0] linien_csrbank3_iir_d_2_z03_w;
wire linien_csrbank3_iir_d_2_z02_re;
wire [7:0] linien_csrbank3_iir_d_2_z02_r;
wire [7:0] linien_csrbank3_iir_d_2_z02_w;
wire linien_csrbank3_iir_d_2_z01_re;
wire [7:0] linien_csrbank3_iir_d_2_z01_r;
wire [7:0] linien_csrbank3_iir_d_2_z01_w;
wire linien_csrbank3_iir_d_2_z00_re;
wire [7:0] linien_csrbank3_iir_d_2_z00_r;
wire [7:0] linien_csrbank3_iir_d_2_z00_w;
wire linien_csrbank3_iir_d_2_a13_re;
wire linien_csrbank3_iir_d_2_a13_r;
wire linien_csrbank3_iir_d_2_a13_w;
wire linien_csrbank3_iir_d_2_a12_re;
wire [7:0] linien_csrbank3_iir_d_2_a12_r;
wire [7:0] linien_csrbank3_iir_d_2_a12_w;
wire linien_csrbank3_iir_d_2_a11_re;
wire [7:0] linien_csrbank3_iir_d_2_a11_r;
wire [7:0] linien_csrbank3_iir_d_2_a11_w;
wire linien_csrbank3_iir_d_2_a10_re;
wire [7:0] linien_csrbank3_iir_d_2_a10_r;
wire [7:0] linien_csrbank3_iir_d_2_a10_w;
wire linien_csrbank3_iir_d_2_a23_re;
wire linien_csrbank3_iir_d_2_a23_r;
wire linien_csrbank3_iir_d_2_a23_w;
wire linien_csrbank3_iir_d_2_a22_re;
wire [7:0] linien_csrbank3_iir_d_2_a22_r;
wire [7:0] linien_csrbank3_iir_d_2_a22_w;
wire linien_csrbank3_iir_d_2_a21_re;
wire [7:0] linien_csrbank3_iir_d_2_a21_r;
wire [7:0] linien_csrbank3_iir_d_2_a21_w;
wire linien_csrbank3_iir_d_2_a20_re;
wire [7:0] linien_csrbank3_iir_d_2_a20_r;
wire [7:0] linien_csrbank3_iir_d_2_a20_w;
wire linien_csrbank3_iir_d_2_b03_re;
wire linien_csrbank3_iir_d_2_b03_r;
wire linien_csrbank3_iir_d_2_b03_w;
wire linien_csrbank3_iir_d_2_b02_re;
wire [7:0] linien_csrbank3_iir_d_2_b02_r;
wire [7:0] linien_csrbank3_iir_d_2_b02_w;
wire linien_csrbank3_iir_d_2_b01_re;
wire [7:0] linien_csrbank3_iir_d_2_b01_r;
wire [7:0] linien_csrbank3_iir_d_2_b01_w;
wire linien_csrbank3_iir_d_2_b00_re;
wire [7:0] linien_csrbank3_iir_d_2_b00_r;
wire [7:0] linien_csrbank3_iir_d_2_b00_w;
wire linien_csrbank3_iir_d_2_b13_re;
wire linien_csrbank3_iir_d_2_b13_r;
wire linien_csrbank3_iir_d_2_b13_w;
wire linien_csrbank3_iir_d_2_b12_re;
wire [7:0] linien_csrbank3_iir_d_2_b12_r;
wire [7:0] linien_csrbank3_iir_d_2_b12_w;
wire linien_csrbank3_iir_d_2_b11_re;
wire [7:0] linien_csrbank3_iir_d_2_b11_r;
wire [7:0] linien_csrbank3_iir_d_2_b11_w;
wire linien_csrbank3_iir_d_2_b10_re;
wire [7:0] linien_csrbank3_iir_d_2_b10_r;
wire [7:0] linien_csrbank3_iir_d_2_b10_w;
wire linien_csrbank3_iir_d_2_b23_re;
wire linien_csrbank3_iir_d_2_b23_r;
wire linien_csrbank3_iir_d_2_b23_w;
wire linien_csrbank3_iir_d_2_b22_re;
wire [7:0] linien_csrbank3_iir_d_2_b22_r;
wire [7:0] linien_csrbank3_iir_d_2_b22_w;
wire linien_csrbank3_iir_d_2_b21_re;
wire [7:0] linien_csrbank3_iir_d_2_b21_r;
wire [7:0] linien_csrbank3_iir_d_2_b21_w;
wire linien_csrbank3_iir_d_2_b20_re;
wire [7:0] linien_csrbank3_iir_d_2_b20_r;
wire [7:0] linien_csrbank3_iir_d_2_b20_w;
wire linien_csrbank3_y_limit_2_min3_re;
wire linien_csrbank3_y_limit_2_min3_r;
wire linien_csrbank3_y_limit_2_min3_w;
wire linien_csrbank3_y_limit_2_min2_re;
wire [7:0] linien_csrbank3_y_limit_2_min2_r;
wire [7:0] linien_csrbank3_y_limit_2_min2_w;
wire linien_csrbank3_y_limit_2_min1_re;
wire [7:0] linien_csrbank3_y_limit_2_min1_r;
wire [7:0] linien_csrbank3_y_limit_2_min1_w;
wire linien_csrbank3_y_limit_2_min0_re;
wire [7:0] linien_csrbank3_y_limit_2_min0_r;
wire [7:0] linien_csrbank3_y_limit_2_min0_w;
wire linien_csrbank3_y_limit_2_max3_re;
wire linien_csrbank3_y_limit_2_max3_r;
wire linien_csrbank3_y_limit_2_max3_w;
wire linien_csrbank3_y_limit_2_max2_re;
wire [7:0] linien_csrbank3_y_limit_2_max2_r;
wire [7:0] linien_csrbank3_y_limit_2_max2_w;
wire linien_csrbank3_y_limit_2_max1_re;
wire [7:0] linien_csrbank3_y_limit_2_max1_r;
wire [7:0] linien_csrbank3_y_limit_2_max1_w;
wire linien_csrbank3_y_limit_2_max0_re;
wire [7:0] linien_csrbank3_y_limit_2_max0_r;
wire [7:0] linien_csrbank3_y_limit_2_max0_w;
wire linien_csrbank3_x_max3_re;
wire linien_csrbank3_x_max3_r;
wire linien_csrbank3_x_max3_w;
wire linien_csrbank3_x_max2_re;
wire [7:0] linien_csrbank3_x_max2_r;
wire [7:0] linien_csrbank3_x_max2_w;
wire linien_csrbank3_x_max1_re;
wire [7:0] linien_csrbank3_x_max1_r;
wire [7:0] linien_csrbank3_x_max1_w;
wire linien_csrbank3_x_max0_re;
wire [7:0] linien_csrbank3_x_max0_r;
wire [7:0] linien_csrbank3_x_max0_w;
wire linien_csrbank3_x_min3_re;
wire linien_csrbank3_x_min3_r;
wire linien_csrbank3_x_min3_w;
wire linien_csrbank3_x_min2_re;
wire [7:0] linien_csrbank3_x_min2_r;
wire [7:0] linien_csrbank3_x_min2_w;
wire linien_csrbank3_x_min1_re;
wire [7:0] linien_csrbank3_x_min1_r;
wire [7:0] linien_csrbank3_x_min1_w;
wire linien_csrbank3_x_min0_re;
wire [7:0] linien_csrbank3_x_min0_r;
wire [7:0] linien_csrbank3_x_min0_w;
wire linien_csrbank3_out_i_max3_re;
wire linien_csrbank3_out_i_max3_r;
wire linien_csrbank3_out_i_max3_w;
wire linien_csrbank3_out_i_max2_re;
wire [7:0] linien_csrbank3_out_i_max2_r;
wire [7:0] linien_csrbank3_out_i_max2_w;
wire linien_csrbank3_out_i_max1_re;
wire [7:0] linien_csrbank3_out_i_max1_r;
wire [7:0] linien_csrbank3_out_i_max1_w;
wire linien_csrbank3_out_i_max0_re;
wire [7:0] linien_csrbank3_out_i_max0_r;
wire [7:0] linien_csrbank3_out_i_max0_w;
wire linien_csrbank3_out_i_min3_re;
wire linien_csrbank3_out_i_min3_r;
wire linien_csrbank3_out_i_min3_w;
wire linien_csrbank3_out_i_min2_re;
wire [7:0] linien_csrbank3_out_i_min2_r;
wire [7:0] linien_csrbank3_out_i_min2_w;
wire linien_csrbank3_out_i_min1_re;
wire [7:0] linien_csrbank3_out_i_min1_r;
wire [7:0] linien_csrbank3_out_i_min1_w;
wire linien_csrbank3_out_i_min0_re;
wire [7:0] linien_csrbank3_out_i_min0_r;
wire [7:0] linien_csrbank3_out_i_min0_w;
wire linien_csrbank3_out_q_max3_re;
wire linien_csrbank3_out_q_max3_r;
wire linien_csrbank3_out_q_max3_w;
wire linien_csrbank3_out_q_max2_re;
wire [7:0] linien_csrbank3_out_q_max2_r;
wire [7:0] linien_csrbank3_out_q_max2_w;
wire linien_csrbank3_out_q_max1_re;
wire [7:0] linien_csrbank3_out_q_max1_r;
wire [7:0] linien_csrbank3_out_q_max1_w;
wire linien_csrbank3_out_q_max0_re;
wire [7:0] linien_csrbank3_out_q_max0_r;
wire [7:0] linien_csrbank3_out_q_max0_w;
wire linien_csrbank3_out_q_min3_re;
wire linien_csrbank3_out_q_min3_r;
wire linien_csrbank3_out_q_min3_w;
wire linien_csrbank3_out_q_min2_re;
wire [7:0] linien_csrbank3_out_q_min2_r;
wire [7:0] linien_csrbank3_out_q_min2_w;
wire linien_csrbank3_out_q_min1_re;
wire [7:0] linien_csrbank3_out_q_min1_r;
wire [7:0] linien_csrbank3_out_q_min1_w;
wire linien_csrbank3_out_q_min0_re;
wire [7:0] linien_csrbank3_out_q_min0_r;
wire [7:0] linien_csrbank3_out_q_min0_w;
wire linien_csrbank3_dx_sel0_re;
wire [3:0] linien_csrbank3_dx_sel0_r;
wire [3:0] linien_csrbank3_dx_sel0_w;
wire linien_csrbank3_dy_sel0_re;
wire [3:0] linien_csrbank3_dy_sel0_r;
wire [3:0] linien_csrbank3_dy_sel0_w;
wire linien_csrbank3_sel;
wire [13:0] linien_interface4_bank_bus_adr;
wire linien_interface4_bank_bus_we;
wire [7:0] linien_interface4_bank_bus_dat_w;
reg [7:0] linien_interface4_bank_bus_dat_r = 8'd0;
wire linien_csrbank4_ins_re;
wire [7:0] linien_csrbank4_ins_r;
wire [7:0] linien_csrbank4_ins_w;
wire linien_csrbank4_outs0_re;
wire [7:0] linien_csrbank4_outs0_r;
wire [7:0] linien_csrbank4_outs0_w;
wire linien_csrbank4_oes0_re;
wire [7:0] linien_csrbank4_oes0_r;
wire [7:0] linien_csrbank4_oes0_w;
wire linien_csrbank4_state1_re;
wire linien_csrbank4_state1_r;
wire linien_csrbank4_state1_w;
wire linien_csrbank4_state0_re;
wire [7:0] linien_csrbank4_state0_r;
wire [7:0] linien_csrbank4_state0_w;
wire linien_csrbank4_do0_en1_re;
wire linien_csrbank4_do0_en1_r;
wire linien_csrbank4_do0_en1_w;
wire linien_csrbank4_do0_en0_re;
wire [7:0] linien_csrbank4_do0_en0_r;
wire [7:0] linien_csrbank4_do0_en0_w;
wire linien_csrbank4_do1_en1_re;
wire linien_csrbank4_do1_en1_r;
wire linien_csrbank4_do1_en1_w;
wire linien_csrbank4_do1_en0_re;
wire [7:0] linien_csrbank4_do1_en0_r;
wire [7:0] linien_csrbank4_do1_en0_w;
wire linien_csrbank4_do2_en1_re;
wire linien_csrbank4_do2_en1_r;
wire linien_csrbank4_do2_en1_w;
wire linien_csrbank4_do2_en0_re;
wire [7:0] linien_csrbank4_do2_en0_r;
wire [7:0] linien_csrbank4_do2_en0_w;
wire linien_csrbank4_do3_en1_re;
wire linien_csrbank4_do3_en1_r;
wire linien_csrbank4_do3_en1_w;
wire linien_csrbank4_do3_en0_re;
wire [7:0] linien_csrbank4_do3_en0_r;
wire [7:0] linien_csrbank4_do3_en0_w;
wire linien_csrbank4_do4_en1_re;
wire linien_csrbank4_do4_en1_r;
wire linien_csrbank4_do4_en1_w;
wire linien_csrbank4_do4_en0_re;
wire [7:0] linien_csrbank4_do4_en0_r;
wire [7:0] linien_csrbank4_do4_en0_w;
wire linien_csrbank4_do5_en1_re;
wire linien_csrbank4_do5_en1_r;
wire linien_csrbank4_do5_en1_w;
wire linien_csrbank4_do5_en0_re;
wire [7:0] linien_csrbank4_do5_en0_r;
wire [7:0] linien_csrbank4_do5_en0_w;
wire linien_csrbank4_do6_en1_re;
wire linien_csrbank4_do6_en1_r;
wire linien_csrbank4_do6_en1_w;
wire linien_csrbank4_do6_en0_re;
wire [7:0] linien_csrbank4_do6_en0_r;
wire [7:0] linien_csrbank4_do6_en0_w;
wire linien_csrbank4_do7_en1_re;
wire linien_csrbank4_do7_en1_r;
wire linien_csrbank4_do7_en1_w;
wire linien_csrbank4_do7_en0_re;
wire [7:0] linien_csrbank4_do7_en0_r;
wire [7:0] linien_csrbank4_do7_en0_w;
wire linien_csrbank4_sel;
wire [13:0] linien_interface5_bank_bus_adr;
wire linien_interface5_bank_bus_we;
wire [7:0] linien_interface5_bank_bus_dat_w;
reg [7:0] linien_interface5_bank_bus_dat_r = 8'd0;
wire linien_csrbank5_ins_re;
wire [7:0] linien_csrbank5_ins_r;
wire [7:0] linien_csrbank5_ins_w;
wire linien_csrbank5_outs0_re;
wire [7:0] linien_csrbank5_outs0_r;
wire [7:0] linien_csrbank5_outs0_w;
wire linien_csrbank5_oes0_re;
wire [7:0] linien_csrbank5_oes0_r;
wire [7:0] linien_csrbank5_oes0_w;
wire linien_csrbank5_sel;
wire [13:0] linien_interface6_bank_bus_adr;
wire linien_interface6_bank_bus_we;
wire [7:0] linien_interface6_bank_bus_dat_w;
reg [7:0] linien_interface6_bank_bus_dat_r = 8'd0;
wire linien_csrbank6_x_target_cmd3_re;
wire linien_csrbank6_x_target_cmd3_r;
wire linien_csrbank6_x_target_cmd3_w;
wire linien_csrbank6_x_target_cmd2_re;
wire [7:0] linien_csrbank6_x_target_cmd2_r;
wire [7:0] linien_csrbank6_x_target_cmd2_w;
wire linien_csrbank6_x_target_cmd1_re;
wire [7:0] linien_csrbank6_x_target_cmd1_r;
wire [7:0] linien_csrbank6_x_target_cmd1_w;
wire linien_csrbank6_x_target_cmd0_re;
wire [7:0] linien_csrbank6_x_target_cmd0_r;
wire [7:0] linien_csrbank6_x_target_cmd0_w;
wire linien_csrbank6_f_target_cmd3_re;
wire linien_csrbank6_f_target_cmd3_r;
wire linien_csrbank6_f_target_cmd3_w;
wire linien_csrbank6_f_target_cmd2_re;
wire [7:0] linien_csrbank6_f_target_cmd2_r;
wire [7:0] linien_csrbank6_f_target_cmd2_w;
wire linien_csrbank6_f_target_cmd1_re;
wire [7:0] linien_csrbank6_f_target_cmd1_r;
wire [7:0] linien_csrbank6_f_target_cmd1_w;
wire linien_csrbank6_f_target_cmd0_re;
wire [7:0] linien_csrbank6_f_target_cmd0_r;
wire [7:0] linien_csrbank6_f_target_cmd0_w;
wire linien_csrbank6_t_target_cmd3_re;
wire linien_csrbank6_t_target_cmd3_r;
wire linien_csrbank6_t_target_cmd3_w;
wire linien_csrbank6_t_target_cmd2_re;
wire [7:0] linien_csrbank6_t_target_cmd2_r;
wire [7:0] linien_csrbank6_t_target_cmd2_w;
wire linien_csrbank6_t_target_cmd1_re;
wire [7:0] linien_csrbank6_t_target_cmd1_r;
wire [7:0] linien_csrbank6_t_target_cmd1_w;
wire linien_csrbank6_t_target_cmd0_re;
wire [7:0] linien_csrbank6_t_target_cmd0_r;
wire [7:0] linien_csrbank6_t_target_cmd0_w;
wire linien_csrbank6_power_threshold_target_cmd3_re;
wire linien_csrbank6_power_threshold_target_cmd3_r;
wire linien_csrbank6_power_threshold_target_cmd3_w;
wire linien_csrbank6_power_threshold_target_cmd2_re;
wire [7:0] linien_csrbank6_power_threshold_target_cmd2_r;
wire [7:0] linien_csrbank6_power_threshold_target_cmd2_w;
wire linien_csrbank6_power_threshold_target_cmd1_re;
wire [7:0] linien_csrbank6_power_threshold_target_cmd1_r;
wire [7:0] linien_csrbank6_power_threshold_target_cmd1_w;
wire linien_csrbank6_power_threshold_target_cmd0_re;
wire [7:0] linien_csrbank6_power_threshold_target_cmd0_r;
wire [7:0] linien_csrbank6_power_threshold_target_cmd0_w;
wire linien_csrbank6_sel;
wire [13:0] linien_interface7_bank_bus_adr;
wire linien_interface7_bank_bus_we;
wire [7:0] linien_interface7_bank_bus_dat_w;
reg [7:0] linien_interface7_bank_bus_dat_r = 8'd0;
wire linien_csrbank7_pid_only_mode0_re;
wire linien_csrbank7_pid_only_mode0_r;
wire linien_csrbank7_pid_only_mode0_w;
wire linien_csrbank7_chain_a_factor1_re;
wire linien_csrbank7_chain_a_factor1_r;
wire linien_csrbank7_chain_a_factor1_w;
wire linien_csrbank7_chain_a_factor0_re;
wire [7:0] linien_csrbank7_chain_a_factor0_r;
wire [7:0] linien_csrbank7_chain_a_factor0_w;
wire linien_csrbank7_chain_b_factor1_re;
wire linien_csrbank7_chain_b_factor1_r;
wire linien_csrbank7_chain_b_factor1_w;
wire linien_csrbank7_chain_b_factor0_re;
wire [7:0] linien_csrbank7_chain_b_factor0_r;
wire [7:0] linien_csrbank7_chain_b_factor0_w;
wire linien_csrbank7_chain_a_offset1_re;
wire [5:0] linien_csrbank7_chain_a_offset1_r;
wire [5:0] linien_csrbank7_chain_a_offset1_w;
wire linien_csrbank7_chain_a_offset0_re;
wire [7:0] linien_csrbank7_chain_a_offset0_r;
wire [7:0] linien_csrbank7_chain_a_offset0_w;
wire linien_csrbank7_chain_b_offset1_re;
wire [5:0] linien_csrbank7_chain_b_offset1_r;
wire [5:0] linien_csrbank7_chain_b_offset1_w;
wire linien_csrbank7_chain_b_offset0_re;
wire [7:0] linien_csrbank7_chain_b_offset0_r;
wire [7:0] linien_csrbank7_chain_b_offset0_w;
wire linien_csrbank7_combined_offset1_re;
wire [5:0] linien_csrbank7_combined_offset1_r;
wire [5:0] linien_csrbank7_combined_offset1_w;
wire linien_csrbank7_combined_offset0_re;
wire [7:0] linien_csrbank7_combined_offset0_r;
wire [7:0] linien_csrbank7_combined_offset0_w;
wire linien_csrbank7_out_offset1_re;
wire [5:0] linien_csrbank7_out_offset1_r;
wire [5:0] linien_csrbank7_out_offset1_w;
wire linien_csrbank7_out_offset0_re;
wire [7:0] linien_csrbank7_out_offset0_r;
wire [7:0] linien_csrbank7_out_offset0_w;
wire linien_csrbank7_slow_decimation0_re;
wire [4:0] linien_csrbank7_slow_decimation0_r;
wire [4:0] linien_csrbank7_slow_decimation0_w;
wire linien_csrbank7_analog_out_11_re;
wire [6:0] linien_csrbank7_analog_out_11_r;
wire [6:0] linien_csrbank7_analog_out_11_w;
wire linien_csrbank7_analog_out_10_re;
wire [7:0] linien_csrbank7_analog_out_10_r;
wire [7:0] linien_csrbank7_analog_out_10_w;
wire linien_csrbank7_analog_out_21_re;
wire [6:0] linien_csrbank7_analog_out_21_r;
wire [6:0] linien_csrbank7_analog_out_21_w;
wire linien_csrbank7_analog_out_20_re;
wire [7:0] linien_csrbank7_analog_out_20_r;
wire [7:0] linien_csrbank7_analog_out_20_w;
wire linien_csrbank7_analog_out_31_re;
wire [6:0] linien_csrbank7_analog_out_31_r;
wire [6:0] linien_csrbank7_analog_out_31_w;
wire linien_csrbank7_analog_out_30_re;
wire [7:0] linien_csrbank7_analog_out_30_r;
wire [7:0] linien_csrbank7_analog_out_30_w;
wire linien_csrbank7_slow_value1_re;
wire [5:0] linien_csrbank7_slow_value1_r;
wire [5:0] linien_csrbank7_slow_value1_w;
wire linien_csrbank7_slow_value0_re;
wire [7:0] linien_csrbank7_slow_value0_r;
wire [7:0] linien_csrbank7_slow_value0_w;
wire linien_csrbank7_mod_amp1_re;
wire [5:0] linien_csrbank7_mod_amp1_r;
wire [5:0] linien_csrbank7_mod_amp1_w;
wire linien_csrbank7_mod_amp0_re;
wire [7:0] linien_csrbank7_mod_amp0_r;
wire [7:0] linien_csrbank7_mod_amp0_w;
wire linien_csrbank7_mod_freq3_re;
wire [7:0] linien_csrbank7_mod_freq3_r;
wire [7:0] linien_csrbank7_mod_freq3_w;
wire linien_csrbank7_mod_freq2_re;
wire [7:0] linien_csrbank7_mod_freq2_r;
wire [7:0] linien_csrbank7_mod_freq2_w;
wire linien_csrbank7_mod_freq1_re;
wire [7:0] linien_csrbank7_mod_freq1_r;
wire [7:0] linien_csrbank7_mod_freq1_w;
wire linien_csrbank7_mod_freq0_re;
wire [7:0] linien_csrbank7_mod_freq0_r;
wire [7:0] linien_csrbank7_mod_freq0_w;
wire linien_csrbank7_limit_error_signal_min3_re;
wire linien_csrbank7_limit_error_signal_min3_r;
wire linien_csrbank7_limit_error_signal_min3_w;
wire linien_csrbank7_limit_error_signal_min2_re;
wire [7:0] linien_csrbank7_limit_error_signal_min2_r;
wire [7:0] linien_csrbank7_limit_error_signal_min2_w;
wire linien_csrbank7_limit_error_signal_min1_re;
wire [7:0] linien_csrbank7_limit_error_signal_min1_r;
wire [7:0] linien_csrbank7_limit_error_signal_min1_w;
wire linien_csrbank7_limit_error_signal_min0_re;
wire [7:0] linien_csrbank7_limit_error_signal_min0_r;
wire [7:0] linien_csrbank7_limit_error_signal_min0_w;
wire linien_csrbank7_limit_error_signal_max3_re;
wire linien_csrbank7_limit_error_signal_max3_r;
wire linien_csrbank7_limit_error_signal_max3_w;
wire linien_csrbank7_limit_error_signal_max2_re;
wire [7:0] linien_csrbank7_limit_error_signal_max2_r;
wire [7:0] linien_csrbank7_limit_error_signal_max2_w;
wire linien_csrbank7_limit_error_signal_max1_re;
wire [7:0] linien_csrbank7_limit_error_signal_max1_r;
wire [7:0] linien_csrbank7_limit_error_signal_max1_w;
wire linien_csrbank7_limit_error_signal_max0_re;
wire [7:0] linien_csrbank7_limit_error_signal_max0_r;
wire [7:0] linien_csrbank7_limit_error_signal_max0_w;
wire linien_csrbank7_limit_fast1_min1_re;
wire [5:0] linien_csrbank7_limit_fast1_min1_r;
wire [5:0] linien_csrbank7_limit_fast1_min1_w;
wire linien_csrbank7_limit_fast1_min0_re;
wire [7:0] linien_csrbank7_limit_fast1_min0_r;
wire [7:0] linien_csrbank7_limit_fast1_min0_w;
wire linien_csrbank7_limit_fast1_max1_re;
wire [5:0] linien_csrbank7_limit_fast1_max1_r;
wire [5:0] linien_csrbank7_limit_fast1_max1_w;
wire linien_csrbank7_limit_fast1_max0_re;
wire [7:0] linien_csrbank7_limit_fast1_max0_r;
wire [7:0] linien_csrbank7_limit_fast1_max0_w;
wire linien_csrbank7_limit_fast2_min1_re;
wire [5:0] linien_csrbank7_limit_fast2_min1_r;
wire [5:0] linien_csrbank7_limit_fast2_min1_w;
wire linien_csrbank7_limit_fast2_min0_re;
wire [7:0] linien_csrbank7_limit_fast2_min0_r;
wire [7:0] linien_csrbank7_limit_fast2_min0_w;
wire linien_csrbank7_limit_fast2_max1_re;
wire [5:0] linien_csrbank7_limit_fast2_max1_r;
wire [5:0] linien_csrbank7_limit_fast2_max1_w;
wire linien_csrbank7_limit_fast2_max0_re;
wire [7:0] linien_csrbank7_limit_fast2_max0_r;
wire [7:0] linien_csrbank7_limit_fast2_max0_w;
wire linien_csrbank7_pid_setpoint3_re;
wire linien_csrbank7_pid_setpoint3_r;
wire linien_csrbank7_pid_setpoint3_w;
wire linien_csrbank7_pid_setpoint2_re;
wire [7:0] linien_csrbank7_pid_setpoint2_r;
wire [7:0] linien_csrbank7_pid_setpoint2_w;
wire linien_csrbank7_pid_setpoint1_re;
wire [7:0] linien_csrbank7_pid_setpoint1_r;
wire [7:0] linien_csrbank7_pid_setpoint1_w;
wire linien_csrbank7_pid_setpoint0_re;
wire [7:0] linien_csrbank7_pid_setpoint0_r;
wire [7:0] linien_csrbank7_pid_setpoint0_w;
wire linien_csrbank7_pid_kp1_re;
wire [5:0] linien_csrbank7_pid_kp1_r;
wire [5:0] linien_csrbank7_pid_kp1_w;
wire linien_csrbank7_pid_kp0_re;
wire [7:0] linien_csrbank7_pid_kp0_r;
wire [7:0] linien_csrbank7_pid_kp0_w;
wire linien_csrbank7_pid_ki1_re;
wire [5:0] linien_csrbank7_pid_ki1_r;
wire [5:0] linien_csrbank7_pid_ki1_w;
wire linien_csrbank7_pid_ki0_re;
wire [7:0] linien_csrbank7_pid_ki0_r;
wire [7:0] linien_csrbank7_pid_ki0_w;
wire linien_csrbank7_pid_reset0_re;
wire linien_csrbank7_pid_reset0_r;
wire linien_csrbank7_pid_reset0_w;
wire linien_csrbank7_pid_kd1_re;
wire [5:0] linien_csrbank7_pid_kd1_r;
wire [5:0] linien_csrbank7_pid_kd1_w;
wire linien_csrbank7_pid_kd0_re;
wire [7:0] linien_csrbank7_pid_kd0_r;
wire [7:0] linien_csrbank7_pid_kd0_w;
wire linien_csrbank7_control_signal_max1_re;
wire [5:0] linien_csrbank7_control_signal_max1_r;
wire [5:0] linien_csrbank7_control_signal_max1_w;
wire linien_csrbank7_control_signal_max0_re;
wire [7:0] linien_csrbank7_control_signal_max0_r;
wire [7:0] linien_csrbank7_control_signal_max0_w;
wire linien_csrbank7_control_signal_min1_re;
wire [5:0] linien_csrbank7_control_signal_min1_r;
wire [5:0] linien_csrbank7_control_signal_min1_w;
wire linien_csrbank7_control_signal_min0_re;
wire [7:0] linien_csrbank7_control_signal_min0_r;
wire [7:0] linien_csrbank7_control_signal_min0_w;
wire linien_csrbank7_sel;
wire [13:0] linien_interface8_bank_bus_adr;
wire linien_interface8_bank_bus_we;
wire [7:0] linien_interface8_bank_bus_dat_w;
reg [7:0] linien_interface8_bank_bus_dat_r = 8'd0;
wire linien_csrbank8_fsm_state_re;
wire [1:0] linien_csrbank8_fsm_state_r;
wire [1:0] linien_csrbank8_fsm_state_w;
wire linien_csrbank8_time_command_out3_re;
wire linien_csrbank8_time_command_out3_r;
wire linien_csrbank8_time_command_out3_w;
wire linien_csrbank8_time_command_out2_re;
wire [7:0] linien_csrbank8_time_command_out2_r;
wire [7:0] linien_csrbank8_time_command_out2_w;
wire linien_csrbank8_time_command_out1_re;
wire [7:0] linien_csrbank8_time_command_out1_r;
wire [7:0] linien_csrbank8_time_command_out1_w;
wire linien_csrbank8_time_command_out0_re;
wire [7:0] linien_csrbank8_time_command_out0_r;
wire [7:0] linien_csrbank8_time_command_out0_w;
wire linien_csrbank8_time_command_out_max3_re;
wire linien_csrbank8_time_command_out_max3_r;
wire linien_csrbank8_time_command_out_max3_w;
wire linien_csrbank8_time_command_out_max2_re;
wire [7:0] linien_csrbank8_time_command_out_max2_r;
wire [7:0] linien_csrbank8_time_command_out_max2_w;
wire linien_csrbank8_time_command_out_max1_re;
wire [7:0] linien_csrbank8_time_command_out_max1_r;
wire [7:0] linien_csrbank8_time_command_out_max1_w;
wire linien_csrbank8_time_command_out_max0_re;
wire [7:0] linien_csrbank8_time_command_out_max0_r;
wire [7:0] linien_csrbank8_time_command_out_max0_w;
wire linien_csrbank8_time_command_out_min3_re;
wire linien_csrbank8_time_command_out_min3_r;
wire linien_csrbank8_time_command_out_min3_w;
wire linien_csrbank8_time_command_out_min2_re;
wire [7:0] linien_csrbank8_time_command_out_min2_r;
wire [7:0] linien_csrbank8_time_command_out_min2_w;
wire linien_csrbank8_time_command_out_min1_re;
wire [7:0] linien_csrbank8_time_command_out_min1_r;
wire [7:0] linien_csrbank8_time_command_out_min1_w;
wire linien_csrbank8_time_command_out_min0_re;
wire [7:0] linien_csrbank8_time_command_out_min0_r;
wire [7:0] linien_csrbank8_time_command_out_min0_w;
wire linien_csrbank8_sel;
wire [13:0] linien_interface9_bank_bus_adr;
wire linien_interface9_bank_bus_we;
wire [7:0] linien_interface9_bank_bus_dat_w;
reg [7:0] linien_interface9_bank_bus_dat_r = 8'd0;
wire linien_csrbank9_external_trigger0_re;
wire linien_csrbank9_external_trigger0_r;
wire linien_csrbank9_external_trigger0_w;
wire linien_csrbank9_dac_a_max3_re;
wire linien_csrbank9_dac_a_max3_r;
wire linien_csrbank9_dac_a_max3_w;
wire linien_csrbank9_dac_a_max2_re;
wire [7:0] linien_csrbank9_dac_a_max2_r;
wire [7:0] linien_csrbank9_dac_a_max2_w;
wire linien_csrbank9_dac_a_max1_re;
wire [7:0] linien_csrbank9_dac_a_max1_r;
wire [7:0] linien_csrbank9_dac_a_max1_w;
wire linien_csrbank9_dac_a_max0_re;
wire [7:0] linien_csrbank9_dac_a_max0_r;
wire [7:0] linien_csrbank9_dac_a_max0_w;
wire linien_csrbank9_dac_a_min3_re;
wire linien_csrbank9_dac_a_min3_r;
wire linien_csrbank9_dac_a_min3_w;
wire linien_csrbank9_dac_a_min2_re;
wire [7:0] linien_csrbank9_dac_a_min2_r;
wire [7:0] linien_csrbank9_dac_a_min2_w;
wire linien_csrbank9_dac_a_min1_re;
wire [7:0] linien_csrbank9_dac_a_min1_r;
wire [7:0] linien_csrbank9_dac_a_min1_w;
wire linien_csrbank9_dac_a_min0_re;
wire [7:0] linien_csrbank9_dac_a_min0_r;
wire [7:0] linien_csrbank9_dac_a_min0_w;
wire linien_csrbank9_dac_b_max3_re;
wire linien_csrbank9_dac_b_max3_r;
wire linien_csrbank9_dac_b_max3_w;
wire linien_csrbank9_dac_b_max2_re;
wire [7:0] linien_csrbank9_dac_b_max2_r;
wire [7:0] linien_csrbank9_dac_b_max2_w;
wire linien_csrbank9_dac_b_max1_re;
wire [7:0] linien_csrbank9_dac_b_max1_r;
wire [7:0] linien_csrbank9_dac_b_max1_w;
wire linien_csrbank9_dac_b_max0_re;
wire [7:0] linien_csrbank9_dac_b_max0_r;
wire [7:0] linien_csrbank9_dac_b_max0_w;
wire linien_csrbank9_dac_b_min3_re;
wire linien_csrbank9_dac_b_min3_r;
wire linien_csrbank9_dac_b_min3_w;
wire linien_csrbank9_dac_b_min2_re;
wire [7:0] linien_csrbank9_dac_b_min2_r;
wire [7:0] linien_csrbank9_dac_b_min2_w;
wire linien_csrbank9_dac_b_min1_re;
wire [7:0] linien_csrbank9_dac_b_min1_r;
wire [7:0] linien_csrbank9_dac_b_min1_w;
wire linien_csrbank9_dac_b_min0_re;
wire [7:0] linien_csrbank9_dac_b_min0_r;
wire [7:0] linien_csrbank9_dac_b_min0_w;
wire linien_csrbank9_adc_a_sel0_re;
wire [3:0] linien_csrbank9_adc_a_sel0_r;
wire [3:0] linien_csrbank9_adc_a_sel0_w;
wire linien_csrbank9_adc_b_sel0_re;
wire [3:0] linien_csrbank9_adc_b_sel0_r;
wire [3:0] linien_csrbank9_adc_b_sel0_w;
wire linien_csrbank9_adc_a_q_sel0_re;
wire [3:0] linien_csrbank9_adc_a_q_sel0_r;
wire [3:0] linien_csrbank9_adc_a_q_sel0_w;
wire linien_csrbank9_adc_b_q_sel0_re;
wire [3:0] linien_csrbank9_adc_b_q_sel0_r;
wire [3:0] linien_csrbank9_adc_b_q_sel0_w;
wire linien_csrbank9_sel;
wire [13:0] linien_interface10_bank_bus_adr;
wire linien_interface10_bank_bus_we;
wire [7:0] linien_interface10_bank_bus_dat_w;
reg [7:0] linien_interface10_bank_bus_dat_r = 8'd0;
wire linien_csrbank10_temp1_re;
wire [3:0] linien_csrbank10_temp1_r;
wire [3:0] linien_csrbank10_temp1_w;
wire linien_csrbank10_temp0_re;
wire [7:0] linien_csrbank10_temp0_r;
wire [7:0] linien_csrbank10_temp0_w;
wire linien_csrbank10_v1_re;
wire [3:0] linien_csrbank10_v1_r;
wire [3:0] linien_csrbank10_v1_w;
wire linien_csrbank10_v0_re;
wire [7:0] linien_csrbank10_v0_r;
wire [7:0] linien_csrbank10_v0_w;
wire linien_csrbank10_a1_re;
wire [3:0] linien_csrbank10_a1_r;
wire [3:0] linien_csrbank10_a1_w;
wire linien_csrbank10_a0_re;
wire [7:0] linien_csrbank10_a0_r;
wire [7:0] linien_csrbank10_a0_w;
wire linien_csrbank10_b1_re;
wire [3:0] linien_csrbank10_b1_r;
wire [3:0] linien_csrbank10_b1_w;
wire linien_csrbank10_b0_re;
wire [7:0] linien_csrbank10_b0_r;
wire [7:0] linien_csrbank10_b0_w;
wire linien_csrbank10_c1_re;
wire [3:0] linien_csrbank10_c1_r;
wire [3:0] linien_csrbank10_c1_w;
wire linien_csrbank10_c0_re;
wire [7:0] linien_csrbank10_c0_r;
wire [7:0] linien_csrbank10_c0_w;
wire linien_csrbank10_d1_re;
wire [3:0] linien_csrbank10_d1_r;
wire [3:0] linien_csrbank10_d1_w;
wire linien_csrbank10_d0_re;
wire [7:0] linien_csrbank10_d0_r;
wire [7:0] linien_csrbank10_d0_w;
wire linien_csrbank10_sel;
reg [13:0] linien_csr_adr = 14'd0;
reg linien_csr_we = 1'd0;
reg [7:0] linien_csr_dat_w = 8'd0;
wire [7:0] linien_csr_dat_r;
wire linien_sys_rstn;
wire linien_sys_clk;
wire [31:0] linien_sys_addr;
wire [31:0] linien_sys_wdata;
wire [3:0] linien_sys_sel;
wire linien_sys_wen;
wire linien_sys_ren;
reg [31:0] linien_sys_rdata = 32'd0;
reg linien_sys_err = 1'd0;
reg linien_sys_ack = 1'd0;
reg linien_stb = 1'd0;
wire linien_source_rstn;
wire linien_source_clk;
wire [31:0] linien_source_addr;
wire [31:0] linien_source_wdata;
wire [3:0] linien_source_sel;
wire linien_source_wen;
wire linien_source_ren;
wire [31:0] linien_source_rdata;
wire linien_source_err;
wire linien_source_ack;
wire linien_target_rstn;
wire linien_target_clk;
wire [31:0] linien_target_addr;
wire [31:0] linien_target_wdata;
reg [3:0] linien_target_sel = 4'd0;
wire linien_target_wen;
wire linien_target_ren;
wire [31:0] linien_target_rdata;
wire linien_target_err;
wire linien_target_ack;
wire signed [13:0] linien_pid_out;
reg dummyhk_status = 1'd1;
wire [13:0] dummyhk_bank_bus_adr;
wire dummyhk_bank_bus_we;
wire [7:0] dummyhk_bank_bus_dat_w;
reg [7:0] dummyhk_bank_bus_dat_r = 8'd0;
wire dummyhk_id_re;
wire dummyhk_id_r;
wire dummyhk_id_w;
wire dummyhk_sel;
reg [13:0] dummyhk_csr_adr = 14'd0;
reg dummyhk_csr_we = 1'd0;
reg [7:0] dummyhk_csr_dat_w = 8'd0;
wire [7:0] dummyhk_csr_dat_r;
wire dummyhk_sys_rstn;
wire dummyhk_sys_clk;
wire [31:0] dummyhk_sys_addr;
wire [31:0] dummyhk_sys_wdata;
wire [3:0] dummyhk_sys_sel;
wire dummyhk_sys_wen;
wire dummyhk_sys_ren;
reg [31:0] dummyhk_sys_rdata = 32'd0;
reg dummyhk_sys_err = 1'd0;
reg dummyhk_sys_ack = 1'd0;
reg dummyhk_stb = 1'd0;
wire [1:0] ic_cs;
wire ic_sel0;
wire ic_sel1;
wire ic_sel2;
wire ic_sel3;
reg [1:0] state = 2'd0;
reg [1:0] next_state;
wire [16:0] slice_proxy0;
wire [16:0] slice_proxy1;
wire [16:0] slice_proxy2;
wire [16:0] slice_proxy3;
reg signed [24:0] comb_array_muxed0;
reg signed [24:0] comb_array_muxed1;
reg signed [24:0] comb_array_muxed2;
reg signed [24:0] comb_array_muxed3;
reg signed [13:0] comb_array_muxed4;
reg signed [24:0] sync_array_muxed0;
reg signed [24:0] sync_array_muxed1;
reg signed [24:0] sync_array_muxed2;
reg signed [24:0] sync_array_muxed3;
reg signed [24:0] sync_array_muxed4;
reg signed [24:0] sync_array_muxed5;
reg signed [24:0] sync_array_muxed6;
reg signed [24:0] sync_array_muxed7;
reg array_muxed;
(* async_reg = "true", mr_ff = "true", dont_touch = "true" *) reg [7:0] xilinxmultiregimpl0_regs0 = 8'd0;
(* async_reg = "true", dont_touch = "true" *) reg [7:0] xilinxmultiregimpl0_regs1 = 8'd0;
wire xilinxmultiregimpl0;
(* async_reg = "true", mr_ff = "true", dont_touch = "true" *) reg [7:0] xilinxmultiregimpl1_regs0 = 8'd0;
(* async_reg = "true", dont_touch = "true" *) reg [7:0] xilinxmultiregimpl1_regs1 = 8'd0;
wire xilinxmultiregimpl1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign ps_axi_aclk = ps_fclk[0];
assign ps_axi_arstn = ps_frstn[0];
assign ps_sys_clk = ps_axi_aclk;
assign ps_sys_rstn = ps_axi_arstn;
assign sys_ps_clk = ps_fclk[0];
assign sys_ps_rst = (~ps_frstn[0]);
assign pwm = linien_deltasigma0_out;
assign pwm_1 = linien_deltasigma1_out;
assign pwm_2 = linien_deltasigma2_out;
assign pwm_3 = linien_deltasigma3_out;
assign {user_led_7, user_led_6, user_led_5, user_led_4, user_led_3, user_led_2, user_led_1, user_led} = linien_gpio_n_o;
assign linien_sys_rstn = linien_target_rstn;
assign linien_sys_clk = linien_target_clk;
assign linien_sys_addr = linien_target_addr;
assign linien_sys_wdata = linien_target_wdata;
assign linien_sys_sel = linien_target_sel;
assign linien_sys_wen = linien_target_wen;
assign linien_sys_ren = linien_target_ren;
assign linien_target_rdata = linien_sys_rdata;
assign linien_target_err = linien_sys_err;
assign linien_target_ack = linien_sys_ack;
assign linien_fast_a_adc = linien_analog_adc_a;
assign linien_fast_b_adc = linien_analog_adc_b;
assign linien_i_a = linien_fast_a_out_i;
assign linien_q_a = linien_fast_a_out_q;
assign linien_i_b = linien_fast_b_out_i;
assign linien_q_b = linien_fast_b_out_q;
assign linien_kalman_est_time = linien_x_target_cmd_storage;
assign linien_kalman_est_uncertainty = linien_t_target_cmd_storage;
assign linien_power_level = linien_csr_power_signal_out_status;
assign linien_power_threshold_acquire = linien_power_threshold_target_cmd_storage;
assign linien_logic_running = 1'd1;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	linien_logic_input <= 25'sd0;
	if (linien_logic_pid_only_mode_storage) begin
		linien_logic_input <= (linien_time_command_out <<< 4'd11);
	end else begin
		linien_logic_input <= 1'd0;
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign linien_pid_out = (linien_logic_pid_out >>> 4'd11);
assign linien_deltasigma1_data = linien_logic_csrstorage0_storage;
assign linien_deltasigma2_data = linien_logic_csrstorage1_storage;
assign linien_deltasigma3_data = linien_logic_csrstorage2_storage;
assign linien_logic_limit_fast1_x = linien_pid_out;
assign linien_logic_control_signal = linien_logic_limit_fast1_limitcsr_y;
assign linien_analog_dac_a = linien_logic_limit_fast1_limitcsr_y;
assign linien_analog_dac_b = linien_sine_source_output;
assign linien_sig_status10 = linien_logic_control_signal;
assign linien_logic_phase = linien_logic_z[31:18];
assign linien_logic_cordic_xi1 = ($signed({1'd0, linien_logic_amp_storage}) + linien_logic_modulate_x);
assign linien_logic_cordic_zi1 = (linien_logic_phase <<< 1'd1);
assign linien_logic_modulate_y = (linien_logic_cordic_xo >>> 1'd1);
assign linien_logic_cordic_x0 = (linien_logic_cordic_xi0 <<< 2'd2);
assign linien_logic_cordic_y0 = (linien_logic_cordic_yi0 <<< 2'd2);
assign linien_logic_cordic_z0 = (linien_logic_cordic_zi0 <<< 2'd2);
assign linien_logic_cordic_xo = (linien_logic_cordic_x15 >>> 2'd2);
assign linien_logic_cordic_yo = (linien_logic_cordic_y15 >>> 2'd2);
assign linien_logic_cordic_zo = (linien_logic_cordic_z15 >>> 2'd2);
assign linien_logic_cordic_new_out = 1'd1;
assign linien_logic_cordic_new_in = 1'd1;
assign linien_logic_cordic_dir0 = (linien_logic_cordic_z0 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir1 = (linien_logic_cordic_z1 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir2 = (linien_logic_cordic_z2 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir3 = (linien_logic_cordic_z3 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir4 = (linien_logic_cordic_z4 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir5 = (linien_logic_cordic_z5 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir6 = (linien_logic_cordic_z6 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir7 = (linien_logic_cordic_z7 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir8 = (linien_logic_cordic_z8 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir9 = (linien_logic_cordic_z9 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir10 = (linien_logic_cordic_z10 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir11 = (linien_logic_cordic_z11 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir12 = (linien_logic_cordic_z12 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir13 = (linien_logic_cordic_z13 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_dir14 = (linien_logic_cordic_z14 < $signed({1'd0, 1'd0}));
assign linien_logic_cordic_q = (linien_logic_cordic_zi1[13] ^ linien_logic_cordic_zi1[14]);

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	linien_logic_cordic_xi0 <= 15'sd0;
	linien_logic_cordic_yi0 <= 15'sd0;
	linien_logic_cordic_zi0 <= 15'sd0;
	if (linien_logic_cordic_q) begin
		{linien_logic_cordic_zi0, linien_logic_cordic_yi0, linien_logic_cordic_xi0} <= {(linien_logic_cordic_zi1 + $signed({1'd0, 15'd16384})), (-linien_logic_cordic_yi1), (-linien_logic_cordic_xi1)};
	end else begin
		{linien_logic_cordic_zi0, linien_logic_cordic_yi0, linien_logic_cordic_xi0} <= {linien_logic_cordic_zi1, linien_logic_cordic_yi1, linien_logic_cordic_xi1};
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign linien_logic_limit_error_signal_limit_x = linien_logic_limit_error_signal_x;

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	linien_logic_limit_error_signal_limit_y <= 29'sd0;
	linien_logic_limit_error_signal_limit_railed <= 1'd0;
	if ((linien_logic_limit_error_signal_limit_x >= linien_logic_limit_error_signal_limit_max)) begin
		linien_logic_limit_error_signal_limit_y <= linien_logic_limit_error_signal_limit_max;
		linien_logic_limit_error_signal_limit_railed <= 1'd1;
	end else begin
		if ((linien_logic_limit_error_signal_limit_x <= linien_logic_limit_error_signal_limit_min)) begin
			linien_logic_limit_error_signal_limit_y <= linien_logic_limit_error_signal_limit_min;
			linien_logic_limit_error_signal_limit_railed <= 1'd1;
		end else begin
			linien_logic_limit_error_signal_limit_y <= linien_logic_limit_error_signal_limit_x;
			linien_logic_limit_error_signal_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign linien_logic_limit_fast1_limit_x = linien_logic_limit_fast1_x;

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	linien_logic_limit_fast1_limit_y <= 19'sd0;
	linien_logic_limit_fast1_limit_railed <= 1'd0;
	if ((linien_logic_limit_fast1_limit_x >= linien_logic_limit_fast1_limit_max)) begin
		linien_logic_limit_fast1_limit_y <= linien_logic_limit_fast1_limit_max;
		linien_logic_limit_fast1_limit_railed <= 1'd1;
	end else begin
		if ((linien_logic_limit_fast1_limit_x <= linien_logic_limit_fast1_limit_min)) begin
			linien_logic_limit_fast1_limit_y <= linien_logic_limit_fast1_limit_min;
			linien_logic_limit_fast1_limit_railed <= 1'd1;
		end else begin
			linien_logic_limit_fast1_limit_y <= linien_logic_limit_fast1_limit_x;
			linien_logic_limit_fast1_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign linien_logic_limit_fast2_limit_x = linien_logic_limit_fast2_x;

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	linien_logic_limit_fast2_limit_y <= 19'sd0;
	linien_logic_limit_fast2_limit_railed <= 1'd0;
	if ((linien_logic_limit_fast2_limit_x >= linien_logic_limit_fast2_limit_max)) begin
		linien_logic_limit_fast2_limit_y <= linien_logic_limit_fast2_limit_max;
		linien_logic_limit_fast2_limit_railed <= 1'd1;
	end else begin
		if ((linien_logic_limit_fast2_limit_x <= linien_logic_limit_fast2_limit_min)) begin
			linien_logic_limit_fast2_limit_y <= linien_logic_limit_fast2_limit_min;
			linien_logic_limit_fast2_limit_railed <= 1'd1;
		end else begin
			linien_logic_limit_fast2_limit_y <= linien_logic_limit_fast2_limit_x;
			linien_logic_limit_fast2_limit_railed <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end
assign linien_logic_setpoint_signed = linien_logic_setpoint_storage;

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	linien_logic_error <= 26'sd0;
	if (linien_logic_running) begin
		linien_logic_error <= (linien_logic_input - $signed({1'd0, linien_logic_setpoint_storage}));
	end else begin
		linien_logic_error <= 1'd0;
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign linien_logic_kp_signed = linien_logic_kp_storage;
assign linien_logic_kp_mult = (linien_logic_error * linien_logic_kp_signed);
assign linien_logic_output_p = (linien_logic_kp_mult >>> 4'd12);
assign linien_logic_ki_signed = linien_logic_ki_storage;
assign linien_logic_ki_mult = ((linien_logic_error * linien_logic_ki_signed) >>> 3'd4);
assign linien_logic_int_sum = (linien_logic_ki_mult + linien_logic_int_reg);
assign linien_logic_int_out = (linien_logic_int_reg >>> 5'd18);
assign linien_logic_kd_signed = linien_logic_kd_storage;
assign linien_logic_kd_mult = (linien_logic_error * linien_logic_kd_signed);

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	linien_logic_pid_out <= 25'sd0;
	if ((linien_logic_pid_sum > $signed({1'd0, 24'd16777215}))) begin
		linien_logic_pid_out <= 24'd16777215;
	end else begin
		if ((linien_logic_pid_sum < 25'sd16777216)) begin
			linien_logic_pid_out <= 25'sd16777216;
		end else begin
			linien_logic_pid_out <= linien_logic_pid_sum[24:0];
		end
	end
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end
assign adc_cdcs = 1'd1;
assign adc_clk = 2'd2;
assign linien_analog_adc_a = {linien_analog_adca[15], (~linien_analog_adca[14:2])};
assign linien_analog_adc_b = {linien_analog_adcb[15], (~linien_analog_adcb[14:2])};
assign dac_rst = sys_rst;
assign linien_xadc_adc0 = linien_xadc_a_status;
assign linien_xadc_adc1 = linien_xadc_b_status;
assign linien_xadc_adc2 = linien_xadc_c_status;
assign linien_xadc_adc3 = linien_xadc_d_status;
assign linien_deltasigma0_delta = (linien_deltasigma0_out <<< 4'd15);
assign linien_deltasigma0_out = linien_deltasigma0_sigma[15];
assign linien_deltasigma1_delta = (linien_deltasigma1_out <<< 4'd15);
assign linien_deltasigma1_out = linien_deltasigma1_sigma[15];
assign linien_deltasigma2_delta = (linien_deltasigma2_out <<< 4'd15);
assign linien_deltasigma2_out = linien_deltasigma2_sigma[15];
assign linien_deltasigma3_delta = (linien_deltasigma3_out <<< 4'd15);
assign linien_deltasigma3_out = linien_deltasigma3_sigma[15];
assign {linien_gpio_n_tstriple7_o, linien_gpio_n_tstriple6_o, linien_gpio_n_tstriple5_o, linien_gpio_n_tstriple4_o, linien_gpio_n_tstriple3_o, linien_gpio_n_tstriple2_o, linien_gpio_n_tstriple1_o, linien_gpio_n_tstriple0_o} = (linien_gpio_n_outs_storage | linien_gpio_n_o);
assign {linien_gpio_n_tstriple7_oe, linien_gpio_n_tstriple6_oe, linien_gpio_n_tstriple5_oe, linien_gpio_n_tstriple4_oe, linien_gpio_n_tstriple3_oe, linien_gpio_n_tstriple2_oe, linien_gpio_n_tstriple1_oe, linien_gpio_n_tstriple0_oe} = linien_gpio_n_oes_storage;
assign linien_gpio_n_status = linien_gpio_n_i;
assign linien_state = {linien_gpio_n_i, 1'd1};
assign {linien_gpio_p_tstriple7_o, linien_gpio_p_tstriple6_o, linien_gpio_p_tstriple5_o, linien_gpio_p_tstriple4_o, linien_gpio_p_tstriple3_o, linien_gpio_p_tstriple2_o, linien_gpio_p_tstriple1_o, linien_gpio_p_tstriple0_o} = (linien_gpio_p_outs_storage | linien_gpio_p_o);
assign {linien_gpio_p_tstriple7_oe, linien_gpio_p_tstriple6_oe, linien_gpio_p_tstriple5_oe, linien_gpio_p_tstriple4_oe, linien_gpio_p_tstriple3_oe, linien_gpio_p_tstriple2_oe, linien_gpio_p_tstriple1_oe, linien_gpio_p_tstriple0_oe} = linien_gpio_p_oes_storage;
assign linien_gpio_p_status = linien_gpio_p_i;
assign linien_fast_a_x0 = (linien_fast_a_adc <<< 4'd11);
assign linien_fast_a_x1 = linien_fast_a_adc;
assign linien_fast_a_phase = linien_logic_phase;
assign linien_fast_a_limitcsr0_x0 = ((linien_fast_a_i <<< 4'd11) + linien_fast_a_dx);
assign linien_fast_a_iir0_x0 = linien_fast_a_limitcsr0_limitcsr0_y0;
assign linien_fast_a_iir0_hold0 = 1'd0;
assign linien_fast_a_iir0_clear0 = 1'd0;
assign linien_fast_a_iir0_x1 = linien_fast_a_iir0_y0;
assign linien_fast_a_iir0_hold1 = 1'd0;
assign linien_fast_a_iir0_clear1 = 1'd0;
assign linien_fast_a_limitcsr0_x1 = ((linien_fast_a_invert_storage ? 1'sd1 : $signed({1'd0, 1'd1})) * ((comb_array_muxed0 + (linien_fast_a_ya <<< 4'd11)) + (linien_logic_chain_a_offset_signed <<< 4'd11)));
assign linien_fast_a_out_i = linien_fast_a_limitcsr0_limitcsr0_y1;
assign linien_fast_a_limitcsr1_x0 = ((linien_fast_a_q0 <<< 4'd11) + linien_fast_a_dx);
assign linien_fast_a_iir1_x0 = linien_fast_a_limitcsr1_limitcsr1_y0;
assign linien_fast_a_iir1_hold0 = 1'd0;
assign linien_fast_a_iir1_clear0 = 1'd0;
assign linien_fast_a_iir1_x1 = linien_fast_a_iir1_y0;
assign linien_fast_a_iir1_hold1 = 1'd0;
assign linien_fast_a_iir1_clear1 = 1'd0;
assign linien_fast_a_limitcsr1_x1 = ((linien_fast_a_invert_storage ? 1'sd1 : $signed({1'd0, 1'd1})) * ((comb_array_muxed1 + (linien_fast_a_ya <<< 4'd11)) + (linien_logic_chain_a_offset_signed <<< 4'd11)));
assign linien_fast_a_out_q = linien_fast_a_limitcsr1_limitcsr1_y1;
assign linien_sig_status0 = linien_fast_a_x0;
assign linien_sig_status1 = linien_fast_a_out_i;
assign linien_sig_status2 = linien_fast_a_out_q;
assign linien_fast_a_xi1 = linien_fast_a_x1;
assign linien_fast_a_zi1 = (((linien_fast_a_phase * linien_fast_a_multiplier_storage) + linien_fast_a_delay_storage) <<< 1'd1);
assign linien_fast_a_i = (linien_fast_a_xo >>> 1'd1);
assign linien_fast_a_q0 = (linien_fast_a_yo >>> 1'd1);
assign linien_fast_a_x2 = (linien_fast_a_xi0 <<< 2'd2);
assign linien_fast_a_y0 = (linien_fast_a_yi0 <<< 2'd2);
assign linien_fast_a_z0 = (linien_fast_a_zi0 <<< 2'd2);
assign linien_fast_a_xo = (linien_fast_a_x17 >>> 2'd2);
assign linien_fast_a_yo = (linien_fast_a_y15 >>> 2'd2);
assign linien_fast_a_zo = (linien_fast_a_z15 >>> 2'd2);
assign linien_fast_a_new_out = 1'd1;
assign linien_fast_a_new_in = 1'd1;
assign linien_fast_a_dir0 = (linien_fast_a_z0 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir1 = (linien_fast_a_z1 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir2 = (linien_fast_a_z2 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir3 = (linien_fast_a_z3 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir4 = (linien_fast_a_z4 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir5 = (linien_fast_a_z5 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir6 = (linien_fast_a_z6 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir7 = (linien_fast_a_z7 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir8 = (linien_fast_a_z8 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir9 = (linien_fast_a_z9 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir10 = (linien_fast_a_z10 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir11 = (linien_fast_a_z11 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir12 = (linien_fast_a_z12 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir13 = (linien_fast_a_z13 < $signed({1'd0, 1'd0}));
assign linien_fast_a_dir14 = (linien_fast_a_z14 < $signed({1'd0, 1'd0}));
assign linien_fast_a_q1 = (linien_fast_a_zi1[13] ^ linien_fast_a_zi1[14]);

// synthesis translate_off
reg dummy_d_7;
// synthesis translate_on
always @(*) begin
	linien_fast_a_xi0 <= 15'sd0;
	linien_fast_a_yi0 <= 15'sd0;
	linien_fast_a_zi0 <= 15'sd0;
	if (linien_fast_a_q1) begin
		{linien_fast_a_zi0, linien_fast_a_yi0, linien_fast_a_xi0} <= {(linien_fast_a_zi1 + $signed({1'd0, 15'd16384})), (-linien_fast_a_yi1), (-linien_fast_a_xi1)};
	end else begin
		{linien_fast_a_zi0, linien_fast_a_yi0, linien_fast_a_xi0} <= {linien_fast_a_zi1, linien_fast_a_yi1, linien_fast_a_xi1};
	end
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_a_limitcsr0_limit_x0 = linien_fast_a_limitcsr0_x0;

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	linien_fast_a_limitcsr0_limit_y0 <= 26'sd0;
	linien_fast_a_limitcsr0_limit_railed0 <= 1'd0;
	if ((linien_fast_a_limitcsr0_limit_x0 >= linien_fast_a_limitcsr0_limit_max0)) begin
		linien_fast_a_limitcsr0_limit_y0 <= linien_fast_a_limitcsr0_limit_max0;
		linien_fast_a_limitcsr0_limit_railed0 <= 1'd1;
	end else begin
		if ((linien_fast_a_limitcsr0_limit_x0 <= linien_fast_a_limitcsr0_limit_min0)) begin
			linien_fast_a_limitcsr0_limit_y0 <= linien_fast_a_limitcsr0_limit_min0;
			linien_fast_a_limitcsr0_limit_railed0 <= 1'd1;
		end else begin
			linien_fast_a_limitcsr0_limit_y0 <= linien_fast_a_limitcsr0_limit_x0;
			linien_fast_a_limitcsr0_limit_railed0 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_a_iir0_railed0 = (~((linien_fast_a_iir0_y_next0[49:47] == $signed({1'd0, linien_fast_a_iir0_y_pat0})) | (linien_fast_a_iir0_y_next0[49:47] == $signed({1'd0, (~linien_fast_a_iir0_y_pat0)}))));

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	linien_fast_a_iir0_y_lim0 <= 25'sd0;
	if (linien_fast_a_iir0_railed0) begin
		linien_fast_a_iir0_y_lim0 <= linien_fast_a_iir0_y0;
	end else begin
		linien_fast_a_iir0_y_lim0 <= linien_fast_a_iir0_y_next0[49:23];
	end
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_a_iir0_z0 = (linien_fast_a_iir0_zr0 + (linien_fast_a_iir0_x0 * linien_fast_a_iir0_b10));
assign linien_fast_a_iir0_z1 = (linien_fast_a_iir0_zr1 + (linien_fast_a_iir0_x0 * linien_fast_a_iir0_b00));
assign linien_fast_a_iir0_z2 = (linien_fast_a_iir0_zr2 + (linien_fast_a_iir0_y1 * linien_fast_a_iir0_a10));
assign linien_fast_a_iir0_y_next0 = linien_fast_a_iir0_z2;
assign linien_fast_a_iir0_railed1 = (~((linien_fast_a_iir0_y_next1[49:47] == $signed({1'd0, linien_fast_a_iir0_y_pat1})) | (linien_fast_a_iir0_y_next1[49:47] == $signed({1'd0, (~linien_fast_a_iir0_y_pat1)}))));

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	linien_fast_a_iir0_y_lim1 <= 25'sd0;
	if (linien_fast_a_iir0_railed1) begin
		linien_fast_a_iir0_y_lim1 <= linien_fast_a_iir0_y2;
	end else begin
		linien_fast_a_iir0_y_lim1 <= linien_fast_a_iir0_y_next1[49:23];
	end
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_a_iir0_z3 = (linien_fast_a_iir0_zr3 + (linien_fast_a_iir0_x1 * linien_fast_a_iir0_b2));
assign linien_fast_a_iir0_z4 = (linien_fast_a_iir0_zr4 + (linien_fast_a_iir0_x1 * linien_fast_a_iir0_b11));
assign linien_fast_a_iir0_z5 = (linien_fast_a_iir0_zr5 + (linien_fast_a_iir0_x1 * linien_fast_a_iir0_b01));
assign linien_fast_a_iir0_z6 = (linien_fast_a_iir0_zr6 + (linien_fast_a_iir0_y3 * linien_fast_a_iir0_a2));
assign linien_fast_a_iir0_z7 = (linien_fast_a_iir0_zr7 + (linien_fast_a_iir0_y3 * linien_fast_a_iir0_a11));
assign linien_fast_a_iir0_y_next1 = linien_fast_a_iir0_z7;
assign linien_fast_a_limitcsr0_limit_x1 = linien_fast_a_limitcsr0_x1;

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	linien_fast_a_limitcsr0_limit_y1 <= 28'sd0;
	linien_fast_a_limitcsr0_limit_railed1 <= 1'd0;
	if ((linien_fast_a_limitcsr0_limit_x1 >= linien_fast_a_limitcsr0_limit_max1)) begin
		linien_fast_a_limitcsr0_limit_y1 <= linien_fast_a_limitcsr0_limit_max1;
		linien_fast_a_limitcsr0_limit_railed1 <= 1'd1;
	end else begin
		if ((linien_fast_a_limitcsr0_limit_x1 <= linien_fast_a_limitcsr0_limit_min1)) begin
			linien_fast_a_limitcsr0_limit_y1 <= linien_fast_a_limitcsr0_limit_min1;
			linien_fast_a_limitcsr0_limit_railed1 <= 1'd1;
		end else begin
			linien_fast_a_limitcsr0_limit_y1 <= linien_fast_a_limitcsr0_limit_x1;
			linien_fast_a_limitcsr0_limit_railed1 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_a_limitcsr1_limit_x0 = linien_fast_a_limitcsr1_x0;

// synthesis translate_off
reg dummy_d_12;
// synthesis translate_on
always @(*) begin
	linien_fast_a_limitcsr1_limit_y0 <= 26'sd0;
	linien_fast_a_limitcsr1_limit_railed0 <= 1'd0;
	if ((linien_fast_a_limitcsr1_limit_x0 >= linien_fast_a_limitcsr1_limit_max0)) begin
		linien_fast_a_limitcsr1_limit_y0 <= linien_fast_a_limitcsr1_limit_max0;
		linien_fast_a_limitcsr1_limit_railed0 <= 1'd1;
	end else begin
		if ((linien_fast_a_limitcsr1_limit_x0 <= linien_fast_a_limitcsr1_limit_min0)) begin
			linien_fast_a_limitcsr1_limit_y0 <= linien_fast_a_limitcsr1_limit_min0;
			linien_fast_a_limitcsr1_limit_railed0 <= 1'd1;
		end else begin
			linien_fast_a_limitcsr1_limit_y0 <= linien_fast_a_limitcsr1_limit_x0;
			linien_fast_a_limitcsr1_limit_railed0 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_12 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_a_iir1_railed0 = (~((linien_fast_a_iir1_y_next0[49:47] == $signed({1'd0, linien_fast_a_iir1_y_pat0})) | (linien_fast_a_iir1_y_next0[49:47] == $signed({1'd0, (~linien_fast_a_iir1_y_pat0)}))));

// synthesis translate_off
reg dummy_d_13;
// synthesis translate_on
always @(*) begin
	linien_fast_a_iir1_y_lim0 <= 25'sd0;
	if (linien_fast_a_iir1_railed0) begin
		linien_fast_a_iir1_y_lim0 <= linien_fast_a_iir1_y0;
	end else begin
		linien_fast_a_iir1_y_lim0 <= linien_fast_a_iir1_y_next0[49:23];
	end
// synthesis translate_off
	dummy_d_13 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_a_iir1_z0 = (linien_fast_a_iir1_zr0 + (linien_fast_a_iir1_x0 * linien_fast_a_iir1_b10));
assign linien_fast_a_iir1_z1 = (linien_fast_a_iir1_zr1 + (linien_fast_a_iir1_x0 * linien_fast_a_iir1_b00));
assign linien_fast_a_iir1_z2 = (linien_fast_a_iir1_zr2 + (linien_fast_a_iir1_y1 * linien_fast_a_iir1_a10));
assign linien_fast_a_iir1_y_next0 = linien_fast_a_iir1_z2;
assign linien_fast_a_iir1_railed1 = (~((linien_fast_a_iir1_y_next1[49:47] == $signed({1'd0, linien_fast_a_iir1_y_pat1})) | (linien_fast_a_iir1_y_next1[49:47] == $signed({1'd0, (~linien_fast_a_iir1_y_pat1)}))));

// synthesis translate_off
reg dummy_d_14;
// synthesis translate_on
always @(*) begin
	linien_fast_a_iir1_y_lim1 <= 25'sd0;
	if (linien_fast_a_iir1_railed1) begin
		linien_fast_a_iir1_y_lim1 <= linien_fast_a_iir1_y2;
	end else begin
		linien_fast_a_iir1_y_lim1 <= linien_fast_a_iir1_y_next1[49:23];
	end
// synthesis translate_off
	dummy_d_14 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_a_iir1_z3 = (linien_fast_a_iir1_zr3 + (linien_fast_a_iir1_x1 * linien_fast_a_iir1_b2));
assign linien_fast_a_iir1_z4 = (linien_fast_a_iir1_zr4 + (linien_fast_a_iir1_x1 * linien_fast_a_iir1_b11));
assign linien_fast_a_iir1_z5 = (linien_fast_a_iir1_zr5 + (linien_fast_a_iir1_x1 * linien_fast_a_iir1_b01));
assign linien_fast_a_iir1_z6 = (linien_fast_a_iir1_zr6 + (linien_fast_a_iir1_y3 * linien_fast_a_iir1_a2));
assign linien_fast_a_iir1_z7 = (linien_fast_a_iir1_zr7 + (linien_fast_a_iir1_y3 * linien_fast_a_iir1_a11));
assign linien_fast_a_iir1_y_next1 = linien_fast_a_iir1_z7;
assign linien_fast_a_limitcsr1_limit_x1 = linien_fast_a_limitcsr1_x1;

// synthesis translate_off
reg dummy_d_15;
// synthesis translate_on
always @(*) begin
	linien_fast_a_limitcsr1_limit_y1 <= 28'sd0;
	linien_fast_a_limitcsr1_limit_railed1 <= 1'd0;
	if ((linien_fast_a_limitcsr1_limit_x1 >= linien_fast_a_limitcsr1_limit_max1)) begin
		linien_fast_a_limitcsr1_limit_y1 <= linien_fast_a_limitcsr1_limit_max1;
		linien_fast_a_limitcsr1_limit_railed1 <= 1'd1;
	end else begin
		if ((linien_fast_a_limitcsr1_limit_x1 <= linien_fast_a_limitcsr1_limit_min1)) begin
			linien_fast_a_limitcsr1_limit_y1 <= linien_fast_a_limitcsr1_limit_min1;
			linien_fast_a_limitcsr1_limit_railed1 <= 1'd1;
		end else begin
			linien_fast_a_limitcsr1_limit_y1 <= linien_fast_a_limitcsr1_limit_x1;
			linien_fast_a_limitcsr1_limit_railed1 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_15 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_b_x0 = (linien_fast_b_adc <<< 4'd11);
assign linien_fast_b_x1 = linien_fast_b_adc;
assign linien_fast_b_phase = linien_logic_phase;
assign linien_fast_b_limitcsr0_x0 = ((linien_fast_b_i <<< 4'd11) + linien_fast_b_dx);
assign linien_fast_b_iir0_x0 = linien_fast_b_limitcsr0_limitcsr0_y0;
assign linien_fast_b_iir0_hold0 = 1'd0;
assign linien_fast_b_iir0_clear0 = 1'd0;
assign linien_fast_b_iir0_x1 = linien_fast_b_iir0_y0;
assign linien_fast_b_iir0_hold1 = 1'd0;
assign linien_fast_b_iir0_clear1 = 1'd0;
assign linien_fast_b_limitcsr0_x1 = ((linien_fast_b_invert_storage ? 1'sd1 : $signed({1'd0, 1'd1})) * ((comb_array_muxed2 + (linien_fast_b_ya <<< 4'd11)) + (linien_logic_chain_b_offset_signed <<< 4'd11)));
assign linien_fast_b_out_i = linien_fast_b_limitcsr0_limitcsr0_y1;
assign linien_fast_b_limitcsr1_x0 = ((linien_fast_b_q0 <<< 4'd11) + linien_fast_b_dx);
assign linien_fast_b_iir1_x0 = linien_fast_b_limitcsr1_limitcsr1_y0;
assign linien_fast_b_iir1_hold0 = 1'd0;
assign linien_fast_b_iir1_clear0 = 1'd0;
assign linien_fast_b_iir1_x1 = linien_fast_b_iir1_y0;
assign linien_fast_b_iir1_hold1 = 1'd0;
assign linien_fast_b_iir1_clear1 = 1'd0;
assign linien_fast_b_limitcsr1_x1 = ((linien_fast_b_invert_storage ? 1'sd1 : $signed({1'd0, 1'd1})) * ((comb_array_muxed3 + (linien_fast_b_ya <<< 4'd11)) + (linien_logic_chain_b_offset_signed <<< 4'd11)));
assign linien_fast_b_out_q = linien_fast_b_limitcsr1_limitcsr1_y1;
assign linien_sig_status3 = linien_fast_b_x0;
assign linien_sig_status4 = linien_fast_b_out_i;
assign linien_sig_status5 = linien_fast_b_out_q;
assign linien_fast_b_xi1 = linien_fast_b_x1;
assign linien_fast_b_zi1 = (((linien_fast_b_phase * linien_fast_b_multiplier_storage) + linien_fast_b_delay_storage) <<< 1'd1);
assign linien_fast_b_i = (linien_fast_b_xo >>> 1'd1);
assign linien_fast_b_q0 = (linien_fast_b_yo >>> 1'd1);
assign linien_fast_b_x2 = (linien_fast_b_xi0 <<< 2'd2);
assign linien_fast_b_y0 = (linien_fast_b_yi0 <<< 2'd2);
assign linien_fast_b_z0 = (linien_fast_b_zi0 <<< 2'd2);
assign linien_fast_b_xo = (linien_fast_b_x17 >>> 2'd2);
assign linien_fast_b_yo = (linien_fast_b_y15 >>> 2'd2);
assign linien_fast_b_zo = (linien_fast_b_z15 >>> 2'd2);
assign linien_fast_b_new_out = 1'd1;
assign linien_fast_b_new_in = 1'd1;
assign linien_fast_b_dir0 = (linien_fast_b_z0 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir1 = (linien_fast_b_z1 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir2 = (linien_fast_b_z2 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir3 = (linien_fast_b_z3 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir4 = (linien_fast_b_z4 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir5 = (linien_fast_b_z5 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir6 = (linien_fast_b_z6 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir7 = (linien_fast_b_z7 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir8 = (linien_fast_b_z8 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir9 = (linien_fast_b_z9 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir10 = (linien_fast_b_z10 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir11 = (linien_fast_b_z11 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir12 = (linien_fast_b_z12 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir13 = (linien_fast_b_z13 < $signed({1'd0, 1'd0}));
assign linien_fast_b_dir14 = (linien_fast_b_z14 < $signed({1'd0, 1'd0}));
assign linien_fast_b_q1 = (linien_fast_b_zi1[13] ^ linien_fast_b_zi1[14]);

// synthesis translate_off
reg dummy_d_16;
// synthesis translate_on
always @(*) begin
	linien_fast_b_xi0 <= 15'sd0;
	linien_fast_b_yi0 <= 15'sd0;
	linien_fast_b_zi0 <= 15'sd0;
	if (linien_fast_b_q1) begin
		{linien_fast_b_zi0, linien_fast_b_yi0, linien_fast_b_xi0} <= {(linien_fast_b_zi1 + $signed({1'd0, 15'd16384})), (-linien_fast_b_yi1), (-linien_fast_b_xi1)};
	end else begin
		{linien_fast_b_zi0, linien_fast_b_yi0, linien_fast_b_xi0} <= {linien_fast_b_zi1, linien_fast_b_yi1, linien_fast_b_xi1};
	end
// synthesis translate_off
	dummy_d_16 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_b_limitcsr0_limit_x0 = linien_fast_b_limitcsr0_x0;

// synthesis translate_off
reg dummy_d_17;
// synthesis translate_on
always @(*) begin
	linien_fast_b_limitcsr0_limit_y0 <= 26'sd0;
	linien_fast_b_limitcsr0_limit_railed0 <= 1'd0;
	if ((linien_fast_b_limitcsr0_limit_x0 >= linien_fast_b_limitcsr0_limit_max0)) begin
		linien_fast_b_limitcsr0_limit_y0 <= linien_fast_b_limitcsr0_limit_max0;
		linien_fast_b_limitcsr0_limit_railed0 <= 1'd1;
	end else begin
		if ((linien_fast_b_limitcsr0_limit_x0 <= linien_fast_b_limitcsr0_limit_min0)) begin
			linien_fast_b_limitcsr0_limit_y0 <= linien_fast_b_limitcsr0_limit_min0;
			linien_fast_b_limitcsr0_limit_railed0 <= 1'd1;
		end else begin
			linien_fast_b_limitcsr0_limit_y0 <= linien_fast_b_limitcsr0_limit_x0;
			linien_fast_b_limitcsr0_limit_railed0 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_17 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_b_iir0_railed0 = (~((linien_fast_b_iir0_y_next0[49:47] == $signed({1'd0, linien_fast_b_iir0_y_pat0})) | (linien_fast_b_iir0_y_next0[49:47] == $signed({1'd0, (~linien_fast_b_iir0_y_pat0)}))));

// synthesis translate_off
reg dummy_d_18;
// synthesis translate_on
always @(*) begin
	linien_fast_b_iir0_y_lim0 <= 25'sd0;
	if (linien_fast_b_iir0_railed0) begin
		linien_fast_b_iir0_y_lim0 <= linien_fast_b_iir0_y0;
	end else begin
		linien_fast_b_iir0_y_lim0 <= linien_fast_b_iir0_y_next0[49:23];
	end
// synthesis translate_off
	dummy_d_18 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_b_iir0_z0 = (linien_fast_b_iir0_zr0 + (linien_fast_b_iir0_x0 * linien_fast_b_iir0_b10));
assign linien_fast_b_iir0_z1 = (linien_fast_b_iir0_zr1 + (linien_fast_b_iir0_x0 * linien_fast_b_iir0_b00));
assign linien_fast_b_iir0_z2 = (linien_fast_b_iir0_zr2 + (linien_fast_b_iir0_y1 * linien_fast_b_iir0_a10));
assign linien_fast_b_iir0_y_next0 = linien_fast_b_iir0_z2;
assign linien_fast_b_iir0_railed1 = (~((linien_fast_b_iir0_y_next1[49:47] == $signed({1'd0, linien_fast_b_iir0_y_pat1})) | (linien_fast_b_iir0_y_next1[49:47] == $signed({1'd0, (~linien_fast_b_iir0_y_pat1)}))));

// synthesis translate_off
reg dummy_d_19;
// synthesis translate_on
always @(*) begin
	linien_fast_b_iir0_y_lim1 <= 25'sd0;
	if (linien_fast_b_iir0_railed1) begin
		linien_fast_b_iir0_y_lim1 <= linien_fast_b_iir0_y2;
	end else begin
		linien_fast_b_iir0_y_lim1 <= linien_fast_b_iir0_y_next1[49:23];
	end
// synthesis translate_off
	dummy_d_19 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_b_iir0_z3 = (linien_fast_b_iir0_zr3 + (linien_fast_b_iir0_x1 * linien_fast_b_iir0_b2));
assign linien_fast_b_iir0_z4 = (linien_fast_b_iir0_zr4 + (linien_fast_b_iir0_x1 * linien_fast_b_iir0_b11));
assign linien_fast_b_iir0_z5 = (linien_fast_b_iir0_zr5 + (linien_fast_b_iir0_x1 * linien_fast_b_iir0_b01));
assign linien_fast_b_iir0_z6 = (linien_fast_b_iir0_zr6 + (linien_fast_b_iir0_y3 * linien_fast_b_iir0_a2));
assign linien_fast_b_iir0_z7 = (linien_fast_b_iir0_zr7 + (linien_fast_b_iir0_y3 * linien_fast_b_iir0_a11));
assign linien_fast_b_iir0_y_next1 = linien_fast_b_iir0_z7;
assign linien_fast_b_limitcsr0_limit_x1 = linien_fast_b_limitcsr0_x1;

// synthesis translate_off
reg dummy_d_20;
// synthesis translate_on
always @(*) begin
	linien_fast_b_limitcsr0_limit_y1 <= 28'sd0;
	linien_fast_b_limitcsr0_limit_railed1 <= 1'd0;
	if ((linien_fast_b_limitcsr0_limit_x1 >= linien_fast_b_limitcsr0_limit_max1)) begin
		linien_fast_b_limitcsr0_limit_y1 <= linien_fast_b_limitcsr0_limit_max1;
		linien_fast_b_limitcsr0_limit_railed1 <= 1'd1;
	end else begin
		if ((linien_fast_b_limitcsr0_limit_x1 <= linien_fast_b_limitcsr0_limit_min1)) begin
			linien_fast_b_limitcsr0_limit_y1 <= linien_fast_b_limitcsr0_limit_min1;
			linien_fast_b_limitcsr0_limit_railed1 <= 1'd1;
		end else begin
			linien_fast_b_limitcsr0_limit_y1 <= linien_fast_b_limitcsr0_limit_x1;
			linien_fast_b_limitcsr0_limit_railed1 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_20 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_b_limitcsr1_limit_x0 = linien_fast_b_limitcsr1_x0;

// synthesis translate_off
reg dummy_d_21;
// synthesis translate_on
always @(*) begin
	linien_fast_b_limitcsr1_limit_y0 <= 26'sd0;
	linien_fast_b_limitcsr1_limit_railed0 <= 1'd0;
	if ((linien_fast_b_limitcsr1_limit_x0 >= linien_fast_b_limitcsr1_limit_max0)) begin
		linien_fast_b_limitcsr1_limit_y0 <= linien_fast_b_limitcsr1_limit_max0;
		linien_fast_b_limitcsr1_limit_railed0 <= 1'd1;
	end else begin
		if ((linien_fast_b_limitcsr1_limit_x0 <= linien_fast_b_limitcsr1_limit_min0)) begin
			linien_fast_b_limitcsr1_limit_y0 <= linien_fast_b_limitcsr1_limit_min0;
			linien_fast_b_limitcsr1_limit_railed0 <= 1'd1;
		end else begin
			linien_fast_b_limitcsr1_limit_y0 <= linien_fast_b_limitcsr1_limit_x0;
			linien_fast_b_limitcsr1_limit_railed0 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_21 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_b_iir1_railed0 = (~((linien_fast_b_iir1_y_next0[49:47] == $signed({1'd0, linien_fast_b_iir1_y_pat0})) | (linien_fast_b_iir1_y_next0[49:47] == $signed({1'd0, (~linien_fast_b_iir1_y_pat0)}))));

// synthesis translate_off
reg dummy_d_22;
// synthesis translate_on
always @(*) begin
	linien_fast_b_iir1_y_lim0 <= 25'sd0;
	if (linien_fast_b_iir1_railed0) begin
		linien_fast_b_iir1_y_lim0 <= linien_fast_b_iir1_y0;
	end else begin
		linien_fast_b_iir1_y_lim0 <= linien_fast_b_iir1_y_next0[49:23];
	end
// synthesis translate_off
	dummy_d_22 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_b_iir1_z0 = (linien_fast_b_iir1_zr0 + (linien_fast_b_iir1_x0 * linien_fast_b_iir1_b10));
assign linien_fast_b_iir1_z1 = (linien_fast_b_iir1_zr1 + (linien_fast_b_iir1_x0 * linien_fast_b_iir1_b00));
assign linien_fast_b_iir1_z2 = (linien_fast_b_iir1_zr2 + (linien_fast_b_iir1_y1 * linien_fast_b_iir1_a10));
assign linien_fast_b_iir1_y_next0 = linien_fast_b_iir1_z2;
assign linien_fast_b_iir1_railed1 = (~((linien_fast_b_iir1_y_next1[49:47] == $signed({1'd0, linien_fast_b_iir1_y_pat1})) | (linien_fast_b_iir1_y_next1[49:47] == $signed({1'd0, (~linien_fast_b_iir1_y_pat1)}))));

// synthesis translate_off
reg dummy_d_23;
// synthesis translate_on
always @(*) begin
	linien_fast_b_iir1_y_lim1 <= 25'sd0;
	if (linien_fast_b_iir1_railed1) begin
		linien_fast_b_iir1_y_lim1 <= linien_fast_b_iir1_y2;
	end else begin
		linien_fast_b_iir1_y_lim1 <= linien_fast_b_iir1_y_next1[49:23];
	end
// synthesis translate_off
	dummy_d_23 <= dummy_s;
// synthesis translate_on
end
assign linien_fast_b_iir1_z3 = (linien_fast_b_iir1_zr3 + (linien_fast_b_iir1_x1 * linien_fast_b_iir1_b2));
assign linien_fast_b_iir1_z4 = (linien_fast_b_iir1_zr4 + (linien_fast_b_iir1_x1 * linien_fast_b_iir1_b11));
assign linien_fast_b_iir1_z5 = (linien_fast_b_iir1_zr5 + (linien_fast_b_iir1_x1 * linien_fast_b_iir1_b01));
assign linien_fast_b_iir1_z6 = (linien_fast_b_iir1_zr6 + (linien_fast_b_iir1_y3 * linien_fast_b_iir1_a2));
assign linien_fast_b_iir1_z7 = (linien_fast_b_iir1_zr7 + (linien_fast_b_iir1_y3 * linien_fast_b_iir1_a11));
assign linien_fast_b_iir1_y_next1 = linien_fast_b_iir1_z7;
assign linien_fast_b_limitcsr1_limit_x1 = linien_fast_b_limitcsr1_x1;

// synthesis translate_off
reg dummy_d_24;
// synthesis translate_on
always @(*) begin
	linien_fast_b_limitcsr1_limit_y1 <= 28'sd0;
	linien_fast_b_limitcsr1_limit_railed1 <= 1'd0;
	if ((linien_fast_b_limitcsr1_limit_x1 >= linien_fast_b_limitcsr1_limit_max1)) begin
		linien_fast_b_limitcsr1_limit_y1 <= linien_fast_b_limitcsr1_limit_max1;
		linien_fast_b_limitcsr1_limit_railed1 <= 1'd1;
	end else begin
		if ((linien_fast_b_limitcsr1_limit_x1 <= linien_fast_b_limitcsr1_limit_min1)) begin
			linien_fast_b_limitcsr1_limit_y1 <= linien_fast_b_limitcsr1_limit_min1;
			linien_fast_b_limitcsr1_limit_railed1 <= 1'd1;
		end else begin
			linien_fast_b_limitcsr1_limit_y1 <= linien_fast_b_limitcsr1_limit_x1;
			linien_fast_b_limitcsr1_limit_railed1 <= 1'd0;
		end
	end
// synthesis translate_off
	dummy_d_24 <= dummy_s;
// synthesis translate_on
end
assign linien_cordic_a_xi1 = linien_i_a;
assign linien_cordic_a_yi1 = linien_q_a;
assign linien_mag_a = linien_cordic_a_xo;
assign linien_cordic_b_xi1 = linien_i_b;
assign linien_cordic_b_yi1 = linien_q_b;
assign linien_mag_b = linien_cordic_b_xo;
assign linien_mag_a_scaled = (linien_mag_a >>> 1'd1);
assign linien_mag_b_scaled = (linien_mag_b >>> 1'd1);
assign linien_numerator = (linien_mag_a_scaled - linien_mag_b_scaled);
assign linien_denominator = (linien_mag_a_scaled + linien_mag_b_scaled);
assign linien_safe_to_divide = (linien_denominator > $signed({1'd0, 3'd4}));
assign linien_start_pulse = (linien_safe_to_divide & (~linien_safe_to_divide_reg));
assign linien_divider_start = linien_start_pulse;
assign linien_divider_num = linien_numerator;
assign linien_divider_den = linien_denominator;
assign linien_csr_out_e_status = linien_out_e;
assign linien_csr_power_signal_out_status = linien_denominator_reg;
assign linien_power_signal_out = linien_denominator_reg;
assign linien_sig_status6 = linien_out_e;
assign linien_sig_status7 = linien_power_signal_out;
assign linien_cordic_a_x0 = (linien_cordic_a_xi0 <<< 1'd0);
assign linien_cordic_a_y0 = (linien_cordic_a_yi0 <<< 1'd0);
assign linien_cordic_a_z0 = (linien_cordic_a_zi0 <<< 1'd0);
assign linien_cordic_a_xo = (linien_cordic_a_x25 >>> 1'd0);
assign linien_cordic_a_yo = (linien_cordic_a_y25 >>> 1'd0);
assign linien_cordic_a_zo = (linien_cordic_a_z25 >>> 1'd0);
assign linien_cordic_a_new_out = 1'd1;
assign linien_cordic_a_new_in = 1'd1;
assign linien_cordic_a_dir0 = (linien_cordic_a_y0 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x1 = (linien_cordic_a_x0 + (linien_cordic_a_dir0 ? (linien_cordic_a_y0 >>> 1'd0) : (-(linien_cordic_a_y0 >>> 1'd0))));
assign linien_cordic_a_y1 = (linien_cordic_a_y0 + (linien_cordic_a_dir0 ? (-(linien_cordic_a_x0 >>> 1'd0)) : (linien_cordic_a_x0 >>> 1'd0)));
assign linien_cordic_a_z1 = (linien_cordic_a_z0 + (linien_cordic_a_dir0 ? $signed({1'd0, 23'd4194304}) : 23'sd4194304));
assign linien_cordic_a_dir1 = (linien_cordic_a_y1 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x2 = (linien_cordic_a_x1 + (linien_cordic_a_dir1 ? (linien_cordic_a_y1 >>> 1'd1) : (-(linien_cordic_a_y1 >>> 1'd1))));
assign linien_cordic_a_y2 = (linien_cordic_a_y1 + (linien_cordic_a_dir1 ? (-(linien_cordic_a_x1 >>> 1'd1)) : (linien_cordic_a_x1 >>> 1'd1)));
assign linien_cordic_a_z2 = (linien_cordic_a_z1 + (linien_cordic_a_dir1 ? $signed({1'd0, 22'd2476042}) : 23'sd5912566));
assign linien_cordic_a_dir2 = (linien_cordic_a_y2 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x3 = (linien_cordic_a_x2 + (linien_cordic_a_dir2 ? (linien_cordic_a_y2 >>> 2'd2) : (-(linien_cordic_a_y2 >>> 2'd2))));
assign linien_cordic_a_y3 = (linien_cordic_a_y2 + (linien_cordic_a_dir2 ? (-(linien_cordic_a_x2 >>> 2'd2)) : (linien_cordic_a_x2 >>> 2'd2)));
assign linien_cordic_a_z3 = (linien_cordic_a_z2 + (linien_cordic_a_dir2 ? $signed({1'd0, 21'd1308273}) : 22'sd2886031));
assign linien_cordic_a_dir3 = (linien_cordic_a_y3 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x4 = (linien_cordic_a_x3 + (linien_cordic_a_dir3 ? (linien_cordic_a_y3 >>> 2'd3) : (-(linien_cordic_a_y3 >>> 2'd3))));
assign linien_cordic_a_y4 = (linien_cordic_a_y3 + (linien_cordic_a_dir3 ? (-(linien_cordic_a_x3 >>> 2'd3)) : (linien_cordic_a_x3 >>> 2'd3)));
assign linien_cordic_a_z4 = (linien_cordic_a_z3 + (linien_cordic_a_dir3 ? $signed({1'd0, 20'd664100}) : 21'sd1433052));
assign linien_cordic_a_dir4 = (linien_cordic_a_y4 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x5 = (linien_cordic_a_x4 + (linien_cordic_a_dir4 ? (linien_cordic_a_y4 >>> 3'd4) : (-(linien_cordic_a_y4 >>> 3'd4))));
assign linien_cordic_a_y5 = (linien_cordic_a_y4 + (linien_cordic_a_dir4 ? (-(linien_cordic_a_x4 >>> 3'd4)) : (linien_cordic_a_x4 >>> 3'd4)));
assign linien_cordic_a_z5 = (linien_cordic_a_z4 + (linien_cordic_a_dir4 ? $signed({1'd0, 19'd333339}) : 20'sd715237));
assign linien_cordic_a_dir5 = (linien_cordic_a_y5 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x6 = (linien_cordic_a_x5 + (linien_cordic_a_dir5 ? (linien_cordic_a_y5 >>> 3'd5) : (-(linien_cordic_a_y5 >>> 3'd5))));
assign linien_cordic_a_y6 = (linien_cordic_a_y5 + (linien_cordic_a_dir5 ? (-(linien_cordic_a_x5 >>> 3'd5)) : (linien_cordic_a_x5 >>> 3'd5)));
assign linien_cordic_a_z6 = (linien_cordic_a_z5 + (linien_cordic_a_dir5 ? $signed({1'd0, 18'd166832}) : 19'sd357456));
assign linien_cordic_a_dir6 = (linien_cordic_a_y6 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x7 = (linien_cordic_a_x6 + (linien_cordic_a_dir6 ? (linien_cordic_a_y6 >>> 3'd6) : (-(linien_cordic_a_y6 >>> 3'd6))));
assign linien_cordic_a_y7 = (linien_cordic_a_y6 + (linien_cordic_a_dir6 ? (-(linien_cordic_a_x6 >>> 3'd6)) : (linien_cordic_a_x6 >>> 3'd6)));
assign linien_cordic_a_z7 = (linien_cordic_a_z6 + (linien_cordic_a_dir6 ? $signed({1'd0, 17'd83436}) : 18'sd178708));
assign linien_cordic_a_dir7 = (linien_cordic_a_y7 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x8 = (linien_cordic_a_x7 + (linien_cordic_a_dir7 ? (linien_cordic_a_y7 >>> 3'd7) : (-(linien_cordic_a_y7 >>> 3'd7))));
assign linien_cordic_a_y8 = (linien_cordic_a_y7 + (linien_cordic_a_dir7 ? (-(linien_cordic_a_x7 >>> 3'd7)) : (linien_cordic_a_x7 >>> 3'd7)));
assign linien_cordic_a_z8 = (linien_cordic_a_z7 + (linien_cordic_a_dir7 ? $signed({1'd0, 16'd41721}) : 17'sd89351));
assign linien_cordic_a_dir8 = (linien_cordic_a_y8 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x9 = (linien_cordic_a_x8 + (linien_cordic_a_dir8 ? (linien_cordic_a_y8 >>> 4'd8) : (-(linien_cordic_a_y8 >>> 4'd8))));
assign linien_cordic_a_y9 = (linien_cordic_a_y8 + (linien_cordic_a_dir8 ? (-(linien_cordic_a_x8 >>> 4'd8)) : (linien_cordic_a_x8 >>> 4'd8)));
assign linien_cordic_a_z9 = (linien_cordic_a_z8 + (linien_cordic_a_dir8 ? $signed({1'd0, 15'd20861}) : 16'sd44675));
assign linien_cordic_a_dir9 = (linien_cordic_a_y9 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x10 = (linien_cordic_a_x9 + (linien_cordic_a_dir9 ? (linien_cordic_a_y9 >>> 4'd9) : (-(linien_cordic_a_y9 >>> 4'd9))));
assign linien_cordic_a_y10 = (linien_cordic_a_y9 + (linien_cordic_a_dir9 ? (-(linien_cordic_a_x9 >>> 4'd9)) : (linien_cordic_a_x9 >>> 4'd9)));
assign linien_cordic_a_z10 = (linien_cordic_a_z9 + (linien_cordic_a_dir9 ? $signed({1'd0, 14'd10430}) : 15'sd22338));
assign linien_cordic_a_dir10 = (linien_cordic_a_y10 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x11 = (linien_cordic_a_x10 + (linien_cordic_a_dir10 ? (linien_cordic_a_y10 >>> 4'd10) : (-(linien_cordic_a_y10 >>> 4'd10))));
assign linien_cordic_a_y11 = (linien_cordic_a_y10 + (linien_cordic_a_dir10 ? (-(linien_cordic_a_x10 >>> 4'd10)) : (linien_cordic_a_x10 >>> 4'd10)));
assign linien_cordic_a_z11 = (linien_cordic_a_z10 + (linien_cordic_a_dir10 ? $signed({1'd0, 13'd5215}) : 14'sd11169));
assign linien_cordic_a_dir11 = (linien_cordic_a_y11 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x12 = (linien_cordic_a_x11 + (linien_cordic_a_dir11 ? (linien_cordic_a_y11 >>> 4'd11) : (-(linien_cordic_a_y11 >>> 4'd11))));
assign linien_cordic_a_y12 = (linien_cordic_a_y11 + (linien_cordic_a_dir11 ? (-(linien_cordic_a_x11 >>> 4'd11)) : (linien_cordic_a_x11 >>> 4'd11)));
assign linien_cordic_a_z12 = (linien_cordic_a_z11 + (linien_cordic_a_dir11 ? $signed({1'd0, 12'd2608}) : 13'sd5584));
assign linien_cordic_a_dir12 = (linien_cordic_a_y12 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x13 = (linien_cordic_a_x12 + (linien_cordic_a_dir12 ? (linien_cordic_a_y12 >>> 4'd12) : (-(linien_cordic_a_y12 >>> 4'd12))));
assign linien_cordic_a_y13 = (linien_cordic_a_y12 + (linien_cordic_a_dir12 ? (-(linien_cordic_a_x12 >>> 4'd12)) : (linien_cordic_a_x12 >>> 4'd12)));
assign linien_cordic_a_z13 = (linien_cordic_a_z12 + (linien_cordic_a_dir12 ? $signed({1'd0, 11'd1304}) : 12'sd2792));
assign linien_cordic_a_dir13 = (linien_cordic_a_y13 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x14 = (linien_cordic_a_x13 + (linien_cordic_a_dir13 ? (linien_cordic_a_y13 >>> 4'd13) : (-(linien_cordic_a_y13 >>> 4'd13))));
assign linien_cordic_a_y14 = (linien_cordic_a_y13 + (linien_cordic_a_dir13 ? (-(linien_cordic_a_x13 >>> 4'd13)) : (linien_cordic_a_x13 >>> 4'd13)));
assign linien_cordic_a_z14 = (linien_cordic_a_z13 + (linien_cordic_a_dir13 ? $signed({1'd0, 10'd652}) : 11'sd1396));
assign linien_cordic_a_dir14 = (linien_cordic_a_y14 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x15 = (linien_cordic_a_x14 + (linien_cordic_a_dir14 ? (linien_cordic_a_y14 >>> 4'd14) : (-(linien_cordic_a_y14 >>> 4'd14))));
assign linien_cordic_a_y15 = (linien_cordic_a_y14 + (linien_cordic_a_dir14 ? (-(linien_cordic_a_x14 >>> 4'd14)) : (linien_cordic_a_x14 >>> 4'd14)));
assign linien_cordic_a_z15 = (linien_cordic_a_z14 + (linien_cordic_a_dir14 ? $signed({1'd0, 9'd326}) : 10'sd698));
assign linien_cordic_a_dir15 = (linien_cordic_a_y15 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x16 = (linien_cordic_a_x15 + (linien_cordic_a_dir15 ? (linien_cordic_a_y15 >>> 4'd15) : (-(linien_cordic_a_y15 >>> 4'd15))));
assign linien_cordic_a_y16 = (linien_cordic_a_y15 + (linien_cordic_a_dir15 ? (-(linien_cordic_a_x15 >>> 4'd15)) : (linien_cordic_a_x15 >>> 4'd15)));
assign linien_cordic_a_z16 = (linien_cordic_a_z15 + (linien_cordic_a_dir15 ? $signed({1'd0, 8'd163}) : 9'sd349));
assign linien_cordic_a_dir16 = (linien_cordic_a_y16 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x17 = (linien_cordic_a_x16 + (linien_cordic_a_dir16 ? (linien_cordic_a_y16 >>> 5'd16) : (-(linien_cordic_a_y16 >>> 5'd16))));
assign linien_cordic_a_y17 = (linien_cordic_a_y16 + (linien_cordic_a_dir16 ? (-(linien_cordic_a_x16 >>> 5'd16)) : (linien_cordic_a_x16 >>> 5'd16)));
assign linien_cordic_a_z17 = (linien_cordic_a_z16 + (linien_cordic_a_dir16 ? $signed({1'd0, 7'd81}) : 8'sd175));
assign linien_cordic_a_dir17 = (linien_cordic_a_y17 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x18 = (linien_cordic_a_x17 + (linien_cordic_a_dir17 ? (linien_cordic_a_y17 >>> 5'd17) : (-(linien_cordic_a_y17 >>> 5'd17))));
assign linien_cordic_a_y18 = (linien_cordic_a_y17 + (linien_cordic_a_dir17 ? (-(linien_cordic_a_x17 >>> 5'd17)) : (linien_cordic_a_x17 >>> 5'd17)));
assign linien_cordic_a_z18 = (linien_cordic_a_z17 + (linien_cordic_a_dir17 ? $signed({1'd0, 6'd41}) : 7'sd87));
assign linien_cordic_a_dir18 = (linien_cordic_a_y18 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x19 = (linien_cordic_a_x18 + (linien_cordic_a_dir18 ? (linien_cordic_a_y18 >>> 5'd18) : (-(linien_cordic_a_y18 >>> 5'd18))));
assign linien_cordic_a_y19 = (linien_cordic_a_y18 + (linien_cordic_a_dir18 ? (-(linien_cordic_a_x18 >>> 5'd18)) : (linien_cordic_a_x18 >>> 5'd18)));
assign linien_cordic_a_z19 = (linien_cordic_a_z18 + (linien_cordic_a_dir18 ? $signed({1'd0, 5'd20}) : 6'sd44));
assign linien_cordic_a_dir19 = (linien_cordic_a_y19 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x20 = (linien_cordic_a_x19 + (linien_cordic_a_dir19 ? (linien_cordic_a_y19 >>> 5'd19) : (-(linien_cordic_a_y19 >>> 5'd19))));
assign linien_cordic_a_y20 = (linien_cordic_a_y19 + (linien_cordic_a_dir19 ? (-(linien_cordic_a_x19 >>> 5'd19)) : (linien_cordic_a_x19 >>> 5'd19)));
assign linien_cordic_a_z20 = (linien_cordic_a_z19 + (linien_cordic_a_dir19 ? $signed({1'd0, 4'd10}) : 5'sd22));
assign linien_cordic_a_dir20 = (linien_cordic_a_y20 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x21 = (linien_cordic_a_x20 + (linien_cordic_a_dir20 ? (linien_cordic_a_y20 >>> 5'd20) : (-(linien_cordic_a_y20 >>> 5'd20))));
assign linien_cordic_a_y21 = (linien_cordic_a_y20 + (linien_cordic_a_dir20 ? (-(linien_cordic_a_x20 >>> 5'd20)) : (linien_cordic_a_x20 >>> 5'd20)));
assign linien_cordic_a_z21 = (linien_cordic_a_z20 + (linien_cordic_a_dir20 ? $signed({1'd0, 3'd5}) : 4'sd11));
assign linien_cordic_a_dir21 = (linien_cordic_a_y21 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x22 = (linien_cordic_a_x21 + (linien_cordic_a_dir21 ? (linien_cordic_a_y21 >>> 5'd21) : (-(linien_cordic_a_y21 >>> 5'd21))));
assign linien_cordic_a_y22 = (linien_cordic_a_y21 + (linien_cordic_a_dir21 ? (-(linien_cordic_a_x21 >>> 5'd21)) : (linien_cordic_a_x21 >>> 5'd21)));
assign linien_cordic_a_z22 = (linien_cordic_a_z21 + (linien_cordic_a_dir21 ? $signed({1'd0, 2'd3}) : 3'sd5));
assign linien_cordic_a_dir22 = (linien_cordic_a_y22 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x23 = (linien_cordic_a_x22 + (linien_cordic_a_dir22 ? (linien_cordic_a_y22 >>> 5'd22) : (-(linien_cordic_a_y22 >>> 5'd22))));
assign linien_cordic_a_y23 = (linien_cordic_a_y22 + (linien_cordic_a_dir22 ? (-(linien_cordic_a_x22 >>> 5'd22)) : (linien_cordic_a_x22 >>> 5'd22)));
assign linien_cordic_a_z23 = (linien_cordic_a_z22 + (linien_cordic_a_dir22 ? $signed({1'd0, 1'd1}) : 1'sd1));
assign linien_cordic_a_dir23 = (linien_cordic_a_y23 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x24 = (linien_cordic_a_x23 + (linien_cordic_a_dir23 ? (linien_cordic_a_y23 >>> 5'd23) : (-(linien_cordic_a_y23 >>> 5'd23))));
assign linien_cordic_a_y24 = (linien_cordic_a_y23 + (linien_cordic_a_dir23 ? (-(linien_cordic_a_x23 >>> 5'd23)) : (linien_cordic_a_x23 >>> 5'd23)));
assign linien_cordic_a_z24 = (linien_cordic_a_z23 + (linien_cordic_a_dir23 ? $signed({1'd0, 1'd1}) : 1'sd1));
assign linien_cordic_a_dir24 = (linien_cordic_a_y24 >= $signed({1'd0, 1'd0}));
assign linien_cordic_a_x25 = (linien_cordic_a_x24 + (linien_cordic_a_dir24 ? (linien_cordic_a_y24 >>> 5'd24) : (-(linien_cordic_a_y24 >>> 5'd24))));
assign linien_cordic_a_y25 = (linien_cordic_a_y24 + (linien_cordic_a_dir24 ? (-(linien_cordic_a_x24 >>> 5'd24)) : (linien_cordic_a_x24 >>> 5'd24)));
assign linien_cordic_a_z25 = (linien_cordic_a_z24 + $signed({1'd0, (linien_cordic_a_dir24 ? 1'd0 : 1'd0)}));
assign linien_cordic_a_q = (linien_cordic_a_xi1 < $signed({1'd0, 1'd0}));

// synthesis translate_off
reg dummy_d_25;
// synthesis translate_on
always @(*) begin
	linien_cordic_a_xi0 <= 25'sd0;
	linien_cordic_a_yi0 <= 25'sd0;
	linien_cordic_a_zi0 <= 25'sd0;
	if (linien_cordic_a_q) begin
		{linien_cordic_a_zi0, linien_cordic_a_yi0, linien_cordic_a_xi0} <= {(linien_cordic_a_zi1 + $signed({1'd0, 25'd16777216})), (-linien_cordic_a_yi1), (-linien_cordic_a_xi1)};
	end else begin
		{linien_cordic_a_zi0, linien_cordic_a_yi0, linien_cordic_a_xi0} <= {linien_cordic_a_zi1, linien_cordic_a_yi1, linien_cordic_a_xi1};
	end
// synthesis translate_off
	dummy_d_25 <= dummy_s;
// synthesis translate_on
end
assign linien_cordic_b_x0 = (linien_cordic_b_xi0 <<< 1'd0);
assign linien_cordic_b_y0 = (linien_cordic_b_yi0 <<< 1'd0);
assign linien_cordic_b_z0 = (linien_cordic_b_zi0 <<< 1'd0);
assign linien_cordic_b_xo = (linien_cordic_b_x25 >>> 1'd0);
assign linien_cordic_b_yo = (linien_cordic_b_y25 >>> 1'd0);
assign linien_cordic_b_zo = (linien_cordic_b_z25 >>> 1'd0);
assign linien_cordic_b_new_out = 1'd1;
assign linien_cordic_b_new_in = 1'd1;
assign linien_cordic_b_dir0 = (linien_cordic_b_y0 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x1 = (linien_cordic_b_x0 + (linien_cordic_b_dir0 ? (linien_cordic_b_y0 >>> 1'd0) : (-(linien_cordic_b_y0 >>> 1'd0))));
assign linien_cordic_b_y1 = (linien_cordic_b_y0 + (linien_cordic_b_dir0 ? (-(linien_cordic_b_x0 >>> 1'd0)) : (linien_cordic_b_x0 >>> 1'd0)));
assign linien_cordic_b_z1 = (linien_cordic_b_z0 + (linien_cordic_b_dir0 ? $signed({1'd0, 23'd4194304}) : 23'sd4194304));
assign linien_cordic_b_dir1 = (linien_cordic_b_y1 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x2 = (linien_cordic_b_x1 + (linien_cordic_b_dir1 ? (linien_cordic_b_y1 >>> 1'd1) : (-(linien_cordic_b_y1 >>> 1'd1))));
assign linien_cordic_b_y2 = (linien_cordic_b_y1 + (linien_cordic_b_dir1 ? (-(linien_cordic_b_x1 >>> 1'd1)) : (linien_cordic_b_x1 >>> 1'd1)));
assign linien_cordic_b_z2 = (linien_cordic_b_z1 + (linien_cordic_b_dir1 ? $signed({1'd0, 22'd2476042}) : 23'sd5912566));
assign linien_cordic_b_dir2 = (linien_cordic_b_y2 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x3 = (linien_cordic_b_x2 + (linien_cordic_b_dir2 ? (linien_cordic_b_y2 >>> 2'd2) : (-(linien_cordic_b_y2 >>> 2'd2))));
assign linien_cordic_b_y3 = (linien_cordic_b_y2 + (linien_cordic_b_dir2 ? (-(linien_cordic_b_x2 >>> 2'd2)) : (linien_cordic_b_x2 >>> 2'd2)));
assign linien_cordic_b_z3 = (linien_cordic_b_z2 + (linien_cordic_b_dir2 ? $signed({1'd0, 21'd1308273}) : 22'sd2886031));
assign linien_cordic_b_dir3 = (linien_cordic_b_y3 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x4 = (linien_cordic_b_x3 + (linien_cordic_b_dir3 ? (linien_cordic_b_y3 >>> 2'd3) : (-(linien_cordic_b_y3 >>> 2'd3))));
assign linien_cordic_b_y4 = (linien_cordic_b_y3 + (linien_cordic_b_dir3 ? (-(linien_cordic_b_x3 >>> 2'd3)) : (linien_cordic_b_x3 >>> 2'd3)));
assign linien_cordic_b_z4 = (linien_cordic_b_z3 + (linien_cordic_b_dir3 ? $signed({1'd0, 20'd664100}) : 21'sd1433052));
assign linien_cordic_b_dir4 = (linien_cordic_b_y4 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x5 = (linien_cordic_b_x4 + (linien_cordic_b_dir4 ? (linien_cordic_b_y4 >>> 3'd4) : (-(linien_cordic_b_y4 >>> 3'd4))));
assign linien_cordic_b_y5 = (linien_cordic_b_y4 + (linien_cordic_b_dir4 ? (-(linien_cordic_b_x4 >>> 3'd4)) : (linien_cordic_b_x4 >>> 3'd4)));
assign linien_cordic_b_z5 = (linien_cordic_b_z4 + (linien_cordic_b_dir4 ? $signed({1'd0, 19'd333339}) : 20'sd715237));
assign linien_cordic_b_dir5 = (linien_cordic_b_y5 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x6 = (linien_cordic_b_x5 + (linien_cordic_b_dir5 ? (linien_cordic_b_y5 >>> 3'd5) : (-(linien_cordic_b_y5 >>> 3'd5))));
assign linien_cordic_b_y6 = (linien_cordic_b_y5 + (linien_cordic_b_dir5 ? (-(linien_cordic_b_x5 >>> 3'd5)) : (linien_cordic_b_x5 >>> 3'd5)));
assign linien_cordic_b_z6 = (linien_cordic_b_z5 + (linien_cordic_b_dir5 ? $signed({1'd0, 18'd166832}) : 19'sd357456));
assign linien_cordic_b_dir6 = (linien_cordic_b_y6 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x7 = (linien_cordic_b_x6 + (linien_cordic_b_dir6 ? (linien_cordic_b_y6 >>> 3'd6) : (-(linien_cordic_b_y6 >>> 3'd6))));
assign linien_cordic_b_y7 = (linien_cordic_b_y6 + (linien_cordic_b_dir6 ? (-(linien_cordic_b_x6 >>> 3'd6)) : (linien_cordic_b_x6 >>> 3'd6)));
assign linien_cordic_b_z7 = (linien_cordic_b_z6 + (linien_cordic_b_dir6 ? $signed({1'd0, 17'd83436}) : 18'sd178708));
assign linien_cordic_b_dir7 = (linien_cordic_b_y7 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x8 = (linien_cordic_b_x7 + (linien_cordic_b_dir7 ? (linien_cordic_b_y7 >>> 3'd7) : (-(linien_cordic_b_y7 >>> 3'd7))));
assign linien_cordic_b_y8 = (linien_cordic_b_y7 + (linien_cordic_b_dir7 ? (-(linien_cordic_b_x7 >>> 3'd7)) : (linien_cordic_b_x7 >>> 3'd7)));
assign linien_cordic_b_z8 = (linien_cordic_b_z7 + (linien_cordic_b_dir7 ? $signed({1'd0, 16'd41721}) : 17'sd89351));
assign linien_cordic_b_dir8 = (linien_cordic_b_y8 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x9 = (linien_cordic_b_x8 + (linien_cordic_b_dir8 ? (linien_cordic_b_y8 >>> 4'd8) : (-(linien_cordic_b_y8 >>> 4'd8))));
assign linien_cordic_b_y9 = (linien_cordic_b_y8 + (linien_cordic_b_dir8 ? (-(linien_cordic_b_x8 >>> 4'd8)) : (linien_cordic_b_x8 >>> 4'd8)));
assign linien_cordic_b_z9 = (linien_cordic_b_z8 + (linien_cordic_b_dir8 ? $signed({1'd0, 15'd20861}) : 16'sd44675));
assign linien_cordic_b_dir9 = (linien_cordic_b_y9 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x10 = (linien_cordic_b_x9 + (linien_cordic_b_dir9 ? (linien_cordic_b_y9 >>> 4'd9) : (-(linien_cordic_b_y9 >>> 4'd9))));
assign linien_cordic_b_y10 = (linien_cordic_b_y9 + (linien_cordic_b_dir9 ? (-(linien_cordic_b_x9 >>> 4'd9)) : (linien_cordic_b_x9 >>> 4'd9)));
assign linien_cordic_b_z10 = (linien_cordic_b_z9 + (linien_cordic_b_dir9 ? $signed({1'd0, 14'd10430}) : 15'sd22338));
assign linien_cordic_b_dir10 = (linien_cordic_b_y10 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x11 = (linien_cordic_b_x10 + (linien_cordic_b_dir10 ? (linien_cordic_b_y10 >>> 4'd10) : (-(linien_cordic_b_y10 >>> 4'd10))));
assign linien_cordic_b_y11 = (linien_cordic_b_y10 + (linien_cordic_b_dir10 ? (-(linien_cordic_b_x10 >>> 4'd10)) : (linien_cordic_b_x10 >>> 4'd10)));
assign linien_cordic_b_z11 = (linien_cordic_b_z10 + (linien_cordic_b_dir10 ? $signed({1'd0, 13'd5215}) : 14'sd11169));
assign linien_cordic_b_dir11 = (linien_cordic_b_y11 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x12 = (linien_cordic_b_x11 + (linien_cordic_b_dir11 ? (linien_cordic_b_y11 >>> 4'd11) : (-(linien_cordic_b_y11 >>> 4'd11))));
assign linien_cordic_b_y12 = (linien_cordic_b_y11 + (linien_cordic_b_dir11 ? (-(linien_cordic_b_x11 >>> 4'd11)) : (linien_cordic_b_x11 >>> 4'd11)));
assign linien_cordic_b_z12 = (linien_cordic_b_z11 + (linien_cordic_b_dir11 ? $signed({1'd0, 12'd2608}) : 13'sd5584));
assign linien_cordic_b_dir12 = (linien_cordic_b_y12 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x13 = (linien_cordic_b_x12 + (linien_cordic_b_dir12 ? (linien_cordic_b_y12 >>> 4'd12) : (-(linien_cordic_b_y12 >>> 4'd12))));
assign linien_cordic_b_y13 = (linien_cordic_b_y12 + (linien_cordic_b_dir12 ? (-(linien_cordic_b_x12 >>> 4'd12)) : (linien_cordic_b_x12 >>> 4'd12)));
assign linien_cordic_b_z13 = (linien_cordic_b_z12 + (linien_cordic_b_dir12 ? $signed({1'd0, 11'd1304}) : 12'sd2792));
assign linien_cordic_b_dir13 = (linien_cordic_b_y13 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x14 = (linien_cordic_b_x13 + (linien_cordic_b_dir13 ? (linien_cordic_b_y13 >>> 4'd13) : (-(linien_cordic_b_y13 >>> 4'd13))));
assign linien_cordic_b_y14 = (linien_cordic_b_y13 + (linien_cordic_b_dir13 ? (-(linien_cordic_b_x13 >>> 4'd13)) : (linien_cordic_b_x13 >>> 4'd13)));
assign linien_cordic_b_z14 = (linien_cordic_b_z13 + (linien_cordic_b_dir13 ? $signed({1'd0, 10'd652}) : 11'sd1396));
assign linien_cordic_b_dir14 = (linien_cordic_b_y14 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x15 = (linien_cordic_b_x14 + (linien_cordic_b_dir14 ? (linien_cordic_b_y14 >>> 4'd14) : (-(linien_cordic_b_y14 >>> 4'd14))));
assign linien_cordic_b_y15 = (linien_cordic_b_y14 + (linien_cordic_b_dir14 ? (-(linien_cordic_b_x14 >>> 4'd14)) : (linien_cordic_b_x14 >>> 4'd14)));
assign linien_cordic_b_z15 = (linien_cordic_b_z14 + (linien_cordic_b_dir14 ? $signed({1'd0, 9'd326}) : 10'sd698));
assign linien_cordic_b_dir15 = (linien_cordic_b_y15 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x16 = (linien_cordic_b_x15 + (linien_cordic_b_dir15 ? (linien_cordic_b_y15 >>> 4'd15) : (-(linien_cordic_b_y15 >>> 4'd15))));
assign linien_cordic_b_y16 = (linien_cordic_b_y15 + (linien_cordic_b_dir15 ? (-(linien_cordic_b_x15 >>> 4'd15)) : (linien_cordic_b_x15 >>> 4'd15)));
assign linien_cordic_b_z16 = (linien_cordic_b_z15 + (linien_cordic_b_dir15 ? $signed({1'd0, 8'd163}) : 9'sd349));
assign linien_cordic_b_dir16 = (linien_cordic_b_y16 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x17 = (linien_cordic_b_x16 + (linien_cordic_b_dir16 ? (linien_cordic_b_y16 >>> 5'd16) : (-(linien_cordic_b_y16 >>> 5'd16))));
assign linien_cordic_b_y17 = (linien_cordic_b_y16 + (linien_cordic_b_dir16 ? (-(linien_cordic_b_x16 >>> 5'd16)) : (linien_cordic_b_x16 >>> 5'd16)));
assign linien_cordic_b_z17 = (linien_cordic_b_z16 + (linien_cordic_b_dir16 ? $signed({1'd0, 7'd81}) : 8'sd175));
assign linien_cordic_b_dir17 = (linien_cordic_b_y17 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x18 = (linien_cordic_b_x17 + (linien_cordic_b_dir17 ? (linien_cordic_b_y17 >>> 5'd17) : (-(linien_cordic_b_y17 >>> 5'd17))));
assign linien_cordic_b_y18 = (linien_cordic_b_y17 + (linien_cordic_b_dir17 ? (-(linien_cordic_b_x17 >>> 5'd17)) : (linien_cordic_b_x17 >>> 5'd17)));
assign linien_cordic_b_z18 = (linien_cordic_b_z17 + (linien_cordic_b_dir17 ? $signed({1'd0, 6'd41}) : 7'sd87));
assign linien_cordic_b_dir18 = (linien_cordic_b_y18 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x19 = (linien_cordic_b_x18 + (linien_cordic_b_dir18 ? (linien_cordic_b_y18 >>> 5'd18) : (-(linien_cordic_b_y18 >>> 5'd18))));
assign linien_cordic_b_y19 = (linien_cordic_b_y18 + (linien_cordic_b_dir18 ? (-(linien_cordic_b_x18 >>> 5'd18)) : (linien_cordic_b_x18 >>> 5'd18)));
assign linien_cordic_b_z19 = (linien_cordic_b_z18 + (linien_cordic_b_dir18 ? $signed({1'd0, 5'd20}) : 6'sd44));
assign linien_cordic_b_dir19 = (linien_cordic_b_y19 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x20 = (linien_cordic_b_x19 + (linien_cordic_b_dir19 ? (linien_cordic_b_y19 >>> 5'd19) : (-(linien_cordic_b_y19 >>> 5'd19))));
assign linien_cordic_b_y20 = (linien_cordic_b_y19 + (linien_cordic_b_dir19 ? (-(linien_cordic_b_x19 >>> 5'd19)) : (linien_cordic_b_x19 >>> 5'd19)));
assign linien_cordic_b_z20 = (linien_cordic_b_z19 + (linien_cordic_b_dir19 ? $signed({1'd0, 4'd10}) : 5'sd22));
assign linien_cordic_b_dir20 = (linien_cordic_b_y20 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x21 = (linien_cordic_b_x20 + (linien_cordic_b_dir20 ? (linien_cordic_b_y20 >>> 5'd20) : (-(linien_cordic_b_y20 >>> 5'd20))));
assign linien_cordic_b_y21 = (linien_cordic_b_y20 + (linien_cordic_b_dir20 ? (-(linien_cordic_b_x20 >>> 5'd20)) : (linien_cordic_b_x20 >>> 5'd20)));
assign linien_cordic_b_z21 = (linien_cordic_b_z20 + (linien_cordic_b_dir20 ? $signed({1'd0, 3'd5}) : 4'sd11));
assign linien_cordic_b_dir21 = (linien_cordic_b_y21 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x22 = (linien_cordic_b_x21 + (linien_cordic_b_dir21 ? (linien_cordic_b_y21 >>> 5'd21) : (-(linien_cordic_b_y21 >>> 5'd21))));
assign linien_cordic_b_y22 = (linien_cordic_b_y21 + (linien_cordic_b_dir21 ? (-(linien_cordic_b_x21 >>> 5'd21)) : (linien_cordic_b_x21 >>> 5'd21)));
assign linien_cordic_b_z22 = (linien_cordic_b_z21 + (linien_cordic_b_dir21 ? $signed({1'd0, 2'd3}) : 3'sd5));
assign linien_cordic_b_dir22 = (linien_cordic_b_y22 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x23 = (linien_cordic_b_x22 + (linien_cordic_b_dir22 ? (linien_cordic_b_y22 >>> 5'd22) : (-(linien_cordic_b_y22 >>> 5'd22))));
assign linien_cordic_b_y23 = (linien_cordic_b_y22 + (linien_cordic_b_dir22 ? (-(linien_cordic_b_x22 >>> 5'd22)) : (linien_cordic_b_x22 >>> 5'd22)));
assign linien_cordic_b_z23 = (linien_cordic_b_z22 + (linien_cordic_b_dir22 ? $signed({1'd0, 1'd1}) : 1'sd1));
assign linien_cordic_b_dir23 = (linien_cordic_b_y23 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x24 = (linien_cordic_b_x23 + (linien_cordic_b_dir23 ? (linien_cordic_b_y23 >>> 5'd23) : (-(linien_cordic_b_y23 >>> 5'd23))));
assign linien_cordic_b_y24 = (linien_cordic_b_y23 + (linien_cordic_b_dir23 ? (-(linien_cordic_b_x23 >>> 5'd23)) : (linien_cordic_b_x23 >>> 5'd23)));
assign linien_cordic_b_z24 = (linien_cordic_b_z23 + (linien_cordic_b_dir23 ? $signed({1'd0, 1'd1}) : 1'sd1));
assign linien_cordic_b_dir24 = (linien_cordic_b_y24 >= $signed({1'd0, 1'd0}));
assign linien_cordic_b_x25 = (linien_cordic_b_x24 + (linien_cordic_b_dir24 ? (linien_cordic_b_y24 >>> 5'd24) : (-(linien_cordic_b_y24 >>> 5'd24))));
assign linien_cordic_b_y25 = (linien_cordic_b_y24 + (linien_cordic_b_dir24 ? (-(linien_cordic_b_x24 >>> 5'd24)) : (linien_cordic_b_x24 >>> 5'd24)));
assign linien_cordic_b_z25 = (linien_cordic_b_z24 + $signed({1'd0, (linien_cordic_b_dir24 ? 1'd0 : 1'd0)}));
assign linien_cordic_b_q = (linien_cordic_b_xi1 < $signed({1'd0, 1'd0}));

// synthesis translate_off
reg dummy_d_26;
// synthesis translate_on
always @(*) begin
	linien_cordic_b_xi0 <= 25'sd0;
	linien_cordic_b_yi0 <= 25'sd0;
	linien_cordic_b_zi0 <= 25'sd0;
	if (linien_cordic_b_q) begin
		{linien_cordic_b_zi0, linien_cordic_b_yi0, linien_cordic_b_xi0} <= {(linien_cordic_b_zi1 + $signed({1'd0, 25'd16777216})), (-linien_cordic_b_yi1), (-linien_cordic_b_xi1)};
	end else begin
		{linien_cordic_b_zi0, linien_cordic_b_yi0, linien_cordic_b_xi0} <= {linien_cordic_b_zi1, linien_cordic_b_yi1, linien_cordic_b_xi1};
	end
// synthesis translate_off
	dummy_d_26 <= dummy_s;
// synthesis translate_on
end
assign linien_divider_n_sign = linien_divider_num[24];
assign linien_divider_d_sign = linien_divider_den[24];
assign linien_divider_n_abs = (linien_divider_n_sign ? (-linien_divider_num) : linien_divider_num);
assign linien_divider_d_abs = (linien_divider_d_sign ? (-linien_divider_den) : linien_divider_den);
assign linien_divider_q_sign = (linien_divider_n_sign ^ linien_divider_d_sign);
assign linien_divider_n_abs_scaled = (linien_divider_n_abs <<< 4'd10);
assign linien_divider_r_sub0 = ({linien_divider_r0[24:0], linien_divider_q0[34]} - linien_divider_d0);
assign linien_divider_sub_success0 = (linien_divider_r_sub0[25] == 1'd0);
assign linien_divider_r_sub1 = ({linien_divider_r1[24:0], linien_divider_q1[34]} - linien_divider_d1);
assign linien_divider_sub_success1 = (linien_divider_r_sub1[25] == 1'd0);
assign linien_divider_r_sub2 = ({linien_divider_r2[24:0], linien_divider_q2[34]} - linien_divider_d2);
assign linien_divider_sub_success2 = (linien_divider_r_sub2[25] == 1'd0);
assign linien_divider_r_sub3 = ({linien_divider_r3[24:0], linien_divider_q3[34]} - linien_divider_d3);
assign linien_divider_sub_success3 = (linien_divider_r_sub3[25] == 1'd0);
assign linien_divider_r_sub4 = ({linien_divider_r4[24:0], linien_divider_q4[34]} - linien_divider_d4);
assign linien_divider_sub_success4 = (linien_divider_r_sub4[25] == 1'd0);
assign linien_divider_r_sub5 = ({linien_divider_r5[24:0], linien_divider_q5[34]} - linien_divider_d5);
assign linien_divider_sub_success5 = (linien_divider_r_sub5[25] == 1'd0);
assign linien_divider_r_sub6 = ({linien_divider_r6[24:0], linien_divider_q6[34]} - linien_divider_d6);
assign linien_divider_sub_success6 = (linien_divider_r_sub6[25] == 1'd0);
assign linien_divider_r_sub7 = ({linien_divider_r7[24:0], linien_divider_q7[34]} - linien_divider_d7);
assign linien_divider_sub_success7 = (linien_divider_r_sub7[25] == 1'd0);
assign linien_divider_r_sub8 = ({linien_divider_r8[24:0], linien_divider_q8[34]} - linien_divider_d8);
assign linien_divider_sub_success8 = (linien_divider_r_sub8[25] == 1'd0);
assign linien_divider_r_sub9 = ({linien_divider_r9[24:0], linien_divider_q9[34]} - linien_divider_d9);
assign linien_divider_sub_success9 = (linien_divider_r_sub9[25] == 1'd0);
assign linien_divider_r_sub10 = ({linien_divider_r10[24:0], linien_divider_q10[34]} - linien_divider_d10);
assign linien_divider_sub_success10 = (linien_divider_r_sub10[25] == 1'd0);
assign linien_divider_r_sub11 = ({linien_divider_r11[24:0], linien_divider_q11[34]} - linien_divider_d11);
assign linien_divider_sub_success11 = (linien_divider_r_sub11[25] == 1'd0);
assign linien_divider_r_sub12 = ({linien_divider_r12[24:0], linien_divider_q12[34]} - linien_divider_d12);
assign linien_divider_sub_success12 = (linien_divider_r_sub12[25] == 1'd0);
assign linien_divider_r_sub13 = ({linien_divider_r13[24:0], linien_divider_q13[34]} - linien_divider_d13);
assign linien_divider_sub_success13 = (linien_divider_r_sub13[25] == 1'd0);
assign linien_divider_r_sub14 = ({linien_divider_r14[24:0], linien_divider_q14[34]} - linien_divider_d14);
assign linien_divider_sub_success14 = (linien_divider_r_sub14[25] == 1'd0);
assign linien_divider_r_sub15 = ({linien_divider_r15[24:0], linien_divider_q15[34]} - linien_divider_d15);
assign linien_divider_sub_success15 = (linien_divider_r_sub15[25] == 1'd0);
assign linien_divider_r_sub16 = ({linien_divider_r16[24:0], linien_divider_q16[34]} - linien_divider_d16);
assign linien_divider_sub_success16 = (linien_divider_r_sub16[25] == 1'd0);
assign linien_divider_r_sub17 = ({linien_divider_r17[24:0], linien_divider_q17[34]} - linien_divider_d17);
assign linien_divider_sub_success17 = (linien_divider_r_sub17[25] == 1'd0);
assign linien_divider_r_sub18 = ({linien_divider_r18[24:0], linien_divider_q18[34]} - linien_divider_d18);
assign linien_divider_sub_success18 = (linien_divider_r_sub18[25] == 1'd0);
assign linien_divider_r_sub19 = ({linien_divider_r19[24:0], linien_divider_q19[34]} - linien_divider_d19);
assign linien_divider_sub_success19 = (linien_divider_r_sub19[25] == 1'd0);
assign linien_divider_r_sub20 = ({linien_divider_r20[24:0], linien_divider_q20[34]} - linien_divider_d20);
assign linien_divider_sub_success20 = (linien_divider_r_sub20[25] == 1'd0);
assign linien_divider_r_sub21 = ({linien_divider_r21[24:0], linien_divider_q21[34]} - linien_divider_d21);
assign linien_divider_sub_success21 = (linien_divider_r_sub21[25] == 1'd0);
assign linien_divider_r_sub22 = ({linien_divider_r22[24:0], linien_divider_q22[34]} - linien_divider_d22);
assign linien_divider_sub_success22 = (linien_divider_r_sub22[25] == 1'd0);
assign linien_divider_r_sub23 = ({linien_divider_r23[24:0], linien_divider_q23[34]} - linien_divider_d23);
assign linien_divider_sub_success23 = (linien_divider_r_sub23[25] == 1'd0);
assign linien_divider_r_sub24 = ({linien_divider_r24[24:0], linien_divider_q24[34]} - linien_divider_d24);
assign linien_divider_sub_success24 = (linien_divider_r_sub24[25] == 1'd0);
assign linien_divider_r_sub25 = ({linien_divider_r25[24:0], linien_divider_q25[34]} - linien_divider_d25);
assign linien_divider_sub_success25 = (linien_divider_r_sub25[25] == 1'd0);
assign linien_divider_r_sub26 = ({linien_divider_r26[24:0], linien_divider_q26[34]} - linien_divider_d26);
assign linien_divider_sub_success26 = (linien_divider_r_sub26[25] == 1'd0);
assign linien_divider_r_sub27 = ({linien_divider_r27[24:0], linien_divider_q27[34]} - linien_divider_d27);
assign linien_divider_sub_success27 = (linien_divider_r_sub27[25] == 1'd0);
assign linien_divider_r_sub28 = ({linien_divider_r28[24:0], linien_divider_q28[34]} - linien_divider_d28);
assign linien_divider_sub_success28 = (linien_divider_r_sub28[25] == 1'd0);
assign linien_divider_r_sub29 = ({linien_divider_r29[24:0], linien_divider_q29[34]} - linien_divider_d29);
assign linien_divider_sub_success29 = (linien_divider_r_sub29[25] == 1'd0);
assign linien_divider_r_sub30 = ({linien_divider_r30[24:0], linien_divider_q30[34]} - linien_divider_d30);
assign linien_divider_sub_success30 = (linien_divider_r_sub30[25] == 1'd0);
assign linien_divider_r_sub31 = ({linien_divider_r31[24:0], linien_divider_q31[34]} - linien_divider_d31);
assign linien_divider_sub_success31 = (linien_divider_r_sub31[25] == 1'd0);
assign linien_divider_r_sub32 = ({linien_divider_r32[24:0], linien_divider_q32[34]} - linien_divider_d32);
assign linien_divider_sub_success32 = (linien_divider_r_sub32[25] == 1'd0);
assign linien_divider_r_sub33 = ({linien_divider_r33[24:0], linien_divider_q33[34]} - linien_divider_d33);
assign linien_divider_sub_success33 = (linien_divider_r_sub33[25] == 1'd0);
assign linien_divider_r_sub34 = ({linien_divider_r34[24:0], linien_divider_q34[34]} - linien_divider_d34);
assign linien_divider_sub_success34 = (linien_divider_r_sub34[25] == 1'd0);
assign linien_divider_q_final_trunc = linien_divider_quo35[24:0];
assign linien_divider_busy = (((((((((((((((((((((((((((((((((((linien_divider_v0 | linien_divider_v1) | linien_divider_v2) | linien_divider_v3) | linien_divider_v4) | linien_divider_v5) | linien_divider_v6) | linien_divider_v7) | linien_divider_v8) | linien_divider_v9) | linien_divider_v10) | linien_divider_v11) | linien_divider_v12) | linien_divider_v13) | linien_divider_v14) | linien_divider_v15) | linien_divider_v16) | linien_divider_v17) | linien_divider_v18) | linien_divider_v19) | linien_divider_v20) | linien_divider_v21) | linien_divider_v22) | linien_divider_v23) | linien_divider_v24) | linien_divider_v25) | linien_divider_v26) | linien_divider_v27) | linien_divider_v28) | linien_divider_v29) | linien_divider_v30) | linien_divider_v31) | linien_divider_v32) | linien_divider_v33) | linien_divider_v34) | linien_divider_v35);
assign linien_time_command_out = linien_current_output_time;
assign linien_fsm_state_status_status = linien_fsm_state;
assign linien_time_command_out_status_status = linien_time_command_out;
assign linien_sig_status11 = linien_time_command_out;

// synthesis translate_off
reg dummy_d_27;
// synthesis translate_on
always @(*) begin
	linien_fsm_state <= 2'd0;
	linien_sweep_center <= 25'sd0;
	linien_sweep_span <= 25'sd0;
	linien_is_ongoing0 <= 1'd0;
	linien_is_ongoing1 <= 1'd0;
	linien_is_ongoing2 <= 1'd0;
	linien_is_ongoing3 <= 1'd0;
	next_state <= 2'd0;
	next_state <= state;
	case (state)
		1'd1: begin
			linien_fsm_state <= 1'd1;
			linien_sweep_center <= linien_kalman_est_time;
			linien_sweep_span <= (linien_kalman_est_uncertainty * 2'd3);
			if (((linien_kalman_est_uncertainty < 9'd500) & (linien_power_level > linien_power_threshold_acquire))) begin
				next_state <= 2'd2;
			end else begin
				if ((linien_narrow_search_timeout_counter >= 27'd125000000)) begin
					next_state <= 1'd0;
				end
			end
			linien_is_ongoing1 <= 1'd1;
			linien_is_ongoing3 <= 1'd1;
		end
		2'd2: begin
			linien_fsm_state <= 2'd2;
			linien_sweep_center <= 1'd0;
			linien_sweep_span <= 1'd0;
			linien_is_ongoing2 <= 1'd1;
		end
		default: begin
			linien_fsm_state <= 1'd0;
			linien_sweep_center <= 1'd0;
			linien_sweep_span <= 22'd2500000;
			if ((linien_power_level > linien_power_threshold_acquire)) begin
				next_state <= 1'd1;
			end
			linien_is_ongoing0 <= 1'd1;
		end
	endcase
// synthesis translate_off
	dummy_d_27 <= dummy_s;
// synthesis translate_on
end
assign linien_scopegen_dac_a = (linien_scopegen_asg_a <<< 4'd11);
assign linien_scopegen_dac_b = (linien_scopegen_asg_b <<< 4'd11);
assign linien_sig_status8 = linien_scopegen_dac_a;
assign linien_sig_status9 = linien_scopegen_dac_b;
assign linien_sine_source_index = linien_sine_source_phase[31:22];
assign linien_sine_source_output = comb_array_muxed4;
assign linien_csrbank0_sel = (linien_interface0_bank_bus_adr[13:9] == 5'd28);
assign linien_csrbank0_dna7_r = linien_interface0_bank_bus_dat_w[7:0];
assign linien_csrbank0_dna7_re = ((linien_csrbank0_sel & linien_interface0_bank_bus_we) & (linien_interface0_bank_bus_adr[2:0] == 1'd0));
assign linien_csrbank0_dna6_r = linien_interface0_bank_bus_dat_w[7:0];
assign linien_csrbank0_dna6_re = ((linien_csrbank0_sel & linien_interface0_bank_bus_we) & (linien_interface0_bank_bus_adr[2:0] == 1'd1));
assign linien_csrbank0_dna5_r = linien_interface0_bank_bus_dat_w[7:0];
assign linien_csrbank0_dna5_re = ((linien_csrbank0_sel & linien_interface0_bank_bus_we) & (linien_interface0_bank_bus_adr[2:0] == 2'd2));
assign linien_csrbank0_dna4_r = linien_interface0_bank_bus_dat_w[7:0];
assign linien_csrbank0_dna4_re = ((linien_csrbank0_sel & linien_interface0_bank_bus_we) & (linien_interface0_bank_bus_adr[2:0] == 2'd3));
assign linien_csrbank0_dna3_r = linien_interface0_bank_bus_dat_w[7:0];
assign linien_csrbank0_dna3_re = ((linien_csrbank0_sel & linien_interface0_bank_bus_we) & (linien_interface0_bank_bus_adr[2:0] == 3'd4));
assign linien_csrbank0_dna2_r = linien_interface0_bank_bus_dat_w[7:0];
assign linien_csrbank0_dna2_re = ((linien_csrbank0_sel & linien_interface0_bank_bus_we) & (linien_interface0_bank_bus_adr[2:0] == 3'd5));
assign linien_csrbank0_dna1_r = linien_interface0_bank_bus_dat_w[7:0];
assign linien_csrbank0_dna1_re = ((linien_csrbank0_sel & linien_interface0_bank_bus_we) & (linien_interface0_bank_bus_adr[2:0] == 3'd6));
assign linien_csrbank0_dna0_r = linien_interface0_bank_bus_dat_w[7:0];
assign linien_csrbank0_dna0_re = ((linien_csrbank0_sel & linien_interface0_bank_bus_we) & (linien_interface0_bank_bus_adr[2:0] == 3'd7));
assign linien_csrbank0_dna7_w = linien_dna_status[63:56];
assign linien_csrbank0_dna6_w = linien_dna_status[55:48];
assign linien_csrbank0_dna5_w = linien_dna_status[47:40];
assign linien_csrbank0_dna4_w = linien_dna_status[39:32];
assign linien_csrbank0_dna3_w = linien_dna_status[31:24];
assign linien_csrbank0_dna2_w = linien_dna_status[23:16];
assign linien_csrbank0_dna1_w = linien_dna_status[15:8];
assign linien_csrbank0_dna0_w = linien_dna_status[7:0];
assign linien_csrbank1_sel = (linien_interface1_bank_bus_adr[13:9] == 4'd9);
assign linien_csrbank1_out_e3_r = linien_interface1_bank_bus_dat_w[0];
assign linien_csrbank1_out_e3_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 1'd0));
assign linien_csrbank1_out_e2_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_out_e2_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 1'd1));
assign linien_csrbank1_out_e1_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_out_e1_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 2'd2));
assign linien_csrbank1_out_e0_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_out_e0_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 2'd3));
assign linien_csrbank1_power_signal_out3_r = linien_interface1_bank_bus_dat_w[0];
assign linien_csrbank1_power_signal_out3_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 3'd4));
assign linien_csrbank1_power_signal_out2_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_power_signal_out2_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 3'd5));
assign linien_csrbank1_power_signal_out1_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_power_signal_out1_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 3'd6));
assign linien_csrbank1_power_signal_out0_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_power_signal_out0_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 3'd7));
assign linien_out_e_clr_r = linien_interface1_bank_bus_dat_w[0];
assign linien_out_e_clr_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 4'd8));
assign linien_csrbank1_out_e_max3_r = linien_interface1_bank_bus_dat_w[0];
assign linien_csrbank1_out_e_max3_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 4'd9));
assign linien_csrbank1_out_e_max2_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_out_e_max2_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 4'd10));
assign linien_csrbank1_out_e_max1_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_out_e_max1_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 4'd11));
assign linien_csrbank1_out_e_max0_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_out_e_max0_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 4'd12));
assign linien_csrbank1_out_e_min3_r = linien_interface1_bank_bus_dat_w[0];
assign linien_csrbank1_out_e_min3_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 4'd13));
assign linien_csrbank1_out_e_min2_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_out_e_min2_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 4'd14));
assign linien_csrbank1_out_e_min1_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_out_e_min1_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 4'd15));
assign linien_csrbank1_out_e_min0_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_out_e_min0_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd16));
assign linien_power_signal_out_clr_r = linien_interface1_bank_bus_dat_w[0];
assign linien_power_signal_out_clr_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd17));
assign linien_csrbank1_power_signal_out_max3_r = linien_interface1_bank_bus_dat_w[0];
assign linien_csrbank1_power_signal_out_max3_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd18));
assign linien_csrbank1_power_signal_out_max2_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_power_signal_out_max2_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd19));
assign linien_csrbank1_power_signal_out_max1_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_power_signal_out_max1_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd20));
assign linien_csrbank1_power_signal_out_max0_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_power_signal_out_max0_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd21));
assign linien_csrbank1_power_signal_out_min3_r = linien_interface1_bank_bus_dat_w[0];
assign linien_csrbank1_power_signal_out_min3_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd22));
assign linien_csrbank1_power_signal_out_min2_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_power_signal_out_min2_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd23));
assign linien_csrbank1_power_signal_out_min1_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_power_signal_out_min1_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd24));
assign linien_csrbank1_power_signal_out_min0_r = linien_interface1_bank_bus_dat_w[7:0];
assign linien_csrbank1_power_signal_out_min0_re = ((linien_csrbank1_sel & linien_interface1_bank_bus_we) & (linien_interface1_bank_bus_adr[4:0] == 5'd25));
assign linien_csrbank1_out_e3_w = linien_csr_out_e_status[24];
assign linien_csrbank1_out_e2_w = linien_csr_out_e_status[23:16];
assign linien_csrbank1_out_e1_w = linien_csr_out_e_status[15:8];
assign linien_csrbank1_out_e0_w = linien_csr_out_e_status[7:0];
assign linien_csrbank1_power_signal_out3_w = linien_csr_power_signal_out_status[24];
assign linien_csrbank1_power_signal_out2_w = linien_csr_power_signal_out_status[23:16];
assign linien_csrbank1_power_signal_out1_w = linien_csr_power_signal_out_status[15:8];
assign linien_csrbank1_power_signal_out0_w = linien_csr_power_signal_out_status[7:0];
assign linien_csrbank1_out_e_max3_w = linien_max_status6[24];
assign linien_csrbank1_out_e_max2_w = linien_max_status6[23:16];
assign linien_csrbank1_out_e_max1_w = linien_max_status6[15:8];
assign linien_csrbank1_out_e_max0_w = linien_max_status6[7:0];
assign linien_csrbank1_out_e_min3_w = linien_min_status6[24];
assign linien_csrbank1_out_e_min2_w = linien_min_status6[23:16];
assign linien_csrbank1_out_e_min1_w = linien_min_status6[15:8];
assign linien_csrbank1_out_e_min0_w = linien_min_status6[7:0];
assign linien_csrbank1_power_signal_out_max3_w = linien_max_status7[24];
assign linien_csrbank1_power_signal_out_max2_w = linien_max_status7[23:16];
assign linien_csrbank1_power_signal_out_max1_w = linien_max_status7[15:8];
assign linien_csrbank1_power_signal_out_max0_w = linien_max_status7[7:0];
assign linien_csrbank1_power_signal_out_min3_w = linien_min_status7[24];
assign linien_csrbank1_power_signal_out_min2_w = linien_min_status7[23:16];
assign linien_csrbank1_power_signal_out_min1_w = linien_min_status7[15:8];
assign linien_csrbank1_power_signal_out_min0_w = linien_min_status7[7:0];
assign linien_csrbank2_sel = (linien_interface2_bank_bus_adr[13:9] == 1'd0);
assign linien_csrbank2_y_tap0_r = linien_interface2_bank_bus_dat_w[1:0];
assign linien_csrbank2_y_tap0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 1'd0));
assign linien_csrbank2_invert0_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_invert0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 1'd1));
assign linien_csrbank2_demod_delay3_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_demod_delay3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 2'd2));
assign linien_csrbank2_demod_delay2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_demod_delay2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 2'd3));
assign linien_csrbank2_demod_delay1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_demod_delay1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 3'd4));
assign linien_csrbank2_demod_delay0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_demod_delay0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 3'd5));
assign linien_csrbank2_demod_multiplier0_r = linien_interface2_bank_bus_dat_w[3:0];
assign linien_csrbank2_demod_multiplier0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 3'd6));
assign linien_csrbank2_x_limit_1_min3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_x_limit_1_min3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 3'd7));
assign linien_csrbank2_x_limit_1_min2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_1_min2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 4'd8));
assign linien_csrbank2_x_limit_1_min1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_1_min1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 4'd9));
assign linien_csrbank2_x_limit_1_min0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_1_min0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 4'd10));
assign linien_csrbank2_x_limit_1_max3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_x_limit_1_max3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 4'd11));
assign linien_csrbank2_x_limit_1_max2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_1_max2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 4'd12));
assign linien_csrbank2_x_limit_1_max1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_1_max1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 4'd13));
assign linien_csrbank2_x_limit_1_max0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_1_max0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 4'd14));
assign linien_csrbank2_iir_c_1_z03_r = linien_interface2_bank_bus_dat_w[2:0];
assign linien_csrbank2_iir_c_1_z03_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 4'd15));
assign linien_csrbank2_iir_c_1_z02_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_z02_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd16));
assign linien_csrbank2_iir_c_1_z01_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_z01_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd17));
assign linien_csrbank2_iir_c_1_z00_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_z00_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd18));
assign linien_csrbank2_iir_c_1_a13_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_c_1_a13_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd19));
assign linien_csrbank2_iir_c_1_a12_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_a12_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd20));
assign linien_csrbank2_iir_c_1_a11_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_a11_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd21));
assign linien_csrbank2_iir_c_1_a10_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_a10_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd22));
assign linien_csrbank2_iir_c_1_b03_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_c_1_b03_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd23));
assign linien_csrbank2_iir_c_1_b02_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_b02_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd24));
assign linien_csrbank2_iir_c_1_b01_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_b01_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd25));
assign linien_csrbank2_iir_c_1_b00_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_b00_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd26));
assign linien_csrbank2_iir_c_1_b13_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_c_1_b13_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd27));
assign linien_csrbank2_iir_c_1_b12_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_b12_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd28));
assign linien_csrbank2_iir_c_1_b11_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_b11_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd29));
assign linien_csrbank2_iir_c_1_b10_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_1_b10_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd30));
assign linien_csrbank2_iir_d_1_z03_r = linien_interface2_bank_bus_dat_w[2:0];
assign linien_csrbank2_iir_d_1_z03_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 5'd31));
assign linien_csrbank2_iir_d_1_z02_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_z02_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd32));
assign linien_csrbank2_iir_d_1_z01_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_z01_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd33));
assign linien_csrbank2_iir_d_1_z00_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_z00_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd34));
assign linien_csrbank2_iir_d_1_a13_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_1_a13_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd35));
assign linien_csrbank2_iir_d_1_a12_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_a12_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd36));
assign linien_csrbank2_iir_d_1_a11_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_a11_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd37));
assign linien_csrbank2_iir_d_1_a10_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_a10_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd38));
assign linien_csrbank2_iir_d_1_a23_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_1_a23_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd39));
assign linien_csrbank2_iir_d_1_a22_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_a22_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd40));
assign linien_csrbank2_iir_d_1_a21_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_a21_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd41));
assign linien_csrbank2_iir_d_1_a20_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_a20_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd42));
assign linien_csrbank2_iir_d_1_b03_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_1_b03_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd43));
assign linien_csrbank2_iir_d_1_b02_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_b02_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd44));
assign linien_csrbank2_iir_d_1_b01_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_b01_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd45));
assign linien_csrbank2_iir_d_1_b00_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_b00_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd46));
assign linien_csrbank2_iir_d_1_b13_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_1_b13_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd47));
assign linien_csrbank2_iir_d_1_b12_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_b12_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd48));
assign linien_csrbank2_iir_d_1_b11_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_b11_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd49));
assign linien_csrbank2_iir_d_1_b10_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_b10_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd50));
assign linien_csrbank2_iir_d_1_b23_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_1_b23_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd51));
assign linien_csrbank2_iir_d_1_b22_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_b22_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd52));
assign linien_csrbank2_iir_d_1_b21_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_b21_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd53));
assign linien_csrbank2_iir_d_1_b20_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_1_b20_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd54));
assign linien_csrbank2_y_limit_1_min3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_y_limit_1_min3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd55));
assign linien_csrbank2_y_limit_1_min2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_1_min2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd56));
assign linien_csrbank2_y_limit_1_min1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_1_min1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd57));
assign linien_csrbank2_y_limit_1_min0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_1_min0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd58));
assign linien_csrbank2_y_limit_1_max3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_y_limit_1_max3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd59));
assign linien_csrbank2_y_limit_1_max2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_1_max2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd60));
assign linien_csrbank2_y_limit_1_max1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_1_max1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd61));
assign linien_csrbank2_y_limit_1_max0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_1_max0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd62));
assign linien_csrbank2_x_limit_2_min3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_x_limit_2_min3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 6'd63));
assign linien_csrbank2_x_limit_2_min2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_2_min2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd64));
assign linien_csrbank2_x_limit_2_min1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_2_min1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd65));
assign linien_csrbank2_x_limit_2_min0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_2_min0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd66));
assign linien_csrbank2_x_limit_2_max3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_x_limit_2_max3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd67));
assign linien_csrbank2_x_limit_2_max2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_2_max2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd68));
assign linien_csrbank2_x_limit_2_max1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_2_max1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd69));
assign linien_csrbank2_x_limit_2_max0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_limit_2_max0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd70));
assign linien_csrbank2_iir_c_2_z03_r = linien_interface2_bank_bus_dat_w[2:0];
assign linien_csrbank2_iir_c_2_z03_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd71));
assign linien_csrbank2_iir_c_2_z02_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_z02_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd72));
assign linien_csrbank2_iir_c_2_z01_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_z01_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd73));
assign linien_csrbank2_iir_c_2_z00_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_z00_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd74));
assign linien_csrbank2_iir_c_2_a13_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_c_2_a13_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd75));
assign linien_csrbank2_iir_c_2_a12_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_a12_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd76));
assign linien_csrbank2_iir_c_2_a11_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_a11_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd77));
assign linien_csrbank2_iir_c_2_a10_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_a10_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd78));
assign linien_csrbank2_iir_c_2_b03_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_c_2_b03_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd79));
assign linien_csrbank2_iir_c_2_b02_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_b02_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd80));
assign linien_csrbank2_iir_c_2_b01_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_b01_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd81));
assign linien_csrbank2_iir_c_2_b00_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_b00_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd82));
assign linien_csrbank2_iir_c_2_b13_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_c_2_b13_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd83));
assign linien_csrbank2_iir_c_2_b12_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_b12_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd84));
assign linien_csrbank2_iir_c_2_b11_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_b11_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd85));
assign linien_csrbank2_iir_c_2_b10_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_c_2_b10_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd86));
assign linien_csrbank2_iir_d_2_z03_r = linien_interface2_bank_bus_dat_w[2:0];
assign linien_csrbank2_iir_d_2_z03_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd87));
assign linien_csrbank2_iir_d_2_z02_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_z02_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd88));
assign linien_csrbank2_iir_d_2_z01_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_z01_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd89));
assign linien_csrbank2_iir_d_2_z00_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_z00_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd90));
assign linien_csrbank2_iir_d_2_a13_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_2_a13_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd91));
assign linien_csrbank2_iir_d_2_a12_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_a12_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd92));
assign linien_csrbank2_iir_d_2_a11_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_a11_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd93));
assign linien_csrbank2_iir_d_2_a10_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_a10_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd94));
assign linien_csrbank2_iir_d_2_a23_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_2_a23_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd95));
assign linien_csrbank2_iir_d_2_a22_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_a22_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd96));
assign linien_csrbank2_iir_d_2_a21_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_a21_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd97));
assign linien_csrbank2_iir_d_2_a20_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_a20_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd98));
assign linien_csrbank2_iir_d_2_b03_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_2_b03_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd99));
assign linien_csrbank2_iir_d_2_b02_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_b02_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd100));
assign linien_csrbank2_iir_d_2_b01_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_b01_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd101));
assign linien_csrbank2_iir_d_2_b00_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_b00_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd102));
assign linien_csrbank2_iir_d_2_b13_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_2_b13_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd103));
assign linien_csrbank2_iir_d_2_b12_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_b12_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd104));
assign linien_csrbank2_iir_d_2_b11_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_b11_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd105));
assign linien_csrbank2_iir_d_2_b10_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_b10_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd106));
assign linien_csrbank2_iir_d_2_b23_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_iir_d_2_b23_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd107));
assign linien_csrbank2_iir_d_2_b22_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_b22_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd108));
assign linien_csrbank2_iir_d_2_b21_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_b21_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd109));
assign linien_csrbank2_iir_d_2_b20_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_iir_d_2_b20_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd110));
assign linien_csrbank2_y_limit_2_min3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_y_limit_2_min3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd111));
assign linien_csrbank2_y_limit_2_min2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_2_min2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd112));
assign linien_csrbank2_y_limit_2_min1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_2_min1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd113));
assign linien_csrbank2_y_limit_2_min0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_2_min0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd114));
assign linien_csrbank2_y_limit_2_max3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_y_limit_2_max3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd115));
assign linien_csrbank2_y_limit_2_max2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_2_max2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd116));
assign linien_csrbank2_y_limit_2_max1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_2_max1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd117));
assign linien_csrbank2_y_limit_2_max0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_y_limit_2_max0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd118));
assign linien_csr0_x_clr_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csr0_x_clr_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd119));
assign linien_csrbank2_x_max3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_x_max3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd120));
assign linien_csrbank2_x_max2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_max2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd121));
assign linien_csrbank2_x_max1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_max1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd122));
assign linien_csrbank2_x_max0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_max0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd123));
assign linien_csrbank2_x_min3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_x_min3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd124));
assign linien_csrbank2_x_min2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_min2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd125));
assign linien_csrbank2_x_min1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_min1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd126));
assign linien_csrbank2_x_min0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_x_min0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 7'd127));
assign linien_csr1_out_i_clr_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csr1_out_i_clr_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd128));
assign linien_csrbank2_out_i_max3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_out_i_max3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd129));
assign linien_csrbank2_out_i_max2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_i_max2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd130));
assign linien_csrbank2_out_i_max1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_i_max1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd131));
assign linien_csrbank2_out_i_max0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_i_max0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd132));
assign linien_csrbank2_out_i_min3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_out_i_min3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd133));
assign linien_csrbank2_out_i_min2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_i_min2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd134));
assign linien_csrbank2_out_i_min1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_i_min1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd135));
assign linien_csrbank2_out_i_min0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_i_min0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd136));
assign linien_csr2_out_q_clr_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csr2_out_q_clr_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd137));
assign linien_csrbank2_out_q_max3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_out_q_max3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd138));
assign linien_csrbank2_out_q_max2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_q_max2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd139));
assign linien_csrbank2_out_q_max1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_q_max1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd140));
assign linien_csrbank2_out_q_max0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_q_max0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd141));
assign linien_csrbank2_out_q_min3_r = linien_interface2_bank_bus_dat_w[0];
assign linien_csrbank2_out_q_min3_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd142));
assign linien_csrbank2_out_q_min2_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_q_min2_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd143));
assign linien_csrbank2_out_q_min1_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_q_min1_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd144));
assign linien_csrbank2_out_q_min0_r = linien_interface2_bank_bus_dat_w[7:0];
assign linien_csrbank2_out_q_min0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd145));
assign linien_csrbank2_dx_sel0_r = linien_interface2_bank_bus_dat_w[3:0];
assign linien_csrbank2_dx_sel0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd146));
assign linien_csrbank2_dy_sel0_r = linien_interface2_bank_bus_dat_w[3:0];
assign linien_csrbank2_dy_sel0_re = ((linien_csrbank2_sel & linien_interface2_bank_bus_we) & (linien_interface2_bank_bus_adr[7:0] == 8'd147));
assign linien_fast_a_y_tap_storage = linien_fast_a_y_tap_storage_full[1:0];
assign linien_csrbank2_y_tap0_w = linien_fast_a_y_tap_storage_full[1:0];
assign linien_fast_a_invert_storage = linien_fast_a_invert_storage_full;
assign linien_csrbank2_invert0_w = linien_fast_a_invert_storage_full;
assign linien_fast_a_delay_storage = linien_fast_a_delay_storage_full[31:0];
assign linien_csrbank2_demod_delay3_w = linien_fast_a_delay_storage_full[31:24];
assign linien_csrbank2_demod_delay2_w = linien_fast_a_delay_storage_full[23:16];
assign linien_csrbank2_demod_delay1_w = linien_fast_a_delay_storage_full[15:8];
assign linien_csrbank2_demod_delay0_w = linien_fast_a_delay_storage_full[7:0];
assign linien_fast_a_multiplier_storage = linien_fast_a_multiplier_storage_full[3:0];
assign linien_csrbank2_demod_multiplier0_w = linien_fast_a_multiplier_storage_full[3:0];
assign linien_fast_a_limitcsr0_min_storage0 = linien_fast_a_limitcsr0_min_storage_full0[24:0];
assign linien_csrbank2_x_limit_1_min3_w = linien_fast_a_limitcsr0_min_storage_full0[24];
assign linien_csrbank2_x_limit_1_min2_w = linien_fast_a_limitcsr0_min_storage_full0[23:16];
assign linien_csrbank2_x_limit_1_min1_w = linien_fast_a_limitcsr0_min_storage_full0[15:8];
assign linien_csrbank2_x_limit_1_min0_w = linien_fast_a_limitcsr0_min_storage_full0[7:0];
assign linien_fast_a_limitcsr0_max_storage0 = linien_fast_a_limitcsr0_max_storage_full0[24:0];
assign linien_csrbank2_x_limit_1_max3_w = linien_fast_a_limitcsr0_max_storage_full0[24];
assign linien_csrbank2_x_limit_1_max2_w = linien_fast_a_limitcsr0_max_storage_full0[23:16];
assign linien_csrbank2_x_limit_1_max1_w = linien_fast_a_limitcsr0_max_storage_full0[15:8];
assign linien_csrbank2_x_limit_1_max0_w = linien_fast_a_limitcsr0_max_storage_full0[7:0];
assign linien_fast_a_iir0_storage0 = linien_fast_a_iir0_storage_full0[26:0];
assign linien_csrbank2_iir_c_1_z03_w = linien_fast_a_iir0_storage_full0[26:24];
assign linien_csrbank2_iir_c_1_z02_w = linien_fast_a_iir0_storage_full0[23:16];
assign linien_csrbank2_iir_c_1_z01_w = linien_fast_a_iir0_storage_full0[15:8];
assign linien_csrbank2_iir_c_1_z00_w = linien_fast_a_iir0_storage_full0[7:0];
assign linien_fast_a_iir0_csrstorage0_storage0 = linien_fast_a_iir0_csrstorage0_storage_full0[24:0];
assign linien_csrbank2_iir_c_1_a13_w = linien_fast_a_iir0_csrstorage0_storage_full0[24];
assign linien_csrbank2_iir_c_1_a12_w = linien_fast_a_iir0_csrstorage0_storage_full0[23:16];
assign linien_csrbank2_iir_c_1_a11_w = linien_fast_a_iir0_csrstorage0_storage_full0[15:8];
assign linien_csrbank2_iir_c_1_a10_w = linien_fast_a_iir0_csrstorage0_storage_full0[7:0];
assign linien_fast_a_iir0_csrstorage1_storage0 = linien_fast_a_iir0_csrstorage1_storage_full0[24:0];
assign linien_csrbank2_iir_c_1_b03_w = linien_fast_a_iir0_csrstorage1_storage_full0[24];
assign linien_csrbank2_iir_c_1_b02_w = linien_fast_a_iir0_csrstorage1_storage_full0[23:16];
assign linien_csrbank2_iir_c_1_b01_w = linien_fast_a_iir0_csrstorage1_storage_full0[15:8];
assign linien_csrbank2_iir_c_1_b00_w = linien_fast_a_iir0_csrstorage1_storage_full0[7:0];
assign linien_fast_a_iir0_csrstorage2_storage0 = linien_fast_a_iir0_csrstorage2_storage_full0[24:0];
assign linien_csrbank2_iir_c_1_b13_w = linien_fast_a_iir0_csrstorage2_storage_full0[24];
assign linien_csrbank2_iir_c_1_b12_w = linien_fast_a_iir0_csrstorage2_storage_full0[23:16];
assign linien_csrbank2_iir_c_1_b11_w = linien_fast_a_iir0_csrstorage2_storage_full0[15:8];
assign linien_csrbank2_iir_c_1_b10_w = linien_fast_a_iir0_csrstorage2_storage_full0[7:0];
assign linien_fast_a_iir0_storage1 = linien_fast_a_iir0_storage_full1[26:0];
assign linien_csrbank2_iir_d_1_z03_w = linien_fast_a_iir0_storage_full1[26:24];
assign linien_csrbank2_iir_d_1_z02_w = linien_fast_a_iir0_storage_full1[23:16];
assign linien_csrbank2_iir_d_1_z01_w = linien_fast_a_iir0_storage_full1[15:8];
assign linien_csrbank2_iir_d_1_z00_w = linien_fast_a_iir0_storage_full1[7:0];
assign linien_fast_a_iir0_csrstorage0_storage1 = linien_fast_a_iir0_csrstorage0_storage_full1[24:0];
assign linien_csrbank2_iir_d_1_a13_w = linien_fast_a_iir0_csrstorage0_storage_full1[24];
assign linien_csrbank2_iir_d_1_a12_w = linien_fast_a_iir0_csrstorage0_storage_full1[23:16];
assign linien_csrbank2_iir_d_1_a11_w = linien_fast_a_iir0_csrstorage0_storage_full1[15:8];
assign linien_csrbank2_iir_d_1_a10_w = linien_fast_a_iir0_csrstorage0_storage_full1[7:0];
assign linien_fast_a_iir0_csrstorage1_storage1 = linien_fast_a_iir0_csrstorage1_storage_full1[24:0];
assign linien_csrbank2_iir_d_1_a23_w = linien_fast_a_iir0_csrstorage1_storage_full1[24];
assign linien_csrbank2_iir_d_1_a22_w = linien_fast_a_iir0_csrstorage1_storage_full1[23:16];
assign linien_csrbank2_iir_d_1_a21_w = linien_fast_a_iir0_csrstorage1_storage_full1[15:8];
assign linien_csrbank2_iir_d_1_a20_w = linien_fast_a_iir0_csrstorage1_storage_full1[7:0];
assign linien_fast_a_iir0_csrstorage2_storage1 = linien_fast_a_iir0_csrstorage2_storage_full1[24:0];
assign linien_csrbank2_iir_d_1_b03_w = linien_fast_a_iir0_csrstorage2_storage_full1[24];
assign linien_csrbank2_iir_d_1_b02_w = linien_fast_a_iir0_csrstorage2_storage_full1[23:16];
assign linien_csrbank2_iir_d_1_b01_w = linien_fast_a_iir0_csrstorage2_storage_full1[15:8];
assign linien_csrbank2_iir_d_1_b00_w = linien_fast_a_iir0_csrstorage2_storage_full1[7:0];
assign linien_fast_a_iir0_csrstorage3_storage = linien_fast_a_iir0_csrstorage3_storage_full[24:0];
assign linien_csrbank2_iir_d_1_b13_w = linien_fast_a_iir0_csrstorage3_storage_full[24];
assign linien_csrbank2_iir_d_1_b12_w = linien_fast_a_iir0_csrstorage3_storage_full[23:16];
assign linien_csrbank2_iir_d_1_b11_w = linien_fast_a_iir0_csrstorage3_storage_full[15:8];
assign linien_csrbank2_iir_d_1_b10_w = linien_fast_a_iir0_csrstorage3_storage_full[7:0];
assign linien_fast_a_iir0_csrstorage4_storage = linien_fast_a_iir0_csrstorage4_storage_full[24:0];
assign linien_csrbank2_iir_d_1_b23_w = linien_fast_a_iir0_csrstorage4_storage_full[24];
assign linien_csrbank2_iir_d_1_b22_w = linien_fast_a_iir0_csrstorage4_storage_full[23:16];
assign linien_csrbank2_iir_d_1_b21_w = linien_fast_a_iir0_csrstorage4_storage_full[15:8];
assign linien_csrbank2_iir_d_1_b20_w = linien_fast_a_iir0_csrstorage4_storage_full[7:0];
assign linien_fast_a_limitcsr0_min_storage1 = linien_fast_a_limitcsr0_min_storage_full1[24:0];
assign linien_csrbank2_y_limit_1_min3_w = linien_fast_a_limitcsr0_min_storage_full1[24];
assign linien_csrbank2_y_limit_1_min2_w = linien_fast_a_limitcsr0_min_storage_full1[23:16];
assign linien_csrbank2_y_limit_1_min1_w = linien_fast_a_limitcsr0_min_storage_full1[15:8];
assign linien_csrbank2_y_limit_1_min0_w = linien_fast_a_limitcsr0_min_storage_full1[7:0];
assign linien_fast_a_limitcsr0_max_storage1 = linien_fast_a_limitcsr0_max_storage_full1[24:0];
assign linien_csrbank2_y_limit_1_max3_w = linien_fast_a_limitcsr0_max_storage_full1[24];
assign linien_csrbank2_y_limit_1_max2_w = linien_fast_a_limitcsr0_max_storage_full1[23:16];
assign linien_csrbank2_y_limit_1_max1_w = linien_fast_a_limitcsr0_max_storage_full1[15:8];
assign linien_csrbank2_y_limit_1_max0_w = linien_fast_a_limitcsr0_max_storage_full1[7:0];
assign linien_fast_a_limitcsr1_min_storage0 = linien_fast_a_limitcsr1_min_storage_full0[24:0];
assign linien_csrbank2_x_limit_2_min3_w = linien_fast_a_limitcsr1_min_storage_full0[24];
assign linien_csrbank2_x_limit_2_min2_w = linien_fast_a_limitcsr1_min_storage_full0[23:16];
assign linien_csrbank2_x_limit_2_min1_w = linien_fast_a_limitcsr1_min_storage_full0[15:8];
assign linien_csrbank2_x_limit_2_min0_w = linien_fast_a_limitcsr1_min_storage_full0[7:0];
assign linien_fast_a_limitcsr1_max_storage0 = linien_fast_a_limitcsr1_max_storage_full0[24:0];
assign linien_csrbank2_x_limit_2_max3_w = linien_fast_a_limitcsr1_max_storage_full0[24];
assign linien_csrbank2_x_limit_2_max2_w = linien_fast_a_limitcsr1_max_storage_full0[23:16];
assign linien_csrbank2_x_limit_2_max1_w = linien_fast_a_limitcsr1_max_storage_full0[15:8];
assign linien_csrbank2_x_limit_2_max0_w = linien_fast_a_limitcsr1_max_storage_full0[7:0];
assign linien_fast_a_iir1_storage0 = linien_fast_a_iir1_storage_full0[26:0];
assign linien_csrbank2_iir_c_2_z03_w = linien_fast_a_iir1_storage_full0[26:24];
assign linien_csrbank2_iir_c_2_z02_w = linien_fast_a_iir1_storage_full0[23:16];
assign linien_csrbank2_iir_c_2_z01_w = linien_fast_a_iir1_storage_full0[15:8];
assign linien_csrbank2_iir_c_2_z00_w = linien_fast_a_iir1_storage_full0[7:0];
assign linien_fast_a_iir1_csrstorage3_storage = linien_fast_a_iir1_csrstorage3_storage_full[24:0];
assign linien_csrbank2_iir_c_2_a13_w = linien_fast_a_iir1_csrstorage3_storage_full[24];
assign linien_csrbank2_iir_c_2_a12_w = linien_fast_a_iir1_csrstorage3_storage_full[23:16];
assign linien_csrbank2_iir_c_2_a11_w = linien_fast_a_iir1_csrstorage3_storage_full[15:8];
assign linien_csrbank2_iir_c_2_a10_w = linien_fast_a_iir1_csrstorage3_storage_full[7:0];
assign linien_fast_a_iir1_csrstorage4_storage = linien_fast_a_iir1_csrstorage4_storage_full[24:0];
assign linien_csrbank2_iir_c_2_b03_w = linien_fast_a_iir1_csrstorage4_storage_full[24];
assign linien_csrbank2_iir_c_2_b02_w = linien_fast_a_iir1_csrstorage4_storage_full[23:16];
assign linien_csrbank2_iir_c_2_b01_w = linien_fast_a_iir1_csrstorage4_storage_full[15:8];
assign linien_csrbank2_iir_c_2_b00_w = linien_fast_a_iir1_csrstorage4_storage_full[7:0];
assign linien_fast_a_iir1_csrstorage5_storage0 = linien_fast_a_iir1_csrstorage5_storage_full0[24:0];
assign linien_csrbank2_iir_c_2_b13_w = linien_fast_a_iir1_csrstorage5_storage_full0[24];
assign linien_csrbank2_iir_c_2_b12_w = linien_fast_a_iir1_csrstorage5_storage_full0[23:16];
assign linien_csrbank2_iir_c_2_b11_w = linien_fast_a_iir1_csrstorage5_storage_full0[15:8];
assign linien_csrbank2_iir_c_2_b10_w = linien_fast_a_iir1_csrstorage5_storage_full0[7:0];
assign linien_fast_a_iir1_storage1 = linien_fast_a_iir1_storage_full1[26:0];
assign linien_csrbank2_iir_d_2_z03_w = linien_fast_a_iir1_storage_full1[26:24];
assign linien_csrbank2_iir_d_2_z02_w = linien_fast_a_iir1_storage_full1[23:16];
assign linien_csrbank2_iir_d_2_z01_w = linien_fast_a_iir1_storage_full1[15:8];
assign linien_csrbank2_iir_d_2_z00_w = linien_fast_a_iir1_storage_full1[7:0];
assign linien_fast_a_iir1_csrstorage5_storage1 = linien_fast_a_iir1_csrstorage5_storage_full1[24:0];
assign linien_csrbank2_iir_d_2_a13_w = linien_fast_a_iir1_csrstorage5_storage_full1[24];
assign linien_csrbank2_iir_d_2_a12_w = linien_fast_a_iir1_csrstorage5_storage_full1[23:16];
assign linien_csrbank2_iir_d_2_a11_w = linien_fast_a_iir1_csrstorage5_storage_full1[15:8];
assign linien_csrbank2_iir_d_2_a10_w = linien_fast_a_iir1_csrstorage5_storage_full1[7:0];
assign linien_fast_a_iir1_csrstorage6_storage = linien_fast_a_iir1_csrstorage6_storage_full[24:0];
assign linien_csrbank2_iir_d_2_a23_w = linien_fast_a_iir1_csrstorage6_storage_full[24];
assign linien_csrbank2_iir_d_2_a22_w = linien_fast_a_iir1_csrstorage6_storage_full[23:16];
assign linien_csrbank2_iir_d_2_a21_w = linien_fast_a_iir1_csrstorage6_storage_full[15:8];
assign linien_csrbank2_iir_d_2_a20_w = linien_fast_a_iir1_csrstorage6_storage_full[7:0];
assign linien_fast_a_iir1_csrstorage7_storage = linien_fast_a_iir1_csrstorage7_storage_full[24:0];
assign linien_csrbank2_iir_d_2_b03_w = linien_fast_a_iir1_csrstorage7_storage_full[24];
assign linien_csrbank2_iir_d_2_b02_w = linien_fast_a_iir1_csrstorage7_storage_full[23:16];
assign linien_csrbank2_iir_d_2_b01_w = linien_fast_a_iir1_csrstorage7_storage_full[15:8];
assign linien_csrbank2_iir_d_2_b00_w = linien_fast_a_iir1_csrstorage7_storage_full[7:0];
assign linien_fast_a_iir1_csrstorage8_storage = linien_fast_a_iir1_csrstorage8_storage_full[24:0];
assign linien_csrbank2_iir_d_2_b13_w = linien_fast_a_iir1_csrstorage8_storage_full[24];
assign linien_csrbank2_iir_d_2_b12_w = linien_fast_a_iir1_csrstorage8_storage_full[23:16];
assign linien_csrbank2_iir_d_2_b11_w = linien_fast_a_iir1_csrstorage8_storage_full[15:8];
assign linien_csrbank2_iir_d_2_b10_w = linien_fast_a_iir1_csrstorage8_storage_full[7:0];
assign linien_fast_a_iir1_csrstorage9_storage = linien_fast_a_iir1_csrstorage9_storage_full[24:0];
assign linien_csrbank2_iir_d_2_b23_w = linien_fast_a_iir1_csrstorage9_storage_full[24];
assign linien_csrbank2_iir_d_2_b22_w = linien_fast_a_iir1_csrstorage9_storage_full[23:16];
assign linien_csrbank2_iir_d_2_b21_w = linien_fast_a_iir1_csrstorage9_storage_full[15:8];
assign linien_csrbank2_iir_d_2_b20_w = linien_fast_a_iir1_csrstorage9_storage_full[7:0];
assign linien_fast_a_limitcsr1_min_storage1 = linien_fast_a_limitcsr1_min_storage_full1[24:0];
assign linien_csrbank2_y_limit_2_min3_w = linien_fast_a_limitcsr1_min_storage_full1[24];
assign linien_csrbank2_y_limit_2_min2_w = linien_fast_a_limitcsr1_min_storage_full1[23:16];
assign linien_csrbank2_y_limit_2_min1_w = linien_fast_a_limitcsr1_min_storage_full1[15:8];
assign linien_csrbank2_y_limit_2_min0_w = linien_fast_a_limitcsr1_min_storage_full1[7:0];
assign linien_fast_a_limitcsr1_max_storage1 = linien_fast_a_limitcsr1_max_storage_full1[24:0];
assign linien_csrbank2_y_limit_2_max3_w = linien_fast_a_limitcsr1_max_storage_full1[24];
assign linien_csrbank2_y_limit_2_max2_w = linien_fast_a_limitcsr1_max_storage_full1[23:16];
assign linien_csrbank2_y_limit_2_max1_w = linien_fast_a_limitcsr1_max_storage_full1[15:8];
assign linien_csrbank2_y_limit_2_max0_w = linien_fast_a_limitcsr1_max_storage_full1[7:0];
assign linien_csrbank2_x_max3_w = linien_max_status0[24];
assign linien_csrbank2_x_max2_w = linien_max_status0[23:16];
assign linien_csrbank2_x_max1_w = linien_max_status0[15:8];
assign linien_csrbank2_x_max0_w = linien_max_status0[7:0];
assign linien_csrbank2_x_min3_w = linien_min_status0[24];
assign linien_csrbank2_x_min2_w = linien_min_status0[23:16];
assign linien_csrbank2_x_min1_w = linien_min_status0[15:8];
assign linien_csrbank2_x_min0_w = linien_min_status0[7:0];
assign linien_csrbank2_out_i_max3_w = linien_max_status1[24];
assign linien_csrbank2_out_i_max2_w = linien_max_status1[23:16];
assign linien_csrbank2_out_i_max1_w = linien_max_status1[15:8];
assign linien_csrbank2_out_i_max0_w = linien_max_status1[7:0];
assign linien_csrbank2_out_i_min3_w = linien_min_status1[24];
assign linien_csrbank2_out_i_min2_w = linien_min_status1[23:16];
assign linien_csrbank2_out_i_min1_w = linien_min_status1[15:8];
assign linien_csrbank2_out_i_min0_w = linien_min_status1[7:0];
assign linien_csrbank2_out_q_max3_w = linien_max_status2[24];
assign linien_csrbank2_out_q_max2_w = linien_max_status2[23:16];
assign linien_csrbank2_out_q_max1_w = linien_max_status2[15:8];
assign linien_csrbank2_out_q_max0_w = linien_max_status2[7:0];
assign linien_csrbank2_out_q_min3_w = linien_min_status2[24];
assign linien_csrbank2_out_q_min2_w = linien_min_status2[23:16];
assign linien_csrbank2_out_q_min1_w = linien_min_status2[15:8];
assign linien_csrbank2_out_q_min0_w = linien_min_status2[7:0];
assign linien_csrstorage8_storage = linien_csrstorage8_storage_full[3:0];
assign linien_csrbank2_dx_sel0_w = linien_csrstorage8_storage_full[3:0];
assign linien_csrstorage9_storage = linien_csrstorage9_storage_full[3:0];
assign linien_csrbank2_dy_sel0_w = linien_csrstorage9_storage_full[3:0];
assign linien_csrbank3_sel = (linien_interface3_bank_bus_adr[13:9] == 1'd1);
assign linien_csrbank3_y_tap0_r = linien_interface3_bank_bus_dat_w[1:0];
assign linien_csrbank3_y_tap0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 1'd0));
assign linien_csrbank3_invert0_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_invert0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 1'd1));
assign linien_csrbank3_demod_delay3_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_demod_delay3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 2'd2));
assign linien_csrbank3_demod_delay2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_demod_delay2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 2'd3));
assign linien_csrbank3_demod_delay1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_demod_delay1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 3'd4));
assign linien_csrbank3_demod_delay0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_demod_delay0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 3'd5));
assign linien_csrbank3_demod_multiplier0_r = linien_interface3_bank_bus_dat_w[3:0];
assign linien_csrbank3_demod_multiplier0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 3'd6));
assign linien_csrbank3_x_limit_1_min3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_x_limit_1_min3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 3'd7));
assign linien_csrbank3_x_limit_1_min2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_1_min2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 4'd8));
assign linien_csrbank3_x_limit_1_min1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_1_min1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 4'd9));
assign linien_csrbank3_x_limit_1_min0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_1_min0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 4'd10));
assign linien_csrbank3_x_limit_1_max3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_x_limit_1_max3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 4'd11));
assign linien_csrbank3_x_limit_1_max2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_1_max2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 4'd12));
assign linien_csrbank3_x_limit_1_max1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_1_max1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 4'd13));
assign linien_csrbank3_x_limit_1_max0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_1_max0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 4'd14));
assign linien_csrbank3_iir_c_1_z03_r = linien_interface3_bank_bus_dat_w[2:0];
assign linien_csrbank3_iir_c_1_z03_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 4'd15));
assign linien_csrbank3_iir_c_1_z02_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_z02_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd16));
assign linien_csrbank3_iir_c_1_z01_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_z01_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd17));
assign linien_csrbank3_iir_c_1_z00_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_z00_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd18));
assign linien_csrbank3_iir_c_1_a13_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_c_1_a13_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd19));
assign linien_csrbank3_iir_c_1_a12_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_a12_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd20));
assign linien_csrbank3_iir_c_1_a11_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_a11_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd21));
assign linien_csrbank3_iir_c_1_a10_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_a10_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd22));
assign linien_csrbank3_iir_c_1_b03_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_c_1_b03_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd23));
assign linien_csrbank3_iir_c_1_b02_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_b02_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd24));
assign linien_csrbank3_iir_c_1_b01_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_b01_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd25));
assign linien_csrbank3_iir_c_1_b00_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_b00_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd26));
assign linien_csrbank3_iir_c_1_b13_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_c_1_b13_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd27));
assign linien_csrbank3_iir_c_1_b12_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_b12_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd28));
assign linien_csrbank3_iir_c_1_b11_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_b11_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd29));
assign linien_csrbank3_iir_c_1_b10_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_1_b10_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd30));
assign linien_csrbank3_iir_d_1_z03_r = linien_interface3_bank_bus_dat_w[2:0];
assign linien_csrbank3_iir_d_1_z03_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 5'd31));
assign linien_csrbank3_iir_d_1_z02_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_z02_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd32));
assign linien_csrbank3_iir_d_1_z01_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_z01_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd33));
assign linien_csrbank3_iir_d_1_z00_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_z00_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd34));
assign linien_csrbank3_iir_d_1_a13_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_1_a13_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd35));
assign linien_csrbank3_iir_d_1_a12_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_a12_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd36));
assign linien_csrbank3_iir_d_1_a11_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_a11_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd37));
assign linien_csrbank3_iir_d_1_a10_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_a10_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd38));
assign linien_csrbank3_iir_d_1_a23_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_1_a23_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd39));
assign linien_csrbank3_iir_d_1_a22_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_a22_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd40));
assign linien_csrbank3_iir_d_1_a21_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_a21_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd41));
assign linien_csrbank3_iir_d_1_a20_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_a20_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd42));
assign linien_csrbank3_iir_d_1_b03_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_1_b03_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd43));
assign linien_csrbank3_iir_d_1_b02_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_b02_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd44));
assign linien_csrbank3_iir_d_1_b01_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_b01_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd45));
assign linien_csrbank3_iir_d_1_b00_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_b00_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd46));
assign linien_csrbank3_iir_d_1_b13_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_1_b13_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd47));
assign linien_csrbank3_iir_d_1_b12_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_b12_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd48));
assign linien_csrbank3_iir_d_1_b11_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_b11_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd49));
assign linien_csrbank3_iir_d_1_b10_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_b10_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd50));
assign linien_csrbank3_iir_d_1_b23_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_1_b23_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd51));
assign linien_csrbank3_iir_d_1_b22_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_b22_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd52));
assign linien_csrbank3_iir_d_1_b21_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_b21_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd53));
assign linien_csrbank3_iir_d_1_b20_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_1_b20_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd54));
assign linien_csrbank3_y_limit_1_min3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_y_limit_1_min3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd55));
assign linien_csrbank3_y_limit_1_min2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_1_min2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd56));
assign linien_csrbank3_y_limit_1_min1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_1_min1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd57));
assign linien_csrbank3_y_limit_1_min0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_1_min0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd58));
assign linien_csrbank3_y_limit_1_max3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_y_limit_1_max3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd59));
assign linien_csrbank3_y_limit_1_max2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_1_max2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd60));
assign linien_csrbank3_y_limit_1_max1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_1_max1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd61));
assign linien_csrbank3_y_limit_1_max0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_1_max0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd62));
assign linien_csrbank3_x_limit_2_min3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_x_limit_2_min3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 6'd63));
assign linien_csrbank3_x_limit_2_min2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_2_min2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd64));
assign linien_csrbank3_x_limit_2_min1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_2_min1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd65));
assign linien_csrbank3_x_limit_2_min0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_2_min0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd66));
assign linien_csrbank3_x_limit_2_max3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_x_limit_2_max3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd67));
assign linien_csrbank3_x_limit_2_max2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_2_max2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd68));
assign linien_csrbank3_x_limit_2_max1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_2_max1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd69));
assign linien_csrbank3_x_limit_2_max0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_limit_2_max0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd70));
assign linien_csrbank3_iir_c_2_z03_r = linien_interface3_bank_bus_dat_w[2:0];
assign linien_csrbank3_iir_c_2_z03_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd71));
assign linien_csrbank3_iir_c_2_z02_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_z02_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd72));
assign linien_csrbank3_iir_c_2_z01_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_z01_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd73));
assign linien_csrbank3_iir_c_2_z00_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_z00_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd74));
assign linien_csrbank3_iir_c_2_a13_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_c_2_a13_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd75));
assign linien_csrbank3_iir_c_2_a12_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_a12_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd76));
assign linien_csrbank3_iir_c_2_a11_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_a11_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd77));
assign linien_csrbank3_iir_c_2_a10_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_a10_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd78));
assign linien_csrbank3_iir_c_2_b03_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_c_2_b03_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd79));
assign linien_csrbank3_iir_c_2_b02_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_b02_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd80));
assign linien_csrbank3_iir_c_2_b01_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_b01_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd81));
assign linien_csrbank3_iir_c_2_b00_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_b00_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd82));
assign linien_csrbank3_iir_c_2_b13_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_c_2_b13_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd83));
assign linien_csrbank3_iir_c_2_b12_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_b12_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd84));
assign linien_csrbank3_iir_c_2_b11_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_b11_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd85));
assign linien_csrbank3_iir_c_2_b10_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_c_2_b10_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd86));
assign linien_csrbank3_iir_d_2_z03_r = linien_interface3_bank_bus_dat_w[2:0];
assign linien_csrbank3_iir_d_2_z03_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd87));
assign linien_csrbank3_iir_d_2_z02_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_z02_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd88));
assign linien_csrbank3_iir_d_2_z01_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_z01_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd89));
assign linien_csrbank3_iir_d_2_z00_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_z00_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd90));
assign linien_csrbank3_iir_d_2_a13_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_2_a13_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd91));
assign linien_csrbank3_iir_d_2_a12_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_a12_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd92));
assign linien_csrbank3_iir_d_2_a11_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_a11_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd93));
assign linien_csrbank3_iir_d_2_a10_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_a10_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd94));
assign linien_csrbank3_iir_d_2_a23_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_2_a23_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd95));
assign linien_csrbank3_iir_d_2_a22_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_a22_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd96));
assign linien_csrbank3_iir_d_2_a21_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_a21_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd97));
assign linien_csrbank3_iir_d_2_a20_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_a20_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd98));
assign linien_csrbank3_iir_d_2_b03_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_2_b03_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd99));
assign linien_csrbank3_iir_d_2_b02_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_b02_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd100));
assign linien_csrbank3_iir_d_2_b01_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_b01_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd101));
assign linien_csrbank3_iir_d_2_b00_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_b00_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd102));
assign linien_csrbank3_iir_d_2_b13_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_2_b13_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd103));
assign linien_csrbank3_iir_d_2_b12_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_b12_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd104));
assign linien_csrbank3_iir_d_2_b11_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_b11_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd105));
assign linien_csrbank3_iir_d_2_b10_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_b10_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd106));
assign linien_csrbank3_iir_d_2_b23_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_iir_d_2_b23_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd107));
assign linien_csrbank3_iir_d_2_b22_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_b22_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd108));
assign linien_csrbank3_iir_d_2_b21_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_b21_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd109));
assign linien_csrbank3_iir_d_2_b20_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_iir_d_2_b20_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd110));
assign linien_csrbank3_y_limit_2_min3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_y_limit_2_min3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd111));
assign linien_csrbank3_y_limit_2_min2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_2_min2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd112));
assign linien_csrbank3_y_limit_2_min1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_2_min1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd113));
assign linien_csrbank3_y_limit_2_min0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_2_min0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd114));
assign linien_csrbank3_y_limit_2_max3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_y_limit_2_max3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd115));
assign linien_csrbank3_y_limit_2_max2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_2_max2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd116));
assign linien_csrbank3_y_limit_2_max1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_2_max1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd117));
assign linien_csrbank3_y_limit_2_max0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_y_limit_2_max0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd118));
assign linien_csr3_x_clr_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csr3_x_clr_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd119));
assign linien_csrbank3_x_max3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_x_max3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd120));
assign linien_csrbank3_x_max2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_max2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd121));
assign linien_csrbank3_x_max1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_max1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd122));
assign linien_csrbank3_x_max0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_max0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd123));
assign linien_csrbank3_x_min3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_x_min3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd124));
assign linien_csrbank3_x_min2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_min2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd125));
assign linien_csrbank3_x_min1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_min1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd126));
assign linien_csrbank3_x_min0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_x_min0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 7'd127));
assign linien_csr4_out_i_clr_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csr4_out_i_clr_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd128));
assign linien_csrbank3_out_i_max3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_out_i_max3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd129));
assign linien_csrbank3_out_i_max2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_i_max2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd130));
assign linien_csrbank3_out_i_max1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_i_max1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd131));
assign linien_csrbank3_out_i_max0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_i_max0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd132));
assign linien_csrbank3_out_i_min3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_out_i_min3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd133));
assign linien_csrbank3_out_i_min2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_i_min2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd134));
assign linien_csrbank3_out_i_min1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_i_min1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd135));
assign linien_csrbank3_out_i_min0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_i_min0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd136));
assign linien_csr5_out_q_clr_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csr5_out_q_clr_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd137));
assign linien_csrbank3_out_q_max3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_out_q_max3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd138));
assign linien_csrbank3_out_q_max2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_q_max2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd139));
assign linien_csrbank3_out_q_max1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_q_max1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd140));
assign linien_csrbank3_out_q_max0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_q_max0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd141));
assign linien_csrbank3_out_q_min3_r = linien_interface3_bank_bus_dat_w[0];
assign linien_csrbank3_out_q_min3_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd142));
assign linien_csrbank3_out_q_min2_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_q_min2_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd143));
assign linien_csrbank3_out_q_min1_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_q_min1_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd144));
assign linien_csrbank3_out_q_min0_r = linien_interface3_bank_bus_dat_w[7:0];
assign linien_csrbank3_out_q_min0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd145));
assign linien_csrbank3_dx_sel0_r = linien_interface3_bank_bus_dat_w[3:0];
assign linien_csrbank3_dx_sel0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd146));
assign linien_csrbank3_dy_sel0_r = linien_interface3_bank_bus_dat_w[3:0];
assign linien_csrbank3_dy_sel0_re = ((linien_csrbank3_sel & linien_interface3_bank_bus_we) & (linien_interface3_bank_bus_adr[7:0] == 8'd147));
assign linien_fast_b_y_tap_storage = linien_fast_b_y_tap_storage_full[1:0];
assign linien_csrbank3_y_tap0_w = linien_fast_b_y_tap_storage_full[1:0];
assign linien_fast_b_invert_storage = linien_fast_b_invert_storage_full;
assign linien_csrbank3_invert0_w = linien_fast_b_invert_storage_full;
assign linien_fast_b_delay_storage = linien_fast_b_delay_storage_full[31:0];
assign linien_csrbank3_demod_delay3_w = linien_fast_b_delay_storage_full[31:24];
assign linien_csrbank3_demod_delay2_w = linien_fast_b_delay_storage_full[23:16];
assign linien_csrbank3_demod_delay1_w = linien_fast_b_delay_storage_full[15:8];
assign linien_csrbank3_demod_delay0_w = linien_fast_b_delay_storage_full[7:0];
assign linien_fast_b_multiplier_storage = linien_fast_b_multiplier_storage_full[3:0];
assign linien_csrbank3_demod_multiplier0_w = linien_fast_b_multiplier_storage_full[3:0];
assign linien_fast_b_limitcsr0_min_storage0 = linien_fast_b_limitcsr0_min_storage_full0[24:0];
assign linien_csrbank3_x_limit_1_min3_w = linien_fast_b_limitcsr0_min_storage_full0[24];
assign linien_csrbank3_x_limit_1_min2_w = linien_fast_b_limitcsr0_min_storage_full0[23:16];
assign linien_csrbank3_x_limit_1_min1_w = linien_fast_b_limitcsr0_min_storage_full0[15:8];
assign linien_csrbank3_x_limit_1_min0_w = linien_fast_b_limitcsr0_min_storage_full0[7:0];
assign linien_fast_b_limitcsr0_max_storage0 = linien_fast_b_limitcsr0_max_storage_full0[24:0];
assign linien_csrbank3_x_limit_1_max3_w = linien_fast_b_limitcsr0_max_storage_full0[24];
assign linien_csrbank3_x_limit_1_max2_w = linien_fast_b_limitcsr0_max_storage_full0[23:16];
assign linien_csrbank3_x_limit_1_max1_w = linien_fast_b_limitcsr0_max_storage_full0[15:8];
assign linien_csrbank3_x_limit_1_max0_w = linien_fast_b_limitcsr0_max_storage_full0[7:0];
assign linien_fast_b_iir0_storage0 = linien_fast_b_iir0_storage_full0[26:0];
assign linien_csrbank3_iir_c_1_z03_w = linien_fast_b_iir0_storage_full0[26:24];
assign linien_csrbank3_iir_c_1_z02_w = linien_fast_b_iir0_storage_full0[23:16];
assign linien_csrbank3_iir_c_1_z01_w = linien_fast_b_iir0_storage_full0[15:8];
assign linien_csrbank3_iir_c_1_z00_w = linien_fast_b_iir0_storage_full0[7:0];
assign linien_fast_b_iir0_csrstorage0_storage0 = linien_fast_b_iir0_csrstorage0_storage_full0[24:0];
assign linien_csrbank3_iir_c_1_a13_w = linien_fast_b_iir0_csrstorage0_storage_full0[24];
assign linien_csrbank3_iir_c_1_a12_w = linien_fast_b_iir0_csrstorage0_storage_full0[23:16];
assign linien_csrbank3_iir_c_1_a11_w = linien_fast_b_iir0_csrstorage0_storage_full0[15:8];
assign linien_csrbank3_iir_c_1_a10_w = linien_fast_b_iir0_csrstorage0_storage_full0[7:0];
assign linien_fast_b_iir0_csrstorage1_storage0 = linien_fast_b_iir0_csrstorage1_storage_full0[24:0];
assign linien_csrbank3_iir_c_1_b03_w = linien_fast_b_iir0_csrstorage1_storage_full0[24];
assign linien_csrbank3_iir_c_1_b02_w = linien_fast_b_iir0_csrstorage1_storage_full0[23:16];
assign linien_csrbank3_iir_c_1_b01_w = linien_fast_b_iir0_csrstorage1_storage_full0[15:8];
assign linien_csrbank3_iir_c_1_b00_w = linien_fast_b_iir0_csrstorage1_storage_full0[7:0];
assign linien_fast_b_iir0_csrstorage2_storage0 = linien_fast_b_iir0_csrstorage2_storage_full0[24:0];
assign linien_csrbank3_iir_c_1_b13_w = linien_fast_b_iir0_csrstorage2_storage_full0[24];
assign linien_csrbank3_iir_c_1_b12_w = linien_fast_b_iir0_csrstorage2_storage_full0[23:16];
assign linien_csrbank3_iir_c_1_b11_w = linien_fast_b_iir0_csrstorage2_storage_full0[15:8];
assign linien_csrbank3_iir_c_1_b10_w = linien_fast_b_iir0_csrstorage2_storage_full0[7:0];
assign linien_fast_b_iir0_storage1 = linien_fast_b_iir0_storage_full1[26:0];
assign linien_csrbank3_iir_d_1_z03_w = linien_fast_b_iir0_storage_full1[26:24];
assign linien_csrbank3_iir_d_1_z02_w = linien_fast_b_iir0_storage_full1[23:16];
assign linien_csrbank3_iir_d_1_z01_w = linien_fast_b_iir0_storage_full1[15:8];
assign linien_csrbank3_iir_d_1_z00_w = linien_fast_b_iir0_storage_full1[7:0];
assign linien_fast_b_iir0_csrstorage0_storage1 = linien_fast_b_iir0_csrstorage0_storage_full1[24:0];
assign linien_csrbank3_iir_d_1_a13_w = linien_fast_b_iir0_csrstorage0_storage_full1[24];
assign linien_csrbank3_iir_d_1_a12_w = linien_fast_b_iir0_csrstorage0_storage_full1[23:16];
assign linien_csrbank3_iir_d_1_a11_w = linien_fast_b_iir0_csrstorage0_storage_full1[15:8];
assign linien_csrbank3_iir_d_1_a10_w = linien_fast_b_iir0_csrstorage0_storage_full1[7:0];
assign linien_fast_b_iir0_csrstorage1_storage1 = linien_fast_b_iir0_csrstorage1_storage_full1[24:0];
assign linien_csrbank3_iir_d_1_a23_w = linien_fast_b_iir0_csrstorage1_storage_full1[24];
assign linien_csrbank3_iir_d_1_a22_w = linien_fast_b_iir0_csrstorage1_storage_full1[23:16];
assign linien_csrbank3_iir_d_1_a21_w = linien_fast_b_iir0_csrstorage1_storage_full1[15:8];
assign linien_csrbank3_iir_d_1_a20_w = linien_fast_b_iir0_csrstorage1_storage_full1[7:0];
assign linien_fast_b_iir0_csrstorage2_storage1 = linien_fast_b_iir0_csrstorage2_storage_full1[24:0];
assign linien_csrbank3_iir_d_1_b03_w = linien_fast_b_iir0_csrstorage2_storage_full1[24];
assign linien_csrbank3_iir_d_1_b02_w = linien_fast_b_iir0_csrstorage2_storage_full1[23:16];
assign linien_csrbank3_iir_d_1_b01_w = linien_fast_b_iir0_csrstorage2_storage_full1[15:8];
assign linien_csrbank3_iir_d_1_b00_w = linien_fast_b_iir0_csrstorage2_storage_full1[7:0];
assign linien_fast_b_iir0_csrstorage3_storage = linien_fast_b_iir0_csrstorage3_storage_full[24:0];
assign linien_csrbank3_iir_d_1_b13_w = linien_fast_b_iir0_csrstorage3_storage_full[24];
assign linien_csrbank3_iir_d_1_b12_w = linien_fast_b_iir0_csrstorage3_storage_full[23:16];
assign linien_csrbank3_iir_d_1_b11_w = linien_fast_b_iir0_csrstorage3_storage_full[15:8];
assign linien_csrbank3_iir_d_1_b10_w = linien_fast_b_iir0_csrstorage3_storage_full[7:0];
assign linien_fast_b_iir0_csrstorage4_storage = linien_fast_b_iir0_csrstorage4_storage_full[24:0];
assign linien_csrbank3_iir_d_1_b23_w = linien_fast_b_iir0_csrstorage4_storage_full[24];
assign linien_csrbank3_iir_d_1_b22_w = linien_fast_b_iir0_csrstorage4_storage_full[23:16];
assign linien_csrbank3_iir_d_1_b21_w = linien_fast_b_iir0_csrstorage4_storage_full[15:8];
assign linien_csrbank3_iir_d_1_b20_w = linien_fast_b_iir0_csrstorage4_storage_full[7:0];
assign linien_fast_b_limitcsr0_min_storage1 = linien_fast_b_limitcsr0_min_storage_full1[24:0];
assign linien_csrbank3_y_limit_1_min3_w = linien_fast_b_limitcsr0_min_storage_full1[24];
assign linien_csrbank3_y_limit_1_min2_w = linien_fast_b_limitcsr0_min_storage_full1[23:16];
assign linien_csrbank3_y_limit_1_min1_w = linien_fast_b_limitcsr0_min_storage_full1[15:8];
assign linien_csrbank3_y_limit_1_min0_w = linien_fast_b_limitcsr0_min_storage_full1[7:0];
assign linien_fast_b_limitcsr0_max_storage1 = linien_fast_b_limitcsr0_max_storage_full1[24:0];
assign linien_csrbank3_y_limit_1_max3_w = linien_fast_b_limitcsr0_max_storage_full1[24];
assign linien_csrbank3_y_limit_1_max2_w = linien_fast_b_limitcsr0_max_storage_full1[23:16];
assign linien_csrbank3_y_limit_1_max1_w = linien_fast_b_limitcsr0_max_storage_full1[15:8];
assign linien_csrbank3_y_limit_1_max0_w = linien_fast_b_limitcsr0_max_storage_full1[7:0];
assign linien_fast_b_limitcsr1_min_storage0 = linien_fast_b_limitcsr1_min_storage_full0[24:0];
assign linien_csrbank3_x_limit_2_min3_w = linien_fast_b_limitcsr1_min_storage_full0[24];
assign linien_csrbank3_x_limit_2_min2_w = linien_fast_b_limitcsr1_min_storage_full0[23:16];
assign linien_csrbank3_x_limit_2_min1_w = linien_fast_b_limitcsr1_min_storage_full0[15:8];
assign linien_csrbank3_x_limit_2_min0_w = linien_fast_b_limitcsr1_min_storage_full0[7:0];
assign linien_fast_b_limitcsr1_max_storage0 = linien_fast_b_limitcsr1_max_storage_full0[24:0];
assign linien_csrbank3_x_limit_2_max3_w = linien_fast_b_limitcsr1_max_storage_full0[24];
assign linien_csrbank3_x_limit_2_max2_w = linien_fast_b_limitcsr1_max_storage_full0[23:16];
assign linien_csrbank3_x_limit_2_max1_w = linien_fast_b_limitcsr1_max_storage_full0[15:8];
assign linien_csrbank3_x_limit_2_max0_w = linien_fast_b_limitcsr1_max_storage_full0[7:0];
assign linien_fast_b_iir1_storage0 = linien_fast_b_iir1_storage_full0[26:0];
assign linien_csrbank3_iir_c_2_z03_w = linien_fast_b_iir1_storage_full0[26:24];
assign linien_csrbank3_iir_c_2_z02_w = linien_fast_b_iir1_storage_full0[23:16];
assign linien_csrbank3_iir_c_2_z01_w = linien_fast_b_iir1_storage_full0[15:8];
assign linien_csrbank3_iir_c_2_z00_w = linien_fast_b_iir1_storage_full0[7:0];
assign linien_fast_b_iir1_csrstorage3_storage = linien_fast_b_iir1_csrstorage3_storage_full[24:0];
assign linien_csrbank3_iir_c_2_a13_w = linien_fast_b_iir1_csrstorage3_storage_full[24];
assign linien_csrbank3_iir_c_2_a12_w = linien_fast_b_iir1_csrstorage3_storage_full[23:16];
assign linien_csrbank3_iir_c_2_a11_w = linien_fast_b_iir1_csrstorage3_storage_full[15:8];
assign linien_csrbank3_iir_c_2_a10_w = linien_fast_b_iir1_csrstorage3_storage_full[7:0];
assign linien_fast_b_iir1_csrstorage4_storage = linien_fast_b_iir1_csrstorage4_storage_full[24:0];
assign linien_csrbank3_iir_c_2_b03_w = linien_fast_b_iir1_csrstorage4_storage_full[24];
assign linien_csrbank3_iir_c_2_b02_w = linien_fast_b_iir1_csrstorage4_storage_full[23:16];
assign linien_csrbank3_iir_c_2_b01_w = linien_fast_b_iir1_csrstorage4_storage_full[15:8];
assign linien_csrbank3_iir_c_2_b00_w = linien_fast_b_iir1_csrstorage4_storage_full[7:0];
assign linien_fast_b_iir1_csrstorage5_storage0 = linien_fast_b_iir1_csrstorage5_storage_full0[24:0];
assign linien_csrbank3_iir_c_2_b13_w = linien_fast_b_iir1_csrstorage5_storage_full0[24];
assign linien_csrbank3_iir_c_2_b12_w = linien_fast_b_iir1_csrstorage5_storage_full0[23:16];
assign linien_csrbank3_iir_c_2_b11_w = linien_fast_b_iir1_csrstorage5_storage_full0[15:8];
assign linien_csrbank3_iir_c_2_b10_w = linien_fast_b_iir1_csrstorage5_storage_full0[7:0];
assign linien_fast_b_iir1_storage1 = linien_fast_b_iir1_storage_full1[26:0];
assign linien_csrbank3_iir_d_2_z03_w = linien_fast_b_iir1_storage_full1[26:24];
assign linien_csrbank3_iir_d_2_z02_w = linien_fast_b_iir1_storage_full1[23:16];
assign linien_csrbank3_iir_d_2_z01_w = linien_fast_b_iir1_storage_full1[15:8];
assign linien_csrbank3_iir_d_2_z00_w = linien_fast_b_iir1_storage_full1[7:0];
assign linien_fast_b_iir1_csrstorage5_storage1 = linien_fast_b_iir1_csrstorage5_storage_full1[24:0];
assign linien_csrbank3_iir_d_2_a13_w = linien_fast_b_iir1_csrstorage5_storage_full1[24];
assign linien_csrbank3_iir_d_2_a12_w = linien_fast_b_iir1_csrstorage5_storage_full1[23:16];
assign linien_csrbank3_iir_d_2_a11_w = linien_fast_b_iir1_csrstorage5_storage_full1[15:8];
assign linien_csrbank3_iir_d_2_a10_w = linien_fast_b_iir1_csrstorage5_storage_full1[7:0];
assign linien_fast_b_iir1_csrstorage6_storage = linien_fast_b_iir1_csrstorage6_storage_full[24:0];
assign linien_csrbank3_iir_d_2_a23_w = linien_fast_b_iir1_csrstorage6_storage_full[24];
assign linien_csrbank3_iir_d_2_a22_w = linien_fast_b_iir1_csrstorage6_storage_full[23:16];
assign linien_csrbank3_iir_d_2_a21_w = linien_fast_b_iir1_csrstorage6_storage_full[15:8];
assign linien_csrbank3_iir_d_2_a20_w = linien_fast_b_iir1_csrstorage6_storage_full[7:0];
assign linien_fast_b_iir1_csrstorage7_storage = linien_fast_b_iir1_csrstorage7_storage_full[24:0];
assign linien_csrbank3_iir_d_2_b03_w = linien_fast_b_iir1_csrstorage7_storage_full[24];
assign linien_csrbank3_iir_d_2_b02_w = linien_fast_b_iir1_csrstorage7_storage_full[23:16];
assign linien_csrbank3_iir_d_2_b01_w = linien_fast_b_iir1_csrstorage7_storage_full[15:8];
assign linien_csrbank3_iir_d_2_b00_w = linien_fast_b_iir1_csrstorage7_storage_full[7:0];
assign linien_fast_b_iir1_csrstorage8_storage = linien_fast_b_iir1_csrstorage8_storage_full[24:0];
assign linien_csrbank3_iir_d_2_b13_w = linien_fast_b_iir1_csrstorage8_storage_full[24];
assign linien_csrbank3_iir_d_2_b12_w = linien_fast_b_iir1_csrstorage8_storage_full[23:16];
assign linien_csrbank3_iir_d_2_b11_w = linien_fast_b_iir1_csrstorage8_storage_full[15:8];
assign linien_csrbank3_iir_d_2_b10_w = linien_fast_b_iir1_csrstorage8_storage_full[7:0];
assign linien_fast_b_iir1_csrstorage9_storage = linien_fast_b_iir1_csrstorage9_storage_full[24:0];
assign linien_csrbank3_iir_d_2_b23_w = linien_fast_b_iir1_csrstorage9_storage_full[24];
assign linien_csrbank3_iir_d_2_b22_w = linien_fast_b_iir1_csrstorage9_storage_full[23:16];
assign linien_csrbank3_iir_d_2_b21_w = linien_fast_b_iir1_csrstorage9_storage_full[15:8];
assign linien_csrbank3_iir_d_2_b20_w = linien_fast_b_iir1_csrstorage9_storage_full[7:0];
assign linien_fast_b_limitcsr1_min_storage1 = linien_fast_b_limitcsr1_min_storage_full1[24:0];
assign linien_csrbank3_y_limit_2_min3_w = linien_fast_b_limitcsr1_min_storage_full1[24];
assign linien_csrbank3_y_limit_2_min2_w = linien_fast_b_limitcsr1_min_storage_full1[23:16];
assign linien_csrbank3_y_limit_2_min1_w = linien_fast_b_limitcsr1_min_storage_full1[15:8];
assign linien_csrbank3_y_limit_2_min0_w = linien_fast_b_limitcsr1_min_storage_full1[7:0];
assign linien_fast_b_limitcsr1_max_storage1 = linien_fast_b_limitcsr1_max_storage_full1[24:0];
assign linien_csrbank3_y_limit_2_max3_w = linien_fast_b_limitcsr1_max_storage_full1[24];
assign linien_csrbank3_y_limit_2_max2_w = linien_fast_b_limitcsr1_max_storage_full1[23:16];
assign linien_csrbank3_y_limit_2_max1_w = linien_fast_b_limitcsr1_max_storage_full1[15:8];
assign linien_csrbank3_y_limit_2_max0_w = linien_fast_b_limitcsr1_max_storage_full1[7:0];
assign linien_csrbank3_x_max3_w = linien_max_status3[24];
assign linien_csrbank3_x_max2_w = linien_max_status3[23:16];
assign linien_csrbank3_x_max1_w = linien_max_status3[15:8];
assign linien_csrbank3_x_max0_w = linien_max_status3[7:0];
assign linien_csrbank3_x_min3_w = linien_min_status3[24];
assign linien_csrbank3_x_min2_w = linien_min_status3[23:16];
assign linien_csrbank3_x_min1_w = linien_min_status3[15:8];
assign linien_csrbank3_x_min0_w = linien_min_status3[7:0];
assign linien_csrbank3_out_i_max3_w = linien_max_status4[24];
assign linien_csrbank3_out_i_max2_w = linien_max_status4[23:16];
assign linien_csrbank3_out_i_max1_w = linien_max_status4[15:8];
assign linien_csrbank3_out_i_max0_w = linien_max_status4[7:0];
assign linien_csrbank3_out_i_min3_w = linien_min_status4[24];
assign linien_csrbank3_out_i_min2_w = linien_min_status4[23:16];
assign linien_csrbank3_out_i_min1_w = linien_min_status4[15:8];
assign linien_csrbank3_out_i_min0_w = linien_min_status4[7:0];
assign linien_csrbank3_out_q_max3_w = linien_max_status5[24];
assign linien_csrbank3_out_q_max2_w = linien_max_status5[23:16];
assign linien_csrbank3_out_q_max1_w = linien_max_status5[15:8];
assign linien_csrbank3_out_q_max0_w = linien_max_status5[7:0];
assign linien_csrbank3_out_q_min3_w = linien_min_status5[24];
assign linien_csrbank3_out_q_min2_w = linien_min_status5[23:16];
assign linien_csrbank3_out_q_min1_w = linien_min_status5[15:8];
assign linien_csrbank3_out_q_min0_w = linien_min_status5[7:0];
assign linien_csrstorage10_storage = linien_csrstorage10_storage_full[3:0];
assign linien_csrbank3_dx_sel0_w = linien_csrstorage10_storage_full[3:0];
assign linien_csrstorage11_storage = linien_csrstorage11_storage_full[3:0];
assign linien_csrbank3_dy_sel0_w = linien_csrstorage11_storage_full[3:0];
assign linien_csrbank4_sel = (linien_interface4_bank_bus_adr[13:9] == 5'd30);
assign linien_csrbank4_ins_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_ins_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 1'd0));
assign linien_csrbank4_outs0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_outs0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 1'd1));
assign linien_csrbank4_oes0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_oes0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 2'd2));
assign linien_csrbank4_state1_r = linien_interface4_bank_bus_dat_w[0];
assign linien_csrbank4_state1_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 2'd3));
assign linien_csrbank4_state0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_state0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 3'd4));
assign linien_state_clr_r = linien_interface4_bank_bus_dat_w[0];
assign linien_state_clr_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 3'd5));
assign linien_csrbank4_do0_en1_r = linien_interface4_bank_bus_dat_w[0];
assign linien_csrbank4_do0_en1_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 3'd6));
assign linien_csrbank4_do0_en0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_do0_en0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 3'd7));
assign linien_csrbank4_do1_en1_r = linien_interface4_bank_bus_dat_w[0];
assign linien_csrbank4_do1_en1_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 4'd8));
assign linien_csrbank4_do1_en0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_do1_en0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 4'd9));
assign linien_csrbank4_do2_en1_r = linien_interface4_bank_bus_dat_w[0];
assign linien_csrbank4_do2_en1_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 4'd10));
assign linien_csrbank4_do2_en0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_do2_en0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 4'd11));
assign linien_csrbank4_do3_en1_r = linien_interface4_bank_bus_dat_w[0];
assign linien_csrbank4_do3_en1_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 4'd12));
assign linien_csrbank4_do3_en0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_do3_en0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 4'd13));
assign linien_csrbank4_do4_en1_r = linien_interface4_bank_bus_dat_w[0];
assign linien_csrbank4_do4_en1_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 4'd14));
assign linien_csrbank4_do4_en0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_do4_en0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 4'd15));
assign linien_csrbank4_do5_en1_r = linien_interface4_bank_bus_dat_w[0];
assign linien_csrbank4_do5_en1_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 5'd16));
assign linien_csrbank4_do5_en0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_do5_en0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 5'd17));
assign linien_csrbank4_do6_en1_r = linien_interface4_bank_bus_dat_w[0];
assign linien_csrbank4_do6_en1_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 5'd18));
assign linien_csrbank4_do6_en0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_do6_en0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 5'd19));
assign linien_csrbank4_do7_en1_r = linien_interface4_bank_bus_dat_w[0];
assign linien_csrbank4_do7_en1_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 5'd20));
assign linien_csrbank4_do7_en0_r = linien_interface4_bank_bus_dat_w[7:0];
assign linien_csrbank4_do7_en0_re = ((linien_csrbank4_sel & linien_interface4_bank_bus_we) & (linien_interface4_bank_bus_adr[4:0] == 5'd21));
assign linien_csrbank4_ins_w = linien_gpio_n_status[7:0];
assign linien_gpio_n_outs_storage = linien_gpio_n_outs_storage_full[7:0];
assign linien_csrbank4_outs0_w = linien_gpio_n_outs_storage_full[7:0];
assign linien_gpio_n_oes_storage = linien_gpio_n_oes_storage_full[7:0];
assign linien_csrbank4_oes0_w = linien_gpio_n_oes_storage_full[7:0];
assign linien_csrbank4_state1_w = linien_state_status[8];
assign linien_csrbank4_state0_w = linien_state_status[7:0];
assign linien_csrstorage0_storage = linien_csrstorage0_storage_full[8:0];
assign linien_csrbank4_do0_en1_w = linien_csrstorage0_storage_full[8];
assign linien_csrbank4_do0_en0_w = linien_csrstorage0_storage_full[7:0];
assign linien_csrstorage1_storage = linien_csrstorage1_storage_full[8:0];
assign linien_csrbank4_do1_en1_w = linien_csrstorage1_storage_full[8];
assign linien_csrbank4_do1_en0_w = linien_csrstorage1_storage_full[7:0];
assign linien_csrstorage2_storage = linien_csrstorage2_storage_full[8:0];
assign linien_csrbank4_do2_en1_w = linien_csrstorage2_storage_full[8];
assign linien_csrbank4_do2_en0_w = linien_csrstorage2_storage_full[7:0];
assign linien_csrstorage3_storage = linien_csrstorage3_storage_full[8:0];
assign linien_csrbank4_do3_en1_w = linien_csrstorage3_storage_full[8];
assign linien_csrbank4_do3_en0_w = linien_csrstorage3_storage_full[7:0];
assign linien_csrstorage4_storage = linien_csrstorage4_storage_full[8:0];
assign linien_csrbank4_do4_en1_w = linien_csrstorage4_storage_full[8];
assign linien_csrbank4_do4_en0_w = linien_csrstorage4_storage_full[7:0];
assign linien_csrstorage5_storage = linien_csrstorage5_storage_full[8:0];
assign linien_csrbank4_do5_en1_w = linien_csrstorage5_storage_full[8];
assign linien_csrbank4_do5_en0_w = linien_csrstorage5_storage_full[7:0];
assign linien_csrstorage6_storage = linien_csrstorage6_storage_full[8:0];
assign linien_csrbank4_do6_en1_w = linien_csrstorage6_storage_full[8];
assign linien_csrbank4_do6_en0_w = linien_csrstorage6_storage_full[7:0];
assign linien_csrstorage7_storage = linien_csrstorage7_storage_full[8:0];
assign linien_csrbank4_do7_en1_w = linien_csrstorage7_storage_full[8];
assign linien_csrbank4_do7_en0_w = linien_csrstorage7_storage_full[7:0];
assign linien_csrbank5_sel = (linien_interface5_bank_bus_adr[13:9] == 5'd31);
assign linien_csrbank5_ins_r = linien_interface5_bank_bus_dat_w[7:0];
assign linien_csrbank5_ins_re = ((linien_csrbank5_sel & linien_interface5_bank_bus_we) & (linien_interface5_bank_bus_adr[1:0] == 1'd0));
assign linien_csrbank5_outs0_r = linien_interface5_bank_bus_dat_w[7:0];
assign linien_csrbank5_outs0_re = ((linien_csrbank5_sel & linien_interface5_bank_bus_we) & (linien_interface5_bank_bus_adr[1:0] == 1'd1));
assign linien_csrbank5_oes0_r = linien_interface5_bank_bus_dat_w[7:0];
assign linien_csrbank5_oes0_re = ((linien_csrbank5_sel & linien_interface5_bank_bus_we) & (linien_interface5_bank_bus_adr[1:0] == 2'd2));
assign linien_csrbank5_ins_w = linien_gpio_p_status[7:0];
assign linien_gpio_p_outs_storage = linien_gpio_p_outs_storage_full[7:0];
assign linien_csrbank5_outs0_w = linien_gpio_p_outs_storage_full[7:0];
assign linien_gpio_p_oes_storage = linien_gpio_p_oes_storage_full[7:0];
assign linien_csrbank5_oes0_w = linien_gpio_p_oes_storage_full[7:0];
assign linien_csrbank6_sel = (linien_interface6_bank_bus_adr[13:9] == 4'd10);
assign linien_csrbank6_x_target_cmd3_r = linien_interface6_bank_bus_dat_w[0];
assign linien_csrbank6_x_target_cmd3_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 1'd0));
assign linien_csrbank6_x_target_cmd2_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_x_target_cmd2_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 1'd1));
assign linien_csrbank6_x_target_cmd1_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_x_target_cmd1_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 2'd2));
assign linien_csrbank6_x_target_cmd0_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_x_target_cmd0_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 2'd3));
assign linien_csrbank6_f_target_cmd3_r = linien_interface6_bank_bus_dat_w[0];
assign linien_csrbank6_f_target_cmd3_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 3'd4));
assign linien_csrbank6_f_target_cmd2_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_f_target_cmd2_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 3'd5));
assign linien_csrbank6_f_target_cmd1_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_f_target_cmd1_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 3'd6));
assign linien_csrbank6_f_target_cmd0_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_f_target_cmd0_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 3'd7));
assign linien_csrbank6_t_target_cmd3_r = linien_interface6_bank_bus_dat_w[0];
assign linien_csrbank6_t_target_cmd3_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 4'd8));
assign linien_csrbank6_t_target_cmd2_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_t_target_cmd2_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 4'd9));
assign linien_csrbank6_t_target_cmd1_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_t_target_cmd1_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 4'd10));
assign linien_csrbank6_t_target_cmd0_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_t_target_cmd0_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 4'd11));
assign linien_csrbank6_power_threshold_target_cmd3_r = linien_interface6_bank_bus_dat_w[0];
assign linien_csrbank6_power_threshold_target_cmd3_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 4'd12));
assign linien_csrbank6_power_threshold_target_cmd2_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_power_threshold_target_cmd2_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 4'd13));
assign linien_csrbank6_power_threshold_target_cmd1_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_power_threshold_target_cmd1_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 4'd14));
assign linien_csrbank6_power_threshold_target_cmd0_r = linien_interface6_bank_bus_dat_w[7:0];
assign linien_csrbank6_power_threshold_target_cmd0_re = ((linien_csrbank6_sel & linien_interface6_bank_bus_we) & (linien_interface6_bank_bus_adr[3:0] == 4'd15));
assign linien_x_target_cmd_storage = linien_x_target_cmd_storage_full[24:0];
assign linien_csrbank6_x_target_cmd3_w = linien_x_target_cmd_storage_full[24];
assign linien_csrbank6_x_target_cmd2_w = linien_x_target_cmd_storage_full[23:16];
assign linien_csrbank6_x_target_cmd1_w = linien_x_target_cmd_storage_full[15:8];
assign linien_csrbank6_x_target_cmd0_w = linien_x_target_cmd_storage_full[7:0];
assign linien_f_target_cmd_storage = linien_f_target_cmd_storage_full[24:0];
assign linien_csrbank6_f_target_cmd3_w = linien_f_target_cmd_storage_full[24];
assign linien_csrbank6_f_target_cmd2_w = linien_f_target_cmd_storage_full[23:16];
assign linien_csrbank6_f_target_cmd1_w = linien_f_target_cmd_storage_full[15:8];
assign linien_csrbank6_f_target_cmd0_w = linien_f_target_cmd_storage_full[7:0];
assign linien_t_target_cmd_storage = linien_t_target_cmd_storage_full[24:0];
assign linien_csrbank6_t_target_cmd3_w = linien_t_target_cmd_storage_full[24];
assign linien_csrbank6_t_target_cmd2_w = linien_t_target_cmd_storage_full[23:16];
assign linien_csrbank6_t_target_cmd1_w = linien_t_target_cmd_storage_full[15:8];
assign linien_csrbank6_t_target_cmd0_w = linien_t_target_cmd_storage_full[7:0];
assign linien_power_threshold_target_cmd_storage = linien_power_threshold_target_cmd_storage_full[24:0];
assign linien_csrbank6_power_threshold_target_cmd3_w = linien_power_threshold_target_cmd_storage_full[24];
assign linien_csrbank6_power_threshold_target_cmd2_w = linien_power_threshold_target_cmd_storage_full[23:16];
assign linien_csrbank6_power_threshold_target_cmd1_w = linien_power_threshold_target_cmd_storage_full[15:8];
assign linien_csrbank6_power_threshold_target_cmd0_w = linien_power_threshold_target_cmd_storage_full[7:0];
assign linien_csrbank7_sel = (linien_interface7_bank_bus_adr[13:9] == 4'd8);
assign linien_csrbank7_pid_only_mode0_r = linien_interface7_bank_bus_dat_w[0];
assign linien_csrbank7_pid_only_mode0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 1'd0));
assign linien_csrbank7_chain_a_factor1_r = linien_interface7_bank_bus_dat_w[0];
assign linien_csrbank7_chain_a_factor1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 1'd1));
assign linien_csrbank7_chain_a_factor0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_chain_a_factor0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 2'd2));
assign linien_csrbank7_chain_b_factor1_r = linien_interface7_bank_bus_dat_w[0];
assign linien_csrbank7_chain_b_factor1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 2'd3));
assign linien_csrbank7_chain_b_factor0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_chain_b_factor0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 3'd4));
assign linien_csrbank7_chain_a_offset1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_chain_a_offset1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 3'd5));
assign linien_csrbank7_chain_a_offset0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_chain_a_offset0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 3'd6));
assign linien_csrbank7_chain_b_offset1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_chain_b_offset1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 3'd7));
assign linien_csrbank7_chain_b_offset0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_chain_b_offset0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 4'd8));
assign linien_csrbank7_combined_offset1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_combined_offset1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 4'd9));
assign linien_csrbank7_combined_offset0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_combined_offset0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 4'd10));
assign linien_csrbank7_out_offset1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_out_offset1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 4'd11));
assign linien_csrbank7_out_offset0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_out_offset0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 4'd12));
assign linien_csrbank7_slow_decimation0_r = linien_interface7_bank_bus_dat_w[4:0];
assign linien_csrbank7_slow_decimation0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 4'd13));
assign linien_csrbank7_analog_out_11_r = linien_interface7_bank_bus_dat_w[6:0];
assign linien_csrbank7_analog_out_11_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 4'd14));
assign linien_csrbank7_analog_out_10_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_analog_out_10_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 4'd15));
assign linien_csrbank7_analog_out_21_r = linien_interface7_bank_bus_dat_w[6:0];
assign linien_csrbank7_analog_out_21_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd16));
assign linien_csrbank7_analog_out_20_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_analog_out_20_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd17));
assign linien_csrbank7_analog_out_31_r = linien_interface7_bank_bus_dat_w[6:0];
assign linien_csrbank7_analog_out_31_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd18));
assign linien_csrbank7_analog_out_30_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_analog_out_30_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd19));
assign linien_csrbank7_slow_value1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_slow_value1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd20));
assign linien_csrbank7_slow_value0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_slow_value0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd21));
assign linien_csrbank7_mod_amp1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_mod_amp1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd22));
assign linien_csrbank7_mod_amp0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_mod_amp0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd23));
assign linien_csrbank7_mod_freq3_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_mod_freq3_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd24));
assign linien_csrbank7_mod_freq2_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_mod_freq2_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd25));
assign linien_csrbank7_mod_freq1_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_mod_freq1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd26));
assign linien_csrbank7_mod_freq0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_mod_freq0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd27));
assign linien_csrbank7_limit_error_signal_min3_r = linien_interface7_bank_bus_dat_w[0];
assign linien_csrbank7_limit_error_signal_min3_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd28));
assign linien_csrbank7_limit_error_signal_min2_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_error_signal_min2_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd29));
assign linien_csrbank7_limit_error_signal_min1_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_error_signal_min1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd30));
assign linien_csrbank7_limit_error_signal_min0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_error_signal_min0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 5'd31));
assign linien_csrbank7_limit_error_signal_max3_r = linien_interface7_bank_bus_dat_w[0];
assign linien_csrbank7_limit_error_signal_max3_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd32));
assign linien_csrbank7_limit_error_signal_max2_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_error_signal_max2_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd33));
assign linien_csrbank7_limit_error_signal_max1_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_error_signal_max1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd34));
assign linien_csrbank7_limit_error_signal_max0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_error_signal_max0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd35));
assign linien_csrbank7_limit_fast1_min1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_limit_fast1_min1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd36));
assign linien_csrbank7_limit_fast1_min0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_fast1_min0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd37));
assign linien_csrbank7_limit_fast1_max1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_limit_fast1_max1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd38));
assign linien_csrbank7_limit_fast1_max0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_fast1_max0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd39));
assign linien_csrbank7_limit_fast2_min1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_limit_fast2_min1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd40));
assign linien_csrbank7_limit_fast2_min0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_fast2_min0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd41));
assign linien_csrbank7_limit_fast2_max1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_limit_fast2_max1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd42));
assign linien_csrbank7_limit_fast2_max0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_limit_fast2_max0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd43));
assign linien_csrbank7_pid_setpoint3_r = linien_interface7_bank_bus_dat_w[0];
assign linien_csrbank7_pid_setpoint3_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd44));
assign linien_csrbank7_pid_setpoint2_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_pid_setpoint2_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd45));
assign linien_csrbank7_pid_setpoint1_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_pid_setpoint1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd46));
assign linien_csrbank7_pid_setpoint0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_pid_setpoint0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd47));
assign linien_csrbank7_pid_kp1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_pid_kp1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd48));
assign linien_csrbank7_pid_kp0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_pid_kp0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd49));
assign linien_csrbank7_pid_ki1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_pid_ki1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd50));
assign linien_csrbank7_pid_ki0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_pid_ki0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd51));
assign linien_csrbank7_pid_reset0_r = linien_interface7_bank_bus_dat_w[0];
assign linien_csrbank7_pid_reset0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd52));
assign linien_csrbank7_pid_kd1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_pid_kd1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd53));
assign linien_csrbank7_pid_kd0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_pid_kd0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd54));
assign linien_control_signal_clr_r = linien_interface7_bank_bus_dat_w[0];
assign linien_control_signal_clr_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd55));
assign linien_csrbank7_control_signal_max1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_control_signal_max1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd56));
assign linien_csrbank7_control_signal_max0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_control_signal_max0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd57));
assign linien_csrbank7_control_signal_min1_r = linien_interface7_bank_bus_dat_w[5:0];
assign linien_csrbank7_control_signal_min1_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd58));
assign linien_csrbank7_control_signal_min0_r = linien_interface7_bank_bus_dat_w[7:0];
assign linien_csrbank7_control_signal_min0_re = ((linien_csrbank7_sel & linien_interface7_bank_bus_we) & (linien_interface7_bank_bus_adr[5:0] == 6'd59));
assign linien_logic_pid_only_mode_storage = linien_logic_pid_only_mode_storage_full;
assign linien_csrbank7_pid_only_mode0_w = linien_logic_pid_only_mode_storage_full;
assign linien_logic_chain_a_factor_storage = linien_logic_chain_a_factor_storage_full[8:0];
assign linien_csrbank7_chain_a_factor1_w = linien_logic_chain_a_factor_storage_full[8];
assign linien_csrbank7_chain_a_factor0_w = linien_logic_chain_a_factor_storage_full[7:0];
assign linien_logic_chain_b_factor_storage = linien_logic_chain_b_factor_storage_full[8:0];
assign linien_csrbank7_chain_b_factor1_w = linien_logic_chain_b_factor_storage_full[8];
assign linien_csrbank7_chain_b_factor0_w = linien_logic_chain_b_factor_storage_full[7:0];
assign linien_logic_chain_a_offset_storage = linien_logic_chain_a_offset_storage_full[13:0];
assign linien_csrbank7_chain_a_offset1_w = linien_logic_chain_a_offset_storage_full[13:8];
assign linien_csrbank7_chain_a_offset0_w = linien_logic_chain_a_offset_storage_full[7:0];
assign linien_logic_chain_b_offset_storage = linien_logic_chain_b_offset_storage_full[13:0];
assign linien_csrbank7_chain_b_offset1_w = linien_logic_chain_b_offset_storage_full[13:8];
assign linien_csrbank7_chain_b_offset0_w = linien_logic_chain_b_offset_storage_full[7:0];
assign linien_logic_combined_offset_storage = linien_logic_combined_offset_storage_full[13:0];
assign linien_csrbank7_combined_offset1_w = linien_logic_combined_offset_storage_full[13:8];
assign linien_csrbank7_combined_offset0_w = linien_logic_combined_offset_storage_full[7:0];
assign linien_logic_out_offset_storage = linien_logic_out_offset_storage_full[13:0];
assign linien_csrbank7_out_offset1_w = linien_logic_out_offset_storage_full[13:8];
assign linien_csrbank7_out_offset0_w = linien_logic_out_offset_storage_full[7:0];
assign linien_logic_slow_decimation_storage = linien_logic_slow_decimation_storage_full[4:0];
assign linien_csrbank7_slow_decimation0_w = linien_logic_slow_decimation_storage_full[4:0];
assign linien_logic_csrstorage0_storage = linien_logic_csrstorage0_storage_full[14:0];
assign linien_csrbank7_analog_out_11_w = linien_logic_csrstorage0_storage_full[14:8];
assign linien_csrbank7_analog_out_10_w = linien_logic_csrstorage0_storage_full[7:0];
assign linien_logic_csrstorage1_storage = linien_logic_csrstorage1_storage_full[14:0];
assign linien_csrbank7_analog_out_21_w = linien_logic_csrstorage1_storage_full[14:8];
assign linien_csrbank7_analog_out_20_w = linien_logic_csrstorage1_storage_full[7:0];
assign linien_logic_csrstorage2_storage = linien_logic_csrstorage2_storage_full[14:0];
assign linien_csrbank7_analog_out_31_w = linien_logic_csrstorage2_storage_full[14:8];
assign linien_csrbank7_analog_out_30_w = linien_logic_csrstorage2_storage_full[7:0];
assign linien_csrbank7_slow_value1_w = linien_logic_status[13:8];
assign linien_csrbank7_slow_value0_w = linien_logic_status[7:0];
assign linien_logic_amp_storage = linien_logic_amp_storage_full[13:0];
assign linien_csrbank7_mod_amp1_w = linien_logic_amp_storage_full[13:8];
assign linien_csrbank7_mod_amp0_w = linien_logic_amp_storage_full[7:0];
assign linien_logic_freq_storage = linien_logic_freq_storage_full[31:0];
assign linien_csrbank7_mod_freq3_w = linien_logic_freq_storage_full[31:24];
assign linien_csrbank7_mod_freq2_w = linien_logic_freq_storage_full[23:16];
assign linien_csrbank7_mod_freq1_w = linien_logic_freq_storage_full[15:8];
assign linien_csrbank7_mod_freq0_w = linien_logic_freq_storage_full[7:0];
assign linien_logic_limit_error_signal_min_storage = linien_logic_limit_error_signal_min_storage_full[24:0];
assign linien_csrbank7_limit_error_signal_min3_w = linien_logic_limit_error_signal_min_storage_full[24];
assign linien_csrbank7_limit_error_signal_min2_w = linien_logic_limit_error_signal_min_storage_full[23:16];
assign linien_csrbank7_limit_error_signal_min1_w = linien_logic_limit_error_signal_min_storage_full[15:8];
assign linien_csrbank7_limit_error_signal_min0_w = linien_logic_limit_error_signal_min_storage_full[7:0];
assign linien_logic_limit_error_signal_max_storage = linien_logic_limit_error_signal_max_storage_full[24:0];
assign linien_csrbank7_limit_error_signal_max3_w = linien_logic_limit_error_signal_max_storage_full[24];
assign linien_csrbank7_limit_error_signal_max2_w = linien_logic_limit_error_signal_max_storage_full[23:16];
assign linien_csrbank7_limit_error_signal_max1_w = linien_logic_limit_error_signal_max_storage_full[15:8];
assign linien_csrbank7_limit_error_signal_max0_w = linien_logic_limit_error_signal_max_storage_full[7:0];
assign linien_logic_limit_fast1_min_storage = linien_logic_limit_fast1_min_storage_full[13:0];
assign linien_csrbank7_limit_fast1_min1_w = linien_logic_limit_fast1_min_storage_full[13:8];
assign linien_csrbank7_limit_fast1_min0_w = linien_logic_limit_fast1_min_storage_full[7:0];
assign linien_logic_limit_fast1_max_storage = linien_logic_limit_fast1_max_storage_full[13:0];
assign linien_csrbank7_limit_fast1_max1_w = linien_logic_limit_fast1_max_storage_full[13:8];
assign linien_csrbank7_limit_fast1_max0_w = linien_logic_limit_fast1_max_storage_full[7:0];
assign linien_logic_limit_fast2_min_storage = linien_logic_limit_fast2_min_storage_full[13:0];
assign linien_csrbank7_limit_fast2_min1_w = linien_logic_limit_fast2_min_storage_full[13:8];
assign linien_csrbank7_limit_fast2_min0_w = linien_logic_limit_fast2_min_storage_full[7:0];
assign linien_logic_limit_fast2_max_storage = linien_logic_limit_fast2_max_storage_full[13:0];
assign linien_csrbank7_limit_fast2_max1_w = linien_logic_limit_fast2_max_storage_full[13:8];
assign linien_csrbank7_limit_fast2_max0_w = linien_logic_limit_fast2_max_storage_full[7:0];
assign linien_logic_setpoint_storage = linien_logic_setpoint_storage_full[24:0];
assign linien_csrbank7_pid_setpoint3_w = linien_logic_setpoint_storage_full[24];
assign linien_csrbank7_pid_setpoint2_w = linien_logic_setpoint_storage_full[23:16];
assign linien_csrbank7_pid_setpoint1_w = linien_logic_setpoint_storage_full[15:8];
assign linien_csrbank7_pid_setpoint0_w = linien_logic_setpoint_storage_full[7:0];
assign linien_logic_kp_storage = linien_logic_kp_storage_full[13:0];
assign linien_csrbank7_pid_kp1_w = linien_logic_kp_storage_full[13:8];
assign linien_csrbank7_pid_kp0_w = linien_logic_kp_storage_full[7:0];
assign linien_logic_ki_storage = linien_logic_ki_storage_full[13:0];
assign linien_csrbank7_pid_ki1_w = linien_logic_ki_storage_full[13:8];
assign linien_csrbank7_pid_ki0_w = linien_logic_ki_storage_full[7:0];
assign linien_logic_reset_storage = linien_logic_reset_storage_full;
assign linien_csrbank7_pid_reset0_w = linien_logic_reset_storage_full;
assign linien_logic_kd_storage = linien_logic_kd_storage_full[13:0];
assign linien_csrbank7_pid_kd1_w = linien_logic_kd_storage_full[13:8];
assign linien_csrbank7_pid_kd0_w = linien_logic_kd_storage_full[7:0];
assign linien_csrbank7_control_signal_max1_w = linien_max_status10[13:8];
assign linien_csrbank7_control_signal_max0_w = linien_max_status10[7:0];
assign linien_csrbank7_control_signal_min1_w = linien_min_status10[13:8];
assign linien_csrbank7_control_signal_min0_w = linien_min_status10[7:0];
assign linien_csrbank8_sel = (linien_interface8_bank_bus_adr[13:9] == 4'd11);
assign linien_csrbank8_fsm_state_r = linien_interface8_bank_bus_dat_w[1:0];
assign linien_csrbank8_fsm_state_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 1'd0));
assign linien_csrbank8_time_command_out3_r = linien_interface8_bank_bus_dat_w[0];
assign linien_csrbank8_time_command_out3_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 1'd1));
assign linien_csrbank8_time_command_out2_r = linien_interface8_bank_bus_dat_w[7:0];
assign linien_csrbank8_time_command_out2_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 2'd2));
assign linien_csrbank8_time_command_out1_r = linien_interface8_bank_bus_dat_w[7:0];
assign linien_csrbank8_time_command_out1_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 2'd3));
assign linien_csrbank8_time_command_out0_r = linien_interface8_bank_bus_dat_w[7:0];
assign linien_csrbank8_time_command_out0_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 3'd4));
assign linien_time_command_out_clr_r = linien_interface8_bank_bus_dat_w[0];
assign linien_time_command_out_clr_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 3'd5));
assign linien_csrbank8_time_command_out_max3_r = linien_interface8_bank_bus_dat_w[0];
assign linien_csrbank8_time_command_out_max3_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 3'd6));
assign linien_csrbank8_time_command_out_max2_r = linien_interface8_bank_bus_dat_w[7:0];
assign linien_csrbank8_time_command_out_max2_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 3'd7));
assign linien_csrbank8_time_command_out_max1_r = linien_interface8_bank_bus_dat_w[7:0];
assign linien_csrbank8_time_command_out_max1_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 4'd8));
assign linien_csrbank8_time_command_out_max0_r = linien_interface8_bank_bus_dat_w[7:0];
assign linien_csrbank8_time_command_out_max0_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 4'd9));
assign linien_csrbank8_time_command_out_min3_r = linien_interface8_bank_bus_dat_w[0];
assign linien_csrbank8_time_command_out_min3_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 4'd10));
assign linien_csrbank8_time_command_out_min2_r = linien_interface8_bank_bus_dat_w[7:0];
assign linien_csrbank8_time_command_out_min2_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 4'd11));
assign linien_csrbank8_time_command_out_min1_r = linien_interface8_bank_bus_dat_w[7:0];
assign linien_csrbank8_time_command_out_min1_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 4'd12));
assign linien_csrbank8_time_command_out_min0_r = linien_interface8_bank_bus_dat_w[7:0];
assign linien_csrbank8_time_command_out_min0_re = ((linien_csrbank8_sel & linien_interface8_bank_bus_we) & (linien_interface8_bank_bus_adr[3:0] == 4'd13));
assign linien_csrbank8_fsm_state_w = linien_fsm_state_status_status[1:0];
assign linien_csrbank8_time_command_out3_w = linien_time_command_out_status_status[24];
assign linien_csrbank8_time_command_out2_w = linien_time_command_out_status_status[23:16];
assign linien_csrbank8_time_command_out1_w = linien_time_command_out_status_status[15:8];
assign linien_csrbank8_time_command_out0_w = linien_time_command_out_status_status[7:0];
assign linien_csrbank8_time_command_out_max3_w = linien_max_status11[24];
assign linien_csrbank8_time_command_out_max2_w = linien_max_status11[23:16];
assign linien_csrbank8_time_command_out_max1_w = linien_max_status11[15:8];
assign linien_csrbank8_time_command_out_max0_w = linien_max_status11[7:0];
assign linien_csrbank8_time_command_out_min3_w = linien_min_status11[24];
assign linien_csrbank8_time_command_out_min2_w = linien_min_status11[23:16];
assign linien_csrbank8_time_command_out_min1_w = linien_min_status11[15:8];
assign linien_csrbank8_time_command_out_min0_w = linien_min_status11[7:0];
assign linien_csrbank9_sel = (linien_interface9_bank_bus_adr[13:9] == 3'd6);
assign linien_csrbank9_external_trigger0_r = linien_interface9_bank_bus_dat_w[0];
assign linien_csrbank9_external_trigger0_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 1'd0));
assign linien_dac_a_clr_r = linien_interface9_bank_bus_dat_w[0];
assign linien_dac_a_clr_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 1'd1));
assign linien_csrbank9_dac_a_max3_r = linien_interface9_bank_bus_dat_w[0];
assign linien_csrbank9_dac_a_max3_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 2'd2));
assign linien_csrbank9_dac_a_max2_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_a_max2_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 2'd3));
assign linien_csrbank9_dac_a_max1_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_a_max1_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 3'd4));
assign linien_csrbank9_dac_a_max0_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_a_max0_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 3'd5));
assign linien_csrbank9_dac_a_min3_r = linien_interface9_bank_bus_dat_w[0];
assign linien_csrbank9_dac_a_min3_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 3'd6));
assign linien_csrbank9_dac_a_min2_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_a_min2_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 3'd7));
assign linien_csrbank9_dac_a_min1_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_a_min1_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 4'd8));
assign linien_csrbank9_dac_a_min0_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_a_min0_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 4'd9));
assign linien_dac_b_clr_r = linien_interface9_bank_bus_dat_w[0];
assign linien_dac_b_clr_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 4'd10));
assign linien_csrbank9_dac_b_max3_r = linien_interface9_bank_bus_dat_w[0];
assign linien_csrbank9_dac_b_max3_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 4'd11));
assign linien_csrbank9_dac_b_max2_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_b_max2_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 4'd12));
assign linien_csrbank9_dac_b_max1_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_b_max1_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 4'd13));
assign linien_csrbank9_dac_b_max0_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_b_max0_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 4'd14));
assign linien_csrbank9_dac_b_min3_r = linien_interface9_bank_bus_dat_w[0];
assign linien_csrbank9_dac_b_min3_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 4'd15));
assign linien_csrbank9_dac_b_min2_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_b_min2_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 5'd16));
assign linien_csrbank9_dac_b_min1_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_b_min1_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 5'd17));
assign linien_csrbank9_dac_b_min0_r = linien_interface9_bank_bus_dat_w[7:0];
assign linien_csrbank9_dac_b_min0_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 5'd18));
assign linien_csrbank9_adc_a_sel0_r = linien_interface9_bank_bus_dat_w[3:0];
assign linien_csrbank9_adc_a_sel0_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 5'd19));
assign linien_csrbank9_adc_b_sel0_r = linien_interface9_bank_bus_dat_w[3:0];
assign linien_csrbank9_adc_b_sel0_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 5'd20));
assign linien_csrbank9_adc_a_q_sel0_r = linien_interface9_bank_bus_dat_w[3:0];
assign linien_csrbank9_adc_a_q_sel0_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 5'd21));
assign linien_csrbank9_adc_b_q_sel0_r = linien_interface9_bank_bus_dat_w[3:0];
assign linien_csrbank9_adc_b_q_sel0_re = ((linien_csrbank9_sel & linien_interface9_bank_bus_we) & (linien_interface9_bank_bus_adr[4:0] == 5'd22));
assign linien_scopegen_storage = linien_scopegen_storage_full;
assign linien_csrbank9_external_trigger0_w = linien_scopegen_storage_full;
assign linien_csrbank9_dac_a_max3_w = linien_max_status8[24];
assign linien_csrbank9_dac_a_max2_w = linien_max_status8[23:16];
assign linien_csrbank9_dac_a_max1_w = linien_max_status8[15:8];
assign linien_csrbank9_dac_a_max0_w = linien_max_status8[7:0];
assign linien_csrbank9_dac_a_min3_w = linien_min_status8[24];
assign linien_csrbank9_dac_a_min2_w = linien_min_status8[23:16];
assign linien_csrbank9_dac_a_min1_w = linien_min_status8[15:8];
assign linien_csrbank9_dac_a_min0_w = linien_min_status8[7:0];
assign linien_csrbank9_dac_b_max3_w = linien_max_status9[24];
assign linien_csrbank9_dac_b_max2_w = linien_max_status9[23:16];
assign linien_csrbank9_dac_b_max1_w = linien_max_status9[15:8];
assign linien_csrbank9_dac_b_max0_w = linien_max_status9[7:0];
assign linien_csrbank9_dac_b_min3_w = linien_min_status9[24];
assign linien_csrbank9_dac_b_min2_w = linien_min_status9[23:16];
assign linien_csrbank9_dac_b_min1_w = linien_min_status9[15:8];
assign linien_csrbank9_dac_b_min0_w = linien_min_status9[7:0];
assign linien_csrstorage12_storage = linien_csrstorage12_storage_full[3:0];
assign linien_csrbank9_adc_a_sel0_w = linien_csrstorage12_storage_full[3:0];
assign linien_csrstorage13_storage = linien_csrstorage13_storage_full[3:0];
assign linien_csrbank9_adc_b_sel0_w = linien_csrstorage13_storage_full[3:0];
assign linien_csrstorage14_storage = linien_csrstorage14_storage_full[3:0];
assign linien_csrbank9_adc_a_q_sel0_w = linien_csrstorage14_storage_full[3:0];
assign linien_csrstorage15_storage = linien_csrstorage15_storage_full[3:0];
assign linien_csrbank9_adc_b_q_sel0_w = linien_csrstorage15_storage_full[3:0];
assign linien_csrbank10_sel = (linien_interface10_bank_bus_adr[13:9] == 5'd29);
assign linien_csrbank10_temp1_r = linien_interface10_bank_bus_dat_w[3:0];
assign linien_csrbank10_temp1_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 1'd0));
assign linien_csrbank10_temp0_r = linien_interface10_bank_bus_dat_w[7:0];
assign linien_csrbank10_temp0_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 1'd1));
assign linien_csrbank10_v1_r = linien_interface10_bank_bus_dat_w[3:0];
assign linien_csrbank10_v1_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 2'd2));
assign linien_csrbank10_v0_r = linien_interface10_bank_bus_dat_w[7:0];
assign linien_csrbank10_v0_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 2'd3));
assign linien_csrbank10_a1_r = linien_interface10_bank_bus_dat_w[3:0];
assign linien_csrbank10_a1_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 3'd4));
assign linien_csrbank10_a0_r = linien_interface10_bank_bus_dat_w[7:0];
assign linien_csrbank10_a0_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 3'd5));
assign linien_csrbank10_b1_r = linien_interface10_bank_bus_dat_w[3:0];
assign linien_csrbank10_b1_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 3'd6));
assign linien_csrbank10_b0_r = linien_interface10_bank_bus_dat_w[7:0];
assign linien_csrbank10_b0_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 3'd7));
assign linien_csrbank10_c1_r = linien_interface10_bank_bus_dat_w[3:0];
assign linien_csrbank10_c1_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 4'd8));
assign linien_csrbank10_c0_r = linien_interface10_bank_bus_dat_w[7:0];
assign linien_csrbank10_c0_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 4'd9));
assign linien_csrbank10_d1_r = linien_interface10_bank_bus_dat_w[3:0];
assign linien_csrbank10_d1_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 4'd10));
assign linien_csrbank10_d0_r = linien_interface10_bank_bus_dat_w[7:0];
assign linien_csrbank10_d0_re = ((linien_csrbank10_sel & linien_interface10_bank_bus_we) & (linien_interface10_bank_bus_adr[3:0] == 4'd11));
assign linien_csrbank10_temp1_w = linien_xadc_temp_status[11:8];
assign linien_csrbank10_temp0_w = linien_xadc_temp_status[7:0];
assign linien_csrbank10_v1_w = linien_xadc_v_status[11:8];
assign linien_csrbank10_v0_w = linien_xadc_v_status[7:0];
assign linien_csrbank10_a1_w = linien_xadc_a_status[11:8];
assign linien_csrbank10_a0_w = linien_xadc_a_status[7:0];
assign linien_csrbank10_b1_w = linien_xadc_b_status[11:8];
assign linien_csrbank10_b0_w = linien_xadc_b_status[7:0];
assign linien_csrbank10_c1_w = linien_xadc_c_status[11:8];
assign linien_csrbank10_c0_w = linien_xadc_c_status[7:0];
assign linien_csrbank10_d1_w = linien_xadc_d_status[11:8];
assign linien_csrbank10_d0_w = linien_xadc_d_status[7:0];
assign linien_interface0_bank_bus_adr = linien_csr_adr;
assign linien_interface1_bank_bus_adr = linien_csr_adr;
assign linien_interface2_bank_bus_adr = linien_csr_adr;
assign linien_interface3_bank_bus_adr = linien_csr_adr;
assign linien_interface4_bank_bus_adr = linien_csr_adr;
assign linien_interface5_bank_bus_adr = linien_csr_adr;
assign linien_interface6_bank_bus_adr = linien_csr_adr;
assign linien_interface7_bank_bus_adr = linien_csr_adr;
assign linien_interface8_bank_bus_adr = linien_csr_adr;
assign linien_interface9_bank_bus_adr = linien_csr_adr;
assign linien_interface10_bank_bus_adr = linien_csr_adr;
assign linien_interface0_bank_bus_we = linien_csr_we;
assign linien_interface1_bank_bus_we = linien_csr_we;
assign linien_interface2_bank_bus_we = linien_csr_we;
assign linien_interface3_bank_bus_we = linien_csr_we;
assign linien_interface4_bank_bus_we = linien_csr_we;
assign linien_interface5_bank_bus_we = linien_csr_we;
assign linien_interface6_bank_bus_we = linien_csr_we;
assign linien_interface7_bank_bus_we = linien_csr_we;
assign linien_interface8_bank_bus_we = linien_csr_we;
assign linien_interface9_bank_bus_we = linien_csr_we;
assign linien_interface10_bank_bus_we = linien_csr_we;
assign linien_interface0_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface1_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface2_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface3_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface4_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface5_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface6_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface7_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface8_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface9_bank_bus_dat_w = linien_csr_dat_w;
assign linien_interface10_bank_bus_dat_w = linien_csr_dat_w;
assign linien_csr_dat_r = ((((((((((linien_interface0_bank_bus_dat_r | linien_interface1_bank_bus_dat_r) | linien_interface2_bank_bus_dat_r) | linien_interface3_bank_bus_dat_r) | linien_interface4_bank_bus_dat_r) | linien_interface5_bank_bus_dat_r) | linien_interface6_bank_bus_dat_r) | linien_interface7_bank_bus_dat_r) | linien_interface8_bank_bus_dat_r) | linien_interface9_bank_bus_dat_r) | linien_interface10_bank_bus_dat_r);
assign linien_target_clk = sys_clk;
assign linien_target_rstn = (~sys_rst);
assign dummyhk_sel = (dummyhk_bank_bus_adr[13:9] == 1'd0);
assign dummyhk_id_r = dummyhk_bank_bus_dat_w[0];
assign dummyhk_id_re = ((dummyhk_sel & dummyhk_bank_bus_we) & (dummyhk_bank_bus_adr[0] == 1'd0));
assign dummyhk_id_w = dummyhk_status;
assign dummyhk_bank_bus_adr = dummyhk_csr_adr;
assign dummyhk_bank_bus_we = dummyhk_csr_we;
assign dummyhk_bank_bus_dat_w = dummyhk_csr_dat_w;
assign dummyhk_csr_dat_r = dummyhk_bank_bus_dat_r;
assign ic_cs = ps_sys_addr[22:20];
assign ic_sel0 = (ic_cs == 1'd0);
assign dummyhk_sys_clk = ps_sys_clk;
assign dummyhk_sys_rstn = ps_sys_rstn;
assign dummyhk_sys_addr = ps_sys_addr;
assign dummyhk_sys_wdata = ps_sys_wdata;
assign dummyhk_sys_sel = ps_sys_sel;
assign dummyhk_sys_wen = (ic_sel0 & ps_sys_wen);
assign dummyhk_sys_ren = (ic_sel0 & ps_sys_ren);
assign ic_sel1 = (ic_cs == 1'd1);
assign linien_scopegen_scope_sys_clk = ps_sys_clk;
assign linien_scopegen_scope_sys_rstn = ps_sys_rstn;
assign linien_scopegen_scope_sys_addr = ps_sys_addr;
assign linien_scopegen_scope_sys_wdata = ps_sys_wdata;
assign linien_scopegen_scope_sys_sel = ps_sys_sel;
assign linien_scopegen_scope_sys_wen = (ic_sel1 & ps_sys_wen);
assign linien_scopegen_scope_sys_ren = (ic_sel1 & ps_sys_ren);
assign ic_sel2 = (ic_cs == 2'd2);
assign linien_scopegen_asg_sys_clk = ps_sys_clk;
assign linien_scopegen_asg_sys_rstn = ps_sys_rstn;
assign linien_scopegen_asg_sys_addr = ps_sys_addr;
assign linien_scopegen_asg_sys_wdata = ps_sys_wdata;
assign linien_scopegen_asg_sys_sel = ps_sys_sel;
assign linien_scopegen_asg_sys_wen = (ic_sel2 & ps_sys_wen);
assign linien_scopegen_asg_sys_ren = (ic_sel2 & ps_sys_ren);
assign ic_sel3 = (ic_cs == 2'd3);
assign linien_source_clk = ps_sys_clk;
assign linien_source_rstn = ps_sys_rstn;
assign linien_source_addr = ps_sys_addr;
assign linien_source_wdata = ps_sys_wdata;
assign linien_source_sel = ps_sys_sel;
assign linien_source_wen = (ic_sel3 & ps_sys_wen);
assign linien_source_ren = (ic_sel3 & ps_sys_ren);
assign {ps_sys_rdata, ps_sys_ack, ps_sys_err} = (((({34{ic_sel0}} & {dummyhk_sys_rdata, dummyhk_sys_ack, dummyhk_sys_err}) | ({34{ic_sel1}} & {linien_scopegen_scope_sys_rdata, linien_scopegen_scope_sys_ack, linien_scopegen_scope_sys_err})) | ({34{ic_sel2}} & {linien_scopegen_asg_sys_rdata, linien_scopegen_asg_sys_ack, linien_scopegen_asg_sys_err})) | ({34{ic_sel3}} & {linien_source_rdata, linien_source_ack, linien_source_err}));
assign slice_proxy0 = {xadc_n[4], {6{1'd0}}, xadc_n[3:2], {6{1'd0}}, xadc_n[1:0]};
assign slice_proxy1 = {xadc_p[4], {6{1'd0}}, xadc_p[3:2], {6{1'd0}}, xadc_p[1:0]};
assign slice_proxy2 = {xadc_n[4], {6{1'd0}}, xadc_n[3:2], {6{1'd0}}, xadc_n[1:0]};
assign slice_proxy3 = {xadc_p[4], {6{1'd0}}, xadc_p[3:2], {6{1'd0}}, xadc_p[1:0]};

// synthesis translate_off
reg dummy_d_28;
// synthesis translate_on
always @(*) begin
	comb_array_muxed0 <= 25'sd0;
	case (linien_fast_a_y_tap_storage)
		1'd0: begin
			comb_array_muxed0 <= linien_fast_a_iir0_x0;
		end
		1'd1: begin
			comb_array_muxed0 <= linien_fast_a_iir0_y0;
		end
		default: begin
			comb_array_muxed0 <= linien_fast_a_iir0_y2;
		end
	endcase
// synthesis translate_off
	dummy_d_28 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_29;
// synthesis translate_on
always @(*) begin
	comb_array_muxed1 <= 25'sd0;
	case (linien_fast_a_y_tap_storage)
		1'd0: begin
			comb_array_muxed1 <= linien_fast_a_iir1_x0;
		end
		1'd1: begin
			comb_array_muxed1 <= linien_fast_a_iir1_y0;
		end
		default: begin
			comb_array_muxed1 <= linien_fast_a_iir1_y2;
		end
	endcase
// synthesis translate_off
	dummy_d_29 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_30;
// synthesis translate_on
always @(*) begin
	comb_array_muxed2 <= 25'sd0;
	case (linien_fast_b_y_tap_storage)
		1'd0: begin
			comb_array_muxed2 <= linien_fast_b_iir0_x0;
		end
		1'd1: begin
			comb_array_muxed2 <= linien_fast_b_iir0_y0;
		end
		default: begin
			comb_array_muxed2 <= linien_fast_b_iir0_y2;
		end
	endcase
// synthesis translate_off
	dummy_d_30 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_31;
// synthesis translate_on
always @(*) begin
	comb_array_muxed3 <= 25'sd0;
	case (linien_fast_b_y_tap_storage)
		1'd0: begin
			comb_array_muxed3 <= linien_fast_b_iir1_x0;
		end
		1'd1: begin
			comb_array_muxed3 <= linien_fast_b_iir1_y0;
		end
		default: begin
			comb_array_muxed3 <= linien_fast_b_iir1_y2;
		end
	endcase
// synthesis translate_off
	dummy_d_31 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_32;
// synthesis translate_on
always @(*) begin
	comb_array_muxed4 <= 14'sd0;
	case (linien_sine_source_index)
		1'd0: begin
			comb_array_muxed4 <= 14'sd0;
		end
		1'd1: begin
			comb_array_muxed4 <= 14'sd15;
		end
		2'd2: begin
			comb_array_muxed4 <= 14'sd30;
		end
		2'd3: begin
			comb_array_muxed4 <= 14'sd45;
		end
		3'd4: begin
			comb_array_muxed4 <= 14'sd60;
		end
		3'd5: begin
			comb_array_muxed4 <= 14'sd75;
		end
		3'd6: begin
			comb_array_muxed4 <= 14'sd90;
		end
		3'd7: begin
			comb_array_muxed4 <= 14'sd105;
		end
		4'd8: begin
			comb_array_muxed4 <= 14'sd121;
		end
		4'd9: begin
			comb_array_muxed4 <= 14'sd136;
		end
		4'd10: begin
			comb_array_muxed4 <= 14'sd151;
		end
		4'd11: begin
			comb_array_muxed4 <= 14'sd166;
		end
		4'd12: begin
			comb_array_muxed4 <= 14'sd181;
		end
		4'd13: begin
			comb_array_muxed4 <= 14'sd196;
		end
		4'd14: begin
			comb_array_muxed4 <= 14'sd211;
		end
		4'd15: begin
			comb_array_muxed4 <= 14'sd226;
		end
		5'd16: begin
			comb_array_muxed4 <= 14'sd241;
		end
		5'd17: begin
			comb_array_muxed4 <= 14'sd256;
		end
		5'd18: begin
			comb_array_muxed4 <= 14'sd271;
		end
		5'd19: begin
			comb_array_muxed4 <= 14'sd286;
		end
		5'd20: begin
			comb_array_muxed4 <= 14'sd301;
		end
		5'd21: begin
			comb_array_muxed4 <= 14'sd316;
		end
		5'd22: begin
			comb_array_muxed4 <= 14'sd331;
		end
		5'd23: begin
			comb_array_muxed4 <= 14'sd346;
		end
		5'd24: begin
			comb_array_muxed4 <= 14'sd361;
		end
		5'd25: begin
			comb_array_muxed4 <= 14'sd375;
		end
		5'd26: begin
			comb_array_muxed4 <= 14'sd390;
		end
		5'd27: begin
			comb_array_muxed4 <= 14'sd405;
		end
		5'd28: begin
			comb_array_muxed4 <= 14'sd420;
		end
		5'd29: begin
			comb_array_muxed4 <= 14'sd435;
		end
		5'd30: begin
			comb_array_muxed4 <= 14'sd450;
		end
		5'd31: begin
			comb_array_muxed4 <= 14'sd465;
		end
		6'd32: begin
			comb_array_muxed4 <= 14'sd479;
		end
		6'd33: begin
			comb_array_muxed4 <= 14'sd494;
		end
		6'd34: begin
			comb_array_muxed4 <= 14'sd509;
		end
		6'd35: begin
			comb_array_muxed4 <= 14'sd524;
		end
		6'd36: begin
			comb_array_muxed4 <= 14'sd538;
		end
		6'd37: begin
			comb_array_muxed4 <= 14'sd553;
		end
		6'd38: begin
			comb_array_muxed4 <= 14'sd568;
		end
		6'd39: begin
			comb_array_muxed4 <= 14'sd582;
		end
		6'd40: begin
			comb_array_muxed4 <= 14'sd597;
		end
		6'd41: begin
			comb_array_muxed4 <= 14'sd612;
		end
		6'd42: begin
			comb_array_muxed4 <= 14'sd626;
		end
		6'd43: begin
			comb_array_muxed4 <= 14'sd641;
		end
		6'd44: begin
			comb_array_muxed4 <= 14'sd655;
		end
		6'd45: begin
			comb_array_muxed4 <= 14'sd670;
		end
		6'd46: begin
			comb_array_muxed4 <= 14'sd684;
		end
		6'd47: begin
			comb_array_muxed4 <= 14'sd699;
		end
		6'd48: begin
			comb_array_muxed4 <= 14'sd713;
		end
		6'd49: begin
			comb_array_muxed4 <= 14'sd728;
		end
		6'd50: begin
			comb_array_muxed4 <= 14'sd742;
		end
		6'd51: begin
			comb_array_muxed4 <= 14'sd756;
		end
		6'd52: begin
			comb_array_muxed4 <= 14'sd771;
		end
		6'd53: begin
			comb_array_muxed4 <= 14'sd785;
		end
		6'd54: begin
			comb_array_muxed4 <= 14'sd799;
		end
		6'd55: begin
			comb_array_muxed4 <= 14'sd814;
		end
		6'd56: begin
			comb_array_muxed4 <= 14'sd828;
		end
		6'd57: begin
			comb_array_muxed4 <= 14'sd842;
		end
		6'd58: begin
			comb_array_muxed4 <= 14'sd856;
		end
		6'd59: begin
			comb_array_muxed4 <= 14'sd870;
		end
		6'd60: begin
			comb_array_muxed4 <= 14'sd884;
		end
		6'd61: begin
			comb_array_muxed4 <= 14'sd898;
		end
		6'd62: begin
			comb_array_muxed4 <= 14'sd912;
		end
		6'd63: begin
			comb_array_muxed4 <= 14'sd926;
		end
		7'd64: begin
			comb_array_muxed4 <= 14'sd940;
		end
		7'd65: begin
			comb_array_muxed4 <= 14'sd954;
		end
		7'd66: begin
			comb_array_muxed4 <= 14'sd968;
		end
		7'd67: begin
			comb_array_muxed4 <= 14'sd982;
		end
		7'd68: begin
			comb_array_muxed4 <= 14'sd996;
		end
		7'd69: begin
			comb_array_muxed4 <= 14'sd1009;
		end
		7'd70: begin
			comb_array_muxed4 <= 14'sd1023;
		end
		7'd71: begin
			comb_array_muxed4 <= 14'sd1037;
		end
		7'd72: begin
			comb_array_muxed4 <= 14'sd1051;
		end
		7'd73: begin
			comb_array_muxed4 <= 14'sd1064;
		end
		7'd74: begin
			comb_array_muxed4 <= 14'sd1078;
		end
		7'd75: begin
			comb_array_muxed4 <= 14'sd1091;
		end
		7'd76: begin
			comb_array_muxed4 <= 14'sd1105;
		end
		7'd77: begin
			comb_array_muxed4 <= 14'sd1118;
		end
		7'd78: begin
			comb_array_muxed4 <= 14'sd1132;
		end
		7'd79: begin
			comb_array_muxed4 <= 14'sd1145;
		end
		7'd80: begin
			comb_array_muxed4 <= 14'sd1158;
		end
		7'd81: begin
			comb_array_muxed4 <= 14'sd1171;
		end
		7'd82: begin
			comb_array_muxed4 <= 14'sd1185;
		end
		7'd83: begin
			comb_array_muxed4 <= 14'sd1198;
		end
		7'd84: begin
			comb_array_muxed4 <= 14'sd1211;
		end
		7'd85: begin
			comb_array_muxed4 <= 14'sd1224;
		end
		7'd86: begin
			comb_array_muxed4 <= 14'sd1237;
		end
		7'd87: begin
			comb_array_muxed4 <= 14'sd1250;
		end
		7'd88: begin
			comb_array_muxed4 <= 14'sd1263;
		end
		7'd89: begin
			comb_array_muxed4 <= 14'sd1276;
		end
		7'd90: begin
			comb_array_muxed4 <= 14'sd1289;
		end
		7'd91: begin
			comb_array_muxed4 <= 14'sd1302;
		end
		7'd92: begin
			comb_array_muxed4 <= 14'sd1314;
		end
		7'd93: begin
			comb_array_muxed4 <= 14'sd1327;
		end
		7'd94: begin
			comb_array_muxed4 <= 14'sd1340;
		end
		7'd95: begin
			comb_array_muxed4 <= 14'sd1352;
		end
		7'd96: begin
			comb_array_muxed4 <= 14'sd1365;
		end
		7'd97: begin
			comb_array_muxed4 <= 14'sd1378;
		end
		7'd98: begin
			comb_array_muxed4 <= 14'sd1390;
		end
		7'd99: begin
			comb_array_muxed4 <= 14'sd1402;
		end
		7'd100: begin
			comb_array_muxed4 <= 14'sd1415;
		end
		7'd101: begin
			comb_array_muxed4 <= 14'sd1427;
		end
		7'd102: begin
			comb_array_muxed4 <= 14'sd1439;
		end
		7'd103: begin
			comb_array_muxed4 <= 14'sd1451;
		end
		7'd104: begin
			comb_array_muxed4 <= 14'sd1464;
		end
		7'd105: begin
			comb_array_muxed4 <= 14'sd1476;
		end
		7'd106: begin
			comb_array_muxed4 <= 14'sd1488;
		end
		7'd107: begin
			comb_array_muxed4 <= 14'sd1500;
		end
		7'd108: begin
			comb_array_muxed4 <= 14'sd1512;
		end
		7'd109: begin
			comb_array_muxed4 <= 14'sd1523;
		end
		7'd110: begin
			comb_array_muxed4 <= 14'sd1535;
		end
		7'd111: begin
			comb_array_muxed4 <= 14'sd1547;
		end
		7'd112: begin
			comb_array_muxed4 <= 14'sd1559;
		end
		7'd113: begin
			comb_array_muxed4 <= 14'sd1570;
		end
		7'd114: begin
			comb_array_muxed4 <= 14'sd1582;
		end
		7'd115: begin
			comb_array_muxed4 <= 14'sd1593;
		end
		7'd116: begin
			comb_array_muxed4 <= 14'sd1605;
		end
		7'd117: begin
			comb_array_muxed4 <= 14'sd1616;
		end
		7'd118: begin
			comb_array_muxed4 <= 14'sd1628;
		end
		7'd119: begin
			comb_array_muxed4 <= 14'sd1639;
		end
		7'd120: begin
			comb_array_muxed4 <= 14'sd1650;
		end
		7'd121: begin
			comb_array_muxed4 <= 14'sd1661;
		end
		7'd122: begin
			comb_array_muxed4 <= 14'sd1672;
		end
		7'd123: begin
			comb_array_muxed4 <= 14'sd1683;
		end
		7'd124: begin
			comb_array_muxed4 <= 14'sd1694;
		end
		7'd125: begin
			comb_array_muxed4 <= 14'sd1705;
		end
		7'd126: begin
			comb_array_muxed4 <= 14'sd1716;
		end
		7'd127: begin
			comb_array_muxed4 <= 14'sd1727;
		end
		8'd128: begin
			comb_array_muxed4 <= 14'sd1737;
		end
		8'd129: begin
			comb_array_muxed4 <= 14'sd1748;
		end
		8'd130: begin
			comb_array_muxed4 <= 14'sd1759;
		end
		8'd131: begin
			comb_array_muxed4 <= 14'sd1769;
		end
		8'd132: begin
			comb_array_muxed4 <= 14'sd1779;
		end
		8'd133: begin
			comb_array_muxed4 <= 14'sd1790;
		end
		8'd134: begin
			comb_array_muxed4 <= 14'sd1800;
		end
		8'd135: begin
			comb_array_muxed4 <= 14'sd1810;
		end
		8'd136: begin
			comb_array_muxed4 <= 14'sd1821;
		end
		8'd137: begin
			comb_array_muxed4 <= 14'sd1831;
		end
		8'd138: begin
			comb_array_muxed4 <= 14'sd1841;
		end
		8'd139: begin
			comb_array_muxed4 <= 14'sd1851;
		end
		8'd140: begin
			comb_array_muxed4 <= 14'sd1860;
		end
		8'd141: begin
			comb_array_muxed4 <= 14'sd1870;
		end
		8'd142: begin
			comb_array_muxed4 <= 14'sd1880;
		end
		8'd143: begin
			comb_array_muxed4 <= 14'sd1890;
		end
		8'd144: begin
			comb_array_muxed4 <= 14'sd1899;
		end
		8'd145: begin
			comb_array_muxed4 <= 14'sd1909;
		end
		8'd146: begin
			comb_array_muxed4 <= 14'sd1918;
		end
		8'd147: begin
			comb_array_muxed4 <= 14'sd1928;
		end
		8'd148: begin
			comb_array_muxed4 <= 14'sd1937;
		end
		8'd149: begin
			comb_array_muxed4 <= 14'sd1946;
		end
		8'd150: begin
			comb_array_muxed4 <= 14'sd1955;
		end
		8'd151: begin
			comb_array_muxed4 <= 14'sd1964;
		end
		8'd152: begin
			comb_array_muxed4 <= 14'sd1973;
		end
		8'd153: begin
			comb_array_muxed4 <= 14'sd1982;
		end
		8'd154: begin
			comb_array_muxed4 <= 14'sd1991;
		end
		8'd155: begin
			comb_array_muxed4 <= 14'sd2000;
		end
		8'd156: begin
			comb_array_muxed4 <= 14'sd2009;
		end
		8'd157: begin
			comb_array_muxed4 <= 14'sd2017;
		end
		8'd158: begin
			comb_array_muxed4 <= 14'sd2026;
		end
		8'd159: begin
			comb_array_muxed4 <= 14'sd2035;
		end
		8'd160: begin
			comb_array_muxed4 <= 14'sd2043;
		end
		8'd161: begin
			comb_array_muxed4 <= 14'sd2051;
		end
		8'd162: begin
			comb_array_muxed4 <= 14'sd2060;
		end
		8'd163: begin
			comb_array_muxed4 <= 14'sd2068;
		end
		8'd164: begin
			comb_array_muxed4 <= 14'sd2076;
		end
		8'd165: begin
			comb_array_muxed4 <= 14'sd2084;
		end
		8'd166: begin
			comb_array_muxed4 <= 14'sd2092;
		end
		8'd167: begin
			comb_array_muxed4 <= 14'sd2100;
		end
		8'd168: begin
			comb_array_muxed4 <= 14'sd2107;
		end
		8'd169: begin
			comb_array_muxed4 <= 14'sd2115;
		end
		8'd170: begin
			comb_array_muxed4 <= 14'sd2123;
		end
		8'd171: begin
			comb_array_muxed4 <= 14'sd2130;
		end
		8'd172: begin
			comb_array_muxed4 <= 14'sd2138;
		end
		8'd173: begin
			comb_array_muxed4 <= 14'sd2145;
		end
		8'd174: begin
			comb_array_muxed4 <= 14'sd2153;
		end
		8'd175: begin
			comb_array_muxed4 <= 14'sd2160;
		end
		8'd176: begin
			comb_array_muxed4 <= 14'sd2167;
		end
		8'd177: begin
			comb_array_muxed4 <= 14'sd2174;
		end
		8'd178: begin
			comb_array_muxed4 <= 14'sd2181;
		end
		8'd179: begin
			comb_array_muxed4 <= 14'sd2188;
		end
		8'd180: begin
			comb_array_muxed4 <= 14'sd2195;
		end
		8'd181: begin
			comb_array_muxed4 <= 14'sd2201;
		end
		8'd182: begin
			comb_array_muxed4 <= 14'sd2208;
		end
		8'd183: begin
			comb_array_muxed4 <= 14'sd2215;
		end
		8'd184: begin
			comb_array_muxed4 <= 14'sd2221;
		end
		8'd185: begin
			comb_array_muxed4 <= 14'sd2228;
		end
		8'd186: begin
			comb_array_muxed4 <= 14'sd2234;
		end
		8'd187: begin
			comb_array_muxed4 <= 14'sd2240;
		end
		8'd188: begin
			comb_array_muxed4 <= 14'sd2246;
		end
		8'd189: begin
			comb_array_muxed4 <= 14'sd2252;
		end
		8'd190: begin
			comb_array_muxed4 <= 14'sd2258;
		end
		8'd191: begin
			comb_array_muxed4 <= 14'sd2264;
		end
		8'd192: begin
			comb_array_muxed4 <= 14'sd2270;
		end
		8'd193: begin
			comb_array_muxed4 <= 14'sd2276;
		end
		8'd194: begin
			comb_array_muxed4 <= 14'sd2281;
		end
		8'd195: begin
			comb_array_muxed4 <= 14'sd2287;
		end
		8'd196: begin
			comb_array_muxed4 <= 14'sd2292;
		end
		8'd197: begin
			comb_array_muxed4 <= 14'sd2298;
		end
		8'd198: begin
			comb_array_muxed4 <= 14'sd2303;
		end
		8'd199: begin
			comb_array_muxed4 <= 14'sd2308;
		end
		8'd200: begin
			comb_array_muxed4 <= 14'sd2313;
		end
		8'd201: begin
			comb_array_muxed4 <= 14'sd2318;
		end
		8'd202: begin
			comb_array_muxed4 <= 14'sd2323;
		end
		8'd203: begin
			comb_array_muxed4 <= 14'sd2328;
		end
		8'd204: begin
			comb_array_muxed4 <= 14'sd2333;
		end
		8'd205: begin
			comb_array_muxed4 <= 14'sd2338;
		end
		8'd206: begin
			comb_array_muxed4 <= 14'sd2342;
		end
		8'd207: begin
			comb_array_muxed4 <= 14'sd2347;
		end
		8'd208: begin
			comb_array_muxed4 <= 14'sd2351;
		end
		8'd209: begin
			comb_array_muxed4 <= 14'sd2356;
		end
		8'd210: begin
			comb_array_muxed4 <= 14'sd2360;
		end
		8'd211: begin
			comb_array_muxed4 <= 14'sd2364;
		end
		8'd212: begin
			comb_array_muxed4 <= 14'sd2368;
		end
		8'd213: begin
			comb_array_muxed4 <= 14'sd2372;
		end
		8'd214: begin
			comb_array_muxed4 <= 14'sd2376;
		end
		8'd215: begin
			comb_array_muxed4 <= 14'sd2380;
		end
		8'd216: begin
			comb_array_muxed4 <= 14'sd2383;
		end
		8'd217: begin
			comb_array_muxed4 <= 14'sd2387;
		end
		8'd218: begin
			comb_array_muxed4 <= 14'sd2391;
		end
		8'd219: begin
			comb_array_muxed4 <= 14'sd2394;
		end
		8'd220: begin
			comb_array_muxed4 <= 14'sd2397;
		end
		8'd221: begin
			comb_array_muxed4 <= 14'sd2401;
		end
		8'd222: begin
			comb_array_muxed4 <= 14'sd2404;
		end
		8'd223: begin
			comb_array_muxed4 <= 14'sd2407;
		end
		8'd224: begin
			comb_array_muxed4 <= 14'sd2410;
		end
		8'd225: begin
			comb_array_muxed4 <= 14'sd2413;
		end
		8'd226: begin
			comb_array_muxed4 <= 14'sd2415;
		end
		8'd227: begin
			comb_array_muxed4 <= 14'sd2418;
		end
		8'd228: begin
			comb_array_muxed4 <= 14'sd2421;
		end
		8'd229: begin
			comb_array_muxed4 <= 14'sd2423;
		end
		8'd230: begin
			comb_array_muxed4 <= 14'sd2426;
		end
		8'd231: begin
			comb_array_muxed4 <= 14'sd2428;
		end
		8'd232: begin
			comb_array_muxed4 <= 14'sd2430;
		end
		8'd233: begin
			comb_array_muxed4 <= 14'sd2433;
		end
		8'd234: begin
			comb_array_muxed4 <= 14'sd2435;
		end
		8'd235: begin
			comb_array_muxed4 <= 14'sd2437;
		end
		8'd236: begin
			comb_array_muxed4 <= 14'sd2439;
		end
		8'd237: begin
			comb_array_muxed4 <= 14'sd2440;
		end
		8'd238: begin
			comb_array_muxed4 <= 14'sd2442;
		end
		8'd239: begin
			comb_array_muxed4 <= 14'sd2444;
		end
		8'd240: begin
			comb_array_muxed4 <= 14'sd2445;
		end
		8'd241: begin
			comb_array_muxed4 <= 14'sd2447;
		end
		8'd242: begin
			comb_array_muxed4 <= 14'sd2448;
		end
		8'd243: begin
			comb_array_muxed4 <= 14'sd2449;
		end
		8'd244: begin
			comb_array_muxed4 <= 14'sd2450;
		end
		8'd245: begin
			comb_array_muxed4 <= 14'sd2451;
		end
		8'd246: begin
			comb_array_muxed4 <= 14'sd2452;
		end
		8'd247: begin
			comb_array_muxed4 <= 14'sd2453;
		end
		8'd248: begin
			comb_array_muxed4 <= 14'sd2454;
		end
		8'd249: begin
			comb_array_muxed4 <= 14'sd2455;
		end
		8'd250: begin
			comb_array_muxed4 <= 14'sd2455;
		end
		8'd251: begin
			comb_array_muxed4 <= 14'sd2456;
		end
		8'd252: begin
			comb_array_muxed4 <= 14'sd2456;
		end
		8'd253: begin
			comb_array_muxed4 <= 14'sd2457;
		end
		8'd254: begin
			comb_array_muxed4 <= 14'sd2457;
		end
		8'd255: begin
			comb_array_muxed4 <= 14'sd2457;
		end
		9'd256: begin
			comb_array_muxed4 <= 14'sd2457;
		end
		9'd257: begin
			comb_array_muxed4 <= 14'sd2457;
		end
		9'd258: begin
			comb_array_muxed4 <= 14'sd2457;
		end
		9'd259: begin
			comb_array_muxed4 <= 14'sd2457;
		end
		9'd260: begin
			comb_array_muxed4 <= 14'sd2456;
		end
		9'd261: begin
			comb_array_muxed4 <= 14'sd2456;
		end
		9'd262: begin
			comb_array_muxed4 <= 14'sd2455;
		end
		9'd263: begin
			comb_array_muxed4 <= 14'sd2455;
		end
		9'd264: begin
			comb_array_muxed4 <= 14'sd2454;
		end
		9'd265: begin
			comb_array_muxed4 <= 14'sd2453;
		end
		9'd266: begin
			comb_array_muxed4 <= 14'sd2452;
		end
		9'd267: begin
			comb_array_muxed4 <= 14'sd2451;
		end
		9'd268: begin
			comb_array_muxed4 <= 14'sd2450;
		end
		9'd269: begin
			comb_array_muxed4 <= 14'sd2449;
		end
		9'd270: begin
			comb_array_muxed4 <= 14'sd2448;
		end
		9'd271: begin
			comb_array_muxed4 <= 14'sd2447;
		end
		9'd272: begin
			comb_array_muxed4 <= 14'sd2445;
		end
		9'd273: begin
			comb_array_muxed4 <= 14'sd2444;
		end
		9'd274: begin
			comb_array_muxed4 <= 14'sd2442;
		end
		9'd275: begin
			comb_array_muxed4 <= 14'sd2440;
		end
		9'd276: begin
			comb_array_muxed4 <= 14'sd2439;
		end
		9'd277: begin
			comb_array_muxed4 <= 14'sd2437;
		end
		9'd278: begin
			comb_array_muxed4 <= 14'sd2435;
		end
		9'd279: begin
			comb_array_muxed4 <= 14'sd2433;
		end
		9'd280: begin
			comb_array_muxed4 <= 14'sd2430;
		end
		9'd281: begin
			comb_array_muxed4 <= 14'sd2428;
		end
		9'd282: begin
			comb_array_muxed4 <= 14'sd2426;
		end
		9'd283: begin
			comb_array_muxed4 <= 14'sd2423;
		end
		9'd284: begin
			comb_array_muxed4 <= 14'sd2421;
		end
		9'd285: begin
			comb_array_muxed4 <= 14'sd2418;
		end
		9'd286: begin
			comb_array_muxed4 <= 14'sd2415;
		end
		9'd287: begin
			comb_array_muxed4 <= 14'sd2413;
		end
		9'd288: begin
			comb_array_muxed4 <= 14'sd2410;
		end
		9'd289: begin
			comb_array_muxed4 <= 14'sd2407;
		end
		9'd290: begin
			comb_array_muxed4 <= 14'sd2404;
		end
		9'd291: begin
			comb_array_muxed4 <= 14'sd2401;
		end
		9'd292: begin
			comb_array_muxed4 <= 14'sd2397;
		end
		9'd293: begin
			comb_array_muxed4 <= 14'sd2394;
		end
		9'd294: begin
			comb_array_muxed4 <= 14'sd2391;
		end
		9'd295: begin
			comb_array_muxed4 <= 14'sd2387;
		end
		9'd296: begin
			comb_array_muxed4 <= 14'sd2383;
		end
		9'd297: begin
			comb_array_muxed4 <= 14'sd2380;
		end
		9'd298: begin
			comb_array_muxed4 <= 14'sd2376;
		end
		9'd299: begin
			comb_array_muxed4 <= 14'sd2372;
		end
		9'd300: begin
			comb_array_muxed4 <= 14'sd2368;
		end
		9'd301: begin
			comb_array_muxed4 <= 14'sd2364;
		end
		9'd302: begin
			comb_array_muxed4 <= 14'sd2360;
		end
		9'd303: begin
			comb_array_muxed4 <= 14'sd2356;
		end
		9'd304: begin
			comb_array_muxed4 <= 14'sd2351;
		end
		9'd305: begin
			comb_array_muxed4 <= 14'sd2347;
		end
		9'd306: begin
			comb_array_muxed4 <= 14'sd2342;
		end
		9'd307: begin
			comb_array_muxed4 <= 14'sd2338;
		end
		9'd308: begin
			comb_array_muxed4 <= 14'sd2333;
		end
		9'd309: begin
			comb_array_muxed4 <= 14'sd2328;
		end
		9'd310: begin
			comb_array_muxed4 <= 14'sd2323;
		end
		9'd311: begin
			comb_array_muxed4 <= 14'sd2318;
		end
		9'd312: begin
			comb_array_muxed4 <= 14'sd2313;
		end
		9'd313: begin
			comb_array_muxed4 <= 14'sd2308;
		end
		9'd314: begin
			comb_array_muxed4 <= 14'sd2303;
		end
		9'd315: begin
			comb_array_muxed4 <= 14'sd2298;
		end
		9'd316: begin
			comb_array_muxed4 <= 14'sd2292;
		end
		9'd317: begin
			comb_array_muxed4 <= 14'sd2287;
		end
		9'd318: begin
			comb_array_muxed4 <= 14'sd2281;
		end
		9'd319: begin
			comb_array_muxed4 <= 14'sd2276;
		end
		9'd320: begin
			comb_array_muxed4 <= 14'sd2270;
		end
		9'd321: begin
			comb_array_muxed4 <= 14'sd2264;
		end
		9'd322: begin
			comb_array_muxed4 <= 14'sd2258;
		end
		9'd323: begin
			comb_array_muxed4 <= 14'sd2252;
		end
		9'd324: begin
			comb_array_muxed4 <= 14'sd2246;
		end
		9'd325: begin
			comb_array_muxed4 <= 14'sd2240;
		end
		9'd326: begin
			comb_array_muxed4 <= 14'sd2234;
		end
		9'd327: begin
			comb_array_muxed4 <= 14'sd2228;
		end
		9'd328: begin
			comb_array_muxed4 <= 14'sd2221;
		end
		9'd329: begin
			comb_array_muxed4 <= 14'sd2215;
		end
		9'd330: begin
			comb_array_muxed4 <= 14'sd2208;
		end
		9'd331: begin
			comb_array_muxed4 <= 14'sd2201;
		end
		9'd332: begin
			comb_array_muxed4 <= 14'sd2195;
		end
		9'd333: begin
			comb_array_muxed4 <= 14'sd2188;
		end
		9'd334: begin
			comb_array_muxed4 <= 14'sd2181;
		end
		9'd335: begin
			comb_array_muxed4 <= 14'sd2174;
		end
		9'd336: begin
			comb_array_muxed4 <= 14'sd2167;
		end
		9'd337: begin
			comb_array_muxed4 <= 14'sd2160;
		end
		9'd338: begin
			comb_array_muxed4 <= 14'sd2153;
		end
		9'd339: begin
			comb_array_muxed4 <= 14'sd2145;
		end
		9'd340: begin
			comb_array_muxed4 <= 14'sd2138;
		end
		9'd341: begin
			comb_array_muxed4 <= 14'sd2130;
		end
		9'd342: begin
			comb_array_muxed4 <= 14'sd2123;
		end
		9'd343: begin
			comb_array_muxed4 <= 14'sd2115;
		end
		9'd344: begin
			comb_array_muxed4 <= 14'sd2107;
		end
		9'd345: begin
			comb_array_muxed4 <= 14'sd2100;
		end
		9'd346: begin
			comb_array_muxed4 <= 14'sd2092;
		end
		9'd347: begin
			comb_array_muxed4 <= 14'sd2084;
		end
		9'd348: begin
			comb_array_muxed4 <= 14'sd2076;
		end
		9'd349: begin
			comb_array_muxed4 <= 14'sd2068;
		end
		9'd350: begin
			comb_array_muxed4 <= 14'sd2060;
		end
		9'd351: begin
			comb_array_muxed4 <= 14'sd2051;
		end
		9'd352: begin
			comb_array_muxed4 <= 14'sd2043;
		end
		9'd353: begin
			comb_array_muxed4 <= 14'sd2035;
		end
		9'd354: begin
			comb_array_muxed4 <= 14'sd2026;
		end
		9'd355: begin
			comb_array_muxed4 <= 14'sd2017;
		end
		9'd356: begin
			comb_array_muxed4 <= 14'sd2009;
		end
		9'd357: begin
			comb_array_muxed4 <= 14'sd2000;
		end
		9'd358: begin
			comb_array_muxed4 <= 14'sd1991;
		end
		9'd359: begin
			comb_array_muxed4 <= 14'sd1982;
		end
		9'd360: begin
			comb_array_muxed4 <= 14'sd1973;
		end
		9'd361: begin
			comb_array_muxed4 <= 14'sd1964;
		end
		9'd362: begin
			comb_array_muxed4 <= 14'sd1955;
		end
		9'd363: begin
			comb_array_muxed4 <= 14'sd1946;
		end
		9'd364: begin
			comb_array_muxed4 <= 14'sd1937;
		end
		9'd365: begin
			comb_array_muxed4 <= 14'sd1928;
		end
		9'd366: begin
			comb_array_muxed4 <= 14'sd1918;
		end
		9'd367: begin
			comb_array_muxed4 <= 14'sd1909;
		end
		9'd368: begin
			comb_array_muxed4 <= 14'sd1899;
		end
		9'd369: begin
			comb_array_muxed4 <= 14'sd1890;
		end
		9'd370: begin
			comb_array_muxed4 <= 14'sd1880;
		end
		9'd371: begin
			comb_array_muxed4 <= 14'sd1870;
		end
		9'd372: begin
			comb_array_muxed4 <= 14'sd1860;
		end
		9'd373: begin
			comb_array_muxed4 <= 14'sd1851;
		end
		9'd374: begin
			comb_array_muxed4 <= 14'sd1841;
		end
		9'd375: begin
			comb_array_muxed4 <= 14'sd1831;
		end
		9'd376: begin
			comb_array_muxed4 <= 14'sd1821;
		end
		9'd377: begin
			comb_array_muxed4 <= 14'sd1810;
		end
		9'd378: begin
			comb_array_muxed4 <= 14'sd1800;
		end
		9'd379: begin
			comb_array_muxed4 <= 14'sd1790;
		end
		9'd380: begin
			comb_array_muxed4 <= 14'sd1779;
		end
		9'd381: begin
			comb_array_muxed4 <= 14'sd1769;
		end
		9'd382: begin
			comb_array_muxed4 <= 14'sd1759;
		end
		9'd383: begin
			comb_array_muxed4 <= 14'sd1748;
		end
		9'd384: begin
			comb_array_muxed4 <= 14'sd1737;
		end
		9'd385: begin
			comb_array_muxed4 <= 14'sd1727;
		end
		9'd386: begin
			comb_array_muxed4 <= 14'sd1716;
		end
		9'd387: begin
			comb_array_muxed4 <= 14'sd1705;
		end
		9'd388: begin
			comb_array_muxed4 <= 14'sd1694;
		end
		9'd389: begin
			comb_array_muxed4 <= 14'sd1683;
		end
		9'd390: begin
			comb_array_muxed4 <= 14'sd1672;
		end
		9'd391: begin
			comb_array_muxed4 <= 14'sd1661;
		end
		9'd392: begin
			comb_array_muxed4 <= 14'sd1650;
		end
		9'd393: begin
			comb_array_muxed4 <= 14'sd1639;
		end
		9'd394: begin
			comb_array_muxed4 <= 14'sd1628;
		end
		9'd395: begin
			comb_array_muxed4 <= 14'sd1616;
		end
		9'd396: begin
			comb_array_muxed4 <= 14'sd1605;
		end
		9'd397: begin
			comb_array_muxed4 <= 14'sd1593;
		end
		9'd398: begin
			comb_array_muxed4 <= 14'sd1582;
		end
		9'd399: begin
			comb_array_muxed4 <= 14'sd1570;
		end
		9'd400: begin
			comb_array_muxed4 <= 14'sd1559;
		end
		9'd401: begin
			comb_array_muxed4 <= 14'sd1547;
		end
		9'd402: begin
			comb_array_muxed4 <= 14'sd1535;
		end
		9'd403: begin
			comb_array_muxed4 <= 14'sd1523;
		end
		9'd404: begin
			comb_array_muxed4 <= 14'sd1512;
		end
		9'd405: begin
			comb_array_muxed4 <= 14'sd1500;
		end
		9'd406: begin
			comb_array_muxed4 <= 14'sd1488;
		end
		9'd407: begin
			comb_array_muxed4 <= 14'sd1476;
		end
		9'd408: begin
			comb_array_muxed4 <= 14'sd1464;
		end
		9'd409: begin
			comb_array_muxed4 <= 14'sd1451;
		end
		9'd410: begin
			comb_array_muxed4 <= 14'sd1439;
		end
		9'd411: begin
			comb_array_muxed4 <= 14'sd1427;
		end
		9'd412: begin
			comb_array_muxed4 <= 14'sd1415;
		end
		9'd413: begin
			comb_array_muxed4 <= 14'sd1402;
		end
		9'd414: begin
			comb_array_muxed4 <= 14'sd1390;
		end
		9'd415: begin
			comb_array_muxed4 <= 14'sd1378;
		end
		9'd416: begin
			comb_array_muxed4 <= 14'sd1365;
		end
		9'd417: begin
			comb_array_muxed4 <= 14'sd1352;
		end
		9'd418: begin
			comb_array_muxed4 <= 14'sd1340;
		end
		9'd419: begin
			comb_array_muxed4 <= 14'sd1327;
		end
		9'd420: begin
			comb_array_muxed4 <= 14'sd1314;
		end
		9'd421: begin
			comb_array_muxed4 <= 14'sd1302;
		end
		9'd422: begin
			comb_array_muxed4 <= 14'sd1289;
		end
		9'd423: begin
			comb_array_muxed4 <= 14'sd1276;
		end
		9'd424: begin
			comb_array_muxed4 <= 14'sd1263;
		end
		9'd425: begin
			comb_array_muxed4 <= 14'sd1250;
		end
		9'd426: begin
			comb_array_muxed4 <= 14'sd1237;
		end
		9'd427: begin
			comb_array_muxed4 <= 14'sd1224;
		end
		9'd428: begin
			comb_array_muxed4 <= 14'sd1211;
		end
		9'd429: begin
			comb_array_muxed4 <= 14'sd1198;
		end
		9'd430: begin
			comb_array_muxed4 <= 14'sd1185;
		end
		9'd431: begin
			comb_array_muxed4 <= 14'sd1171;
		end
		9'd432: begin
			comb_array_muxed4 <= 14'sd1158;
		end
		9'd433: begin
			comb_array_muxed4 <= 14'sd1145;
		end
		9'd434: begin
			comb_array_muxed4 <= 14'sd1132;
		end
		9'd435: begin
			comb_array_muxed4 <= 14'sd1118;
		end
		9'd436: begin
			comb_array_muxed4 <= 14'sd1105;
		end
		9'd437: begin
			comb_array_muxed4 <= 14'sd1091;
		end
		9'd438: begin
			comb_array_muxed4 <= 14'sd1078;
		end
		9'd439: begin
			comb_array_muxed4 <= 14'sd1064;
		end
		9'd440: begin
			comb_array_muxed4 <= 14'sd1051;
		end
		9'd441: begin
			comb_array_muxed4 <= 14'sd1037;
		end
		9'd442: begin
			comb_array_muxed4 <= 14'sd1023;
		end
		9'd443: begin
			comb_array_muxed4 <= 14'sd1009;
		end
		9'd444: begin
			comb_array_muxed4 <= 14'sd996;
		end
		9'd445: begin
			comb_array_muxed4 <= 14'sd982;
		end
		9'd446: begin
			comb_array_muxed4 <= 14'sd968;
		end
		9'd447: begin
			comb_array_muxed4 <= 14'sd954;
		end
		9'd448: begin
			comb_array_muxed4 <= 14'sd940;
		end
		9'd449: begin
			comb_array_muxed4 <= 14'sd926;
		end
		9'd450: begin
			comb_array_muxed4 <= 14'sd912;
		end
		9'd451: begin
			comb_array_muxed4 <= 14'sd898;
		end
		9'd452: begin
			comb_array_muxed4 <= 14'sd884;
		end
		9'd453: begin
			comb_array_muxed4 <= 14'sd870;
		end
		9'd454: begin
			comb_array_muxed4 <= 14'sd856;
		end
		9'd455: begin
			comb_array_muxed4 <= 14'sd842;
		end
		9'd456: begin
			comb_array_muxed4 <= 14'sd828;
		end
		9'd457: begin
			comb_array_muxed4 <= 14'sd814;
		end
		9'd458: begin
			comb_array_muxed4 <= 14'sd799;
		end
		9'd459: begin
			comb_array_muxed4 <= 14'sd785;
		end
		9'd460: begin
			comb_array_muxed4 <= 14'sd771;
		end
		9'd461: begin
			comb_array_muxed4 <= 14'sd756;
		end
		9'd462: begin
			comb_array_muxed4 <= 14'sd742;
		end
		9'd463: begin
			comb_array_muxed4 <= 14'sd728;
		end
		9'd464: begin
			comb_array_muxed4 <= 14'sd713;
		end
		9'd465: begin
			comb_array_muxed4 <= 14'sd699;
		end
		9'd466: begin
			comb_array_muxed4 <= 14'sd684;
		end
		9'd467: begin
			comb_array_muxed4 <= 14'sd670;
		end
		9'd468: begin
			comb_array_muxed4 <= 14'sd655;
		end
		9'd469: begin
			comb_array_muxed4 <= 14'sd641;
		end
		9'd470: begin
			comb_array_muxed4 <= 14'sd626;
		end
		9'd471: begin
			comb_array_muxed4 <= 14'sd612;
		end
		9'd472: begin
			comb_array_muxed4 <= 14'sd597;
		end
		9'd473: begin
			comb_array_muxed4 <= 14'sd582;
		end
		9'd474: begin
			comb_array_muxed4 <= 14'sd568;
		end
		9'd475: begin
			comb_array_muxed4 <= 14'sd553;
		end
		9'd476: begin
			comb_array_muxed4 <= 14'sd538;
		end
		9'd477: begin
			comb_array_muxed4 <= 14'sd524;
		end
		9'd478: begin
			comb_array_muxed4 <= 14'sd509;
		end
		9'd479: begin
			comb_array_muxed4 <= 14'sd494;
		end
		9'd480: begin
			comb_array_muxed4 <= 14'sd479;
		end
		9'd481: begin
			comb_array_muxed4 <= 14'sd465;
		end
		9'd482: begin
			comb_array_muxed4 <= 14'sd450;
		end
		9'd483: begin
			comb_array_muxed4 <= 14'sd435;
		end
		9'd484: begin
			comb_array_muxed4 <= 14'sd420;
		end
		9'd485: begin
			comb_array_muxed4 <= 14'sd405;
		end
		9'd486: begin
			comb_array_muxed4 <= 14'sd390;
		end
		9'd487: begin
			comb_array_muxed4 <= 14'sd375;
		end
		9'd488: begin
			comb_array_muxed4 <= 14'sd361;
		end
		9'd489: begin
			comb_array_muxed4 <= 14'sd346;
		end
		9'd490: begin
			comb_array_muxed4 <= 14'sd331;
		end
		9'd491: begin
			comb_array_muxed4 <= 14'sd316;
		end
		9'd492: begin
			comb_array_muxed4 <= 14'sd301;
		end
		9'd493: begin
			comb_array_muxed4 <= 14'sd286;
		end
		9'd494: begin
			comb_array_muxed4 <= 14'sd271;
		end
		9'd495: begin
			comb_array_muxed4 <= 14'sd256;
		end
		9'd496: begin
			comb_array_muxed4 <= 14'sd241;
		end
		9'd497: begin
			comb_array_muxed4 <= 14'sd226;
		end
		9'd498: begin
			comb_array_muxed4 <= 14'sd211;
		end
		9'd499: begin
			comb_array_muxed4 <= 14'sd196;
		end
		9'd500: begin
			comb_array_muxed4 <= 14'sd181;
		end
		9'd501: begin
			comb_array_muxed4 <= 14'sd166;
		end
		9'd502: begin
			comb_array_muxed4 <= 14'sd151;
		end
		9'd503: begin
			comb_array_muxed4 <= 14'sd136;
		end
		9'd504: begin
			comb_array_muxed4 <= 14'sd121;
		end
		9'd505: begin
			comb_array_muxed4 <= 14'sd105;
		end
		9'd506: begin
			comb_array_muxed4 <= 14'sd90;
		end
		9'd507: begin
			comb_array_muxed4 <= 14'sd75;
		end
		9'd508: begin
			comb_array_muxed4 <= 14'sd60;
		end
		9'd509: begin
			comb_array_muxed4 <= 14'sd45;
		end
		9'd510: begin
			comb_array_muxed4 <= 14'sd30;
		end
		9'd511: begin
			comb_array_muxed4 <= 14'sd15;
		end
		10'd512: begin
			comb_array_muxed4 <= 14'sd0;
		end
		10'd513: begin
			comb_array_muxed4 <= 14'sd16369;
		end
		10'd514: begin
			comb_array_muxed4 <= 14'sd16354;
		end
		10'd515: begin
			comb_array_muxed4 <= 14'sd16339;
		end
		10'd516: begin
			comb_array_muxed4 <= 14'sd16324;
		end
		10'd517: begin
			comb_array_muxed4 <= 14'sd16309;
		end
		10'd518: begin
			comb_array_muxed4 <= 14'sd16294;
		end
		10'd519: begin
			comb_array_muxed4 <= 14'sd16279;
		end
		10'd520: begin
			comb_array_muxed4 <= 14'sd16263;
		end
		10'd521: begin
			comb_array_muxed4 <= 14'sd16248;
		end
		10'd522: begin
			comb_array_muxed4 <= 14'sd16233;
		end
		10'd523: begin
			comb_array_muxed4 <= 14'sd16218;
		end
		10'd524: begin
			comb_array_muxed4 <= 14'sd16203;
		end
		10'd525: begin
			comb_array_muxed4 <= 14'sd16188;
		end
		10'd526: begin
			comb_array_muxed4 <= 14'sd16173;
		end
		10'd527: begin
			comb_array_muxed4 <= 14'sd16158;
		end
		10'd528: begin
			comb_array_muxed4 <= 14'sd16143;
		end
		10'd529: begin
			comb_array_muxed4 <= 14'sd16128;
		end
		10'd530: begin
			comb_array_muxed4 <= 14'sd16113;
		end
		10'd531: begin
			comb_array_muxed4 <= 14'sd16098;
		end
		10'd532: begin
			comb_array_muxed4 <= 14'sd16083;
		end
		10'd533: begin
			comb_array_muxed4 <= 14'sd16068;
		end
		10'd534: begin
			comb_array_muxed4 <= 14'sd16053;
		end
		10'd535: begin
			comb_array_muxed4 <= 14'sd16038;
		end
		10'd536: begin
			comb_array_muxed4 <= 14'sd16023;
		end
		10'd537: begin
			comb_array_muxed4 <= 14'sd16009;
		end
		10'd538: begin
			comb_array_muxed4 <= 14'sd15994;
		end
		10'd539: begin
			comb_array_muxed4 <= 14'sd15979;
		end
		10'd540: begin
			comb_array_muxed4 <= 14'sd15964;
		end
		10'd541: begin
			comb_array_muxed4 <= 14'sd15949;
		end
		10'd542: begin
			comb_array_muxed4 <= 14'sd15934;
		end
		10'd543: begin
			comb_array_muxed4 <= 14'sd15919;
		end
		10'd544: begin
			comb_array_muxed4 <= 14'sd15905;
		end
		10'd545: begin
			comb_array_muxed4 <= 14'sd15890;
		end
		10'd546: begin
			comb_array_muxed4 <= 14'sd15875;
		end
		10'd547: begin
			comb_array_muxed4 <= 14'sd15860;
		end
		10'd548: begin
			comb_array_muxed4 <= 14'sd15846;
		end
		10'd549: begin
			comb_array_muxed4 <= 14'sd15831;
		end
		10'd550: begin
			comb_array_muxed4 <= 14'sd15816;
		end
		10'd551: begin
			comb_array_muxed4 <= 14'sd15802;
		end
		10'd552: begin
			comb_array_muxed4 <= 14'sd15787;
		end
		10'd553: begin
			comb_array_muxed4 <= 14'sd15772;
		end
		10'd554: begin
			comb_array_muxed4 <= 14'sd15758;
		end
		10'd555: begin
			comb_array_muxed4 <= 14'sd15743;
		end
		10'd556: begin
			comb_array_muxed4 <= 14'sd15729;
		end
		10'd557: begin
			comb_array_muxed4 <= 14'sd15714;
		end
		10'd558: begin
			comb_array_muxed4 <= 14'sd15700;
		end
		10'd559: begin
			comb_array_muxed4 <= 14'sd15685;
		end
		10'd560: begin
			comb_array_muxed4 <= 14'sd15671;
		end
		10'd561: begin
			comb_array_muxed4 <= 14'sd15656;
		end
		10'd562: begin
			comb_array_muxed4 <= 14'sd15642;
		end
		10'd563: begin
			comb_array_muxed4 <= 14'sd15628;
		end
		10'd564: begin
			comb_array_muxed4 <= 14'sd15613;
		end
		10'd565: begin
			comb_array_muxed4 <= 14'sd15599;
		end
		10'd566: begin
			comb_array_muxed4 <= 14'sd15585;
		end
		10'd567: begin
			comb_array_muxed4 <= 14'sd15570;
		end
		10'd568: begin
			comb_array_muxed4 <= 14'sd15556;
		end
		10'd569: begin
			comb_array_muxed4 <= 14'sd15542;
		end
		10'd570: begin
			comb_array_muxed4 <= 14'sd15528;
		end
		10'd571: begin
			comb_array_muxed4 <= 14'sd15514;
		end
		10'd572: begin
			comb_array_muxed4 <= 14'sd15500;
		end
		10'd573: begin
			comb_array_muxed4 <= 14'sd15486;
		end
		10'd574: begin
			comb_array_muxed4 <= 14'sd15472;
		end
		10'd575: begin
			comb_array_muxed4 <= 14'sd15458;
		end
		10'd576: begin
			comb_array_muxed4 <= 14'sd15444;
		end
		10'd577: begin
			comb_array_muxed4 <= 14'sd15430;
		end
		10'd578: begin
			comb_array_muxed4 <= 14'sd15416;
		end
		10'd579: begin
			comb_array_muxed4 <= 14'sd15402;
		end
		10'd580: begin
			comb_array_muxed4 <= 14'sd15388;
		end
		10'd581: begin
			comb_array_muxed4 <= 14'sd15375;
		end
		10'd582: begin
			comb_array_muxed4 <= 14'sd15361;
		end
		10'd583: begin
			comb_array_muxed4 <= 14'sd15347;
		end
		10'd584: begin
			comb_array_muxed4 <= 14'sd15333;
		end
		10'd585: begin
			comb_array_muxed4 <= 14'sd15320;
		end
		10'd586: begin
			comb_array_muxed4 <= 14'sd15306;
		end
		10'd587: begin
			comb_array_muxed4 <= 14'sd15293;
		end
		10'd588: begin
			comb_array_muxed4 <= 14'sd15279;
		end
		10'd589: begin
			comb_array_muxed4 <= 14'sd15266;
		end
		10'd590: begin
			comb_array_muxed4 <= 14'sd15252;
		end
		10'd591: begin
			comb_array_muxed4 <= 14'sd15239;
		end
		10'd592: begin
			comb_array_muxed4 <= 14'sd15226;
		end
		10'd593: begin
			comb_array_muxed4 <= 14'sd15213;
		end
		10'd594: begin
			comb_array_muxed4 <= 14'sd15199;
		end
		10'd595: begin
			comb_array_muxed4 <= 14'sd15186;
		end
		10'd596: begin
			comb_array_muxed4 <= 14'sd15173;
		end
		10'd597: begin
			comb_array_muxed4 <= 14'sd15160;
		end
		10'd598: begin
			comb_array_muxed4 <= 14'sd15147;
		end
		10'd599: begin
			comb_array_muxed4 <= 14'sd15134;
		end
		10'd600: begin
			comb_array_muxed4 <= 14'sd15121;
		end
		10'd601: begin
			comb_array_muxed4 <= 14'sd15108;
		end
		10'd602: begin
			comb_array_muxed4 <= 14'sd15095;
		end
		10'd603: begin
			comb_array_muxed4 <= 14'sd15082;
		end
		10'd604: begin
			comb_array_muxed4 <= 14'sd15070;
		end
		10'd605: begin
			comb_array_muxed4 <= 14'sd15057;
		end
		10'd606: begin
			comb_array_muxed4 <= 14'sd15044;
		end
		10'd607: begin
			comb_array_muxed4 <= 14'sd15032;
		end
		10'd608: begin
			comb_array_muxed4 <= 14'sd15019;
		end
		10'd609: begin
			comb_array_muxed4 <= 14'sd15006;
		end
		10'd610: begin
			comb_array_muxed4 <= 14'sd14994;
		end
		10'd611: begin
			comb_array_muxed4 <= 14'sd14982;
		end
		10'd612: begin
			comb_array_muxed4 <= 14'sd14969;
		end
		10'd613: begin
			comb_array_muxed4 <= 14'sd14957;
		end
		10'd614: begin
			comb_array_muxed4 <= 14'sd14945;
		end
		10'd615: begin
			comb_array_muxed4 <= 14'sd14933;
		end
		10'd616: begin
			comb_array_muxed4 <= 14'sd14920;
		end
		10'd617: begin
			comb_array_muxed4 <= 14'sd14908;
		end
		10'd618: begin
			comb_array_muxed4 <= 14'sd14896;
		end
		10'd619: begin
			comb_array_muxed4 <= 14'sd14884;
		end
		10'd620: begin
			comb_array_muxed4 <= 14'sd14872;
		end
		10'd621: begin
			comb_array_muxed4 <= 14'sd14861;
		end
		10'd622: begin
			comb_array_muxed4 <= 14'sd14849;
		end
		10'd623: begin
			comb_array_muxed4 <= 14'sd14837;
		end
		10'd624: begin
			comb_array_muxed4 <= 14'sd14825;
		end
		10'd625: begin
			comb_array_muxed4 <= 14'sd14814;
		end
		10'd626: begin
			comb_array_muxed4 <= 14'sd14802;
		end
		10'd627: begin
			comb_array_muxed4 <= 14'sd14791;
		end
		10'd628: begin
			comb_array_muxed4 <= 14'sd14779;
		end
		10'd629: begin
			comb_array_muxed4 <= 14'sd14768;
		end
		10'd630: begin
			comb_array_muxed4 <= 14'sd14756;
		end
		10'd631: begin
			comb_array_muxed4 <= 14'sd14745;
		end
		10'd632: begin
			comb_array_muxed4 <= 14'sd14734;
		end
		10'd633: begin
			comb_array_muxed4 <= 14'sd14723;
		end
		10'd634: begin
			comb_array_muxed4 <= 14'sd14712;
		end
		10'd635: begin
			comb_array_muxed4 <= 14'sd14701;
		end
		10'd636: begin
			comb_array_muxed4 <= 14'sd14690;
		end
		10'd637: begin
			comb_array_muxed4 <= 14'sd14679;
		end
		10'd638: begin
			comb_array_muxed4 <= 14'sd14668;
		end
		10'd639: begin
			comb_array_muxed4 <= 14'sd14657;
		end
		10'd640: begin
			comb_array_muxed4 <= 14'sd14647;
		end
		10'd641: begin
			comb_array_muxed4 <= 14'sd14636;
		end
		10'd642: begin
			comb_array_muxed4 <= 14'sd14625;
		end
		10'd643: begin
			comb_array_muxed4 <= 14'sd14615;
		end
		10'd644: begin
			comb_array_muxed4 <= 14'sd14605;
		end
		10'd645: begin
			comb_array_muxed4 <= 14'sd14594;
		end
		10'd646: begin
			comb_array_muxed4 <= 14'sd14584;
		end
		10'd647: begin
			comb_array_muxed4 <= 14'sd14574;
		end
		10'd648: begin
			comb_array_muxed4 <= 14'sd14563;
		end
		10'd649: begin
			comb_array_muxed4 <= 14'sd14553;
		end
		10'd650: begin
			comb_array_muxed4 <= 14'sd14543;
		end
		10'd651: begin
			comb_array_muxed4 <= 14'sd14533;
		end
		10'd652: begin
			comb_array_muxed4 <= 14'sd14524;
		end
		10'd653: begin
			comb_array_muxed4 <= 14'sd14514;
		end
		10'd654: begin
			comb_array_muxed4 <= 14'sd14504;
		end
		10'd655: begin
			comb_array_muxed4 <= 14'sd14494;
		end
		10'd656: begin
			comb_array_muxed4 <= 14'sd14485;
		end
		10'd657: begin
			comb_array_muxed4 <= 14'sd14475;
		end
		10'd658: begin
			comb_array_muxed4 <= 14'sd14466;
		end
		10'd659: begin
			comb_array_muxed4 <= 14'sd14456;
		end
		10'd660: begin
			comb_array_muxed4 <= 14'sd14447;
		end
		10'd661: begin
			comb_array_muxed4 <= 14'sd14438;
		end
		10'd662: begin
			comb_array_muxed4 <= 14'sd14429;
		end
		10'd663: begin
			comb_array_muxed4 <= 14'sd14420;
		end
		10'd664: begin
			comb_array_muxed4 <= 14'sd14411;
		end
		10'd665: begin
			comb_array_muxed4 <= 14'sd14402;
		end
		10'd666: begin
			comb_array_muxed4 <= 14'sd14393;
		end
		10'd667: begin
			comb_array_muxed4 <= 14'sd14384;
		end
		10'd668: begin
			comb_array_muxed4 <= 14'sd14375;
		end
		10'd669: begin
			comb_array_muxed4 <= 14'sd14367;
		end
		10'd670: begin
			comb_array_muxed4 <= 14'sd14358;
		end
		10'd671: begin
			comb_array_muxed4 <= 14'sd14349;
		end
		10'd672: begin
			comb_array_muxed4 <= 14'sd14341;
		end
		10'd673: begin
			comb_array_muxed4 <= 14'sd14333;
		end
		10'd674: begin
			comb_array_muxed4 <= 14'sd14324;
		end
		10'd675: begin
			comb_array_muxed4 <= 14'sd14316;
		end
		10'd676: begin
			comb_array_muxed4 <= 14'sd14308;
		end
		10'd677: begin
			comb_array_muxed4 <= 14'sd14300;
		end
		10'd678: begin
			comb_array_muxed4 <= 14'sd14292;
		end
		10'd679: begin
			comb_array_muxed4 <= 14'sd14284;
		end
		10'd680: begin
			comb_array_muxed4 <= 14'sd14277;
		end
		10'd681: begin
			comb_array_muxed4 <= 14'sd14269;
		end
		10'd682: begin
			comb_array_muxed4 <= 14'sd14261;
		end
		10'd683: begin
			comb_array_muxed4 <= 14'sd14254;
		end
		10'd684: begin
			comb_array_muxed4 <= 14'sd14246;
		end
		10'd685: begin
			comb_array_muxed4 <= 14'sd14239;
		end
		10'd686: begin
			comb_array_muxed4 <= 14'sd14231;
		end
		10'd687: begin
			comb_array_muxed4 <= 14'sd14224;
		end
		10'd688: begin
			comb_array_muxed4 <= 14'sd14217;
		end
		10'd689: begin
			comb_array_muxed4 <= 14'sd14210;
		end
		10'd690: begin
			comb_array_muxed4 <= 14'sd14203;
		end
		10'd691: begin
			comb_array_muxed4 <= 14'sd14196;
		end
		10'd692: begin
			comb_array_muxed4 <= 14'sd14189;
		end
		10'd693: begin
			comb_array_muxed4 <= 14'sd14183;
		end
		10'd694: begin
			comb_array_muxed4 <= 14'sd14176;
		end
		10'd695: begin
			comb_array_muxed4 <= 14'sd14169;
		end
		10'd696: begin
			comb_array_muxed4 <= 14'sd14163;
		end
		10'd697: begin
			comb_array_muxed4 <= 14'sd14156;
		end
		10'd698: begin
			comb_array_muxed4 <= 14'sd14150;
		end
		10'd699: begin
			comb_array_muxed4 <= 14'sd14144;
		end
		10'd700: begin
			comb_array_muxed4 <= 14'sd14138;
		end
		10'd701: begin
			comb_array_muxed4 <= 14'sd14132;
		end
		10'd702: begin
			comb_array_muxed4 <= 14'sd14126;
		end
		10'd703: begin
			comb_array_muxed4 <= 14'sd14120;
		end
		10'd704: begin
			comb_array_muxed4 <= 14'sd14114;
		end
		10'd705: begin
			comb_array_muxed4 <= 14'sd14108;
		end
		10'd706: begin
			comb_array_muxed4 <= 14'sd14103;
		end
		10'd707: begin
			comb_array_muxed4 <= 14'sd14097;
		end
		10'd708: begin
			comb_array_muxed4 <= 14'sd14092;
		end
		10'd709: begin
			comb_array_muxed4 <= 14'sd14086;
		end
		10'd710: begin
			comb_array_muxed4 <= 14'sd14081;
		end
		10'd711: begin
			comb_array_muxed4 <= 14'sd14076;
		end
		10'd712: begin
			comb_array_muxed4 <= 14'sd14071;
		end
		10'd713: begin
			comb_array_muxed4 <= 14'sd14066;
		end
		10'd714: begin
			comb_array_muxed4 <= 14'sd14061;
		end
		10'd715: begin
			comb_array_muxed4 <= 14'sd14056;
		end
		10'd716: begin
			comb_array_muxed4 <= 14'sd14051;
		end
		10'd717: begin
			comb_array_muxed4 <= 14'sd14046;
		end
		10'd718: begin
			comb_array_muxed4 <= 14'sd14042;
		end
		10'd719: begin
			comb_array_muxed4 <= 14'sd14037;
		end
		10'd720: begin
			comb_array_muxed4 <= 14'sd14033;
		end
		10'd721: begin
			comb_array_muxed4 <= 14'sd14028;
		end
		10'd722: begin
			comb_array_muxed4 <= 14'sd14024;
		end
		10'd723: begin
			comb_array_muxed4 <= 14'sd14020;
		end
		10'd724: begin
			comb_array_muxed4 <= 14'sd14016;
		end
		10'd725: begin
			comb_array_muxed4 <= 14'sd14012;
		end
		10'd726: begin
			comb_array_muxed4 <= 14'sd14008;
		end
		10'd727: begin
			comb_array_muxed4 <= 14'sd14004;
		end
		10'd728: begin
			comb_array_muxed4 <= 14'sd14001;
		end
		10'd729: begin
			comb_array_muxed4 <= 14'sd13997;
		end
		10'd730: begin
			comb_array_muxed4 <= 14'sd13993;
		end
		10'd731: begin
			comb_array_muxed4 <= 14'sd13990;
		end
		10'd732: begin
			comb_array_muxed4 <= 14'sd13987;
		end
		10'd733: begin
			comb_array_muxed4 <= 14'sd13983;
		end
		10'd734: begin
			comb_array_muxed4 <= 14'sd13980;
		end
		10'd735: begin
			comb_array_muxed4 <= 14'sd13977;
		end
		10'd736: begin
			comb_array_muxed4 <= 14'sd13974;
		end
		10'd737: begin
			comb_array_muxed4 <= 14'sd13971;
		end
		10'd738: begin
			comb_array_muxed4 <= 14'sd13969;
		end
		10'd739: begin
			comb_array_muxed4 <= 14'sd13966;
		end
		10'd740: begin
			comb_array_muxed4 <= 14'sd13963;
		end
		10'd741: begin
			comb_array_muxed4 <= 14'sd13961;
		end
		10'd742: begin
			comb_array_muxed4 <= 14'sd13958;
		end
		10'd743: begin
			comb_array_muxed4 <= 14'sd13956;
		end
		10'd744: begin
			comb_array_muxed4 <= 14'sd13954;
		end
		10'd745: begin
			comb_array_muxed4 <= 14'sd13951;
		end
		10'd746: begin
			comb_array_muxed4 <= 14'sd13949;
		end
		10'd747: begin
			comb_array_muxed4 <= 14'sd13947;
		end
		10'd748: begin
			comb_array_muxed4 <= 14'sd13945;
		end
		10'd749: begin
			comb_array_muxed4 <= 14'sd13944;
		end
		10'd750: begin
			comb_array_muxed4 <= 14'sd13942;
		end
		10'd751: begin
			comb_array_muxed4 <= 14'sd13940;
		end
		10'd752: begin
			comb_array_muxed4 <= 14'sd13939;
		end
		10'd753: begin
			comb_array_muxed4 <= 14'sd13937;
		end
		10'd754: begin
			comb_array_muxed4 <= 14'sd13936;
		end
		10'd755: begin
			comb_array_muxed4 <= 14'sd13935;
		end
		10'd756: begin
			comb_array_muxed4 <= 14'sd13934;
		end
		10'd757: begin
			comb_array_muxed4 <= 14'sd13933;
		end
		10'd758: begin
			comb_array_muxed4 <= 14'sd13932;
		end
		10'd759: begin
			comb_array_muxed4 <= 14'sd13931;
		end
		10'd760: begin
			comb_array_muxed4 <= 14'sd13930;
		end
		10'd761: begin
			comb_array_muxed4 <= 14'sd13929;
		end
		10'd762: begin
			comb_array_muxed4 <= 14'sd13929;
		end
		10'd763: begin
			comb_array_muxed4 <= 14'sd13928;
		end
		10'd764: begin
			comb_array_muxed4 <= 14'sd13928;
		end
		10'd765: begin
			comb_array_muxed4 <= 14'sd13927;
		end
		10'd766: begin
			comb_array_muxed4 <= 14'sd13927;
		end
		10'd767: begin
			comb_array_muxed4 <= 14'sd13927;
		end
		10'd768: begin
			comb_array_muxed4 <= 14'sd13927;
		end
		10'd769: begin
			comb_array_muxed4 <= 14'sd13927;
		end
		10'd770: begin
			comb_array_muxed4 <= 14'sd13927;
		end
		10'd771: begin
			comb_array_muxed4 <= 14'sd13927;
		end
		10'd772: begin
			comb_array_muxed4 <= 14'sd13928;
		end
		10'd773: begin
			comb_array_muxed4 <= 14'sd13928;
		end
		10'd774: begin
			comb_array_muxed4 <= 14'sd13929;
		end
		10'd775: begin
			comb_array_muxed4 <= 14'sd13929;
		end
		10'd776: begin
			comb_array_muxed4 <= 14'sd13930;
		end
		10'd777: begin
			comb_array_muxed4 <= 14'sd13931;
		end
		10'd778: begin
			comb_array_muxed4 <= 14'sd13932;
		end
		10'd779: begin
			comb_array_muxed4 <= 14'sd13933;
		end
		10'd780: begin
			comb_array_muxed4 <= 14'sd13934;
		end
		10'd781: begin
			comb_array_muxed4 <= 14'sd13935;
		end
		10'd782: begin
			comb_array_muxed4 <= 14'sd13936;
		end
		10'd783: begin
			comb_array_muxed4 <= 14'sd13937;
		end
		10'd784: begin
			comb_array_muxed4 <= 14'sd13939;
		end
		10'd785: begin
			comb_array_muxed4 <= 14'sd13940;
		end
		10'd786: begin
			comb_array_muxed4 <= 14'sd13942;
		end
		10'd787: begin
			comb_array_muxed4 <= 14'sd13944;
		end
		10'd788: begin
			comb_array_muxed4 <= 14'sd13945;
		end
		10'd789: begin
			comb_array_muxed4 <= 14'sd13947;
		end
		10'd790: begin
			comb_array_muxed4 <= 14'sd13949;
		end
		10'd791: begin
			comb_array_muxed4 <= 14'sd13951;
		end
		10'd792: begin
			comb_array_muxed4 <= 14'sd13954;
		end
		10'd793: begin
			comb_array_muxed4 <= 14'sd13956;
		end
		10'd794: begin
			comb_array_muxed4 <= 14'sd13958;
		end
		10'd795: begin
			comb_array_muxed4 <= 14'sd13961;
		end
		10'd796: begin
			comb_array_muxed4 <= 14'sd13963;
		end
		10'd797: begin
			comb_array_muxed4 <= 14'sd13966;
		end
		10'd798: begin
			comb_array_muxed4 <= 14'sd13969;
		end
		10'd799: begin
			comb_array_muxed4 <= 14'sd13971;
		end
		10'd800: begin
			comb_array_muxed4 <= 14'sd13974;
		end
		10'd801: begin
			comb_array_muxed4 <= 14'sd13977;
		end
		10'd802: begin
			comb_array_muxed4 <= 14'sd13980;
		end
		10'd803: begin
			comb_array_muxed4 <= 14'sd13983;
		end
		10'd804: begin
			comb_array_muxed4 <= 14'sd13987;
		end
		10'd805: begin
			comb_array_muxed4 <= 14'sd13990;
		end
		10'd806: begin
			comb_array_muxed4 <= 14'sd13993;
		end
		10'd807: begin
			comb_array_muxed4 <= 14'sd13997;
		end
		10'd808: begin
			comb_array_muxed4 <= 14'sd14001;
		end
		10'd809: begin
			comb_array_muxed4 <= 14'sd14004;
		end
		10'd810: begin
			comb_array_muxed4 <= 14'sd14008;
		end
		10'd811: begin
			comb_array_muxed4 <= 14'sd14012;
		end
		10'd812: begin
			comb_array_muxed4 <= 14'sd14016;
		end
		10'd813: begin
			comb_array_muxed4 <= 14'sd14020;
		end
		10'd814: begin
			comb_array_muxed4 <= 14'sd14024;
		end
		10'd815: begin
			comb_array_muxed4 <= 14'sd14028;
		end
		10'd816: begin
			comb_array_muxed4 <= 14'sd14033;
		end
		10'd817: begin
			comb_array_muxed4 <= 14'sd14037;
		end
		10'd818: begin
			comb_array_muxed4 <= 14'sd14042;
		end
		10'd819: begin
			comb_array_muxed4 <= 14'sd14046;
		end
		10'd820: begin
			comb_array_muxed4 <= 14'sd14051;
		end
		10'd821: begin
			comb_array_muxed4 <= 14'sd14056;
		end
		10'd822: begin
			comb_array_muxed4 <= 14'sd14061;
		end
		10'd823: begin
			comb_array_muxed4 <= 14'sd14066;
		end
		10'd824: begin
			comb_array_muxed4 <= 14'sd14071;
		end
		10'd825: begin
			comb_array_muxed4 <= 14'sd14076;
		end
		10'd826: begin
			comb_array_muxed4 <= 14'sd14081;
		end
		10'd827: begin
			comb_array_muxed4 <= 14'sd14086;
		end
		10'd828: begin
			comb_array_muxed4 <= 14'sd14092;
		end
		10'd829: begin
			comb_array_muxed4 <= 14'sd14097;
		end
		10'd830: begin
			comb_array_muxed4 <= 14'sd14103;
		end
		10'd831: begin
			comb_array_muxed4 <= 14'sd14108;
		end
		10'd832: begin
			comb_array_muxed4 <= 14'sd14114;
		end
		10'd833: begin
			comb_array_muxed4 <= 14'sd14120;
		end
		10'd834: begin
			comb_array_muxed4 <= 14'sd14126;
		end
		10'd835: begin
			comb_array_muxed4 <= 14'sd14132;
		end
		10'd836: begin
			comb_array_muxed4 <= 14'sd14138;
		end
		10'd837: begin
			comb_array_muxed4 <= 14'sd14144;
		end
		10'd838: begin
			comb_array_muxed4 <= 14'sd14150;
		end
		10'd839: begin
			comb_array_muxed4 <= 14'sd14156;
		end
		10'd840: begin
			comb_array_muxed4 <= 14'sd14163;
		end
		10'd841: begin
			comb_array_muxed4 <= 14'sd14169;
		end
		10'd842: begin
			comb_array_muxed4 <= 14'sd14176;
		end
		10'd843: begin
			comb_array_muxed4 <= 14'sd14183;
		end
		10'd844: begin
			comb_array_muxed4 <= 14'sd14189;
		end
		10'd845: begin
			comb_array_muxed4 <= 14'sd14196;
		end
		10'd846: begin
			comb_array_muxed4 <= 14'sd14203;
		end
		10'd847: begin
			comb_array_muxed4 <= 14'sd14210;
		end
		10'd848: begin
			comb_array_muxed4 <= 14'sd14217;
		end
		10'd849: begin
			comb_array_muxed4 <= 14'sd14224;
		end
		10'd850: begin
			comb_array_muxed4 <= 14'sd14231;
		end
		10'd851: begin
			comb_array_muxed4 <= 14'sd14239;
		end
		10'd852: begin
			comb_array_muxed4 <= 14'sd14246;
		end
		10'd853: begin
			comb_array_muxed4 <= 14'sd14254;
		end
		10'd854: begin
			comb_array_muxed4 <= 14'sd14261;
		end
		10'd855: begin
			comb_array_muxed4 <= 14'sd14269;
		end
		10'd856: begin
			comb_array_muxed4 <= 14'sd14277;
		end
		10'd857: begin
			comb_array_muxed4 <= 14'sd14284;
		end
		10'd858: begin
			comb_array_muxed4 <= 14'sd14292;
		end
		10'd859: begin
			comb_array_muxed4 <= 14'sd14300;
		end
		10'd860: begin
			comb_array_muxed4 <= 14'sd14308;
		end
		10'd861: begin
			comb_array_muxed4 <= 14'sd14316;
		end
		10'd862: begin
			comb_array_muxed4 <= 14'sd14324;
		end
		10'd863: begin
			comb_array_muxed4 <= 14'sd14333;
		end
		10'd864: begin
			comb_array_muxed4 <= 14'sd14341;
		end
		10'd865: begin
			comb_array_muxed4 <= 14'sd14349;
		end
		10'd866: begin
			comb_array_muxed4 <= 14'sd14358;
		end
		10'd867: begin
			comb_array_muxed4 <= 14'sd14367;
		end
		10'd868: begin
			comb_array_muxed4 <= 14'sd14375;
		end
		10'd869: begin
			comb_array_muxed4 <= 14'sd14384;
		end
		10'd870: begin
			comb_array_muxed4 <= 14'sd14393;
		end
		10'd871: begin
			comb_array_muxed4 <= 14'sd14402;
		end
		10'd872: begin
			comb_array_muxed4 <= 14'sd14411;
		end
		10'd873: begin
			comb_array_muxed4 <= 14'sd14420;
		end
		10'd874: begin
			comb_array_muxed4 <= 14'sd14429;
		end
		10'd875: begin
			comb_array_muxed4 <= 14'sd14438;
		end
		10'd876: begin
			comb_array_muxed4 <= 14'sd14447;
		end
		10'd877: begin
			comb_array_muxed4 <= 14'sd14456;
		end
		10'd878: begin
			comb_array_muxed4 <= 14'sd14466;
		end
		10'd879: begin
			comb_array_muxed4 <= 14'sd14475;
		end
		10'd880: begin
			comb_array_muxed4 <= 14'sd14485;
		end
		10'd881: begin
			comb_array_muxed4 <= 14'sd14494;
		end
		10'd882: begin
			comb_array_muxed4 <= 14'sd14504;
		end
		10'd883: begin
			comb_array_muxed4 <= 14'sd14514;
		end
		10'd884: begin
			comb_array_muxed4 <= 14'sd14524;
		end
		10'd885: begin
			comb_array_muxed4 <= 14'sd14533;
		end
		10'd886: begin
			comb_array_muxed4 <= 14'sd14543;
		end
		10'd887: begin
			comb_array_muxed4 <= 14'sd14553;
		end
		10'd888: begin
			comb_array_muxed4 <= 14'sd14563;
		end
		10'd889: begin
			comb_array_muxed4 <= 14'sd14574;
		end
		10'd890: begin
			comb_array_muxed4 <= 14'sd14584;
		end
		10'd891: begin
			comb_array_muxed4 <= 14'sd14594;
		end
		10'd892: begin
			comb_array_muxed4 <= 14'sd14605;
		end
		10'd893: begin
			comb_array_muxed4 <= 14'sd14615;
		end
		10'd894: begin
			comb_array_muxed4 <= 14'sd14625;
		end
		10'd895: begin
			comb_array_muxed4 <= 14'sd14636;
		end
		10'd896: begin
			comb_array_muxed4 <= 14'sd14647;
		end
		10'd897: begin
			comb_array_muxed4 <= 14'sd14657;
		end
		10'd898: begin
			comb_array_muxed4 <= 14'sd14668;
		end
		10'd899: begin
			comb_array_muxed4 <= 14'sd14679;
		end
		10'd900: begin
			comb_array_muxed4 <= 14'sd14690;
		end
		10'd901: begin
			comb_array_muxed4 <= 14'sd14701;
		end
		10'd902: begin
			comb_array_muxed4 <= 14'sd14712;
		end
		10'd903: begin
			comb_array_muxed4 <= 14'sd14723;
		end
		10'd904: begin
			comb_array_muxed4 <= 14'sd14734;
		end
		10'd905: begin
			comb_array_muxed4 <= 14'sd14745;
		end
		10'd906: begin
			comb_array_muxed4 <= 14'sd14756;
		end
		10'd907: begin
			comb_array_muxed4 <= 14'sd14768;
		end
		10'd908: begin
			comb_array_muxed4 <= 14'sd14779;
		end
		10'd909: begin
			comb_array_muxed4 <= 14'sd14791;
		end
		10'd910: begin
			comb_array_muxed4 <= 14'sd14802;
		end
		10'd911: begin
			comb_array_muxed4 <= 14'sd14814;
		end
		10'd912: begin
			comb_array_muxed4 <= 14'sd14825;
		end
		10'd913: begin
			comb_array_muxed4 <= 14'sd14837;
		end
		10'd914: begin
			comb_array_muxed4 <= 14'sd14849;
		end
		10'd915: begin
			comb_array_muxed4 <= 14'sd14861;
		end
		10'd916: begin
			comb_array_muxed4 <= 14'sd14872;
		end
		10'd917: begin
			comb_array_muxed4 <= 14'sd14884;
		end
		10'd918: begin
			comb_array_muxed4 <= 14'sd14896;
		end
		10'd919: begin
			comb_array_muxed4 <= 14'sd14908;
		end
		10'd920: begin
			comb_array_muxed4 <= 14'sd14920;
		end
		10'd921: begin
			comb_array_muxed4 <= 14'sd14933;
		end
		10'd922: begin
			comb_array_muxed4 <= 14'sd14945;
		end
		10'd923: begin
			comb_array_muxed4 <= 14'sd14957;
		end
		10'd924: begin
			comb_array_muxed4 <= 14'sd14969;
		end
		10'd925: begin
			comb_array_muxed4 <= 14'sd14982;
		end
		10'd926: begin
			comb_array_muxed4 <= 14'sd14994;
		end
		10'd927: begin
			comb_array_muxed4 <= 14'sd15006;
		end
		10'd928: begin
			comb_array_muxed4 <= 14'sd15019;
		end
		10'd929: begin
			comb_array_muxed4 <= 14'sd15032;
		end
		10'd930: begin
			comb_array_muxed4 <= 14'sd15044;
		end
		10'd931: begin
			comb_array_muxed4 <= 14'sd15057;
		end
		10'd932: begin
			comb_array_muxed4 <= 14'sd15070;
		end
		10'd933: begin
			comb_array_muxed4 <= 14'sd15082;
		end
		10'd934: begin
			comb_array_muxed4 <= 14'sd15095;
		end
		10'd935: begin
			comb_array_muxed4 <= 14'sd15108;
		end
		10'd936: begin
			comb_array_muxed4 <= 14'sd15121;
		end
		10'd937: begin
			comb_array_muxed4 <= 14'sd15134;
		end
		10'd938: begin
			comb_array_muxed4 <= 14'sd15147;
		end
		10'd939: begin
			comb_array_muxed4 <= 14'sd15160;
		end
		10'd940: begin
			comb_array_muxed4 <= 14'sd15173;
		end
		10'd941: begin
			comb_array_muxed4 <= 14'sd15186;
		end
		10'd942: begin
			comb_array_muxed4 <= 14'sd15199;
		end
		10'd943: begin
			comb_array_muxed4 <= 14'sd15213;
		end
		10'd944: begin
			comb_array_muxed4 <= 14'sd15226;
		end
		10'd945: begin
			comb_array_muxed4 <= 14'sd15239;
		end
		10'd946: begin
			comb_array_muxed4 <= 14'sd15252;
		end
		10'd947: begin
			comb_array_muxed4 <= 14'sd15266;
		end
		10'd948: begin
			comb_array_muxed4 <= 14'sd15279;
		end
		10'd949: begin
			comb_array_muxed4 <= 14'sd15293;
		end
		10'd950: begin
			comb_array_muxed4 <= 14'sd15306;
		end
		10'd951: begin
			comb_array_muxed4 <= 14'sd15320;
		end
		10'd952: begin
			comb_array_muxed4 <= 14'sd15333;
		end
		10'd953: begin
			comb_array_muxed4 <= 14'sd15347;
		end
		10'd954: begin
			comb_array_muxed4 <= 14'sd15361;
		end
		10'd955: begin
			comb_array_muxed4 <= 14'sd15375;
		end
		10'd956: begin
			comb_array_muxed4 <= 14'sd15388;
		end
		10'd957: begin
			comb_array_muxed4 <= 14'sd15402;
		end
		10'd958: begin
			comb_array_muxed4 <= 14'sd15416;
		end
		10'd959: begin
			comb_array_muxed4 <= 14'sd15430;
		end
		10'd960: begin
			comb_array_muxed4 <= 14'sd15444;
		end
		10'd961: begin
			comb_array_muxed4 <= 14'sd15458;
		end
		10'd962: begin
			comb_array_muxed4 <= 14'sd15472;
		end
		10'd963: begin
			comb_array_muxed4 <= 14'sd15486;
		end
		10'd964: begin
			comb_array_muxed4 <= 14'sd15500;
		end
		10'd965: begin
			comb_array_muxed4 <= 14'sd15514;
		end
		10'd966: begin
			comb_array_muxed4 <= 14'sd15528;
		end
		10'd967: begin
			comb_array_muxed4 <= 14'sd15542;
		end
		10'd968: begin
			comb_array_muxed4 <= 14'sd15556;
		end
		10'd969: begin
			comb_array_muxed4 <= 14'sd15570;
		end
		10'd970: begin
			comb_array_muxed4 <= 14'sd15585;
		end
		10'd971: begin
			comb_array_muxed4 <= 14'sd15599;
		end
		10'd972: begin
			comb_array_muxed4 <= 14'sd15613;
		end
		10'd973: begin
			comb_array_muxed4 <= 14'sd15628;
		end
		10'd974: begin
			comb_array_muxed4 <= 14'sd15642;
		end
		10'd975: begin
			comb_array_muxed4 <= 14'sd15656;
		end
		10'd976: begin
			comb_array_muxed4 <= 14'sd15671;
		end
		10'd977: begin
			comb_array_muxed4 <= 14'sd15685;
		end
		10'd978: begin
			comb_array_muxed4 <= 14'sd15700;
		end
		10'd979: begin
			comb_array_muxed4 <= 14'sd15714;
		end
		10'd980: begin
			comb_array_muxed4 <= 14'sd15729;
		end
		10'd981: begin
			comb_array_muxed4 <= 14'sd15743;
		end
		10'd982: begin
			comb_array_muxed4 <= 14'sd15758;
		end
		10'd983: begin
			comb_array_muxed4 <= 14'sd15772;
		end
		10'd984: begin
			comb_array_muxed4 <= 14'sd15787;
		end
		10'd985: begin
			comb_array_muxed4 <= 14'sd15802;
		end
		10'd986: begin
			comb_array_muxed4 <= 14'sd15816;
		end
		10'd987: begin
			comb_array_muxed4 <= 14'sd15831;
		end
		10'd988: begin
			comb_array_muxed4 <= 14'sd15846;
		end
		10'd989: begin
			comb_array_muxed4 <= 14'sd15860;
		end
		10'd990: begin
			comb_array_muxed4 <= 14'sd15875;
		end
		10'd991: begin
			comb_array_muxed4 <= 14'sd15890;
		end
		10'd992: begin
			comb_array_muxed4 <= 14'sd15905;
		end
		10'd993: begin
			comb_array_muxed4 <= 14'sd15919;
		end
		10'd994: begin
			comb_array_muxed4 <= 14'sd15934;
		end
		10'd995: begin
			comb_array_muxed4 <= 14'sd15949;
		end
		10'd996: begin
			comb_array_muxed4 <= 14'sd15964;
		end
		10'd997: begin
			comb_array_muxed4 <= 14'sd15979;
		end
		10'd998: begin
			comb_array_muxed4 <= 14'sd15994;
		end
		10'd999: begin
			comb_array_muxed4 <= 14'sd16009;
		end
		10'd1000: begin
			comb_array_muxed4 <= 14'sd16023;
		end
		10'd1001: begin
			comb_array_muxed4 <= 14'sd16038;
		end
		10'd1002: begin
			comb_array_muxed4 <= 14'sd16053;
		end
		10'd1003: begin
			comb_array_muxed4 <= 14'sd16068;
		end
		10'd1004: begin
			comb_array_muxed4 <= 14'sd16083;
		end
		10'd1005: begin
			comb_array_muxed4 <= 14'sd16098;
		end
		10'd1006: begin
			comb_array_muxed4 <= 14'sd16113;
		end
		10'd1007: begin
			comb_array_muxed4 <= 14'sd16128;
		end
		10'd1008: begin
			comb_array_muxed4 <= 14'sd16143;
		end
		10'd1009: begin
			comb_array_muxed4 <= 14'sd16158;
		end
		10'd1010: begin
			comb_array_muxed4 <= 14'sd16173;
		end
		10'd1011: begin
			comb_array_muxed4 <= 14'sd16188;
		end
		10'd1012: begin
			comb_array_muxed4 <= 14'sd16203;
		end
		10'd1013: begin
			comb_array_muxed4 <= 14'sd16218;
		end
		10'd1014: begin
			comb_array_muxed4 <= 14'sd16233;
		end
		10'd1015: begin
			comb_array_muxed4 <= 14'sd16248;
		end
		10'd1016: begin
			comb_array_muxed4 <= 14'sd16263;
		end
		10'd1017: begin
			comb_array_muxed4 <= 14'sd16279;
		end
		10'd1018: begin
			comb_array_muxed4 <= 14'sd16294;
		end
		10'd1019: begin
			comb_array_muxed4 <= 14'sd16309;
		end
		10'd1020: begin
			comb_array_muxed4 <= 14'sd16324;
		end
		10'd1021: begin
			comb_array_muxed4 <= 14'sd16339;
		end
		10'd1022: begin
			comb_array_muxed4 <= 14'sd16354;
		end
		default: begin
			comb_array_muxed4 <= 14'sd16369;
		end
	endcase
// synthesis translate_off
	dummy_d_32 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_33;
// synthesis translate_on
always @(*) begin
	sync_array_muxed0 <= 25'sd0;
	case (linien_csrstorage8_storage)
		1'd0: begin
			sync_array_muxed0 <= 1'd0;
		end
		1'd1: begin
			sync_array_muxed0 <= linien_fast_a_x0;
		end
		2'd2: begin
			sync_array_muxed0 <= linien_fast_a_out_i;
		end
		2'd3: begin
			sync_array_muxed0 <= linien_fast_a_out_q;
		end
		3'd4: begin
			sync_array_muxed0 <= linien_fast_b_x0;
		end
		3'd5: begin
			sync_array_muxed0 <= linien_fast_b_out_i;
		end
		3'd6: begin
			sync_array_muxed0 <= linien_fast_b_out_q;
		end
		3'd7: begin
			sync_array_muxed0 <= linien_out_e;
		end
		4'd8: begin
			sync_array_muxed0 <= linien_power_signal_out;
		end
		4'd9: begin
			sync_array_muxed0 <= linien_scopegen_dac_a;
		end
		4'd10: begin
			sync_array_muxed0 <= linien_scopegen_dac_b;
		end
		4'd11: begin
			sync_array_muxed0 <= linien_logic_control_signal;
		end
		default: begin
			sync_array_muxed0 <= linien_time_command_out;
		end
	endcase
// synthesis translate_off
	dummy_d_33 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_34;
// synthesis translate_on
always @(*) begin
	sync_array_muxed1 <= 25'sd0;
	case (linien_csrstorage9_storage)
		1'd0: begin
			sync_array_muxed1 <= 1'd0;
		end
		1'd1: begin
			sync_array_muxed1 <= linien_fast_a_x0;
		end
		2'd2: begin
			sync_array_muxed1 <= linien_fast_a_out_i;
		end
		2'd3: begin
			sync_array_muxed1 <= linien_fast_a_out_q;
		end
		3'd4: begin
			sync_array_muxed1 <= linien_fast_b_x0;
		end
		3'd5: begin
			sync_array_muxed1 <= linien_fast_b_out_i;
		end
		3'd6: begin
			sync_array_muxed1 <= linien_fast_b_out_q;
		end
		3'd7: begin
			sync_array_muxed1 <= linien_out_e;
		end
		4'd8: begin
			sync_array_muxed1 <= linien_power_signal_out;
		end
		4'd9: begin
			sync_array_muxed1 <= linien_scopegen_dac_a;
		end
		4'd10: begin
			sync_array_muxed1 <= linien_scopegen_dac_b;
		end
		4'd11: begin
			sync_array_muxed1 <= linien_logic_control_signal;
		end
		default: begin
			sync_array_muxed1 <= linien_time_command_out;
		end
	endcase
// synthesis translate_off
	dummy_d_34 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_35;
// synthesis translate_on
always @(*) begin
	sync_array_muxed2 <= 25'sd0;
	case (linien_csrstorage10_storage)
		1'd0: begin
			sync_array_muxed2 <= 1'd0;
		end
		1'd1: begin
			sync_array_muxed2 <= linien_fast_a_x0;
		end
		2'd2: begin
			sync_array_muxed2 <= linien_fast_a_out_i;
		end
		2'd3: begin
			sync_array_muxed2 <= linien_fast_a_out_q;
		end
		3'd4: begin
			sync_array_muxed2 <= linien_fast_b_x0;
		end
		3'd5: begin
			sync_array_muxed2 <= linien_fast_b_out_i;
		end
		3'd6: begin
			sync_array_muxed2 <= linien_fast_b_out_q;
		end
		3'd7: begin
			sync_array_muxed2 <= linien_out_e;
		end
		4'd8: begin
			sync_array_muxed2 <= linien_power_signal_out;
		end
		4'd9: begin
			sync_array_muxed2 <= linien_scopegen_dac_a;
		end
		4'd10: begin
			sync_array_muxed2 <= linien_scopegen_dac_b;
		end
		4'd11: begin
			sync_array_muxed2 <= linien_logic_control_signal;
		end
		default: begin
			sync_array_muxed2 <= linien_time_command_out;
		end
	endcase
// synthesis translate_off
	dummy_d_35 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_36;
// synthesis translate_on
always @(*) begin
	sync_array_muxed3 <= 25'sd0;
	case (linien_csrstorage11_storage)
		1'd0: begin
			sync_array_muxed3 <= 1'd0;
		end
		1'd1: begin
			sync_array_muxed3 <= linien_fast_a_x0;
		end
		2'd2: begin
			sync_array_muxed3 <= linien_fast_a_out_i;
		end
		2'd3: begin
			sync_array_muxed3 <= linien_fast_a_out_q;
		end
		3'd4: begin
			sync_array_muxed3 <= linien_fast_b_x0;
		end
		3'd5: begin
			sync_array_muxed3 <= linien_fast_b_out_i;
		end
		3'd6: begin
			sync_array_muxed3 <= linien_fast_b_out_q;
		end
		3'd7: begin
			sync_array_muxed3 <= linien_out_e;
		end
		4'd8: begin
			sync_array_muxed3 <= linien_power_signal_out;
		end
		4'd9: begin
			sync_array_muxed3 <= linien_scopegen_dac_a;
		end
		4'd10: begin
			sync_array_muxed3 <= linien_scopegen_dac_b;
		end
		4'd11: begin
			sync_array_muxed3 <= linien_logic_control_signal;
		end
		default: begin
			sync_array_muxed3 <= linien_time_command_out;
		end
	endcase
// synthesis translate_off
	dummy_d_36 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_37;
// synthesis translate_on
always @(*) begin
	sync_array_muxed4 <= 25'sd0;
	case (linien_csrstorage12_storage)
		1'd0: begin
			sync_array_muxed4 <= 1'd0;
		end
		1'd1: begin
			sync_array_muxed4 <= linien_fast_a_x0;
		end
		2'd2: begin
			sync_array_muxed4 <= linien_fast_a_out_i;
		end
		2'd3: begin
			sync_array_muxed4 <= linien_fast_a_out_q;
		end
		3'd4: begin
			sync_array_muxed4 <= linien_fast_b_x0;
		end
		3'd5: begin
			sync_array_muxed4 <= linien_fast_b_out_i;
		end
		3'd6: begin
			sync_array_muxed4 <= linien_fast_b_out_q;
		end
		3'd7: begin
			sync_array_muxed4 <= linien_out_e;
		end
		4'd8: begin
			sync_array_muxed4 <= linien_power_signal_out;
		end
		4'd9: begin
			sync_array_muxed4 <= linien_scopegen_dac_a;
		end
		4'd10: begin
			sync_array_muxed4 <= linien_scopegen_dac_b;
		end
		4'd11: begin
			sync_array_muxed4 <= linien_logic_control_signal;
		end
		default: begin
			sync_array_muxed4 <= linien_time_command_out;
		end
	endcase
// synthesis translate_off
	dummy_d_37 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_38;
// synthesis translate_on
always @(*) begin
	sync_array_muxed5 <= 25'sd0;
	case (linien_csrstorage13_storage)
		1'd0: begin
			sync_array_muxed5 <= 1'd0;
		end
		1'd1: begin
			sync_array_muxed5 <= linien_fast_a_x0;
		end
		2'd2: begin
			sync_array_muxed5 <= linien_fast_a_out_i;
		end
		2'd3: begin
			sync_array_muxed5 <= linien_fast_a_out_q;
		end
		3'd4: begin
			sync_array_muxed5 <= linien_fast_b_x0;
		end
		3'd5: begin
			sync_array_muxed5 <= linien_fast_b_out_i;
		end
		3'd6: begin
			sync_array_muxed5 <= linien_fast_b_out_q;
		end
		3'd7: begin
			sync_array_muxed5 <= linien_out_e;
		end
		4'd8: begin
			sync_array_muxed5 <= linien_power_signal_out;
		end
		4'd9: begin
			sync_array_muxed5 <= linien_scopegen_dac_a;
		end
		4'd10: begin
			sync_array_muxed5 <= linien_scopegen_dac_b;
		end
		4'd11: begin
			sync_array_muxed5 <= linien_logic_control_signal;
		end
		default: begin
			sync_array_muxed5 <= linien_time_command_out;
		end
	endcase
// synthesis translate_off
	dummy_d_38 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_39;
// synthesis translate_on
always @(*) begin
	sync_array_muxed6 <= 25'sd0;
	case (linien_csrstorage14_storage)
		1'd0: begin
			sync_array_muxed6 <= 1'd0;
		end
		1'd1: begin
			sync_array_muxed6 <= linien_fast_a_x0;
		end
		2'd2: begin
			sync_array_muxed6 <= linien_fast_a_out_i;
		end
		2'd3: begin
			sync_array_muxed6 <= linien_fast_a_out_q;
		end
		3'd4: begin
			sync_array_muxed6 <= linien_fast_b_x0;
		end
		3'd5: begin
			sync_array_muxed6 <= linien_fast_b_out_i;
		end
		3'd6: begin
			sync_array_muxed6 <= linien_fast_b_out_q;
		end
		3'd7: begin
			sync_array_muxed6 <= linien_out_e;
		end
		4'd8: begin
			sync_array_muxed6 <= linien_power_signal_out;
		end
		4'd9: begin
			sync_array_muxed6 <= linien_scopegen_dac_a;
		end
		4'd10: begin
			sync_array_muxed6 <= linien_scopegen_dac_b;
		end
		4'd11: begin
			sync_array_muxed6 <= linien_logic_control_signal;
		end
		default: begin
			sync_array_muxed6 <= linien_time_command_out;
		end
	endcase
// synthesis translate_off
	dummy_d_39 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_40;
// synthesis translate_on
always @(*) begin
	sync_array_muxed7 <= 25'sd0;
	case (linien_csrstorage15_storage)
		1'd0: begin
			sync_array_muxed7 <= 1'd0;
		end
		1'd1: begin
			sync_array_muxed7 <= linien_fast_a_x0;
		end
		2'd2: begin
			sync_array_muxed7 <= linien_fast_a_out_i;
		end
		2'd3: begin
			sync_array_muxed7 <= linien_fast_a_out_q;
		end
		3'd4: begin
			sync_array_muxed7 <= linien_fast_b_x0;
		end
		3'd5: begin
			sync_array_muxed7 <= linien_fast_b_out_i;
		end
		3'd6: begin
			sync_array_muxed7 <= linien_fast_b_out_q;
		end
		3'd7: begin
			sync_array_muxed7 <= linien_out_e;
		end
		4'd8: begin
			sync_array_muxed7 <= linien_power_signal_out;
		end
		4'd9: begin
			sync_array_muxed7 <= linien_scopegen_dac_a;
		end
		4'd10: begin
			sync_array_muxed7 <= linien_scopegen_dac_b;
		end
		4'd11: begin
			sync_array_muxed7 <= linien_logic_control_signal;
		end
		default: begin
			sync_array_muxed7 <= linien_time_command_out;
		end
	endcase
// synthesis translate_off
	dummy_d_40 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_41;
// synthesis translate_on
always @(*) begin
	array_muxed <= 1'd0;
	case (linien_scopegen_storage)
		1'd0: begin
			array_muxed <= linien_scopegen_gpio_trigger;
		end
		default: begin
			array_muxed <= linien_scopegen_sweep_trigger;
		end
	endcase
// synthesis translate_off
	dummy_d_41 <= dummy_s;
// synthesis translate_on
end
assign linien_gpio_n_i = xilinxmultiregimpl0_regs1;
assign xilinxmultiregimpl0 = {linien_gpio_n_tstriple7_i, linien_gpio_n_tstriple6_i, linien_gpio_n_tstriple5_i, linien_gpio_n_tstriple4_i, linien_gpio_n_tstriple3_i, linien_gpio_n_tstriple2_i, linien_gpio_n_tstriple1_i, linien_gpio_n_tstriple0_i};
assign linien_gpio_p_i = xilinxmultiregimpl1_regs1;
assign xilinxmultiregimpl1 = {linien_gpio_p_tstriple7_i, linien_gpio_p_tstriple6_i, linien_gpio_p_tstriple5_i, linien_gpio_p_tstriple4_i, linien_gpio_p_tstriple3_i, linien_gpio_p_tstriple2_i, linien_gpio_p_tstriple1_i, linien_gpio_p_tstriple0_i};

always @(posedge sys_clk) begin
	if (($signed({1'd0, linien_control_signal_clr_re}) | ($signed({1'd0, linien_max_status10}) < linien_logic_control_signal))) begin
		linien_max_status10 <= linien_logic_control_signal;
	end
	if (($signed({1'd0, linien_control_signal_clr_re}) | ($signed({1'd0, linien_min_status10}) > linien_logic_control_signal))) begin
		linien_min_status10 <= linien_logic_control_signal;
	end
	linien_logic_stop <= (linien_logic_freq_storage == 1'd0);
	if ((linien_logic_stop | linien_logic_sync_phase)) begin
		linien_logic_z <= 1'd0;
	end else begin
		linien_logic_z <= (linien_logic_z + linien_logic_freq_storage);
	end
	linien_logic_cordic_x1 <= (linien_logic_cordic_x0 + (linien_logic_cordic_dir0 ? (linien_logic_cordic_y0 >>> 1'd0) : (-(linien_logic_cordic_y0 >>> 1'd0))));
	linien_logic_cordic_y1 <= (linien_logic_cordic_y0 + (linien_logic_cordic_dir0 ? (-(linien_logic_cordic_x0 >>> 1'd0)) : (linien_logic_cordic_x0 >>> 1'd0)));
	linien_logic_cordic_z1 <= (linien_logic_cordic_z0 + (linien_logic_cordic_dir0 ? $signed({1'd0, 15'd16384}) : 15'sd16384));
	linien_logic_cordic_x2 <= (linien_logic_cordic_x1 + (linien_logic_cordic_dir1 ? (linien_logic_cordic_y1 >>> 1'd1) : (-(linien_logic_cordic_y1 >>> 1'd1))));
	linien_logic_cordic_y2 <= (linien_logic_cordic_y1 + (linien_logic_cordic_dir1 ? (-(linien_logic_cordic_x1 >>> 1'd1)) : (linien_logic_cordic_x1 >>> 1'd1)));
	linien_logic_cordic_z2 <= (linien_logic_cordic_z1 + (linien_logic_cordic_dir1 ? $signed({1'd0, 14'd9672}) : 15'sd23096));
	linien_logic_cordic_x3 <= (linien_logic_cordic_x2 + (linien_logic_cordic_dir2 ? (linien_logic_cordic_y2 >>> 2'd2) : (-(linien_logic_cordic_y2 >>> 2'd2))));
	linien_logic_cordic_y3 <= (linien_logic_cordic_y2 + (linien_logic_cordic_dir2 ? (-(linien_logic_cordic_x2 >>> 2'd2)) : (linien_logic_cordic_x2 >>> 2'd2)));
	linien_logic_cordic_z3 <= (linien_logic_cordic_z2 + (linien_logic_cordic_dir2 ? $signed({1'd0, 13'd5110}) : 14'sd11274));
	linien_logic_cordic_x4 <= (linien_logic_cordic_x3 + (linien_logic_cordic_dir3 ? (linien_logic_cordic_y3 >>> 2'd3) : (-(linien_logic_cordic_y3 >>> 2'd3))));
	linien_logic_cordic_y4 <= (linien_logic_cordic_y3 + (linien_logic_cordic_dir3 ? (-(linien_logic_cordic_x3 >>> 2'd3)) : (linien_logic_cordic_x3 >>> 2'd3)));
	linien_logic_cordic_z4 <= (linien_logic_cordic_z3 + (linien_logic_cordic_dir3 ? $signed({1'd0, 12'd2594}) : 13'sd5598));
	linien_logic_cordic_x5 <= (linien_logic_cordic_x4 + (linien_logic_cordic_dir4 ? (linien_logic_cordic_y4 >>> 3'd4) : (-(linien_logic_cordic_y4 >>> 3'd4))));
	linien_logic_cordic_y5 <= (linien_logic_cordic_y4 + (linien_logic_cordic_dir4 ? (-(linien_logic_cordic_x4 >>> 3'd4)) : (linien_logic_cordic_x4 >>> 3'd4)));
	linien_logic_cordic_z5 <= (linien_logic_cordic_z4 + (linien_logic_cordic_dir4 ? $signed({1'd0, 11'd1302}) : 12'sd2794));
	linien_logic_cordic_x6 <= (linien_logic_cordic_x5 + (linien_logic_cordic_dir5 ? (linien_logic_cordic_y5 >>> 3'd5) : (-(linien_logic_cordic_y5 >>> 3'd5))));
	linien_logic_cordic_y6 <= (linien_logic_cordic_y5 + (linien_logic_cordic_dir5 ? (-(linien_logic_cordic_x5 >>> 3'd5)) : (linien_logic_cordic_x5 >>> 3'd5)));
	linien_logic_cordic_z6 <= (linien_logic_cordic_z5 + (linien_logic_cordic_dir5 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	linien_logic_cordic_x7 <= (linien_logic_cordic_x6 + (linien_logic_cordic_dir6 ? (linien_logic_cordic_y6 >>> 3'd6) : (-(linien_logic_cordic_y6 >>> 3'd6))));
	linien_logic_cordic_y7 <= (linien_logic_cordic_y6 + (linien_logic_cordic_dir6 ? (-(linien_logic_cordic_x6 >>> 3'd6)) : (linien_logic_cordic_x6 >>> 3'd6)));
	linien_logic_cordic_z7 <= (linien_logic_cordic_z6 + (linien_logic_cordic_dir6 ? $signed({1'd0, 9'd326}) : 10'sd698));
	linien_logic_cordic_x8 <= (linien_logic_cordic_x7 + (linien_logic_cordic_dir7 ? (linien_logic_cordic_y7 >>> 3'd7) : (-(linien_logic_cordic_y7 >>> 3'd7))));
	linien_logic_cordic_y8 <= (linien_logic_cordic_y7 + (linien_logic_cordic_dir7 ? (-(linien_logic_cordic_x7 >>> 3'd7)) : (linien_logic_cordic_x7 >>> 3'd7)));
	linien_logic_cordic_z8 <= (linien_logic_cordic_z7 + (linien_logic_cordic_dir7 ? $signed({1'd0, 8'd163}) : 9'sd349));
	linien_logic_cordic_x9 <= (linien_logic_cordic_x8 + (linien_logic_cordic_dir8 ? (linien_logic_cordic_y8 >>> 4'd8) : (-(linien_logic_cordic_y8 >>> 4'd8))));
	linien_logic_cordic_y9 <= (linien_logic_cordic_y8 + (linien_logic_cordic_dir8 ? (-(linien_logic_cordic_x8 >>> 4'd8)) : (linien_logic_cordic_x8 >>> 4'd8)));
	linien_logic_cordic_z9 <= (linien_logic_cordic_z8 + (linien_logic_cordic_dir8 ? $signed({1'd0, 7'd81}) : 8'sd175));
	linien_logic_cordic_x10 <= (linien_logic_cordic_x9 + (linien_logic_cordic_dir9 ? (linien_logic_cordic_y9 >>> 4'd9) : (-(linien_logic_cordic_y9 >>> 4'd9))));
	linien_logic_cordic_y10 <= (linien_logic_cordic_y9 + (linien_logic_cordic_dir9 ? (-(linien_logic_cordic_x9 >>> 4'd9)) : (linien_logic_cordic_x9 >>> 4'd9)));
	linien_logic_cordic_z10 <= (linien_logic_cordic_z9 + (linien_logic_cordic_dir9 ? $signed({1'd0, 6'd41}) : 7'sd87));
	linien_logic_cordic_x11 <= (linien_logic_cordic_x10 + (linien_logic_cordic_dir10 ? (linien_logic_cordic_y10 >>> 4'd10) : (-(linien_logic_cordic_y10 >>> 4'd10))));
	linien_logic_cordic_y11 <= (linien_logic_cordic_y10 + (linien_logic_cordic_dir10 ? (-(linien_logic_cordic_x10 >>> 4'd10)) : (linien_logic_cordic_x10 >>> 4'd10)));
	linien_logic_cordic_z11 <= (linien_logic_cordic_z10 + (linien_logic_cordic_dir10 ? $signed({1'd0, 5'd20}) : 6'sd44));
	linien_logic_cordic_x12 <= (linien_logic_cordic_x11 + (linien_logic_cordic_dir11 ? (linien_logic_cordic_y11 >>> 4'd11) : (-(linien_logic_cordic_y11 >>> 4'd11))));
	linien_logic_cordic_y12 <= (linien_logic_cordic_y11 + (linien_logic_cordic_dir11 ? (-(linien_logic_cordic_x11 >>> 4'd11)) : (linien_logic_cordic_x11 >>> 4'd11)));
	linien_logic_cordic_z12 <= (linien_logic_cordic_z11 + (linien_logic_cordic_dir11 ? $signed({1'd0, 4'd10}) : 5'sd22));
	linien_logic_cordic_x13 <= (linien_logic_cordic_x12 + (linien_logic_cordic_dir12 ? (linien_logic_cordic_y12 >>> 4'd12) : (-(linien_logic_cordic_y12 >>> 4'd12))));
	linien_logic_cordic_y13 <= (linien_logic_cordic_y12 + (linien_logic_cordic_dir12 ? (-(linien_logic_cordic_x12 >>> 4'd12)) : (linien_logic_cordic_x12 >>> 4'd12)));
	linien_logic_cordic_z13 <= (linien_logic_cordic_z12 + (linien_logic_cordic_dir12 ? $signed({1'd0, 3'd5}) : 4'sd11));
	linien_logic_cordic_x14 <= (linien_logic_cordic_x13 + (linien_logic_cordic_dir13 ? (linien_logic_cordic_y13 >>> 4'd13) : (-(linien_logic_cordic_y13 >>> 4'd13))));
	linien_logic_cordic_y14 <= (linien_logic_cordic_y13 + (linien_logic_cordic_dir13 ? (-(linien_logic_cordic_x13 >>> 4'd13)) : (linien_logic_cordic_x13 >>> 4'd13)));
	linien_logic_cordic_z14 <= (linien_logic_cordic_z13 + (linien_logic_cordic_dir13 ? $signed({1'd0, 2'd3}) : 3'sd5));
	linien_logic_cordic_x15 <= (linien_logic_cordic_x14 + (linien_logic_cordic_dir14 ? (linien_logic_cordic_y14 >>> 4'd14) : (-(linien_logic_cordic_y14 >>> 4'd14))));
	linien_logic_cordic_y15 <= (linien_logic_cordic_y14 + (linien_logic_cordic_dir14 ? (-(linien_logic_cordic_x14 >>> 4'd14)) : (linien_logic_cordic_x14 >>> 4'd14)));
	linien_logic_cordic_z15 <= (linien_logic_cordic_z14 + (linien_logic_cordic_dir14 ? $signed({1'd0, 1'd1}) : 1'sd1));
	linien_logic_limit_error_signal_limit_min <= {{4{linien_logic_limit_error_signal_min_storage[24]}}, linien_logic_limit_error_signal_min_storage};
	linien_logic_limit_error_signal_limit_max <= {{4{linien_logic_limit_error_signal_max_storage[24]}}, linien_logic_limit_error_signal_max_storage};
	linien_logic_limit_error_signal_limitcsr_y <= linien_logic_limit_error_signal_limit_y;
	linien_logic_limit_error_signal_limitcsr_error <= linien_logic_limit_error_signal_limit_railed;
	linien_logic_limit_fast1_limit_min <= {{5{linien_logic_limit_fast1_min_storage[13]}}, linien_logic_limit_fast1_min_storage};
	linien_logic_limit_fast1_limit_max <= {{5{linien_logic_limit_fast1_max_storage[13]}}, linien_logic_limit_fast1_max_storage};
	linien_logic_limit_fast1_limitcsr_y <= linien_logic_limit_fast1_limit_y;
	linien_logic_limit_fast1_limitcsr_error <= linien_logic_limit_fast1_limit_railed;
	linien_logic_limit_fast2_limit_min <= {{5{linien_logic_limit_fast2_min_storage[13]}}, linien_logic_limit_fast2_min_storage};
	linien_logic_limit_fast2_limit_max <= {{5{linien_logic_limit_fast2_max_storage[13]}}, linien_logic_limit_fast2_max_storage};
	linien_logic_limit_fast2_limitcsr_y <= linien_logic_limit_fast2_limit_y;
	linien_logic_limit_fast2_limitcsr_error <= linien_logic_limit_fast2_limit_railed;
	if (linien_logic_reset_storage) begin
		linien_logic_int_reg <= 1'd0;
	end else begin
		if ((linien_logic_int_sum > $signed({1'd0, 42'd4398046248960}))) begin
			linien_logic_int_reg <= 42'd4398046248960;
		end else begin
			if ((linien_logic_int_sum < 43'sd4398046773247)) begin
				linien_logic_int_reg <= 43'sd4398046773247;
			end else begin
				linien_logic_int_reg <= linien_logic_int_sum;
			end
		end
	end
	linien_logic_kd_reg <= (linien_logic_kd_mult >>> 4'd8);
	linien_logic_kd_reg_r <= linien_logic_kd_reg;
	linien_logic_output_d <= (linien_logic_kd_reg - linien_logic_kd_reg_r);
	linien_logic_pid_sum <= ((linien_logic_output_p + linien_logic_int_out) + linien_logic_output_d);
	linien_analog_adca <= adc_data_a;
	linien_analog_adcb <= adc_data_b;
	linien_analog_daca <= {linien_analog_dac_a[13], (~linien_analog_dac_a[12:0])};
	linien_analog_dacb <= {linien_analog_dac_b[13], (~linien_analog_dac_b[12:0])};
	if (linien_xadc_drdy) begin
		case (linien_xadc_channel)
			1'd0: begin
				linien_xadc_temp_status <= (linien_xadc_data >>> 3'd4);
			end
			2'd3: begin
				linien_xadc_v_status <= (linien_xadc_data >>> 3'd4);
			end
			5'd16: begin
				linien_xadc_b_status <= (linien_xadc_data >>> 3'd4);
			end
			5'd17: begin
				linien_xadc_c_status <= (linien_xadc_data >>> 3'd4);
			end
			5'd24: begin
				linien_xadc_a_status <= (linien_xadc_data >>> 3'd4);
			end
			5'd25: begin
				linien_xadc_d_status <= (linien_xadc_data >>> 3'd4);
			end
		endcase
	end
	if (linien_state_clr_re) begin
		linien_state_status <= 1'd0;
	end else begin
		linien_state_status <= (linien_state_status | linien_state);
	end
	linien_gpio_n_o[0] <= ((linien_state & linien_csrstorage0_storage) != 1'd0);
	linien_gpio_n_o[1] <= ((linien_state & linien_csrstorage1_storage) != 1'd0);
	linien_gpio_n_o[2] <= ((linien_state & linien_csrstorage2_storage) != 1'd0);
	linien_gpio_n_o[3] <= ((linien_state & linien_csrstorage3_storage) != 1'd0);
	linien_gpio_n_o[4] <= ((linien_state & linien_csrstorage4_storage) != 1'd0);
	linien_gpio_n_o[5] <= ((linien_state & linien_csrstorage5_storage) != 1'd0);
	linien_gpio_n_o[6] <= ((linien_state & linien_csrstorage6_storage) != 1'd0);
	linien_gpio_n_o[7] <= ((linien_state & linien_csrstorage7_storage) != 1'd0);
	if ((linien_dna_cnt < 8'd128)) begin
		linien_dna_cnt <= (linien_dna_cnt + 1'd1);
		if (linien_dna_cnt[0]) begin
			linien_dna_status <= {linien_dna_status, linien_dna_do};
		end
	end
	linien_fast_a_ya <= (linien_fast_a_dy >>> 4'd11);
	if (($signed({1'd0, linien_csr0_x_clr_re}) | ($signed({1'd0, linien_max_status0}) < linien_fast_a_x0))) begin
		linien_max_status0 <= linien_fast_a_x0;
	end
	if (($signed({1'd0, linien_csr0_x_clr_re}) | ($signed({1'd0, linien_min_status0}) > linien_fast_a_x0))) begin
		linien_min_status0 <= linien_fast_a_x0;
	end
	if (($signed({1'd0, linien_csr1_out_i_clr_re}) | ($signed({1'd0, linien_max_status1}) < linien_fast_a_out_i))) begin
		linien_max_status1 <= linien_fast_a_out_i;
	end
	if (($signed({1'd0, linien_csr1_out_i_clr_re}) | ($signed({1'd0, linien_min_status1}) > linien_fast_a_out_i))) begin
		linien_min_status1 <= linien_fast_a_out_i;
	end
	if (($signed({1'd0, linien_csr2_out_q_clr_re}) | ($signed({1'd0, linien_max_status2}) < linien_fast_a_out_q))) begin
		linien_max_status2 <= linien_fast_a_out_q;
	end
	if (($signed({1'd0, linien_csr2_out_q_clr_re}) | ($signed({1'd0, linien_min_status2}) > linien_fast_a_out_q))) begin
		linien_min_status2 <= linien_fast_a_out_q;
	end
	linien_fast_a_dx <= sync_array_muxed0;
	linien_fast_a_dy <= sync_array_muxed1;
	linien_fast_a_x3 <= (linien_fast_a_x2 + (linien_fast_a_dir0 ? (linien_fast_a_y0 >>> 1'd0) : (-(linien_fast_a_y0 >>> 1'd0))));
	linien_fast_a_y1 <= (linien_fast_a_y0 + (linien_fast_a_dir0 ? (-(linien_fast_a_x2 >>> 1'd0)) : (linien_fast_a_x2 >>> 1'd0)));
	linien_fast_a_z1 <= (linien_fast_a_z0 + (linien_fast_a_dir0 ? $signed({1'd0, 15'd16384}) : 15'sd16384));
	linien_fast_a_x4 <= (linien_fast_a_x3 + (linien_fast_a_dir1 ? (linien_fast_a_y1 >>> 1'd1) : (-(linien_fast_a_y1 >>> 1'd1))));
	linien_fast_a_y2 <= (linien_fast_a_y1 + (linien_fast_a_dir1 ? (-(linien_fast_a_x3 >>> 1'd1)) : (linien_fast_a_x3 >>> 1'd1)));
	linien_fast_a_z2 <= (linien_fast_a_z1 + (linien_fast_a_dir1 ? $signed({1'd0, 14'd9672}) : 15'sd23096));
	linien_fast_a_x5 <= (linien_fast_a_x4 + (linien_fast_a_dir2 ? (linien_fast_a_y2 >>> 2'd2) : (-(linien_fast_a_y2 >>> 2'd2))));
	linien_fast_a_y3 <= (linien_fast_a_y2 + (linien_fast_a_dir2 ? (-(linien_fast_a_x4 >>> 2'd2)) : (linien_fast_a_x4 >>> 2'd2)));
	linien_fast_a_z3 <= (linien_fast_a_z2 + (linien_fast_a_dir2 ? $signed({1'd0, 13'd5110}) : 14'sd11274));
	linien_fast_a_x6 <= (linien_fast_a_x5 + (linien_fast_a_dir3 ? (linien_fast_a_y3 >>> 2'd3) : (-(linien_fast_a_y3 >>> 2'd3))));
	linien_fast_a_y4 <= (linien_fast_a_y3 + (linien_fast_a_dir3 ? (-(linien_fast_a_x5 >>> 2'd3)) : (linien_fast_a_x5 >>> 2'd3)));
	linien_fast_a_z4 <= (linien_fast_a_z3 + (linien_fast_a_dir3 ? $signed({1'd0, 12'd2594}) : 13'sd5598));
	linien_fast_a_x7 <= (linien_fast_a_x6 + (linien_fast_a_dir4 ? (linien_fast_a_y4 >>> 3'd4) : (-(linien_fast_a_y4 >>> 3'd4))));
	linien_fast_a_y5 <= (linien_fast_a_y4 + (linien_fast_a_dir4 ? (-(linien_fast_a_x6 >>> 3'd4)) : (linien_fast_a_x6 >>> 3'd4)));
	linien_fast_a_z5 <= (linien_fast_a_z4 + (linien_fast_a_dir4 ? $signed({1'd0, 11'd1302}) : 12'sd2794));
	linien_fast_a_x8 <= (linien_fast_a_x7 + (linien_fast_a_dir5 ? (linien_fast_a_y5 >>> 3'd5) : (-(linien_fast_a_y5 >>> 3'd5))));
	linien_fast_a_y6 <= (linien_fast_a_y5 + (linien_fast_a_dir5 ? (-(linien_fast_a_x7 >>> 3'd5)) : (linien_fast_a_x7 >>> 3'd5)));
	linien_fast_a_z6 <= (linien_fast_a_z5 + (linien_fast_a_dir5 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	linien_fast_a_x9 <= (linien_fast_a_x8 + (linien_fast_a_dir6 ? (linien_fast_a_y6 >>> 3'd6) : (-(linien_fast_a_y6 >>> 3'd6))));
	linien_fast_a_y7 <= (linien_fast_a_y6 + (linien_fast_a_dir6 ? (-(linien_fast_a_x8 >>> 3'd6)) : (linien_fast_a_x8 >>> 3'd6)));
	linien_fast_a_z7 <= (linien_fast_a_z6 + (linien_fast_a_dir6 ? $signed({1'd0, 9'd326}) : 10'sd698));
	linien_fast_a_x10 <= (linien_fast_a_x9 + (linien_fast_a_dir7 ? (linien_fast_a_y7 >>> 3'd7) : (-(linien_fast_a_y7 >>> 3'd7))));
	linien_fast_a_y8 <= (linien_fast_a_y7 + (linien_fast_a_dir7 ? (-(linien_fast_a_x9 >>> 3'd7)) : (linien_fast_a_x9 >>> 3'd7)));
	linien_fast_a_z8 <= (linien_fast_a_z7 + (linien_fast_a_dir7 ? $signed({1'd0, 8'd163}) : 9'sd349));
	linien_fast_a_x11 <= (linien_fast_a_x10 + (linien_fast_a_dir8 ? (linien_fast_a_y8 >>> 4'd8) : (-(linien_fast_a_y8 >>> 4'd8))));
	linien_fast_a_y9 <= (linien_fast_a_y8 + (linien_fast_a_dir8 ? (-(linien_fast_a_x10 >>> 4'd8)) : (linien_fast_a_x10 >>> 4'd8)));
	linien_fast_a_z9 <= (linien_fast_a_z8 + (linien_fast_a_dir8 ? $signed({1'd0, 7'd81}) : 8'sd175));
	linien_fast_a_x12 <= (linien_fast_a_x11 + (linien_fast_a_dir9 ? (linien_fast_a_y9 >>> 4'd9) : (-(linien_fast_a_y9 >>> 4'd9))));
	linien_fast_a_y10 <= (linien_fast_a_y9 + (linien_fast_a_dir9 ? (-(linien_fast_a_x11 >>> 4'd9)) : (linien_fast_a_x11 >>> 4'd9)));
	linien_fast_a_z10 <= (linien_fast_a_z9 + (linien_fast_a_dir9 ? $signed({1'd0, 6'd41}) : 7'sd87));
	linien_fast_a_x13 <= (linien_fast_a_x12 + (linien_fast_a_dir10 ? (linien_fast_a_y10 >>> 4'd10) : (-(linien_fast_a_y10 >>> 4'd10))));
	linien_fast_a_y11 <= (linien_fast_a_y10 + (linien_fast_a_dir10 ? (-(linien_fast_a_x12 >>> 4'd10)) : (linien_fast_a_x12 >>> 4'd10)));
	linien_fast_a_z11 <= (linien_fast_a_z10 + (linien_fast_a_dir10 ? $signed({1'd0, 5'd20}) : 6'sd44));
	linien_fast_a_x14 <= (linien_fast_a_x13 + (linien_fast_a_dir11 ? (linien_fast_a_y11 >>> 4'd11) : (-(linien_fast_a_y11 >>> 4'd11))));
	linien_fast_a_y12 <= (linien_fast_a_y11 + (linien_fast_a_dir11 ? (-(linien_fast_a_x13 >>> 4'd11)) : (linien_fast_a_x13 >>> 4'd11)));
	linien_fast_a_z12 <= (linien_fast_a_z11 + (linien_fast_a_dir11 ? $signed({1'd0, 4'd10}) : 5'sd22));
	linien_fast_a_x15 <= (linien_fast_a_x14 + (linien_fast_a_dir12 ? (linien_fast_a_y12 >>> 4'd12) : (-(linien_fast_a_y12 >>> 4'd12))));
	linien_fast_a_y13 <= (linien_fast_a_y12 + (linien_fast_a_dir12 ? (-(linien_fast_a_x14 >>> 4'd12)) : (linien_fast_a_x14 >>> 4'd12)));
	linien_fast_a_z13 <= (linien_fast_a_z12 + (linien_fast_a_dir12 ? $signed({1'd0, 3'd5}) : 4'sd11));
	linien_fast_a_x16 <= (linien_fast_a_x15 + (linien_fast_a_dir13 ? (linien_fast_a_y13 >>> 4'd13) : (-(linien_fast_a_y13 >>> 4'd13))));
	linien_fast_a_y14 <= (linien_fast_a_y13 + (linien_fast_a_dir13 ? (-(linien_fast_a_x15 >>> 4'd13)) : (linien_fast_a_x15 >>> 4'd13)));
	linien_fast_a_z14 <= (linien_fast_a_z13 + (linien_fast_a_dir13 ? $signed({1'd0, 2'd3}) : 3'sd5));
	linien_fast_a_x17 <= (linien_fast_a_x16 + (linien_fast_a_dir14 ? (linien_fast_a_y14 >>> 4'd14) : (-(linien_fast_a_y14 >>> 4'd14))));
	linien_fast_a_y15 <= (linien_fast_a_y14 + (linien_fast_a_dir14 ? (-(linien_fast_a_x16 >>> 4'd14)) : (linien_fast_a_x16 >>> 4'd14)));
	linien_fast_a_z15 <= (linien_fast_a_z14 + (linien_fast_a_dir14 ? $signed({1'd0, 1'd1}) : 1'sd1));
	linien_fast_a_limitcsr0_limit_min0 <= {{1{linien_fast_a_limitcsr0_min_storage0[24]}}, linien_fast_a_limitcsr0_min_storage0};
	linien_fast_a_limitcsr0_limit_max0 <= {{1{linien_fast_a_limitcsr0_max_storage0[24]}}, linien_fast_a_limitcsr0_max_storage0};
	linien_fast_a_limitcsr0_limitcsr0_y0 <= linien_fast_a_limitcsr0_limit_y0;
	linien_fast_a_limitcsr0_limitcsr0_error0 <= linien_fast_a_limitcsr0_limit_railed0;
	linien_fast_a_iir0_a10 <= linien_fast_a_iir0_csrstorage0_storage0;
	linien_fast_a_iir0_b00 <= linien_fast_a_iir0_csrstorage1_storage0;
	linien_fast_a_iir0_b10 <= linien_fast_a_iir0_csrstorage2_storage0;
	linien_fast_a_iir0_z0r0 <= (linien_fast_a_iir0_storage0 <<< 5'd23);
	linien_fast_a_iir0_error0 <= linien_fast_a_iir0_railed0;
	linien_fast_a_iir0_y0 <= linien_fast_a_iir0_y_lim0;
	if (linien_fast_a_iir0_clear0) begin
		linien_fast_a_iir0_y1 <= 1'd0;
	end else begin
		if ((~linien_fast_a_iir0_hold0)) begin
			linien_fast_a_iir0_y1 <= linien_fast_a_iir0_y_lim0;
		end
	end
	linien_fast_a_iir0_zr0 <= linien_fast_a_iir0_z0r0;
	linien_fast_a_iir0_zr1 <= linien_fast_a_iir0_z0;
	linien_fast_a_iir0_zr2 <= linien_fast_a_iir0_z1;
	linien_fast_a_iir0_a11 <= linien_fast_a_iir0_csrstorage0_storage1;
	linien_fast_a_iir0_a2 <= linien_fast_a_iir0_csrstorage1_storage1;
	linien_fast_a_iir0_b01 <= linien_fast_a_iir0_csrstorage2_storage1;
	linien_fast_a_iir0_b11 <= linien_fast_a_iir0_csrstorage3_storage;
	linien_fast_a_iir0_b2 <= linien_fast_a_iir0_csrstorage4_storage;
	linien_fast_a_iir0_z0r1 <= (linien_fast_a_iir0_storage1 <<< 5'd23);
	linien_fast_a_iir0_error1 <= linien_fast_a_iir0_railed1;
	linien_fast_a_iir0_y2 <= linien_fast_a_iir0_y_lim1;
	if (linien_fast_a_iir0_clear1) begin
		linien_fast_a_iir0_y3 <= 1'd0;
	end else begin
		if ((~linien_fast_a_iir0_hold1)) begin
			linien_fast_a_iir0_y3 <= linien_fast_a_iir0_y_lim1;
		end
	end
	linien_fast_a_iir0_zr3 <= linien_fast_a_iir0_z0r1;
	linien_fast_a_iir0_zr4 <= linien_fast_a_iir0_z3;
	linien_fast_a_iir0_zr5 <= linien_fast_a_iir0_z4;
	linien_fast_a_iir0_zr6 <= linien_fast_a_iir0_z5;
	linien_fast_a_iir0_zr7 <= linien_fast_a_iir0_z6;
	linien_fast_a_limitcsr0_limit_min1 <= {{3{linien_fast_a_limitcsr0_min_storage1[24]}}, linien_fast_a_limitcsr0_min_storage1};
	linien_fast_a_limitcsr0_limit_max1 <= {{3{linien_fast_a_limitcsr0_max_storage1[24]}}, linien_fast_a_limitcsr0_max_storage1};
	linien_fast_a_limitcsr0_limitcsr0_y1 <= linien_fast_a_limitcsr0_limit_y1;
	linien_fast_a_limitcsr0_limitcsr0_error1 <= linien_fast_a_limitcsr0_limit_railed1;
	linien_fast_a_limitcsr1_limit_min0 <= {{1{linien_fast_a_limitcsr1_min_storage0[24]}}, linien_fast_a_limitcsr1_min_storage0};
	linien_fast_a_limitcsr1_limit_max0 <= {{1{linien_fast_a_limitcsr1_max_storage0[24]}}, linien_fast_a_limitcsr1_max_storage0};
	linien_fast_a_limitcsr1_limitcsr1_y0 <= linien_fast_a_limitcsr1_limit_y0;
	linien_fast_a_limitcsr1_limitcsr1_error0 <= linien_fast_a_limitcsr1_limit_railed0;
	linien_fast_a_iir1_a10 <= linien_fast_a_iir1_csrstorage3_storage;
	linien_fast_a_iir1_b00 <= linien_fast_a_iir1_csrstorage4_storage;
	linien_fast_a_iir1_b10 <= linien_fast_a_iir1_csrstorage5_storage0;
	linien_fast_a_iir1_z0r0 <= (linien_fast_a_iir1_storage0 <<< 5'd23);
	linien_fast_a_iir1_error0 <= linien_fast_a_iir1_railed0;
	linien_fast_a_iir1_y0 <= linien_fast_a_iir1_y_lim0;
	if (linien_fast_a_iir1_clear0) begin
		linien_fast_a_iir1_y1 <= 1'd0;
	end else begin
		if ((~linien_fast_a_iir1_hold0)) begin
			linien_fast_a_iir1_y1 <= linien_fast_a_iir1_y_lim0;
		end
	end
	linien_fast_a_iir1_zr0 <= linien_fast_a_iir1_z0r0;
	linien_fast_a_iir1_zr1 <= linien_fast_a_iir1_z0;
	linien_fast_a_iir1_zr2 <= linien_fast_a_iir1_z1;
	linien_fast_a_iir1_a11 <= linien_fast_a_iir1_csrstorage5_storage1;
	linien_fast_a_iir1_a2 <= linien_fast_a_iir1_csrstorage6_storage;
	linien_fast_a_iir1_b01 <= linien_fast_a_iir1_csrstorage7_storage;
	linien_fast_a_iir1_b11 <= linien_fast_a_iir1_csrstorage8_storage;
	linien_fast_a_iir1_b2 <= linien_fast_a_iir1_csrstorage9_storage;
	linien_fast_a_iir1_z0r1 <= (linien_fast_a_iir1_storage1 <<< 5'd23);
	linien_fast_a_iir1_error1 <= linien_fast_a_iir1_railed1;
	linien_fast_a_iir1_y2 <= linien_fast_a_iir1_y_lim1;
	if (linien_fast_a_iir1_clear1) begin
		linien_fast_a_iir1_y3 <= 1'd0;
	end else begin
		if ((~linien_fast_a_iir1_hold1)) begin
			linien_fast_a_iir1_y3 <= linien_fast_a_iir1_y_lim1;
		end
	end
	linien_fast_a_iir1_zr3 <= linien_fast_a_iir1_z0r1;
	linien_fast_a_iir1_zr4 <= linien_fast_a_iir1_z3;
	linien_fast_a_iir1_zr5 <= linien_fast_a_iir1_z4;
	linien_fast_a_iir1_zr6 <= linien_fast_a_iir1_z5;
	linien_fast_a_iir1_zr7 <= linien_fast_a_iir1_z6;
	linien_fast_a_limitcsr1_limit_min1 <= {{3{linien_fast_a_limitcsr1_min_storage1[24]}}, linien_fast_a_limitcsr1_min_storage1};
	linien_fast_a_limitcsr1_limit_max1 <= {{3{linien_fast_a_limitcsr1_max_storage1[24]}}, linien_fast_a_limitcsr1_max_storage1};
	linien_fast_a_limitcsr1_limitcsr1_y1 <= linien_fast_a_limitcsr1_limit_y1;
	linien_fast_a_limitcsr1_limitcsr1_error1 <= linien_fast_a_limitcsr1_limit_railed1;
	linien_fast_b_ya <= (linien_fast_b_dy >>> 4'd11);
	if (($signed({1'd0, linien_csr3_x_clr_re}) | ($signed({1'd0, linien_max_status3}) < linien_fast_b_x0))) begin
		linien_max_status3 <= linien_fast_b_x0;
	end
	if (($signed({1'd0, linien_csr3_x_clr_re}) | ($signed({1'd0, linien_min_status3}) > linien_fast_b_x0))) begin
		linien_min_status3 <= linien_fast_b_x0;
	end
	if (($signed({1'd0, linien_csr4_out_i_clr_re}) | ($signed({1'd0, linien_max_status4}) < linien_fast_b_out_i))) begin
		linien_max_status4 <= linien_fast_b_out_i;
	end
	if (($signed({1'd0, linien_csr4_out_i_clr_re}) | ($signed({1'd0, linien_min_status4}) > linien_fast_b_out_i))) begin
		linien_min_status4 <= linien_fast_b_out_i;
	end
	if (($signed({1'd0, linien_csr5_out_q_clr_re}) | ($signed({1'd0, linien_max_status5}) < linien_fast_b_out_q))) begin
		linien_max_status5 <= linien_fast_b_out_q;
	end
	if (($signed({1'd0, linien_csr5_out_q_clr_re}) | ($signed({1'd0, linien_min_status5}) > linien_fast_b_out_q))) begin
		linien_min_status5 <= linien_fast_b_out_q;
	end
	linien_fast_b_dx <= sync_array_muxed2;
	linien_fast_b_dy <= sync_array_muxed3;
	linien_fast_b_x3 <= (linien_fast_b_x2 + (linien_fast_b_dir0 ? (linien_fast_b_y0 >>> 1'd0) : (-(linien_fast_b_y0 >>> 1'd0))));
	linien_fast_b_y1 <= (linien_fast_b_y0 + (linien_fast_b_dir0 ? (-(linien_fast_b_x2 >>> 1'd0)) : (linien_fast_b_x2 >>> 1'd0)));
	linien_fast_b_z1 <= (linien_fast_b_z0 + (linien_fast_b_dir0 ? $signed({1'd0, 15'd16384}) : 15'sd16384));
	linien_fast_b_x4 <= (linien_fast_b_x3 + (linien_fast_b_dir1 ? (linien_fast_b_y1 >>> 1'd1) : (-(linien_fast_b_y1 >>> 1'd1))));
	linien_fast_b_y2 <= (linien_fast_b_y1 + (linien_fast_b_dir1 ? (-(linien_fast_b_x3 >>> 1'd1)) : (linien_fast_b_x3 >>> 1'd1)));
	linien_fast_b_z2 <= (linien_fast_b_z1 + (linien_fast_b_dir1 ? $signed({1'd0, 14'd9672}) : 15'sd23096));
	linien_fast_b_x5 <= (linien_fast_b_x4 + (linien_fast_b_dir2 ? (linien_fast_b_y2 >>> 2'd2) : (-(linien_fast_b_y2 >>> 2'd2))));
	linien_fast_b_y3 <= (linien_fast_b_y2 + (linien_fast_b_dir2 ? (-(linien_fast_b_x4 >>> 2'd2)) : (linien_fast_b_x4 >>> 2'd2)));
	linien_fast_b_z3 <= (linien_fast_b_z2 + (linien_fast_b_dir2 ? $signed({1'd0, 13'd5110}) : 14'sd11274));
	linien_fast_b_x6 <= (linien_fast_b_x5 + (linien_fast_b_dir3 ? (linien_fast_b_y3 >>> 2'd3) : (-(linien_fast_b_y3 >>> 2'd3))));
	linien_fast_b_y4 <= (linien_fast_b_y3 + (linien_fast_b_dir3 ? (-(linien_fast_b_x5 >>> 2'd3)) : (linien_fast_b_x5 >>> 2'd3)));
	linien_fast_b_z4 <= (linien_fast_b_z3 + (linien_fast_b_dir3 ? $signed({1'd0, 12'd2594}) : 13'sd5598));
	linien_fast_b_x7 <= (linien_fast_b_x6 + (linien_fast_b_dir4 ? (linien_fast_b_y4 >>> 3'd4) : (-(linien_fast_b_y4 >>> 3'd4))));
	linien_fast_b_y5 <= (linien_fast_b_y4 + (linien_fast_b_dir4 ? (-(linien_fast_b_x6 >>> 3'd4)) : (linien_fast_b_x6 >>> 3'd4)));
	linien_fast_b_z5 <= (linien_fast_b_z4 + (linien_fast_b_dir4 ? $signed({1'd0, 11'd1302}) : 12'sd2794));
	linien_fast_b_x8 <= (linien_fast_b_x7 + (linien_fast_b_dir5 ? (linien_fast_b_y5 >>> 3'd5) : (-(linien_fast_b_y5 >>> 3'd5))));
	linien_fast_b_y6 <= (linien_fast_b_y5 + (linien_fast_b_dir5 ? (-(linien_fast_b_x7 >>> 3'd5)) : (linien_fast_b_x7 >>> 3'd5)));
	linien_fast_b_z6 <= (linien_fast_b_z5 + (linien_fast_b_dir5 ? $signed({1'd0, 10'd652}) : 11'sd1396));
	linien_fast_b_x9 <= (linien_fast_b_x8 + (linien_fast_b_dir6 ? (linien_fast_b_y6 >>> 3'd6) : (-(linien_fast_b_y6 >>> 3'd6))));
	linien_fast_b_y7 <= (linien_fast_b_y6 + (linien_fast_b_dir6 ? (-(linien_fast_b_x8 >>> 3'd6)) : (linien_fast_b_x8 >>> 3'd6)));
	linien_fast_b_z7 <= (linien_fast_b_z6 + (linien_fast_b_dir6 ? $signed({1'd0, 9'd326}) : 10'sd698));
	linien_fast_b_x10 <= (linien_fast_b_x9 + (linien_fast_b_dir7 ? (linien_fast_b_y7 >>> 3'd7) : (-(linien_fast_b_y7 >>> 3'd7))));
	linien_fast_b_y8 <= (linien_fast_b_y7 + (linien_fast_b_dir7 ? (-(linien_fast_b_x9 >>> 3'd7)) : (linien_fast_b_x9 >>> 3'd7)));
	linien_fast_b_z8 <= (linien_fast_b_z7 + (linien_fast_b_dir7 ? $signed({1'd0, 8'd163}) : 9'sd349));
	linien_fast_b_x11 <= (linien_fast_b_x10 + (linien_fast_b_dir8 ? (linien_fast_b_y8 >>> 4'd8) : (-(linien_fast_b_y8 >>> 4'd8))));
	linien_fast_b_y9 <= (linien_fast_b_y8 + (linien_fast_b_dir8 ? (-(linien_fast_b_x10 >>> 4'd8)) : (linien_fast_b_x10 >>> 4'd8)));
	linien_fast_b_z9 <= (linien_fast_b_z8 + (linien_fast_b_dir8 ? $signed({1'd0, 7'd81}) : 8'sd175));
	linien_fast_b_x12 <= (linien_fast_b_x11 + (linien_fast_b_dir9 ? (linien_fast_b_y9 >>> 4'd9) : (-(linien_fast_b_y9 >>> 4'd9))));
	linien_fast_b_y10 <= (linien_fast_b_y9 + (linien_fast_b_dir9 ? (-(linien_fast_b_x11 >>> 4'd9)) : (linien_fast_b_x11 >>> 4'd9)));
	linien_fast_b_z10 <= (linien_fast_b_z9 + (linien_fast_b_dir9 ? $signed({1'd0, 6'd41}) : 7'sd87));
	linien_fast_b_x13 <= (linien_fast_b_x12 + (linien_fast_b_dir10 ? (linien_fast_b_y10 >>> 4'd10) : (-(linien_fast_b_y10 >>> 4'd10))));
	linien_fast_b_y11 <= (linien_fast_b_y10 + (linien_fast_b_dir10 ? (-(linien_fast_b_x12 >>> 4'd10)) : (linien_fast_b_x12 >>> 4'd10)));
	linien_fast_b_z11 <= (linien_fast_b_z10 + (linien_fast_b_dir10 ? $signed({1'd0, 5'd20}) : 6'sd44));
	linien_fast_b_x14 <= (linien_fast_b_x13 + (linien_fast_b_dir11 ? (linien_fast_b_y11 >>> 4'd11) : (-(linien_fast_b_y11 >>> 4'd11))));
	linien_fast_b_y12 <= (linien_fast_b_y11 + (linien_fast_b_dir11 ? (-(linien_fast_b_x13 >>> 4'd11)) : (linien_fast_b_x13 >>> 4'd11)));
	linien_fast_b_z12 <= (linien_fast_b_z11 + (linien_fast_b_dir11 ? $signed({1'd0, 4'd10}) : 5'sd22));
	linien_fast_b_x15 <= (linien_fast_b_x14 + (linien_fast_b_dir12 ? (linien_fast_b_y12 >>> 4'd12) : (-(linien_fast_b_y12 >>> 4'd12))));
	linien_fast_b_y13 <= (linien_fast_b_y12 + (linien_fast_b_dir12 ? (-(linien_fast_b_x14 >>> 4'd12)) : (linien_fast_b_x14 >>> 4'd12)));
	linien_fast_b_z13 <= (linien_fast_b_z12 + (linien_fast_b_dir12 ? $signed({1'd0, 3'd5}) : 4'sd11));
	linien_fast_b_x16 <= (linien_fast_b_x15 + (linien_fast_b_dir13 ? (linien_fast_b_y13 >>> 4'd13) : (-(linien_fast_b_y13 >>> 4'd13))));
	linien_fast_b_y14 <= (linien_fast_b_y13 + (linien_fast_b_dir13 ? (-(linien_fast_b_x15 >>> 4'd13)) : (linien_fast_b_x15 >>> 4'd13)));
	linien_fast_b_z14 <= (linien_fast_b_z13 + (linien_fast_b_dir13 ? $signed({1'd0, 2'd3}) : 3'sd5));
	linien_fast_b_x17 <= (linien_fast_b_x16 + (linien_fast_b_dir14 ? (linien_fast_b_y14 >>> 4'd14) : (-(linien_fast_b_y14 >>> 4'd14))));
	linien_fast_b_y15 <= (linien_fast_b_y14 + (linien_fast_b_dir14 ? (-(linien_fast_b_x16 >>> 4'd14)) : (linien_fast_b_x16 >>> 4'd14)));
	linien_fast_b_z15 <= (linien_fast_b_z14 + (linien_fast_b_dir14 ? $signed({1'd0, 1'd1}) : 1'sd1));
	linien_fast_b_limitcsr0_limit_min0 <= {{1{linien_fast_b_limitcsr0_min_storage0[24]}}, linien_fast_b_limitcsr0_min_storage0};
	linien_fast_b_limitcsr0_limit_max0 <= {{1{linien_fast_b_limitcsr0_max_storage0[24]}}, linien_fast_b_limitcsr0_max_storage0};
	linien_fast_b_limitcsr0_limitcsr0_y0 <= linien_fast_b_limitcsr0_limit_y0;
	linien_fast_b_limitcsr0_limitcsr0_error0 <= linien_fast_b_limitcsr0_limit_railed0;
	linien_fast_b_iir0_a10 <= linien_fast_b_iir0_csrstorage0_storage0;
	linien_fast_b_iir0_b00 <= linien_fast_b_iir0_csrstorage1_storage0;
	linien_fast_b_iir0_b10 <= linien_fast_b_iir0_csrstorage2_storage0;
	linien_fast_b_iir0_z0r0 <= (linien_fast_b_iir0_storage0 <<< 5'd23);
	linien_fast_b_iir0_error0 <= linien_fast_b_iir0_railed0;
	linien_fast_b_iir0_y0 <= linien_fast_b_iir0_y_lim0;
	if (linien_fast_b_iir0_clear0) begin
		linien_fast_b_iir0_y1 <= 1'd0;
	end else begin
		if ((~linien_fast_b_iir0_hold0)) begin
			linien_fast_b_iir0_y1 <= linien_fast_b_iir0_y_lim0;
		end
	end
	linien_fast_b_iir0_zr0 <= linien_fast_b_iir0_z0r0;
	linien_fast_b_iir0_zr1 <= linien_fast_b_iir0_z0;
	linien_fast_b_iir0_zr2 <= linien_fast_b_iir0_z1;
	linien_fast_b_iir0_a11 <= linien_fast_b_iir0_csrstorage0_storage1;
	linien_fast_b_iir0_a2 <= linien_fast_b_iir0_csrstorage1_storage1;
	linien_fast_b_iir0_b01 <= linien_fast_b_iir0_csrstorage2_storage1;
	linien_fast_b_iir0_b11 <= linien_fast_b_iir0_csrstorage3_storage;
	linien_fast_b_iir0_b2 <= linien_fast_b_iir0_csrstorage4_storage;
	linien_fast_b_iir0_z0r1 <= (linien_fast_b_iir0_storage1 <<< 5'd23);
	linien_fast_b_iir0_error1 <= linien_fast_b_iir0_railed1;
	linien_fast_b_iir0_y2 <= linien_fast_b_iir0_y_lim1;
	if (linien_fast_b_iir0_clear1) begin
		linien_fast_b_iir0_y3 <= 1'd0;
	end else begin
		if ((~linien_fast_b_iir0_hold1)) begin
			linien_fast_b_iir0_y3 <= linien_fast_b_iir0_y_lim1;
		end
	end
	linien_fast_b_iir0_zr3 <= linien_fast_b_iir0_z0r1;
	linien_fast_b_iir0_zr4 <= linien_fast_b_iir0_z3;
	linien_fast_b_iir0_zr5 <= linien_fast_b_iir0_z4;
	linien_fast_b_iir0_zr6 <= linien_fast_b_iir0_z5;
	linien_fast_b_iir0_zr7 <= linien_fast_b_iir0_z6;
	linien_fast_b_limitcsr0_limit_min1 <= {{3{linien_fast_b_limitcsr0_min_storage1[24]}}, linien_fast_b_limitcsr0_min_storage1};
	linien_fast_b_limitcsr0_limit_max1 <= {{3{linien_fast_b_limitcsr0_max_storage1[24]}}, linien_fast_b_limitcsr0_max_storage1};
	linien_fast_b_limitcsr0_limitcsr0_y1 <= linien_fast_b_limitcsr0_limit_y1;
	linien_fast_b_limitcsr0_limitcsr0_error1 <= linien_fast_b_limitcsr0_limit_railed1;
	linien_fast_b_limitcsr1_limit_min0 <= {{1{linien_fast_b_limitcsr1_min_storage0[24]}}, linien_fast_b_limitcsr1_min_storage0};
	linien_fast_b_limitcsr1_limit_max0 <= {{1{linien_fast_b_limitcsr1_max_storage0[24]}}, linien_fast_b_limitcsr1_max_storage0};
	linien_fast_b_limitcsr1_limitcsr1_y0 <= linien_fast_b_limitcsr1_limit_y0;
	linien_fast_b_limitcsr1_limitcsr1_error0 <= linien_fast_b_limitcsr1_limit_railed0;
	linien_fast_b_iir1_a10 <= linien_fast_b_iir1_csrstorage3_storage;
	linien_fast_b_iir1_b00 <= linien_fast_b_iir1_csrstorage4_storage;
	linien_fast_b_iir1_b10 <= linien_fast_b_iir1_csrstorage5_storage0;
	linien_fast_b_iir1_z0r0 <= (linien_fast_b_iir1_storage0 <<< 5'd23);
	linien_fast_b_iir1_error0 <= linien_fast_b_iir1_railed0;
	linien_fast_b_iir1_y0 <= linien_fast_b_iir1_y_lim0;
	if (linien_fast_b_iir1_clear0) begin
		linien_fast_b_iir1_y1 <= 1'd0;
	end else begin
		if ((~linien_fast_b_iir1_hold0)) begin
			linien_fast_b_iir1_y1 <= linien_fast_b_iir1_y_lim0;
		end
	end
	linien_fast_b_iir1_zr0 <= linien_fast_b_iir1_z0r0;
	linien_fast_b_iir1_zr1 <= linien_fast_b_iir1_z0;
	linien_fast_b_iir1_zr2 <= linien_fast_b_iir1_z1;
	linien_fast_b_iir1_a11 <= linien_fast_b_iir1_csrstorage5_storage1;
	linien_fast_b_iir1_a2 <= linien_fast_b_iir1_csrstorage6_storage;
	linien_fast_b_iir1_b01 <= linien_fast_b_iir1_csrstorage7_storage;
	linien_fast_b_iir1_b11 <= linien_fast_b_iir1_csrstorage8_storage;
	linien_fast_b_iir1_b2 <= linien_fast_b_iir1_csrstorage9_storage;
	linien_fast_b_iir1_z0r1 <= (linien_fast_b_iir1_storage1 <<< 5'd23);
	linien_fast_b_iir1_error1 <= linien_fast_b_iir1_railed1;
	linien_fast_b_iir1_y2 <= linien_fast_b_iir1_y_lim1;
	if (linien_fast_b_iir1_clear1) begin
		linien_fast_b_iir1_y3 <= 1'd0;
	end else begin
		if ((~linien_fast_b_iir1_hold1)) begin
			linien_fast_b_iir1_y3 <= linien_fast_b_iir1_y_lim1;
		end
	end
	linien_fast_b_iir1_zr3 <= linien_fast_b_iir1_z0r1;
	linien_fast_b_iir1_zr4 <= linien_fast_b_iir1_z3;
	linien_fast_b_iir1_zr5 <= linien_fast_b_iir1_z4;
	linien_fast_b_iir1_zr6 <= linien_fast_b_iir1_z5;
	linien_fast_b_iir1_zr7 <= linien_fast_b_iir1_z6;
	linien_fast_b_limitcsr1_limit_min1 <= {{3{linien_fast_b_limitcsr1_min_storage1[24]}}, linien_fast_b_limitcsr1_min_storage1};
	linien_fast_b_limitcsr1_limit_max1 <= {{3{linien_fast_b_limitcsr1_max_storage1[24]}}, linien_fast_b_limitcsr1_max_storage1};
	linien_fast_b_limitcsr1_limitcsr1_y1 <= linien_fast_b_limitcsr1_limit_y1;
	linien_fast_b_limitcsr1_limitcsr1_error1 <= linien_fast_b_limitcsr1_limit_railed1;
	linien_safe_to_divide_reg <= linien_safe_to_divide;
	if (linien_divider_done) begin
		linien_out_e <= linien_divider_quotient;
	end else begin
		if (((~linien_divider_busy) & (~linien_start_pulse))) begin
			linien_out_e <= 1'd0;
		end
	end
	linien_denominator_reg <= linien_denominator;
	if (($signed({1'd0, linien_out_e_clr_re}) | ($signed({1'd0, linien_max_status6}) < linien_out_e))) begin
		linien_max_status6 <= linien_out_e;
	end
	if (($signed({1'd0, linien_out_e_clr_re}) | ($signed({1'd0, linien_min_status6}) > linien_out_e))) begin
		linien_min_status6 <= linien_out_e;
	end
	if (($signed({1'd0, linien_power_signal_out_clr_re}) | ($signed({1'd0, linien_max_status7}) < linien_power_signal_out))) begin
		linien_max_status7 <= linien_power_signal_out;
	end
	if (($signed({1'd0, linien_power_signal_out_clr_re}) | ($signed({1'd0, linien_min_status7}) > linien_power_signal_out))) begin
		linien_min_status7 <= linien_power_signal_out;
	end
	if (linien_divider_start) begin
		linien_divider_r0 <= 1'd0;
		linien_divider_q0 <= linien_divider_n_abs_scaled;
		linien_divider_d0 <= linien_divider_d_abs;
		linien_divider_quo0 <= 1'd0;
		linien_divider_v0 <= 1'd1;
	end else begin
		linien_divider_v0 <= 1'd0;
	end
	linien_divider_v1 <= linien_divider_v0;
	linien_divider_q1 <= ((linien_divider_q0 <<< 1'd1) & 35'd34359738367);
	linien_divider_d1 <= linien_divider_d0;
	if (linien_divider_v0) begin
		if (linien_divider_sub_success0) begin
			linien_divider_r1 <= linien_divider_r_sub0;
			linien_divider_quo1 <= ((linien_divider_quo0 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r1 <= {linien_divider_r0[24:0], linien_divider_q0[34]};
			linien_divider_quo1 <= (linien_divider_quo0 <<< 1'd1);
		end
	end
	linien_divider_v2 <= linien_divider_v1;
	linien_divider_q2 <= ((linien_divider_q1 <<< 1'd1) & 35'd34359738367);
	linien_divider_d2 <= linien_divider_d1;
	if (linien_divider_v1) begin
		if (linien_divider_sub_success1) begin
			linien_divider_r2 <= linien_divider_r_sub1;
			linien_divider_quo2 <= ((linien_divider_quo1 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r2 <= {linien_divider_r1[24:0], linien_divider_q1[34]};
			linien_divider_quo2 <= (linien_divider_quo1 <<< 1'd1);
		end
	end
	linien_divider_v3 <= linien_divider_v2;
	linien_divider_q3 <= ((linien_divider_q2 <<< 1'd1) & 35'd34359738367);
	linien_divider_d3 <= linien_divider_d2;
	if (linien_divider_v2) begin
		if (linien_divider_sub_success2) begin
			linien_divider_r3 <= linien_divider_r_sub2;
			linien_divider_quo3 <= ((linien_divider_quo2 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r3 <= {linien_divider_r2[24:0], linien_divider_q2[34]};
			linien_divider_quo3 <= (linien_divider_quo2 <<< 1'd1);
		end
	end
	linien_divider_v4 <= linien_divider_v3;
	linien_divider_q4 <= ((linien_divider_q3 <<< 1'd1) & 35'd34359738367);
	linien_divider_d4 <= linien_divider_d3;
	if (linien_divider_v3) begin
		if (linien_divider_sub_success3) begin
			linien_divider_r4 <= linien_divider_r_sub3;
			linien_divider_quo4 <= ((linien_divider_quo3 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r4 <= {linien_divider_r3[24:0], linien_divider_q3[34]};
			linien_divider_quo4 <= (linien_divider_quo3 <<< 1'd1);
		end
	end
	linien_divider_v5 <= linien_divider_v4;
	linien_divider_q5 <= ((linien_divider_q4 <<< 1'd1) & 35'd34359738367);
	linien_divider_d5 <= linien_divider_d4;
	if (linien_divider_v4) begin
		if (linien_divider_sub_success4) begin
			linien_divider_r5 <= linien_divider_r_sub4;
			linien_divider_quo5 <= ((linien_divider_quo4 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r5 <= {linien_divider_r4[24:0], linien_divider_q4[34]};
			linien_divider_quo5 <= (linien_divider_quo4 <<< 1'd1);
		end
	end
	linien_divider_v6 <= linien_divider_v5;
	linien_divider_q6 <= ((linien_divider_q5 <<< 1'd1) & 35'd34359738367);
	linien_divider_d6 <= linien_divider_d5;
	if (linien_divider_v5) begin
		if (linien_divider_sub_success5) begin
			linien_divider_r6 <= linien_divider_r_sub5;
			linien_divider_quo6 <= ((linien_divider_quo5 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r6 <= {linien_divider_r5[24:0], linien_divider_q5[34]};
			linien_divider_quo6 <= (linien_divider_quo5 <<< 1'd1);
		end
	end
	linien_divider_v7 <= linien_divider_v6;
	linien_divider_q7 <= ((linien_divider_q6 <<< 1'd1) & 35'd34359738367);
	linien_divider_d7 <= linien_divider_d6;
	if (linien_divider_v6) begin
		if (linien_divider_sub_success6) begin
			linien_divider_r7 <= linien_divider_r_sub6;
			linien_divider_quo7 <= ((linien_divider_quo6 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r7 <= {linien_divider_r6[24:0], linien_divider_q6[34]};
			linien_divider_quo7 <= (linien_divider_quo6 <<< 1'd1);
		end
	end
	linien_divider_v8 <= linien_divider_v7;
	linien_divider_q8 <= ((linien_divider_q7 <<< 1'd1) & 35'd34359738367);
	linien_divider_d8 <= linien_divider_d7;
	if (linien_divider_v7) begin
		if (linien_divider_sub_success7) begin
			linien_divider_r8 <= linien_divider_r_sub7;
			linien_divider_quo8 <= ((linien_divider_quo7 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r8 <= {linien_divider_r7[24:0], linien_divider_q7[34]};
			linien_divider_quo8 <= (linien_divider_quo7 <<< 1'd1);
		end
	end
	linien_divider_v9 <= linien_divider_v8;
	linien_divider_q9 <= ((linien_divider_q8 <<< 1'd1) & 35'd34359738367);
	linien_divider_d9 <= linien_divider_d8;
	if (linien_divider_v8) begin
		if (linien_divider_sub_success8) begin
			linien_divider_r9 <= linien_divider_r_sub8;
			linien_divider_quo9 <= ((linien_divider_quo8 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r9 <= {linien_divider_r8[24:0], linien_divider_q8[34]};
			linien_divider_quo9 <= (linien_divider_quo8 <<< 1'd1);
		end
	end
	linien_divider_v10 <= linien_divider_v9;
	linien_divider_q10 <= ((linien_divider_q9 <<< 1'd1) & 35'd34359738367);
	linien_divider_d10 <= linien_divider_d9;
	if (linien_divider_v9) begin
		if (linien_divider_sub_success9) begin
			linien_divider_r10 <= linien_divider_r_sub9;
			linien_divider_quo10 <= ((linien_divider_quo9 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r10 <= {linien_divider_r9[24:0], linien_divider_q9[34]};
			linien_divider_quo10 <= (linien_divider_quo9 <<< 1'd1);
		end
	end
	linien_divider_v11 <= linien_divider_v10;
	linien_divider_q11 <= ((linien_divider_q10 <<< 1'd1) & 35'd34359738367);
	linien_divider_d11 <= linien_divider_d10;
	if (linien_divider_v10) begin
		if (linien_divider_sub_success10) begin
			linien_divider_r11 <= linien_divider_r_sub10;
			linien_divider_quo11 <= ((linien_divider_quo10 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r11 <= {linien_divider_r10[24:0], linien_divider_q10[34]};
			linien_divider_quo11 <= (linien_divider_quo10 <<< 1'd1);
		end
	end
	linien_divider_v12 <= linien_divider_v11;
	linien_divider_q12 <= ((linien_divider_q11 <<< 1'd1) & 35'd34359738367);
	linien_divider_d12 <= linien_divider_d11;
	if (linien_divider_v11) begin
		if (linien_divider_sub_success11) begin
			linien_divider_r12 <= linien_divider_r_sub11;
			linien_divider_quo12 <= ((linien_divider_quo11 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r12 <= {linien_divider_r11[24:0], linien_divider_q11[34]};
			linien_divider_quo12 <= (linien_divider_quo11 <<< 1'd1);
		end
	end
	linien_divider_v13 <= linien_divider_v12;
	linien_divider_q13 <= ((linien_divider_q12 <<< 1'd1) & 35'd34359738367);
	linien_divider_d13 <= linien_divider_d12;
	if (linien_divider_v12) begin
		if (linien_divider_sub_success12) begin
			linien_divider_r13 <= linien_divider_r_sub12;
			linien_divider_quo13 <= ((linien_divider_quo12 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r13 <= {linien_divider_r12[24:0], linien_divider_q12[34]};
			linien_divider_quo13 <= (linien_divider_quo12 <<< 1'd1);
		end
	end
	linien_divider_v14 <= linien_divider_v13;
	linien_divider_q14 <= ((linien_divider_q13 <<< 1'd1) & 35'd34359738367);
	linien_divider_d14 <= linien_divider_d13;
	if (linien_divider_v13) begin
		if (linien_divider_sub_success13) begin
			linien_divider_r14 <= linien_divider_r_sub13;
			linien_divider_quo14 <= ((linien_divider_quo13 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r14 <= {linien_divider_r13[24:0], linien_divider_q13[34]};
			linien_divider_quo14 <= (linien_divider_quo13 <<< 1'd1);
		end
	end
	linien_divider_v15 <= linien_divider_v14;
	linien_divider_q15 <= ((linien_divider_q14 <<< 1'd1) & 35'd34359738367);
	linien_divider_d15 <= linien_divider_d14;
	if (linien_divider_v14) begin
		if (linien_divider_sub_success14) begin
			linien_divider_r15 <= linien_divider_r_sub14;
			linien_divider_quo15 <= ((linien_divider_quo14 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r15 <= {linien_divider_r14[24:0], linien_divider_q14[34]};
			linien_divider_quo15 <= (linien_divider_quo14 <<< 1'd1);
		end
	end
	linien_divider_v16 <= linien_divider_v15;
	linien_divider_q16 <= ((linien_divider_q15 <<< 1'd1) & 35'd34359738367);
	linien_divider_d16 <= linien_divider_d15;
	if (linien_divider_v15) begin
		if (linien_divider_sub_success15) begin
			linien_divider_r16 <= linien_divider_r_sub15;
			linien_divider_quo16 <= ((linien_divider_quo15 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r16 <= {linien_divider_r15[24:0], linien_divider_q15[34]};
			linien_divider_quo16 <= (linien_divider_quo15 <<< 1'd1);
		end
	end
	linien_divider_v17 <= linien_divider_v16;
	linien_divider_q17 <= ((linien_divider_q16 <<< 1'd1) & 35'd34359738367);
	linien_divider_d17 <= linien_divider_d16;
	if (linien_divider_v16) begin
		if (linien_divider_sub_success16) begin
			linien_divider_r17 <= linien_divider_r_sub16;
			linien_divider_quo17 <= ((linien_divider_quo16 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r17 <= {linien_divider_r16[24:0], linien_divider_q16[34]};
			linien_divider_quo17 <= (linien_divider_quo16 <<< 1'd1);
		end
	end
	linien_divider_v18 <= linien_divider_v17;
	linien_divider_q18 <= ((linien_divider_q17 <<< 1'd1) & 35'd34359738367);
	linien_divider_d18 <= linien_divider_d17;
	if (linien_divider_v17) begin
		if (linien_divider_sub_success17) begin
			linien_divider_r18 <= linien_divider_r_sub17;
			linien_divider_quo18 <= ((linien_divider_quo17 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r18 <= {linien_divider_r17[24:0], linien_divider_q17[34]};
			linien_divider_quo18 <= (linien_divider_quo17 <<< 1'd1);
		end
	end
	linien_divider_v19 <= linien_divider_v18;
	linien_divider_q19 <= ((linien_divider_q18 <<< 1'd1) & 35'd34359738367);
	linien_divider_d19 <= linien_divider_d18;
	if (linien_divider_v18) begin
		if (linien_divider_sub_success18) begin
			linien_divider_r19 <= linien_divider_r_sub18;
			linien_divider_quo19 <= ((linien_divider_quo18 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r19 <= {linien_divider_r18[24:0], linien_divider_q18[34]};
			linien_divider_quo19 <= (linien_divider_quo18 <<< 1'd1);
		end
	end
	linien_divider_v20 <= linien_divider_v19;
	linien_divider_q20 <= ((linien_divider_q19 <<< 1'd1) & 35'd34359738367);
	linien_divider_d20 <= linien_divider_d19;
	if (linien_divider_v19) begin
		if (linien_divider_sub_success19) begin
			linien_divider_r20 <= linien_divider_r_sub19;
			linien_divider_quo20 <= ((linien_divider_quo19 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r20 <= {linien_divider_r19[24:0], linien_divider_q19[34]};
			linien_divider_quo20 <= (linien_divider_quo19 <<< 1'd1);
		end
	end
	linien_divider_v21 <= linien_divider_v20;
	linien_divider_q21 <= ((linien_divider_q20 <<< 1'd1) & 35'd34359738367);
	linien_divider_d21 <= linien_divider_d20;
	if (linien_divider_v20) begin
		if (linien_divider_sub_success20) begin
			linien_divider_r21 <= linien_divider_r_sub20;
			linien_divider_quo21 <= ((linien_divider_quo20 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r21 <= {linien_divider_r20[24:0], linien_divider_q20[34]};
			linien_divider_quo21 <= (linien_divider_quo20 <<< 1'd1);
		end
	end
	linien_divider_v22 <= linien_divider_v21;
	linien_divider_q22 <= ((linien_divider_q21 <<< 1'd1) & 35'd34359738367);
	linien_divider_d22 <= linien_divider_d21;
	if (linien_divider_v21) begin
		if (linien_divider_sub_success21) begin
			linien_divider_r22 <= linien_divider_r_sub21;
			linien_divider_quo22 <= ((linien_divider_quo21 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r22 <= {linien_divider_r21[24:0], linien_divider_q21[34]};
			linien_divider_quo22 <= (linien_divider_quo21 <<< 1'd1);
		end
	end
	linien_divider_v23 <= linien_divider_v22;
	linien_divider_q23 <= ((linien_divider_q22 <<< 1'd1) & 35'd34359738367);
	linien_divider_d23 <= linien_divider_d22;
	if (linien_divider_v22) begin
		if (linien_divider_sub_success22) begin
			linien_divider_r23 <= linien_divider_r_sub22;
			linien_divider_quo23 <= ((linien_divider_quo22 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r23 <= {linien_divider_r22[24:0], linien_divider_q22[34]};
			linien_divider_quo23 <= (linien_divider_quo22 <<< 1'd1);
		end
	end
	linien_divider_v24 <= linien_divider_v23;
	linien_divider_q24 <= ((linien_divider_q23 <<< 1'd1) & 35'd34359738367);
	linien_divider_d24 <= linien_divider_d23;
	if (linien_divider_v23) begin
		if (linien_divider_sub_success23) begin
			linien_divider_r24 <= linien_divider_r_sub23;
			linien_divider_quo24 <= ((linien_divider_quo23 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r24 <= {linien_divider_r23[24:0], linien_divider_q23[34]};
			linien_divider_quo24 <= (linien_divider_quo23 <<< 1'd1);
		end
	end
	linien_divider_v25 <= linien_divider_v24;
	linien_divider_q25 <= ((linien_divider_q24 <<< 1'd1) & 35'd34359738367);
	linien_divider_d25 <= linien_divider_d24;
	if (linien_divider_v24) begin
		if (linien_divider_sub_success24) begin
			linien_divider_r25 <= linien_divider_r_sub24;
			linien_divider_quo25 <= ((linien_divider_quo24 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r25 <= {linien_divider_r24[24:0], linien_divider_q24[34]};
			linien_divider_quo25 <= (linien_divider_quo24 <<< 1'd1);
		end
	end
	linien_divider_v26 <= linien_divider_v25;
	linien_divider_q26 <= ((linien_divider_q25 <<< 1'd1) & 35'd34359738367);
	linien_divider_d26 <= linien_divider_d25;
	if (linien_divider_v25) begin
		if (linien_divider_sub_success25) begin
			linien_divider_r26 <= linien_divider_r_sub25;
			linien_divider_quo26 <= ((linien_divider_quo25 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r26 <= {linien_divider_r25[24:0], linien_divider_q25[34]};
			linien_divider_quo26 <= (linien_divider_quo25 <<< 1'd1);
		end
	end
	linien_divider_v27 <= linien_divider_v26;
	linien_divider_q27 <= ((linien_divider_q26 <<< 1'd1) & 35'd34359738367);
	linien_divider_d27 <= linien_divider_d26;
	if (linien_divider_v26) begin
		if (linien_divider_sub_success26) begin
			linien_divider_r27 <= linien_divider_r_sub26;
			linien_divider_quo27 <= ((linien_divider_quo26 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r27 <= {linien_divider_r26[24:0], linien_divider_q26[34]};
			linien_divider_quo27 <= (linien_divider_quo26 <<< 1'd1);
		end
	end
	linien_divider_v28 <= linien_divider_v27;
	linien_divider_q28 <= ((linien_divider_q27 <<< 1'd1) & 35'd34359738367);
	linien_divider_d28 <= linien_divider_d27;
	if (linien_divider_v27) begin
		if (linien_divider_sub_success27) begin
			linien_divider_r28 <= linien_divider_r_sub27;
			linien_divider_quo28 <= ((linien_divider_quo27 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r28 <= {linien_divider_r27[24:0], linien_divider_q27[34]};
			linien_divider_quo28 <= (linien_divider_quo27 <<< 1'd1);
		end
	end
	linien_divider_v29 <= linien_divider_v28;
	linien_divider_q29 <= ((linien_divider_q28 <<< 1'd1) & 35'd34359738367);
	linien_divider_d29 <= linien_divider_d28;
	if (linien_divider_v28) begin
		if (linien_divider_sub_success28) begin
			linien_divider_r29 <= linien_divider_r_sub28;
			linien_divider_quo29 <= ((linien_divider_quo28 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r29 <= {linien_divider_r28[24:0], linien_divider_q28[34]};
			linien_divider_quo29 <= (linien_divider_quo28 <<< 1'd1);
		end
	end
	linien_divider_v30 <= linien_divider_v29;
	linien_divider_q30 <= ((linien_divider_q29 <<< 1'd1) & 35'd34359738367);
	linien_divider_d30 <= linien_divider_d29;
	if (linien_divider_v29) begin
		if (linien_divider_sub_success29) begin
			linien_divider_r30 <= linien_divider_r_sub29;
			linien_divider_quo30 <= ((linien_divider_quo29 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r30 <= {linien_divider_r29[24:0], linien_divider_q29[34]};
			linien_divider_quo30 <= (linien_divider_quo29 <<< 1'd1);
		end
	end
	linien_divider_v31 <= linien_divider_v30;
	linien_divider_q31 <= ((linien_divider_q30 <<< 1'd1) & 35'd34359738367);
	linien_divider_d31 <= linien_divider_d30;
	if (linien_divider_v30) begin
		if (linien_divider_sub_success30) begin
			linien_divider_r31 <= linien_divider_r_sub30;
			linien_divider_quo31 <= ((linien_divider_quo30 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r31 <= {linien_divider_r30[24:0], linien_divider_q30[34]};
			linien_divider_quo31 <= (linien_divider_quo30 <<< 1'd1);
		end
	end
	linien_divider_v32 <= linien_divider_v31;
	linien_divider_q32 <= ((linien_divider_q31 <<< 1'd1) & 35'd34359738367);
	linien_divider_d32 <= linien_divider_d31;
	if (linien_divider_v31) begin
		if (linien_divider_sub_success31) begin
			linien_divider_r32 <= linien_divider_r_sub31;
			linien_divider_quo32 <= ((linien_divider_quo31 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r32 <= {linien_divider_r31[24:0], linien_divider_q31[34]};
			linien_divider_quo32 <= (linien_divider_quo31 <<< 1'd1);
		end
	end
	linien_divider_v33 <= linien_divider_v32;
	linien_divider_q33 <= ((linien_divider_q32 <<< 1'd1) & 35'd34359738367);
	linien_divider_d33 <= linien_divider_d32;
	if (linien_divider_v32) begin
		if (linien_divider_sub_success32) begin
			linien_divider_r33 <= linien_divider_r_sub32;
			linien_divider_quo33 <= ((linien_divider_quo32 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r33 <= {linien_divider_r32[24:0], linien_divider_q32[34]};
			linien_divider_quo33 <= (linien_divider_quo32 <<< 1'd1);
		end
	end
	linien_divider_v34 <= linien_divider_v33;
	linien_divider_q34 <= ((linien_divider_q33 <<< 1'd1) & 35'd34359738367);
	linien_divider_d34 <= linien_divider_d33;
	if (linien_divider_v33) begin
		if (linien_divider_sub_success33) begin
			linien_divider_r34 <= linien_divider_r_sub33;
			linien_divider_quo34 <= ((linien_divider_quo33 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r34 <= {linien_divider_r33[24:0], linien_divider_q33[34]};
			linien_divider_quo34 <= (linien_divider_quo33 <<< 1'd1);
		end
	end
	linien_divider_v35 <= linien_divider_v34;
	linien_divider_q35 <= ((linien_divider_q34 <<< 1'd1) & 35'd34359738367);
	linien_divider_d35 <= linien_divider_d34;
	if (linien_divider_v34) begin
		if (linien_divider_sub_success34) begin
			linien_divider_r35 <= linien_divider_r_sub34;
			linien_divider_quo35 <= ((linien_divider_quo34 <<< 1'd1) | 1'd1);
		end else begin
			linien_divider_r35 <= {linien_divider_r34[24:0], linien_divider_q34[34]};
			linien_divider_quo35 <= (linien_divider_quo34 <<< 1'd1);
		end
	end
	linien_divider_done <= linien_divider_v35;
	if (linien_divider_v35) begin
		linien_divider_quotient <= (linien_divider_q_sign ? (-$signed({1'd0, linien_divider_q_final_trunc})) : $signed({1'd0, linien_divider_q_final_trunc}));
	end
	if ((linien_is_ongoing0 | linien_is_ongoing1)) begin
		if ((linien_sweep_direction == 1'd1)) begin
			linien_current_output_time <= (linien_current_output_time + $signed({1'd0, 1'd1}));
			if ((linien_current_output_time >= ((linien_sweep_center + linien_sweep_span) - $signed({1'd0, 1'd1})))) begin
				linien_current_output_time <= (linien_sweep_center + linien_sweep_span);
				linien_sweep_direction <= 1'd0;
			end
		end else begin
			linien_current_output_time <= (linien_current_output_time - $signed({1'd0, 1'd1}));
			if ((linien_current_output_time <= ((linien_sweep_center - linien_sweep_span) + $signed({1'd0, 1'd1})))) begin
				linien_current_output_time <= (linien_sweep_center - linien_sweep_span);
				linien_sweep_direction <= 1'd1;
			end
		end
	end else begin
		if (linien_is_ongoing2) begin
			linien_current_output_time <= linien_kalman_est_time;
		end else begin
			linien_current_output_time <= 1'd0;
			linien_sweep_direction <= 1'd1;
		end
	end
	if (linien_is_ongoing3) begin
		if ((linien_power_level > linien_power_threshold_acquire)) begin
			linien_narrow_search_timeout_counter <= 1'd0;
		end else begin
			if ((linien_narrow_search_timeout_counter < 27'd125000000)) begin
				linien_narrow_search_timeout_counter <= (linien_narrow_search_timeout_counter + 1'd1);
			end
		end
	end else begin
		linien_narrow_search_timeout_counter <= 1'd0;
	end
	if (($signed({1'd0, linien_time_command_out_clr_re}) | ($signed({1'd0, linien_max_status11}) < linien_time_command_out))) begin
		linien_max_status11 <= linien_time_command_out;
	end
	if (($signed({1'd0, linien_time_command_out_clr_re}) | ($signed({1'd0, linien_min_status11}) > linien_time_command_out))) begin
		linien_min_status11 <= linien_time_command_out;
	end
	state <= next_state;
	if (linien_scopegen_automatically_trigger) begin
		linien_scopegen_automatic_trigger_signal <= (~linien_scopegen_automatic_trigger_signal);
	end else begin
		linien_scopegen_automatic_trigger_signal <= 1'd0;
	end
	if (($signed({1'd0, linien_dac_a_clr_re}) | ($signed({1'd0, linien_max_status8}) < linien_scopegen_dac_a))) begin
		linien_max_status8 <= linien_scopegen_dac_a;
	end
	if (($signed({1'd0, linien_dac_a_clr_re}) | ($signed({1'd0, linien_min_status8}) > linien_scopegen_dac_a))) begin
		linien_min_status8 <= linien_scopegen_dac_a;
	end
	if (($signed({1'd0, linien_dac_b_clr_re}) | ($signed({1'd0, linien_max_status9}) < linien_scopegen_dac_b))) begin
		linien_max_status9 <= linien_scopegen_dac_b;
	end
	if (($signed({1'd0, linien_dac_b_clr_re}) | ($signed({1'd0, linien_min_status9}) > linien_scopegen_dac_b))) begin
		linien_min_status9 <= linien_scopegen_dac_b;
	end
	linien_scopegen_adc_a <= sync_array_muxed4;
	linien_scopegen_adc_b <= sync_array_muxed5;
	linien_scopegen_adc_a_q <= sync_array_muxed6;
	linien_scopegen_adc_b_q <= sync_array_muxed7;
	linien_sine_source_phase <= (linien_sine_source_phase + 22'd3435974);
	linien_interface0_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank0_sel) begin
		case (linien_interface0_bank_bus_adr[2:0])
			1'd0: begin
				linien_interface0_bank_bus_dat_r <= linien_csrbank0_dna7_w;
			end
			1'd1: begin
				linien_interface0_bank_bus_dat_r <= linien_csrbank0_dna6_w;
			end
			2'd2: begin
				linien_interface0_bank_bus_dat_r <= linien_csrbank0_dna5_w;
			end
			2'd3: begin
				linien_interface0_bank_bus_dat_r <= linien_csrbank0_dna4_w;
			end
			3'd4: begin
				linien_interface0_bank_bus_dat_r <= linien_csrbank0_dna3_w;
			end
			3'd5: begin
				linien_interface0_bank_bus_dat_r <= linien_csrbank0_dna2_w;
			end
			3'd6: begin
				linien_interface0_bank_bus_dat_r <= linien_csrbank0_dna1_w;
			end
			3'd7: begin
				linien_interface0_bank_bus_dat_r <= linien_csrbank0_dna0_w;
			end
		endcase
	end
	linien_interface1_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank1_sel) begin
		case (linien_interface1_bank_bus_adr[4:0])
			1'd0: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e3_w;
			end
			1'd1: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e2_w;
			end
			2'd2: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e1_w;
			end
			2'd3: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e0_w;
			end
			3'd4: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out3_w;
			end
			3'd5: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out2_w;
			end
			3'd6: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out1_w;
			end
			3'd7: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out0_w;
			end
			4'd8: begin
				linien_interface1_bank_bus_dat_r <= linien_out_e_clr_w;
			end
			4'd9: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e_max3_w;
			end
			4'd10: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e_max2_w;
			end
			4'd11: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e_max1_w;
			end
			4'd12: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e_max0_w;
			end
			4'd13: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e_min3_w;
			end
			4'd14: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e_min2_w;
			end
			4'd15: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e_min1_w;
			end
			5'd16: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_out_e_min0_w;
			end
			5'd17: begin
				linien_interface1_bank_bus_dat_r <= linien_power_signal_out_clr_w;
			end
			5'd18: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out_max3_w;
			end
			5'd19: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out_max2_w;
			end
			5'd20: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out_max1_w;
			end
			5'd21: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out_max0_w;
			end
			5'd22: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out_min3_w;
			end
			5'd23: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out_min2_w;
			end
			5'd24: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out_min1_w;
			end
			5'd25: begin
				linien_interface1_bank_bus_dat_r <= linien_csrbank1_power_signal_out_min0_w;
			end
		endcase
	end
	linien_interface2_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank2_sel) begin
		case (linien_interface2_bank_bus_adr[7:0])
			1'd0: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_tap0_w;
			end
			1'd1: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_invert0_w;
			end
			2'd2: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_demod_delay3_w;
			end
			2'd3: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_demod_delay2_w;
			end
			3'd4: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_demod_delay1_w;
			end
			3'd5: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_demod_delay0_w;
			end
			3'd6: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_demod_multiplier0_w;
			end
			3'd7: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_1_min3_w;
			end
			4'd8: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_1_min2_w;
			end
			4'd9: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_1_min1_w;
			end
			4'd10: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_1_min0_w;
			end
			4'd11: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_1_max3_w;
			end
			4'd12: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_1_max2_w;
			end
			4'd13: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_1_max1_w;
			end
			4'd14: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_1_max0_w;
			end
			4'd15: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_z03_w;
			end
			5'd16: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_z02_w;
			end
			5'd17: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_z01_w;
			end
			5'd18: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_z00_w;
			end
			5'd19: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_a13_w;
			end
			5'd20: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_a12_w;
			end
			5'd21: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_a11_w;
			end
			5'd22: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_a10_w;
			end
			5'd23: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_b03_w;
			end
			5'd24: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_b02_w;
			end
			5'd25: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_b01_w;
			end
			5'd26: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_b00_w;
			end
			5'd27: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_b13_w;
			end
			5'd28: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_b12_w;
			end
			5'd29: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_b11_w;
			end
			5'd30: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_1_b10_w;
			end
			5'd31: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_z03_w;
			end
			6'd32: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_z02_w;
			end
			6'd33: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_z01_w;
			end
			6'd34: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_z00_w;
			end
			6'd35: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_a13_w;
			end
			6'd36: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_a12_w;
			end
			6'd37: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_a11_w;
			end
			6'd38: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_a10_w;
			end
			6'd39: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_a23_w;
			end
			6'd40: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_a22_w;
			end
			6'd41: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_a21_w;
			end
			6'd42: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_a20_w;
			end
			6'd43: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b03_w;
			end
			6'd44: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b02_w;
			end
			6'd45: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b01_w;
			end
			6'd46: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b00_w;
			end
			6'd47: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b13_w;
			end
			6'd48: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b12_w;
			end
			6'd49: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b11_w;
			end
			6'd50: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b10_w;
			end
			6'd51: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b23_w;
			end
			6'd52: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b22_w;
			end
			6'd53: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b21_w;
			end
			6'd54: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_1_b20_w;
			end
			6'd55: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_1_min3_w;
			end
			6'd56: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_1_min2_w;
			end
			6'd57: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_1_min1_w;
			end
			6'd58: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_1_min0_w;
			end
			6'd59: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_1_max3_w;
			end
			6'd60: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_1_max2_w;
			end
			6'd61: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_1_max1_w;
			end
			6'd62: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_1_max0_w;
			end
			6'd63: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_2_min3_w;
			end
			7'd64: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_2_min2_w;
			end
			7'd65: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_2_min1_w;
			end
			7'd66: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_2_min0_w;
			end
			7'd67: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_2_max3_w;
			end
			7'd68: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_2_max2_w;
			end
			7'd69: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_2_max1_w;
			end
			7'd70: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_limit_2_max0_w;
			end
			7'd71: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_z03_w;
			end
			7'd72: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_z02_w;
			end
			7'd73: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_z01_w;
			end
			7'd74: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_z00_w;
			end
			7'd75: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_a13_w;
			end
			7'd76: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_a12_w;
			end
			7'd77: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_a11_w;
			end
			7'd78: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_a10_w;
			end
			7'd79: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_b03_w;
			end
			7'd80: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_b02_w;
			end
			7'd81: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_b01_w;
			end
			7'd82: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_b00_w;
			end
			7'd83: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_b13_w;
			end
			7'd84: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_b12_w;
			end
			7'd85: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_b11_w;
			end
			7'd86: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_c_2_b10_w;
			end
			7'd87: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_z03_w;
			end
			7'd88: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_z02_w;
			end
			7'd89: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_z01_w;
			end
			7'd90: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_z00_w;
			end
			7'd91: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_a13_w;
			end
			7'd92: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_a12_w;
			end
			7'd93: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_a11_w;
			end
			7'd94: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_a10_w;
			end
			7'd95: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_a23_w;
			end
			7'd96: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_a22_w;
			end
			7'd97: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_a21_w;
			end
			7'd98: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_a20_w;
			end
			7'd99: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b03_w;
			end
			7'd100: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b02_w;
			end
			7'd101: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b01_w;
			end
			7'd102: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b00_w;
			end
			7'd103: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b13_w;
			end
			7'd104: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b12_w;
			end
			7'd105: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b11_w;
			end
			7'd106: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b10_w;
			end
			7'd107: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b23_w;
			end
			7'd108: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b22_w;
			end
			7'd109: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b21_w;
			end
			7'd110: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_iir_d_2_b20_w;
			end
			7'd111: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_2_min3_w;
			end
			7'd112: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_2_min2_w;
			end
			7'd113: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_2_min1_w;
			end
			7'd114: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_2_min0_w;
			end
			7'd115: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_2_max3_w;
			end
			7'd116: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_2_max2_w;
			end
			7'd117: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_2_max1_w;
			end
			7'd118: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_y_limit_2_max0_w;
			end
			7'd119: begin
				linien_interface2_bank_bus_dat_r <= linien_csr0_x_clr_w;
			end
			7'd120: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_max3_w;
			end
			7'd121: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_max2_w;
			end
			7'd122: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_max1_w;
			end
			7'd123: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_max0_w;
			end
			7'd124: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_min3_w;
			end
			7'd125: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_min2_w;
			end
			7'd126: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_min1_w;
			end
			7'd127: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_x_min0_w;
			end
			8'd128: begin
				linien_interface2_bank_bus_dat_r <= linien_csr1_out_i_clr_w;
			end
			8'd129: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_i_max3_w;
			end
			8'd130: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_i_max2_w;
			end
			8'd131: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_i_max1_w;
			end
			8'd132: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_i_max0_w;
			end
			8'd133: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_i_min3_w;
			end
			8'd134: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_i_min2_w;
			end
			8'd135: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_i_min1_w;
			end
			8'd136: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_i_min0_w;
			end
			8'd137: begin
				linien_interface2_bank_bus_dat_r <= linien_csr2_out_q_clr_w;
			end
			8'd138: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_q_max3_w;
			end
			8'd139: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_q_max2_w;
			end
			8'd140: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_q_max1_w;
			end
			8'd141: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_q_max0_w;
			end
			8'd142: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_q_min3_w;
			end
			8'd143: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_q_min2_w;
			end
			8'd144: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_q_min1_w;
			end
			8'd145: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_out_q_min0_w;
			end
			8'd146: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_dx_sel0_w;
			end
			8'd147: begin
				linien_interface2_bank_bus_dat_r <= linien_csrbank2_dy_sel0_w;
			end
		endcase
	end
	if (linien_csrbank2_y_tap0_re) begin
		linien_fast_a_y_tap_storage_full[1:0] <= linien_csrbank2_y_tap0_r;
	end
	linien_fast_a_y_tap_re <= linien_csrbank2_y_tap0_re;
	if (linien_csrbank2_invert0_re) begin
		linien_fast_a_invert_storage_full <= linien_csrbank2_invert0_r;
	end
	linien_fast_a_invert_re <= linien_csrbank2_invert0_re;
	if (linien_csrbank2_demod_delay3_re) begin
		linien_fast_a_delay_storage_full[31:24] <= linien_csrbank2_demod_delay3_r;
	end
	if (linien_csrbank2_demod_delay2_re) begin
		linien_fast_a_delay_storage_full[23:16] <= linien_csrbank2_demod_delay2_r;
	end
	if (linien_csrbank2_demod_delay1_re) begin
		linien_fast_a_delay_storage_full[15:8] <= linien_csrbank2_demod_delay1_r;
	end
	if (linien_csrbank2_demod_delay0_re) begin
		linien_fast_a_delay_storage_full[7:0] <= linien_csrbank2_demod_delay0_r;
	end
	linien_fast_a_delay_re <= linien_csrbank2_demod_delay0_re;
	if (linien_csrbank2_demod_multiplier0_re) begin
		linien_fast_a_multiplier_storage_full[3:0] <= linien_csrbank2_demod_multiplier0_r;
	end
	linien_fast_a_multiplier_re <= linien_csrbank2_demod_multiplier0_re;
	if (linien_csrbank2_x_limit_1_min3_re) begin
		linien_fast_a_limitcsr0_min_storage_full0[24] <= linien_csrbank2_x_limit_1_min3_r;
	end
	if (linien_csrbank2_x_limit_1_min2_re) begin
		linien_fast_a_limitcsr0_min_storage_full0[23:16] <= linien_csrbank2_x_limit_1_min2_r;
	end
	if (linien_csrbank2_x_limit_1_min1_re) begin
		linien_fast_a_limitcsr0_min_storage_full0[15:8] <= linien_csrbank2_x_limit_1_min1_r;
	end
	if (linien_csrbank2_x_limit_1_min0_re) begin
		linien_fast_a_limitcsr0_min_storage_full0[7:0] <= linien_csrbank2_x_limit_1_min0_r;
	end
	linien_fast_a_limitcsr0_min_re0 <= linien_csrbank2_x_limit_1_min0_re;
	if (linien_csrbank2_x_limit_1_max3_re) begin
		linien_fast_a_limitcsr0_max_storage_full0[24] <= linien_csrbank2_x_limit_1_max3_r;
	end
	if (linien_csrbank2_x_limit_1_max2_re) begin
		linien_fast_a_limitcsr0_max_storage_full0[23:16] <= linien_csrbank2_x_limit_1_max2_r;
	end
	if (linien_csrbank2_x_limit_1_max1_re) begin
		linien_fast_a_limitcsr0_max_storage_full0[15:8] <= linien_csrbank2_x_limit_1_max1_r;
	end
	if (linien_csrbank2_x_limit_1_max0_re) begin
		linien_fast_a_limitcsr0_max_storage_full0[7:0] <= linien_csrbank2_x_limit_1_max0_r;
	end
	linien_fast_a_limitcsr0_max_re0 <= linien_csrbank2_x_limit_1_max0_re;
	if (linien_csrbank2_iir_c_1_z03_re) begin
		linien_fast_a_iir0_storage_full0[26:24] <= linien_csrbank2_iir_c_1_z03_r;
	end
	if (linien_csrbank2_iir_c_1_z02_re) begin
		linien_fast_a_iir0_storage_full0[23:16] <= linien_csrbank2_iir_c_1_z02_r;
	end
	if (linien_csrbank2_iir_c_1_z01_re) begin
		linien_fast_a_iir0_storage_full0[15:8] <= linien_csrbank2_iir_c_1_z01_r;
	end
	if (linien_csrbank2_iir_c_1_z00_re) begin
		linien_fast_a_iir0_storage_full0[7:0] <= linien_csrbank2_iir_c_1_z00_r;
	end
	linien_fast_a_iir0_re0 <= linien_csrbank2_iir_c_1_z00_re;
	if (linien_csrbank2_iir_c_1_a13_re) begin
		linien_fast_a_iir0_csrstorage0_storage_full0[24] <= linien_csrbank2_iir_c_1_a13_r;
	end
	if (linien_csrbank2_iir_c_1_a12_re) begin
		linien_fast_a_iir0_csrstorage0_storage_full0[23:16] <= linien_csrbank2_iir_c_1_a12_r;
	end
	if (linien_csrbank2_iir_c_1_a11_re) begin
		linien_fast_a_iir0_csrstorage0_storage_full0[15:8] <= linien_csrbank2_iir_c_1_a11_r;
	end
	if (linien_csrbank2_iir_c_1_a10_re) begin
		linien_fast_a_iir0_csrstorage0_storage_full0[7:0] <= linien_csrbank2_iir_c_1_a10_r;
	end
	linien_fast_a_iir0_csrstorage0_re0 <= linien_csrbank2_iir_c_1_a10_re;
	if (linien_csrbank2_iir_c_1_b03_re) begin
		linien_fast_a_iir0_csrstorage1_storage_full0[24] <= linien_csrbank2_iir_c_1_b03_r;
	end
	if (linien_csrbank2_iir_c_1_b02_re) begin
		linien_fast_a_iir0_csrstorage1_storage_full0[23:16] <= linien_csrbank2_iir_c_1_b02_r;
	end
	if (linien_csrbank2_iir_c_1_b01_re) begin
		linien_fast_a_iir0_csrstorage1_storage_full0[15:8] <= linien_csrbank2_iir_c_1_b01_r;
	end
	if (linien_csrbank2_iir_c_1_b00_re) begin
		linien_fast_a_iir0_csrstorage1_storage_full0[7:0] <= linien_csrbank2_iir_c_1_b00_r;
	end
	linien_fast_a_iir0_csrstorage1_re0 <= linien_csrbank2_iir_c_1_b00_re;
	if (linien_csrbank2_iir_c_1_b13_re) begin
		linien_fast_a_iir0_csrstorage2_storage_full0[24] <= linien_csrbank2_iir_c_1_b13_r;
	end
	if (linien_csrbank2_iir_c_1_b12_re) begin
		linien_fast_a_iir0_csrstorage2_storage_full0[23:16] <= linien_csrbank2_iir_c_1_b12_r;
	end
	if (linien_csrbank2_iir_c_1_b11_re) begin
		linien_fast_a_iir0_csrstorage2_storage_full0[15:8] <= linien_csrbank2_iir_c_1_b11_r;
	end
	if (linien_csrbank2_iir_c_1_b10_re) begin
		linien_fast_a_iir0_csrstorage2_storage_full0[7:0] <= linien_csrbank2_iir_c_1_b10_r;
	end
	linien_fast_a_iir0_csrstorage2_re0 <= linien_csrbank2_iir_c_1_b10_re;
	if (linien_csrbank2_iir_d_1_z03_re) begin
		linien_fast_a_iir0_storage_full1[26:24] <= linien_csrbank2_iir_d_1_z03_r;
	end
	if (linien_csrbank2_iir_d_1_z02_re) begin
		linien_fast_a_iir0_storage_full1[23:16] <= linien_csrbank2_iir_d_1_z02_r;
	end
	if (linien_csrbank2_iir_d_1_z01_re) begin
		linien_fast_a_iir0_storage_full1[15:8] <= linien_csrbank2_iir_d_1_z01_r;
	end
	if (linien_csrbank2_iir_d_1_z00_re) begin
		linien_fast_a_iir0_storage_full1[7:0] <= linien_csrbank2_iir_d_1_z00_r;
	end
	linien_fast_a_iir0_re1 <= linien_csrbank2_iir_d_1_z00_re;
	if (linien_csrbank2_iir_d_1_a13_re) begin
		linien_fast_a_iir0_csrstorage0_storage_full1[24] <= linien_csrbank2_iir_d_1_a13_r;
	end
	if (linien_csrbank2_iir_d_1_a12_re) begin
		linien_fast_a_iir0_csrstorage0_storage_full1[23:16] <= linien_csrbank2_iir_d_1_a12_r;
	end
	if (linien_csrbank2_iir_d_1_a11_re) begin
		linien_fast_a_iir0_csrstorage0_storage_full1[15:8] <= linien_csrbank2_iir_d_1_a11_r;
	end
	if (linien_csrbank2_iir_d_1_a10_re) begin
		linien_fast_a_iir0_csrstorage0_storage_full1[7:0] <= linien_csrbank2_iir_d_1_a10_r;
	end
	linien_fast_a_iir0_csrstorage0_re1 <= linien_csrbank2_iir_d_1_a10_re;
	if (linien_csrbank2_iir_d_1_a23_re) begin
		linien_fast_a_iir0_csrstorage1_storage_full1[24] <= linien_csrbank2_iir_d_1_a23_r;
	end
	if (linien_csrbank2_iir_d_1_a22_re) begin
		linien_fast_a_iir0_csrstorage1_storage_full1[23:16] <= linien_csrbank2_iir_d_1_a22_r;
	end
	if (linien_csrbank2_iir_d_1_a21_re) begin
		linien_fast_a_iir0_csrstorage1_storage_full1[15:8] <= linien_csrbank2_iir_d_1_a21_r;
	end
	if (linien_csrbank2_iir_d_1_a20_re) begin
		linien_fast_a_iir0_csrstorage1_storage_full1[7:0] <= linien_csrbank2_iir_d_1_a20_r;
	end
	linien_fast_a_iir0_csrstorage1_re1 <= linien_csrbank2_iir_d_1_a20_re;
	if (linien_csrbank2_iir_d_1_b03_re) begin
		linien_fast_a_iir0_csrstorage2_storage_full1[24] <= linien_csrbank2_iir_d_1_b03_r;
	end
	if (linien_csrbank2_iir_d_1_b02_re) begin
		linien_fast_a_iir0_csrstorage2_storage_full1[23:16] <= linien_csrbank2_iir_d_1_b02_r;
	end
	if (linien_csrbank2_iir_d_1_b01_re) begin
		linien_fast_a_iir0_csrstorage2_storage_full1[15:8] <= linien_csrbank2_iir_d_1_b01_r;
	end
	if (linien_csrbank2_iir_d_1_b00_re) begin
		linien_fast_a_iir0_csrstorage2_storage_full1[7:0] <= linien_csrbank2_iir_d_1_b00_r;
	end
	linien_fast_a_iir0_csrstorage2_re1 <= linien_csrbank2_iir_d_1_b00_re;
	if (linien_csrbank2_iir_d_1_b13_re) begin
		linien_fast_a_iir0_csrstorage3_storage_full[24] <= linien_csrbank2_iir_d_1_b13_r;
	end
	if (linien_csrbank2_iir_d_1_b12_re) begin
		linien_fast_a_iir0_csrstorage3_storage_full[23:16] <= linien_csrbank2_iir_d_1_b12_r;
	end
	if (linien_csrbank2_iir_d_1_b11_re) begin
		linien_fast_a_iir0_csrstorage3_storage_full[15:8] <= linien_csrbank2_iir_d_1_b11_r;
	end
	if (linien_csrbank2_iir_d_1_b10_re) begin
		linien_fast_a_iir0_csrstorage3_storage_full[7:0] <= linien_csrbank2_iir_d_1_b10_r;
	end
	linien_fast_a_iir0_csrstorage3_re <= linien_csrbank2_iir_d_1_b10_re;
	if (linien_csrbank2_iir_d_1_b23_re) begin
		linien_fast_a_iir0_csrstorage4_storage_full[24] <= linien_csrbank2_iir_d_1_b23_r;
	end
	if (linien_csrbank2_iir_d_1_b22_re) begin
		linien_fast_a_iir0_csrstorage4_storage_full[23:16] <= linien_csrbank2_iir_d_1_b22_r;
	end
	if (linien_csrbank2_iir_d_1_b21_re) begin
		linien_fast_a_iir0_csrstorage4_storage_full[15:8] <= linien_csrbank2_iir_d_1_b21_r;
	end
	if (linien_csrbank2_iir_d_1_b20_re) begin
		linien_fast_a_iir0_csrstorage4_storage_full[7:0] <= linien_csrbank2_iir_d_1_b20_r;
	end
	linien_fast_a_iir0_csrstorage4_re <= linien_csrbank2_iir_d_1_b20_re;
	if (linien_csrbank2_y_limit_1_min3_re) begin
		linien_fast_a_limitcsr0_min_storage_full1[24] <= linien_csrbank2_y_limit_1_min3_r;
	end
	if (linien_csrbank2_y_limit_1_min2_re) begin
		linien_fast_a_limitcsr0_min_storage_full1[23:16] <= linien_csrbank2_y_limit_1_min2_r;
	end
	if (linien_csrbank2_y_limit_1_min1_re) begin
		linien_fast_a_limitcsr0_min_storage_full1[15:8] <= linien_csrbank2_y_limit_1_min1_r;
	end
	if (linien_csrbank2_y_limit_1_min0_re) begin
		linien_fast_a_limitcsr0_min_storage_full1[7:0] <= linien_csrbank2_y_limit_1_min0_r;
	end
	linien_fast_a_limitcsr0_min_re1 <= linien_csrbank2_y_limit_1_min0_re;
	if (linien_csrbank2_y_limit_1_max3_re) begin
		linien_fast_a_limitcsr0_max_storage_full1[24] <= linien_csrbank2_y_limit_1_max3_r;
	end
	if (linien_csrbank2_y_limit_1_max2_re) begin
		linien_fast_a_limitcsr0_max_storage_full1[23:16] <= linien_csrbank2_y_limit_1_max2_r;
	end
	if (linien_csrbank2_y_limit_1_max1_re) begin
		linien_fast_a_limitcsr0_max_storage_full1[15:8] <= linien_csrbank2_y_limit_1_max1_r;
	end
	if (linien_csrbank2_y_limit_1_max0_re) begin
		linien_fast_a_limitcsr0_max_storage_full1[7:0] <= linien_csrbank2_y_limit_1_max0_r;
	end
	linien_fast_a_limitcsr0_max_re1 <= linien_csrbank2_y_limit_1_max0_re;
	if (linien_csrbank2_x_limit_2_min3_re) begin
		linien_fast_a_limitcsr1_min_storage_full0[24] <= linien_csrbank2_x_limit_2_min3_r;
	end
	if (linien_csrbank2_x_limit_2_min2_re) begin
		linien_fast_a_limitcsr1_min_storage_full0[23:16] <= linien_csrbank2_x_limit_2_min2_r;
	end
	if (linien_csrbank2_x_limit_2_min1_re) begin
		linien_fast_a_limitcsr1_min_storage_full0[15:8] <= linien_csrbank2_x_limit_2_min1_r;
	end
	if (linien_csrbank2_x_limit_2_min0_re) begin
		linien_fast_a_limitcsr1_min_storage_full0[7:0] <= linien_csrbank2_x_limit_2_min0_r;
	end
	linien_fast_a_limitcsr1_min_re0 <= linien_csrbank2_x_limit_2_min0_re;
	if (linien_csrbank2_x_limit_2_max3_re) begin
		linien_fast_a_limitcsr1_max_storage_full0[24] <= linien_csrbank2_x_limit_2_max3_r;
	end
	if (linien_csrbank2_x_limit_2_max2_re) begin
		linien_fast_a_limitcsr1_max_storage_full0[23:16] <= linien_csrbank2_x_limit_2_max2_r;
	end
	if (linien_csrbank2_x_limit_2_max1_re) begin
		linien_fast_a_limitcsr1_max_storage_full0[15:8] <= linien_csrbank2_x_limit_2_max1_r;
	end
	if (linien_csrbank2_x_limit_2_max0_re) begin
		linien_fast_a_limitcsr1_max_storage_full0[7:0] <= linien_csrbank2_x_limit_2_max0_r;
	end
	linien_fast_a_limitcsr1_max_re0 <= linien_csrbank2_x_limit_2_max0_re;
	if (linien_csrbank2_iir_c_2_z03_re) begin
		linien_fast_a_iir1_storage_full0[26:24] <= linien_csrbank2_iir_c_2_z03_r;
	end
	if (linien_csrbank2_iir_c_2_z02_re) begin
		linien_fast_a_iir1_storage_full0[23:16] <= linien_csrbank2_iir_c_2_z02_r;
	end
	if (linien_csrbank2_iir_c_2_z01_re) begin
		linien_fast_a_iir1_storage_full0[15:8] <= linien_csrbank2_iir_c_2_z01_r;
	end
	if (linien_csrbank2_iir_c_2_z00_re) begin
		linien_fast_a_iir1_storage_full0[7:0] <= linien_csrbank2_iir_c_2_z00_r;
	end
	linien_fast_a_iir1_re0 <= linien_csrbank2_iir_c_2_z00_re;
	if (linien_csrbank2_iir_c_2_a13_re) begin
		linien_fast_a_iir1_csrstorage3_storage_full[24] <= linien_csrbank2_iir_c_2_a13_r;
	end
	if (linien_csrbank2_iir_c_2_a12_re) begin
		linien_fast_a_iir1_csrstorage3_storage_full[23:16] <= linien_csrbank2_iir_c_2_a12_r;
	end
	if (linien_csrbank2_iir_c_2_a11_re) begin
		linien_fast_a_iir1_csrstorage3_storage_full[15:8] <= linien_csrbank2_iir_c_2_a11_r;
	end
	if (linien_csrbank2_iir_c_2_a10_re) begin
		linien_fast_a_iir1_csrstorage3_storage_full[7:0] <= linien_csrbank2_iir_c_2_a10_r;
	end
	linien_fast_a_iir1_csrstorage3_re <= linien_csrbank2_iir_c_2_a10_re;
	if (linien_csrbank2_iir_c_2_b03_re) begin
		linien_fast_a_iir1_csrstorage4_storage_full[24] <= linien_csrbank2_iir_c_2_b03_r;
	end
	if (linien_csrbank2_iir_c_2_b02_re) begin
		linien_fast_a_iir1_csrstorage4_storage_full[23:16] <= linien_csrbank2_iir_c_2_b02_r;
	end
	if (linien_csrbank2_iir_c_2_b01_re) begin
		linien_fast_a_iir1_csrstorage4_storage_full[15:8] <= linien_csrbank2_iir_c_2_b01_r;
	end
	if (linien_csrbank2_iir_c_2_b00_re) begin
		linien_fast_a_iir1_csrstorage4_storage_full[7:0] <= linien_csrbank2_iir_c_2_b00_r;
	end
	linien_fast_a_iir1_csrstorage4_re <= linien_csrbank2_iir_c_2_b00_re;
	if (linien_csrbank2_iir_c_2_b13_re) begin
		linien_fast_a_iir1_csrstorage5_storage_full0[24] <= linien_csrbank2_iir_c_2_b13_r;
	end
	if (linien_csrbank2_iir_c_2_b12_re) begin
		linien_fast_a_iir1_csrstorage5_storage_full0[23:16] <= linien_csrbank2_iir_c_2_b12_r;
	end
	if (linien_csrbank2_iir_c_2_b11_re) begin
		linien_fast_a_iir1_csrstorage5_storage_full0[15:8] <= linien_csrbank2_iir_c_2_b11_r;
	end
	if (linien_csrbank2_iir_c_2_b10_re) begin
		linien_fast_a_iir1_csrstorage5_storage_full0[7:0] <= linien_csrbank2_iir_c_2_b10_r;
	end
	linien_fast_a_iir1_csrstorage5_re0 <= linien_csrbank2_iir_c_2_b10_re;
	if (linien_csrbank2_iir_d_2_z03_re) begin
		linien_fast_a_iir1_storage_full1[26:24] <= linien_csrbank2_iir_d_2_z03_r;
	end
	if (linien_csrbank2_iir_d_2_z02_re) begin
		linien_fast_a_iir1_storage_full1[23:16] <= linien_csrbank2_iir_d_2_z02_r;
	end
	if (linien_csrbank2_iir_d_2_z01_re) begin
		linien_fast_a_iir1_storage_full1[15:8] <= linien_csrbank2_iir_d_2_z01_r;
	end
	if (linien_csrbank2_iir_d_2_z00_re) begin
		linien_fast_a_iir1_storage_full1[7:0] <= linien_csrbank2_iir_d_2_z00_r;
	end
	linien_fast_a_iir1_re1 <= linien_csrbank2_iir_d_2_z00_re;
	if (linien_csrbank2_iir_d_2_a13_re) begin
		linien_fast_a_iir1_csrstorage5_storage_full1[24] <= linien_csrbank2_iir_d_2_a13_r;
	end
	if (linien_csrbank2_iir_d_2_a12_re) begin
		linien_fast_a_iir1_csrstorage5_storage_full1[23:16] <= linien_csrbank2_iir_d_2_a12_r;
	end
	if (linien_csrbank2_iir_d_2_a11_re) begin
		linien_fast_a_iir1_csrstorage5_storage_full1[15:8] <= linien_csrbank2_iir_d_2_a11_r;
	end
	if (linien_csrbank2_iir_d_2_a10_re) begin
		linien_fast_a_iir1_csrstorage5_storage_full1[7:0] <= linien_csrbank2_iir_d_2_a10_r;
	end
	linien_fast_a_iir1_csrstorage5_re1 <= linien_csrbank2_iir_d_2_a10_re;
	if (linien_csrbank2_iir_d_2_a23_re) begin
		linien_fast_a_iir1_csrstorage6_storage_full[24] <= linien_csrbank2_iir_d_2_a23_r;
	end
	if (linien_csrbank2_iir_d_2_a22_re) begin
		linien_fast_a_iir1_csrstorage6_storage_full[23:16] <= linien_csrbank2_iir_d_2_a22_r;
	end
	if (linien_csrbank2_iir_d_2_a21_re) begin
		linien_fast_a_iir1_csrstorage6_storage_full[15:8] <= linien_csrbank2_iir_d_2_a21_r;
	end
	if (linien_csrbank2_iir_d_2_a20_re) begin
		linien_fast_a_iir1_csrstorage6_storage_full[7:0] <= linien_csrbank2_iir_d_2_a20_r;
	end
	linien_fast_a_iir1_csrstorage6_re <= linien_csrbank2_iir_d_2_a20_re;
	if (linien_csrbank2_iir_d_2_b03_re) begin
		linien_fast_a_iir1_csrstorage7_storage_full[24] <= linien_csrbank2_iir_d_2_b03_r;
	end
	if (linien_csrbank2_iir_d_2_b02_re) begin
		linien_fast_a_iir1_csrstorage7_storage_full[23:16] <= linien_csrbank2_iir_d_2_b02_r;
	end
	if (linien_csrbank2_iir_d_2_b01_re) begin
		linien_fast_a_iir1_csrstorage7_storage_full[15:8] <= linien_csrbank2_iir_d_2_b01_r;
	end
	if (linien_csrbank2_iir_d_2_b00_re) begin
		linien_fast_a_iir1_csrstorage7_storage_full[7:0] <= linien_csrbank2_iir_d_2_b00_r;
	end
	linien_fast_a_iir1_csrstorage7_re <= linien_csrbank2_iir_d_2_b00_re;
	if (linien_csrbank2_iir_d_2_b13_re) begin
		linien_fast_a_iir1_csrstorage8_storage_full[24] <= linien_csrbank2_iir_d_2_b13_r;
	end
	if (linien_csrbank2_iir_d_2_b12_re) begin
		linien_fast_a_iir1_csrstorage8_storage_full[23:16] <= linien_csrbank2_iir_d_2_b12_r;
	end
	if (linien_csrbank2_iir_d_2_b11_re) begin
		linien_fast_a_iir1_csrstorage8_storage_full[15:8] <= linien_csrbank2_iir_d_2_b11_r;
	end
	if (linien_csrbank2_iir_d_2_b10_re) begin
		linien_fast_a_iir1_csrstorage8_storage_full[7:0] <= linien_csrbank2_iir_d_2_b10_r;
	end
	linien_fast_a_iir1_csrstorage8_re <= linien_csrbank2_iir_d_2_b10_re;
	if (linien_csrbank2_iir_d_2_b23_re) begin
		linien_fast_a_iir1_csrstorage9_storage_full[24] <= linien_csrbank2_iir_d_2_b23_r;
	end
	if (linien_csrbank2_iir_d_2_b22_re) begin
		linien_fast_a_iir1_csrstorage9_storage_full[23:16] <= linien_csrbank2_iir_d_2_b22_r;
	end
	if (linien_csrbank2_iir_d_2_b21_re) begin
		linien_fast_a_iir1_csrstorage9_storage_full[15:8] <= linien_csrbank2_iir_d_2_b21_r;
	end
	if (linien_csrbank2_iir_d_2_b20_re) begin
		linien_fast_a_iir1_csrstorage9_storage_full[7:0] <= linien_csrbank2_iir_d_2_b20_r;
	end
	linien_fast_a_iir1_csrstorage9_re <= linien_csrbank2_iir_d_2_b20_re;
	if (linien_csrbank2_y_limit_2_min3_re) begin
		linien_fast_a_limitcsr1_min_storage_full1[24] <= linien_csrbank2_y_limit_2_min3_r;
	end
	if (linien_csrbank2_y_limit_2_min2_re) begin
		linien_fast_a_limitcsr1_min_storage_full1[23:16] <= linien_csrbank2_y_limit_2_min2_r;
	end
	if (linien_csrbank2_y_limit_2_min1_re) begin
		linien_fast_a_limitcsr1_min_storage_full1[15:8] <= linien_csrbank2_y_limit_2_min1_r;
	end
	if (linien_csrbank2_y_limit_2_min0_re) begin
		linien_fast_a_limitcsr1_min_storage_full1[7:0] <= linien_csrbank2_y_limit_2_min0_r;
	end
	linien_fast_a_limitcsr1_min_re1 <= linien_csrbank2_y_limit_2_min0_re;
	if (linien_csrbank2_y_limit_2_max3_re) begin
		linien_fast_a_limitcsr1_max_storage_full1[24] <= linien_csrbank2_y_limit_2_max3_r;
	end
	if (linien_csrbank2_y_limit_2_max2_re) begin
		linien_fast_a_limitcsr1_max_storage_full1[23:16] <= linien_csrbank2_y_limit_2_max2_r;
	end
	if (linien_csrbank2_y_limit_2_max1_re) begin
		linien_fast_a_limitcsr1_max_storage_full1[15:8] <= linien_csrbank2_y_limit_2_max1_r;
	end
	if (linien_csrbank2_y_limit_2_max0_re) begin
		linien_fast_a_limitcsr1_max_storage_full1[7:0] <= linien_csrbank2_y_limit_2_max0_r;
	end
	linien_fast_a_limitcsr1_max_re1 <= linien_csrbank2_y_limit_2_max0_re;
	if (linien_csrbank2_dx_sel0_re) begin
		linien_csrstorage8_storage_full[3:0] <= linien_csrbank2_dx_sel0_r;
	end
	linien_csrstorage8_re <= linien_csrbank2_dx_sel0_re;
	if (linien_csrbank2_dy_sel0_re) begin
		linien_csrstorage9_storage_full[3:0] <= linien_csrbank2_dy_sel0_r;
	end
	linien_csrstorage9_re <= linien_csrbank2_dy_sel0_re;
	linien_interface3_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank3_sel) begin
		case (linien_interface3_bank_bus_adr[7:0])
			1'd0: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_tap0_w;
			end
			1'd1: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_invert0_w;
			end
			2'd2: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_demod_delay3_w;
			end
			2'd3: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_demod_delay2_w;
			end
			3'd4: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_demod_delay1_w;
			end
			3'd5: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_demod_delay0_w;
			end
			3'd6: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_demod_multiplier0_w;
			end
			3'd7: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_1_min3_w;
			end
			4'd8: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_1_min2_w;
			end
			4'd9: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_1_min1_w;
			end
			4'd10: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_1_min0_w;
			end
			4'd11: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_1_max3_w;
			end
			4'd12: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_1_max2_w;
			end
			4'd13: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_1_max1_w;
			end
			4'd14: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_1_max0_w;
			end
			4'd15: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_z03_w;
			end
			5'd16: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_z02_w;
			end
			5'd17: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_z01_w;
			end
			5'd18: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_z00_w;
			end
			5'd19: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_a13_w;
			end
			5'd20: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_a12_w;
			end
			5'd21: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_a11_w;
			end
			5'd22: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_a10_w;
			end
			5'd23: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_b03_w;
			end
			5'd24: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_b02_w;
			end
			5'd25: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_b01_w;
			end
			5'd26: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_b00_w;
			end
			5'd27: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_b13_w;
			end
			5'd28: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_b12_w;
			end
			5'd29: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_b11_w;
			end
			5'd30: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_1_b10_w;
			end
			5'd31: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_z03_w;
			end
			6'd32: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_z02_w;
			end
			6'd33: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_z01_w;
			end
			6'd34: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_z00_w;
			end
			6'd35: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_a13_w;
			end
			6'd36: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_a12_w;
			end
			6'd37: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_a11_w;
			end
			6'd38: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_a10_w;
			end
			6'd39: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_a23_w;
			end
			6'd40: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_a22_w;
			end
			6'd41: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_a21_w;
			end
			6'd42: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_a20_w;
			end
			6'd43: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b03_w;
			end
			6'd44: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b02_w;
			end
			6'd45: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b01_w;
			end
			6'd46: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b00_w;
			end
			6'd47: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b13_w;
			end
			6'd48: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b12_w;
			end
			6'd49: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b11_w;
			end
			6'd50: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b10_w;
			end
			6'd51: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b23_w;
			end
			6'd52: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b22_w;
			end
			6'd53: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b21_w;
			end
			6'd54: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_1_b20_w;
			end
			6'd55: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_1_min3_w;
			end
			6'd56: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_1_min2_w;
			end
			6'd57: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_1_min1_w;
			end
			6'd58: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_1_min0_w;
			end
			6'd59: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_1_max3_w;
			end
			6'd60: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_1_max2_w;
			end
			6'd61: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_1_max1_w;
			end
			6'd62: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_1_max0_w;
			end
			6'd63: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_2_min3_w;
			end
			7'd64: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_2_min2_w;
			end
			7'd65: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_2_min1_w;
			end
			7'd66: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_2_min0_w;
			end
			7'd67: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_2_max3_w;
			end
			7'd68: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_2_max2_w;
			end
			7'd69: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_2_max1_w;
			end
			7'd70: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_limit_2_max0_w;
			end
			7'd71: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_z03_w;
			end
			7'd72: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_z02_w;
			end
			7'd73: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_z01_w;
			end
			7'd74: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_z00_w;
			end
			7'd75: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_a13_w;
			end
			7'd76: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_a12_w;
			end
			7'd77: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_a11_w;
			end
			7'd78: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_a10_w;
			end
			7'd79: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_b03_w;
			end
			7'd80: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_b02_w;
			end
			7'd81: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_b01_w;
			end
			7'd82: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_b00_w;
			end
			7'd83: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_b13_w;
			end
			7'd84: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_b12_w;
			end
			7'd85: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_b11_w;
			end
			7'd86: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_c_2_b10_w;
			end
			7'd87: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_z03_w;
			end
			7'd88: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_z02_w;
			end
			7'd89: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_z01_w;
			end
			7'd90: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_z00_w;
			end
			7'd91: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_a13_w;
			end
			7'd92: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_a12_w;
			end
			7'd93: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_a11_w;
			end
			7'd94: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_a10_w;
			end
			7'd95: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_a23_w;
			end
			7'd96: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_a22_w;
			end
			7'd97: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_a21_w;
			end
			7'd98: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_a20_w;
			end
			7'd99: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b03_w;
			end
			7'd100: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b02_w;
			end
			7'd101: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b01_w;
			end
			7'd102: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b00_w;
			end
			7'd103: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b13_w;
			end
			7'd104: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b12_w;
			end
			7'd105: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b11_w;
			end
			7'd106: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b10_w;
			end
			7'd107: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b23_w;
			end
			7'd108: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b22_w;
			end
			7'd109: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b21_w;
			end
			7'd110: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_iir_d_2_b20_w;
			end
			7'd111: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_2_min3_w;
			end
			7'd112: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_2_min2_w;
			end
			7'd113: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_2_min1_w;
			end
			7'd114: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_2_min0_w;
			end
			7'd115: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_2_max3_w;
			end
			7'd116: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_2_max2_w;
			end
			7'd117: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_2_max1_w;
			end
			7'd118: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_y_limit_2_max0_w;
			end
			7'd119: begin
				linien_interface3_bank_bus_dat_r <= linien_csr3_x_clr_w;
			end
			7'd120: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_max3_w;
			end
			7'd121: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_max2_w;
			end
			7'd122: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_max1_w;
			end
			7'd123: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_max0_w;
			end
			7'd124: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_min3_w;
			end
			7'd125: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_min2_w;
			end
			7'd126: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_min1_w;
			end
			7'd127: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_x_min0_w;
			end
			8'd128: begin
				linien_interface3_bank_bus_dat_r <= linien_csr4_out_i_clr_w;
			end
			8'd129: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_i_max3_w;
			end
			8'd130: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_i_max2_w;
			end
			8'd131: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_i_max1_w;
			end
			8'd132: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_i_max0_w;
			end
			8'd133: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_i_min3_w;
			end
			8'd134: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_i_min2_w;
			end
			8'd135: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_i_min1_w;
			end
			8'd136: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_i_min0_w;
			end
			8'd137: begin
				linien_interface3_bank_bus_dat_r <= linien_csr5_out_q_clr_w;
			end
			8'd138: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_q_max3_w;
			end
			8'd139: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_q_max2_w;
			end
			8'd140: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_q_max1_w;
			end
			8'd141: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_q_max0_w;
			end
			8'd142: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_q_min3_w;
			end
			8'd143: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_q_min2_w;
			end
			8'd144: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_q_min1_w;
			end
			8'd145: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_out_q_min0_w;
			end
			8'd146: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_dx_sel0_w;
			end
			8'd147: begin
				linien_interface3_bank_bus_dat_r <= linien_csrbank3_dy_sel0_w;
			end
		endcase
	end
	if (linien_csrbank3_y_tap0_re) begin
		linien_fast_b_y_tap_storage_full[1:0] <= linien_csrbank3_y_tap0_r;
	end
	linien_fast_b_y_tap_re <= linien_csrbank3_y_tap0_re;
	if (linien_csrbank3_invert0_re) begin
		linien_fast_b_invert_storage_full <= linien_csrbank3_invert0_r;
	end
	linien_fast_b_invert_re <= linien_csrbank3_invert0_re;
	if (linien_csrbank3_demod_delay3_re) begin
		linien_fast_b_delay_storage_full[31:24] <= linien_csrbank3_demod_delay3_r;
	end
	if (linien_csrbank3_demod_delay2_re) begin
		linien_fast_b_delay_storage_full[23:16] <= linien_csrbank3_demod_delay2_r;
	end
	if (linien_csrbank3_demod_delay1_re) begin
		linien_fast_b_delay_storage_full[15:8] <= linien_csrbank3_demod_delay1_r;
	end
	if (linien_csrbank3_demod_delay0_re) begin
		linien_fast_b_delay_storage_full[7:0] <= linien_csrbank3_demod_delay0_r;
	end
	linien_fast_b_delay_re <= linien_csrbank3_demod_delay0_re;
	if (linien_csrbank3_demod_multiplier0_re) begin
		linien_fast_b_multiplier_storage_full[3:0] <= linien_csrbank3_demod_multiplier0_r;
	end
	linien_fast_b_multiplier_re <= linien_csrbank3_demod_multiplier0_re;
	if (linien_csrbank3_x_limit_1_min3_re) begin
		linien_fast_b_limitcsr0_min_storage_full0[24] <= linien_csrbank3_x_limit_1_min3_r;
	end
	if (linien_csrbank3_x_limit_1_min2_re) begin
		linien_fast_b_limitcsr0_min_storage_full0[23:16] <= linien_csrbank3_x_limit_1_min2_r;
	end
	if (linien_csrbank3_x_limit_1_min1_re) begin
		linien_fast_b_limitcsr0_min_storage_full0[15:8] <= linien_csrbank3_x_limit_1_min1_r;
	end
	if (linien_csrbank3_x_limit_1_min0_re) begin
		linien_fast_b_limitcsr0_min_storage_full0[7:0] <= linien_csrbank3_x_limit_1_min0_r;
	end
	linien_fast_b_limitcsr0_min_re0 <= linien_csrbank3_x_limit_1_min0_re;
	if (linien_csrbank3_x_limit_1_max3_re) begin
		linien_fast_b_limitcsr0_max_storage_full0[24] <= linien_csrbank3_x_limit_1_max3_r;
	end
	if (linien_csrbank3_x_limit_1_max2_re) begin
		linien_fast_b_limitcsr0_max_storage_full0[23:16] <= linien_csrbank3_x_limit_1_max2_r;
	end
	if (linien_csrbank3_x_limit_1_max1_re) begin
		linien_fast_b_limitcsr0_max_storage_full0[15:8] <= linien_csrbank3_x_limit_1_max1_r;
	end
	if (linien_csrbank3_x_limit_1_max0_re) begin
		linien_fast_b_limitcsr0_max_storage_full0[7:0] <= linien_csrbank3_x_limit_1_max0_r;
	end
	linien_fast_b_limitcsr0_max_re0 <= linien_csrbank3_x_limit_1_max0_re;
	if (linien_csrbank3_iir_c_1_z03_re) begin
		linien_fast_b_iir0_storage_full0[26:24] <= linien_csrbank3_iir_c_1_z03_r;
	end
	if (linien_csrbank3_iir_c_1_z02_re) begin
		linien_fast_b_iir0_storage_full0[23:16] <= linien_csrbank3_iir_c_1_z02_r;
	end
	if (linien_csrbank3_iir_c_1_z01_re) begin
		linien_fast_b_iir0_storage_full0[15:8] <= linien_csrbank3_iir_c_1_z01_r;
	end
	if (linien_csrbank3_iir_c_1_z00_re) begin
		linien_fast_b_iir0_storage_full0[7:0] <= linien_csrbank3_iir_c_1_z00_r;
	end
	linien_fast_b_iir0_re0 <= linien_csrbank3_iir_c_1_z00_re;
	if (linien_csrbank3_iir_c_1_a13_re) begin
		linien_fast_b_iir0_csrstorage0_storage_full0[24] <= linien_csrbank3_iir_c_1_a13_r;
	end
	if (linien_csrbank3_iir_c_1_a12_re) begin
		linien_fast_b_iir0_csrstorage0_storage_full0[23:16] <= linien_csrbank3_iir_c_1_a12_r;
	end
	if (linien_csrbank3_iir_c_1_a11_re) begin
		linien_fast_b_iir0_csrstorage0_storage_full0[15:8] <= linien_csrbank3_iir_c_1_a11_r;
	end
	if (linien_csrbank3_iir_c_1_a10_re) begin
		linien_fast_b_iir0_csrstorage0_storage_full0[7:0] <= linien_csrbank3_iir_c_1_a10_r;
	end
	linien_fast_b_iir0_csrstorage0_re0 <= linien_csrbank3_iir_c_1_a10_re;
	if (linien_csrbank3_iir_c_1_b03_re) begin
		linien_fast_b_iir0_csrstorage1_storage_full0[24] <= linien_csrbank3_iir_c_1_b03_r;
	end
	if (linien_csrbank3_iir_c_1_b02_re) begin
		linien_fast_b_iir0_csrstorage1_storage_full0[23:16] <= linien_csrbank3_iir_c_1_b02_r;
	end
	if (linien_csrbank3_iir_c_1_b01_re) begin
		linien_fast_b_iir0_csrstorage1_storage_full0[15:8] <= linien_csrbank3_iir_c_1_b01_r;
	end
	if (linien_csrbank3_iir_c_1_b00_re) begin
		linien_fast_b_iir0_csrstorage1_storage_full0[7:0] <= linien_csrbank3_iir_c_1_b00_r;
	end
	linien_fast_b_iir0_csrstorage1_re0 <= linien_csrbank3_iir_c_1_b00_re;
	if (linien_csrbank3_iir_c_1_b13_re) begin
		linien_fast_b_iir0_csrstorage2_storage_full0[24] <= linien_csrbank3_iir_c_1_b13_r;
	end
	if (linien_csrbank3_iir_c_1_b12_re) begin
		linien_fast_b_iir0_csrstorage2_storage_full0[23:16] <= linien_csrbank3_iir_c_1_b12_r;
	end
	if (linien_csrbank3_iir_c_1_b11_re) begin
		linien_fast_b_iir0_csrstorage2_storage_full0[15:8] <= linien_csrbank3_iir_c_1_b11_r;
	end
	if (linien_csrbank3_iir_c_1_b10_re) begin
		linien_fast_b_iir0_csrstorage2_storage_full0[7:0] <= linien_csrbank3_iir_c_1_b10_r;
	end
	linien_fast_b_iir0_csrstorage2_re0 <= linien_csrbank3_iir_c_1_b10_re;
	if (linien_csrbank3_iir_d_1_z03_re) begin
		linien_fast_b_iir0_storage_full1[26:24] <= linien_csrbank3_iir_d_1_z03_r;
	end
	if (linien_csrbank3_iir_d_1_z02_re) begin
		linien_fast_b_iir0_storage_full1[23:16] <= linien_csrbank3_iir_d_1_z02_r;
	end
	if (linien_csrbank3_iir_d_1_z01_re) begin
		linien_fast_b_iir0_storage_full1[15:8] <= linien_csrbank3_iir_d_1_z01_r;
	end
	if (linien_csrbank3_iir_d_1_z00_re) begin
		linien_fast_b_iir0_storage_full1[7:0] <= linien_csrbank3_iir_d_1_z00_r;
	end
	linien_fast_b_iir0_re1 <= linien_csrbank3_iir_d_1_z00_re;
	if (linien_csrbank3_iir_d_1_a13_re) begin
		linien_fast_b_iir0_csrstorage0_storage_full1[24] <= linien_csrbank3_iir_d_1_a13_r;
	end
	if (linien_csrbank3_iir_d_1_a12_re) begin
		linien_fast_b_iir0_csrstorage0_storage_full1[23:16] <= linien_csrbank3_iir_d_1_a12_r;
	end
	if (linien_csrbank3_iir_d_1_a11_re) begin
		linien_fast_b_iir0_csrstorage0_storage_full1[15:8] <= linien_csrbank3_iir_d_1_a11_r;
	end
	if (linien_csrbank3_iir_d_1_a10_re) begin
		linien_fast_b_iir0_csrstorage0_storage_full1[7:0] <= linien_csrbank3_iir_d_1_a10_r;
	end
	linien_fast_b_iir0_csrstorage0_re1 <= linien_csrbank3_iir_d_1_a10_re;
	if (linien_csrbank3_iir_d_1_a23_re) begin
		linien_fast_b_iir0_csrstorage1_storage_full1[24] <= linien_csrbank3_iir_d_1_a23_r;
	end
	if (linien_csrbank3_iir_d_1_a22_re) begin
		linien_fast_b_iir0_csrstorage1_storage_full1[23:16] <= linien_csrbank3_iir_d_1_a22_r;
	end
	if (linien_csrbank3_iir_d_1_a21_re) begin
		linien_fast_b_iir0_csrstorage1_storage_full1[15:8] <= linien_csrbank3_iir_d_1_a21_r;
	end
	if (linien_csrbank3_iir_d_1_a20_re) begin
		linien_fast_b_iir0_csrstorage1_storage_full1[7:0] <= linien_csrbank3_iir_d_1_a20_r;
	end
	linien_fast_b_iir0_csrstorage1_re1 <= linien_csrbank3_iir_d_1_a20_re;
	if (linien_csrbank3_iir_d_1_b03_re) begin
		linien_fast_b_iir0_csrstorage2_storage_full1[24] <= linien_csrbank3_iir_d_1_b03_r;
	end
	if (linien_csrbank3_iir_d_1_b02_re) begin
		linien_fast_b_iir0_csrstorage2_storage_full1[23:16] <= linien_csrbank3_iir_d_1_b02_r;
	end
	if (linien_csrbank3_iir_d_1_b01_re) begin
		linien_fast_b_iir0_csrstorage2_storage_full1[15:8] <= linien_csrbank3_iir_d_1_b01_r;
	end
	if (linien_csrbank3_iir_d_1_b00_re) begin
		linien_fast_b_iir0_csrstorage2_storage_full1[7:0] <= linien_csrbank3_iir_d_1_b00_r;
	end
	linien_fast_b_iir0_csrstorage2_re1 <= linien_csrbank3_iir_d_1_b00_re;
	if (linien_csrbank3_iir_d_1_b13_re) begin
		linien_fast_b_iir0_csrstorage3_storage_full[24] <= linien_csrbank3_iir_d_1_b13_r;
	end
	if (linien_csrbank3_iir_d_1_b12_re) begin
		linien_fast_b_iir0_csrstorage3_storage_full[23:16] <= linien_csrbank3_iir_d_1_b12_r;
	end
	if (linien_csrbank3_iir_d_1_b11_re) begin
		linien_fast_b_iir0_csrstorage3_storage_full[15:8] <= linien_csrbank3_iir_d_1_b11_r;
	end
	if (linien_csrbank3_iir_d_1_b10_re) begin
		linien_fast_b_iir0_csrstorage3_storage_full[7:0] <= linien_csrbank3_iir_d_1_b10_r;
	end
	linien_fast_b_iir0_csrstorage3_re <= linien_csrbank3_iir_d_1_b10_re;
	if (linien_csrbank3_iir_d_1_b23_re) begin
		linien_fast_b_iir0_csrstorage4_storage_full[24] <= linien_csrbank3_iir_d_1_b23_r;
	end
	if (linien_csrbank3_iir_d_1_b22_re) begin
		linien_fast_b_iir0_csrstorage4_storage_full[23:16] <= linien_csrbank3_iir_d_1_b22_r;
	end
	if (linien_csrbank3_iir_d_1_b21_re) begin
		linien_fast_b_iir0_csrstorage4_storage_full[15:8] <= linien_csrbank3_iir_d_1_b21_r;
	end
	if (linien_csrbank3_iir_d_1_b20_re) begin
		linien_fast_b_iir0_csrstorage4_storage_full[7:0] <= linien_csrbank3_iir_d_1_b20_r;
	end
	linien_fast_b_iir0_csrstorage4_re <= linien_csrbank3_iir_d_1_b20_re;
	if (linien_csrbank3_y_limit_1_min3_re) begin
		linien_fast_b_limitcsr0_min_storage_full1[24] <= linien_csrbank3_y_limit_1_min3_r;
	end
	if (linien_csrbank3_y_limit_1_min2_re) begin
		linien_fast_b_limitcsr0_min_storage_full1[23:16] <= linien_csrbank3_y_limit_1_min2_r;
	end
	if (linien_csrbank3_y_limit_1_min1_re) begin
		linien_fast_b_limitcsr0_min_storage_full1[15:8] <= linien_csrbank3_y_limit_1_min1_r;
	end
	if (linien_csrbank3_y_limit_1_min0_re) begin
		linien_fast_b_limitcsr0_min_storage_full1[7:0] <= linien_csrbank3_y_limit_1_min0_r;
	end
	linien_fast_b_limitcsr0_min_re1 <= linien_csrbank3_y_limit_1_min0_re;
	if (linien_csrbank3_y_limit_1_max3_re) begin
		linien_fast_b_limitcsr0_max_storage_full1[24] <= linien_csrbank3_y_limit_1_max3_r;
	end
	if (linien_csrbank3_y_limit_1_max2_re) begin
		linien_fast_b_limitcsr0_max_storage_full1[23:16] <= linien_csrbank3_y_limit_1_max2_r;
	end
	if (linien_csrbank3_y_limit_1_max1_re) begin
		linien_fast_b_limitcsr0_max_storage_full1[15:8] <= linien_csrbank3_y_limit_1_max1_r;
	end
	if (linien_csrbank3_y_limit_1_max0_re) begin
		linien_fast_b_limitcsr0_max_storage_full1[7:0] <= linien_csrbank3_y_limit_1_max0_r;
	end
	linien_fast_b_limitcsr0_max_re1 <= linien_csrbank3_y_limit_1_max0_re;
	if (linien_csrbank3_x_limit_2_min3_re) begin
		linien_fast_b_limitcsr1_min_storage_full0[24] <= linien_csrbank3_x_limit_2_min3_r;
	end
	if (linien_csrbank3_x_limit_2_min2_re) begin
		linien_fast_b_limitcsr1_min_storage_full0[23:16] <= linien_csrbank3_x_limit_2_min2_r;
	end
	if (linien_csrbank3_x_limit_2_min1_re) begin
		linien_fast_b_limitcsr1_min_storage_full0[15:8] <= linien_csrbank3_x_limit_2_min1_r;
	end
	if (linien_csrbank3_x_limit_2_min0_re) begin
		linien_fast_b_limitcsr1_min_storage_full0[7:0] <= linien_csrbank3_x_limit_2_min0_r;
	end
	linien_fast_b_limitcsr1_min_re0 <= linien_csrbank3_x_limit_2_min0_re;
	if (linien_csrbank3_x_limit_2_max3_re) begin
		linien_fast_b_limitcsr1_max_storage_full0[24] <= linien_csrbank3_x_limit_2_max3_r;
	end
	if (linien_csrbank3_x_limit_2_max2_re) begin
		linien_fast_b_limitcsr1_max_storage_full0[23:16] <= linien_csrbank3_x_limit_2_max2_r;
	end
	if (linien_csrbank3_x_limit_2_max1_re) begin
		linien_fast_b_limitcsr1_max_storage_full0[15:8] <= linien_csrbank3_x_limit_2_max1_r;
	end
	if (linien_csrbank3_x_limit_2_max0_re) begin
		linien_fast_b_limitcsr1_max_storage_full0[7:0] <= linien_csrbank3_x_limit_2_max0_r;
	end
	linien_fast_b_limitcsr1_max_re0 <= linien_csrbank3_x_limit_2_max0_re;
	if (linien_csrbank3_iir_c_2_z03_re) begin
		linien_fast_b_iir1_storage_full0[26:24] <= linien_csrbank3_iir_c_2_z03_r;
	end
	if (linien_csrbank3_iir_c_2_z02_re) begin
		linien_fast_b_iir1_storage_full0[23:16] <= linien_csrbank3_iir_c_2_z02_r;
	end
	if (linien_csrbank3_iir_c_2_z01_re) begin
		linien_fast_b_iir1_storage_full0[15:8] <= linien_csrbank3_iir_c_2_z01_r;
	end
	if (linien_csrbank3_iir_c_2_z00_re) begin
		linien_fast_b_iir1_storage_full0[7:0] <= linien_csrbank3_iir_c_2_z00_r;
	end
	linien_fast_b_iir1_re0 <= linien_csrbank3_iir_c_2_z00_re;
	if (linien_csrbank3_iir_c_2_a13_re) begin
		linien_fast_b_iir1_csrstorage3_storage_full[24] <= linien_csrbank3_iir_c_2_a13_r;
	end
	if (linien_csrbank3_iir_c_2_a12_re) begin
		linien_fast_b_iir1_csrstorage3_storage_full[23:16] <= linien_csrbank3_iir_c_2_a12_r;
	end
	if (linien_csrbank3_iir_c_2_a11_re) begin
		linien_fast_b_iir1_csrstorage3_storage_full[15:8] <= linien_csrbank3_iir_c_2_a11_r;
	end
	if (linien_csrbank3_iir_c_2_a10_re) begin
		linien_fast_b_iir1_csrstorage3_storage_full[7:0] <= linien_csrbank3_iir_c_2_a10_r;
	end
	linien_fast_b_iir1_csrstorage3_re <= linien_csrbank3_iir_c_2_a10_re;
	if (linien_csrbank3_iir_c_2_b03_re) begin
		linien_fast_b_iir1_csrstorage4_storage_full[24] <= linien_csrbank3_iir_c_2_b03_r;
	end
	if (linien_csrbank3_iir_c_2_b02_re) begin
		linien_fast_b_iir1_csrstorage4_storage_full[23:16] <= linien_csrbank3_iir_c_2_b02_r;
	end
	if (linien_csrbank3_iir_c_2_b01_re) begin
		linien_fast_b_iir1_csrstorage4_storage_full[15:8] <= linien_csrbank3_iir_c_2_b01_r;
	end
	if (linien_csrbank3_iir_c_2_b00_re) begin
		linien_fast_b_iir1_csrstorage4_storage_full[7:0] <= linien_csrbank3_iir_c_2_b00_r;
	end
	linien_fast_b_iir1_csrstorage4_re <= linien_csrbank3_iir_c_2_b00_re;
	if (linien_csrbank3_iir_c_2_b13_re) begin
		linien_fast_b_iir1_csrstorage5_storage_full0[24] <= linien_csrbank3_iir_c_2_b13_r;
	end
	if (linien_csrbank3_iir_c_2_b12_re) begin
		linien_fast_b_iir1_csrstorage5_storage_full0[23:16] <= linien_csrbank3_iir_c_2_b12_r;
	end
	if (linien_csrbank3_iir_c_2_b11_re) begin
		linien_fast_b_iir1_csrstorage5_storage_full0[15:8] <= linien_csrbank3_iir_c_2_b11_r;
	end
	if (linien_csrbank3_iir_c_2_b10_re) begin
		linien_fast_b_iir1_csrstorage5_storage_full0[7:0] <= linien_csrbank3_iir_c_2_b10_r;
	end
	linien_fast_b_iir1_csrstorage5_re0 <= linien_csrbank3_iir_c_2_b10_re;
	if (linien_csrbank3_iir_d_2_z03_re) begin
		linien_fast_b_iir1_storage_full1[26:24] <= linien_csrbank3_iir_d_2_z03_r;
	end
	if (linien_csrbank3_iir_d_2_z02_re) begin
		linien_fast_b_iir1_storage_full1[23:16] <= linien_csrbank3_iir_d_2_z02_r;
	end
	if (linien_csrbank3_iir_d_2_z01_re) begin
		linien_fast_b_iir1_storage_full1[15:8] <= linien_csrbank3_iir_d_2_z01_r;
	end
	if (linien_csrbank3_iir_d_2_z00_re) begin
		linien_fast_b_iir1_storage_full1[7:0] <= linien_csrbank3_iir_d_2_z00_r;
	end
	linien_fast_b_iir1_re1 <= linien_csrbank3_iir_d_2_z00_re;
	if (linien_csrbank3_iir_d_2_a13_re) begin
		linien_fast_b_iir1_csrstorage5_storage_full1[24] <= linien_csrbank3_iir_d_2_a13_r;
	end
	if (linien_csrbank3_iir_d_2_a12_re) begin
		linien_fast_b_iir1_csrstorage5_storage_full1[23:16] <= linien_csrbank3_iir_d_2_a12_r;
	end
	if (linien_csrbank3_iir_d_2_a11_re) begin
		linien_fast_b_iir1_csrstorage5_storage_full1[15:8] <= linien_csrbank3_iir_d_2_a11_r;
	end
	if (linien_csrbank3_iir_d_2_a10_re) begin
		linien_fast_b_iir1_csrstorage5_storage_full1[7:0] <= linien_csrbank3_iir_d_2_a10_r;
	end
	linien_fast_b_iir1_csrstorage5_re1 <= linien_csrbank3_iir_d_2_a10_re;
	if (linien_csrbank3_iir_d_2_a23_re) begin
		linien_fast_b_iir1_csrstorage6_storage_full[24] <= linien_csrbank3_iir_d_2_a23_r;
	end
	if (linien_csrbank3_iir_d_2_a22_re) begin
		linien_fast_b_iir1_csrstorage6_storage_full[23:16] <= linien_csrbank3_iir_d_2_a22_r;
	end
	if (linien_csrbank3_iir_d_2_a21_re) begin
		linien_fast_b_iir1_csrstorage6_storage_full[15:8] <= linien_csrbank3_iir_d_2_a21_r;
	end
	if (linien_csrbank3_iir_d_2_a20_re) begin
		linien_fast_b_iir1_csrstorage6_storage_full[7:0] <= linien_csrbank3_iir_d_2_a20_r;
	end
	linien_fast_b_iir1_csrstorage6_re <= linien_csrbank3_iir_d_2_a20_re;
	if (linien_csrbank3_iir_d_2_b03_re) begin
		linien_fast_b_iir1_csrstorage7_storage_full[24] <= linien_csrbank3_iir_d_2_b03_r;
	end
	if (linien_csrbank3_iir_d_2_b02_re) begin
		linien_fast_b_iir1_csrstorage7_storage_full[23:16] <= linien_csrbank3_iir_d_2_b02_r;
	end
	if (linien_csrbank3_iir_d_2_b01_re) begin
		linien_fast_b_iir1_csrstorage7_storage_full[15:8] <= linien_csrbank3_iir_d_2_b01_r;
	end
	if (linien_csrbank3_iir_d_2_b00_re) begin
		linien_fast_b_iir1_csrstorage7_storage_full[7:0] <= linien_csrbank3_iir_d_2_b00_r;
	end
	linien_fast_b_iir1_csrstorage7_re <= linien_csrbank3_iir_d_2_b00_re;
	if (linien_csrbank3_iir_d_2_b13_re) begin
		linien_fast_b_iir1_csrstorage8_storage_full[24] <= linien_csrbank3_iir_d_2_b13_r;
	end
	if (linien_csrbank3_iir_d_2_b12_re) begin
		linien_fast_b_iir1_csrstorage8_storage_full[23:16] <= linien_csrbank3_iir_d_2_b12_r;
	end
	if (linien_csrbank3_iir_d_2_b11_re) begin
		linien_fast_b_iir1_csrstorage8_storage_full[15:8] <= linien_csrbank3_iir_d_2_b11_r;
	end
	if (linien_csrbank3_iir_d_2_b10_re) begin
		linien_fast_b_iir1_csrstorage8_storage_full[7:0] <= linien_csrbank3_iir_d_2_b10_r;
	end
	linien_fast_b_iir1_csrstorage8_re <= linien_csrbank3_iir_d_2_b10_re;
	if (linien_csrbank3_iir_d_2_b23_re) begin
		linien_fast_b_iir1_csrstorage9_storage_full[24] <= linien_csrbank3_iir_d_2_b23_r;
	end
	if (linien_csrbank3_iir_d_2_b22_re) begin
		linien_fast_b_iir1_csrstorage9_storage_full[23:16] <= linien_csrbank3_iir_d_2_b22_r;
	end
	if (linien_csrbank3_iir_d_2_b21_re) begin
		linien_fast_b_iir1_csrstorage9_storage_full[15:8] <= linien_csrbank3_iir_d_2_b21_r;
	end
	if (linien_csrbank3_iir_d_2_b20_re) begin
		linien_fast_b_iir1_csrstorage9_storage_full[7:0] <= linien_csrbank3_iir_d_2_b20_r;
	end
	linien_fast_b_iir1_csrstorage9_re <= linien_csrbank3_iir_d_2_b20_re;
	if (linien_csrbank3_y_limit_2_min3_re) begin
		linien_fast_b_limitcsr1_min_storage_full1[24] <= linien_csrbank3_y_limit_2_min3_r;
	end
	if (linien_csrbank3_y_limit_2_min2_re) begin
		linien_fast_b_limitcsr1_min_storage_full1[23:16] <= linien_csrbank3_y_limit_2_min2_r;
	end
	if (linien_csrbank3_y_limit_2_min1_re) begin
		linien_fast_b_limitcsr1_min_storage_full1[15:8] <= linien_csrbank3_y_limit_2_min1_r;
	end
	if (linien_csrbank3_y_limit_2_min0_re) begin
		linien_fast_b_limitcsr1_min_storage_full1[7:0] <= linien_csrbank3_y_limit_2_min0_r;
	end
	linien_fast_b_limitcsr1_min_re1 <= linien_csrbank3_y_limit_2_min0_re;
	if (linien_csrbank3_y_limit_2_max3_re) begin
		linien_fast_b_limitcsr1_max_storage_full1[24] <= linien_csrbank3_y_limit_2_max3_r;
	end
	if (linien_csrbank3_y_limit_2_max2_re) begin
		linien_fast_b_limitcsr1_max_storage_full1[23:16] <= linien_csrbank3_y_limit_2_max2_r;
	end
	if (linien_csrbank3_y_limit_2_max1_re) begin
		linien_fast_b_limitcsr1_max_storage_full1[15:8] <= linien_csrbank3_y_limit_2_max1_r;
	end
	if (linien_csrbank3_y_limit_2_max0_re) begin
		linien_fast_b_limitcsr1_max_storage_full1[7:0] <= linien_csrbank3_y_limit_2_max0_r;
	end
	linien_fast_b_limitcsr1_max_re1 <= linien_csrbank3_y_limit_2_max0_re;
	if (linien_csrbank3_dx_sel0_re) begin
		linien_csrstorage10_storage_full[3:0] <= linien_csrbank3_dx_sel0_r;
	end
	linien_csrstorage10_re <= linien_csrbank3_dx_sel0_re;
	if (linien_csrbank3_dy_sel0_re) begin
		linien_csrstorage11_storage_full[3:0] <= linien_csrbank3_dy_sel0_r;
	end
	linien_csrstorage11_re <= linien_csrbank3_dy_sel0_re;
	linien_interface4_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank4_sel) begin
		case (linien_interface4_bank_bus_adr[4:0])
			1'd0: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_ins_w;
			end
			1'd1: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_outs0_w;
			end
			2'd2: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_oes0_w;
			end
			2'd3: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_state1_w;
			end
			3'd4: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_state0_w;
			end
			3'd5: begin
				linien_interface4_bank_bus_dat_r <= linien_state_clr_w;
			end
			3'd6: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do0_en1_w;
			end
			3'd7: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do0_en0_w;
			end
			4'd8: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do1_en1_w;
			end
			4'd9: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do1_en0_w;
			end
			4'd10: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do2_en1_w;
			end
			4'd11: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do2_en0_w;
			end
			4'd12: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do3_en1_w;
			end
			4'd13: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do3_en0_w;
			end
			4'd14: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do4_en1_w;
			end
			4'd15: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do4_en0_w;
			end
			5'd16: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do5_en1_w;
			end
			5'd17: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do5_en0_w;
			end
			5'd18: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do6_en1_w;
			end
			5'd19: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do6_en0_w;
			end
			5'd20: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do7_en1_w;
			end
			5'd21: begin
				linien_interface4_bank_bus_dat_r <= linien_csrbank4_do7_en0_w;
			end
		endcase
	end
	if (linien_csrbank4_outs0_re) begin
		linien_gpio_n_outs_storage_full[7:0] <= linien_csrbank4_outs0_r;
	end
	linien_gpio_n_outs_re <= linien_csrbank4_outs0_re;
	if (linien_csrbank4_oes0_re) begin
		linien_gpio_n_oes_storage_full[7:0] <= linien_csrbank4_oes0_r;
	end
	linien_gpio_n_oes_re <= linien_csrbank4_oes0_re;
	if (linien_csrbank4_do0_en1_re) begin
		linien_csrstorage0_storage_full[8] <= linien_csrbank4_do0_en1_r;
	end
	if (linien_csrbank4_do0_en0_re) begin
		linien_csrstorage0_storage_full[7:0] <= linien_csrbank4_do0_en0_r;
	end
	linien_csrstorage0_re <= linien_csrbank4_do0_en0_re;
	if (linien_csrbank4_do1_en1_re) begin
		linien_csrstorage1_storage_full[8] <= linien_csrbank4_do1_en1_r;
	end
	if (linien_csrbank4_do1_en0_re) begin
		linien_csrstorage1_storage_full[7:0] <= linien_csrbank4_do1_en0_r;
	end
	linien_csrstorage1_re <= linien_csrbank4_do1_en0_re;
	if (linien_csrbank4_do2_en1_re) begin
		linien_csrstorage2_storage_full[8] <= linien_csrbank4_do2_en1_r;
	end
	if (linien_csrbank4_do2_en0_re) begin
		linien_csrstorage2_storage_full[7:0] <= linien_csrbank4_do2_en0_r;
	end
	linien_csrstorage2_re <= linien_csrbank4_do2_en0_re;
	if (linien_csrbank4_do3_en1_re) begin
		linien_csrstorage3_storage_full[8] <= linien_csrbank4_do3_en1_r;
	end
	if (linien_csrbank4_do3_en0_re) begin
		linien_csrstorage3_storage_full[7:0] <= linien_csrbank4_do3_en0_r;
	end
	linien_csrstorage3_re <= linien_csrbank4_do3_en0_re;
	if (linien_csrbank4_do4_en1_re) begin
		linien_csrstorage4_storage_full[8] <= linien_csrbank4_do4_en1_r;
	end
	if (linien_csrbank4_do4_en0_re) begin
		linien_csrstorage4_storage_full[7:0] <= linien_csrbank4_do4_en0_r;
	end
	linien_csrstorage4_re <= linien_csrbank4_do4_en0_re;
	if (linien_csrbank4_do5_en1_re) begin
		linien_csrstorage5_storage_full[8] <= linien_csrbank4_do5_en1_r;
	end
	if (linien_csrbank4_do5_en0_re) begin
		linien_csrstorage5_storage_full[7:0] <= linien_csrbank4_do5_en0_r;
	end
	linien_csrstorage5_re <= linien_csrbank4_do5_en0_re;
	if (linien_csrbank4_do6_en1_re) begin
		linien_csrstorage6_storage_full[8] <= linien_csrbank4_do6_en1_r;
	end
	if (linien_csrbank4_do6_en0_re) begin
		linien_csrstorage6_storage_full[7:0] <= linien_csrbank4_do6_en0_r;
	end
	linien_csrstorage6_re <= linien_csrbank4_do6_en0_re;
	if (linien_csrbank4_do7_en1_re) begin
		linien_csrstorage7_storage_full[8] <= linien_csrbank4_do7_en1_r;
	end
	if (linien_csrbank4_do7_en0_re) begin
		linien_csrstorage7_storage_full[7:0] <= linien_csrbank4_do7_en0_r;
	end
	linien_csrstorage7_re <= linien_csrbank4_do7_en0_re;
	linien_interface5_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank5_sel) begin
		case (linien_interface5_bank_bus_adr[1:0])
			1'd0: begin
				linien_interface5_bank_bus_dat_r <= linien_csrbank5_ins_w;
			end
			1'd1: begin
				linien_interface5_bank_bus_dat_r <= linien_csrbank5_outs0_w;
			end
			2'd2: begin
				linien_interface5_bank_bus_dat_r <= linien_csrbank5_oes0_w;
			end
		endcase
	end
	if (linien_csrbank5_outs0_re) begin
		linien_gpio_p_outs_storage_full[7:0] <= linien_csrbank5_outs0_r;
	end
	linien_gpio_p_outs_re <= linien_csrbank5_outs0_re;
	if (linien_csrbank5_oes0_re) begin
		linien_gpio_p_oes_storage_full[7:0] <= linien_csrbank5_oes0_r;
	end
	linien_gpio_p_oes_re <= linien_csrbank5_oes0_re;
	linien_interface6_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank6_sel) begin
		case (linien_interface6_bank_bus_adr[3:0])
			1'd0: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_x_target_cmd3_w;
			end
			1'd1: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_x_target_cmd2_w;
			end
			2'd2: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_x_target_cmd1_w;
			end
			2'd3: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_x_target_cmd0_w;
			end
			3'd4: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_f_target_cmd3_w;
			end
			3'd5: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_f_target_cmd2_w;
			end
			3'd6: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_f_target_cmd1_w;
			end
			3'd7: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_f_target_cmd0_w;
			end
			4'd8: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_t_target_cmd3_w;
			end
			4'd9: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_t_target_cmd2_w;
			end
			4'd10: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_t_target_cmd1_w;
			end
			4'd11: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_t_target_cmd0_w;
			end
			4'd12: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_power_threshold_target_cmd3_w;
			end
			4'd13: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_power_threshold_target_cmd2_w;
			end
			4'd14: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_power_threshold_target_cmd1_w;
			end
			4'd15: begin
				linien_interface6_bank_bus_dat_r <= linien_csrbank6_power_threshold_target_cmd0_w;
			end
		endcase
	end
	if (linien_csrbank6_x_target_cmd3_re) begin
		linien_x_target_cmd_storage_full[24] <= linien_csrbank6_x_target_cmd3_r;
	end
	if (linien_csrbank6_x_target_cmd2_re) begin
		linien_x_target_cmd_storage_full[23:16] <= linien_csrbank6_x_target_cmd2_r;
	end
	if (linien_csrbank6_x_target_cmd1_re) begin
		linien_x_target_cmd_storage_full[15:8] <= linien_csrbank6_x_target_cmd1_r;
	end
	if (linien_csrbank6_x_target_cmd0_re) begin
		linien_x_target_cmd_storage_full[7:0] <= linien_csrbank6_x_target_cmd0_r;
	end
	linien_x_target_cmd_re <= linien_csrbank6_x_target_cmd0_re;
	if (linien_csrbank6_f_target_cmd3_re) begin
		linien_f_target_cmd_storage_full[24] <= linien_csrbank6_f_target_cmd3_r;
	end
	if (linien_csrbank6_f_target_cmd2_re) begin
		linien_f_target_cmd_storage_full[23:16] <= linien_csrbank6_f_target_cmd2_r;
	end
	if (linien_csrbank6_f_target_cmd1_re) begin
		linien_f_target_cmd_storage_full[15:8] <= linien_csrbank6_f_target_cmd1_r;
	end
	if (linien_csrbank6_f_target_cmd0_re) begin
		linien_f_target_cmd_storage_full[7:0] <= linien_csrbank6_f_target_cmd0_r;
	end
	linien_f_target_cmd_re <= linien_csrbank6_f_target_cmd0_re;
	if (linien_csrbank6_t_target_cmd3_re) begin
		linien_t_target_cmd_storage_full[24] <= linien_csrbank6_t_target_cmd3_r;
	end
	if (linien_csrbank6_t_target_cmd2_re) begin
		linien_t_target_cmd_storage_full[23:16] <= linien_csrbank6_t_target_cmd2_r;
	end
	if (linien_csrbank6_t_target_cmd1_re) begin
		linien_t_target_cmd_storage_full[15:8] <= linien_csrbank6_t_target_cmd1_r;
	end
	if (linien_csrbank6_t_target_cmd0_re) begin
		linien_t_target_cmd_storage_full[7:0] <= linien_csrbank6_t_target_cmd0_r;
	end
	linien_t_target_cmd_re <= linien_csrbank6_t_target_cmd0_re;
	if (linien_csrbank6_power_threshold_target_cmd3_re) begin
		linien_power_threshold_target_cmd_storage_full[24] <= linien_csrbank6_power_threshold_target_cmd3_r;
	end
	if (linien_csrbank6_power_threshold_target_cmd2_re) begin
		linien_power_threshold_target_cmd_storage_full[23:16] <= linien_csrbank6_power_threshold_target_cmd2_r;
	end
	if (linien_csrbank6_power_threshold_target_cmd1_re) begin
		linien_power_threshold_target_cmd_storage_full[15:8] <= linien_csrbank6_power_threshold_target_cmd1_r;
	end
	if (linien_csrbank6_power_threshold_target_cmd0_re) begin
		linien_power_threshold_target_cmd_storage_full[7:0] <= linien_csrbank6_power_threshold_target_cmd0_r;
	end
	linien_power_threshold_target_cmd_re <= linien_csrbank6_power_threshold_target_cmd0_re;
	linien_interface7_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank7_sel) begin
		case (linien_interface7_bank_bus_adr[5:0])
			1'd0: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_only_mode0_w;
			end
			1'd1: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_chain_a_factor1_w;
			end
			2'd2: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_chain_a_factor0_w;
			end
			2'd3: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_chain_b_factor1_w;
			end
			3'd4: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_chain_b_factor0_w;
			end
			3'd5: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_chain_a_offset1_w;
			end
			3'd6: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_chain_a_offset0_w;
			end
			3'd7: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_chain_b_offset1_w;
			end
			4'd8: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_chain_b_offset0_w;
			end
			4'd9: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_combined_offset1_w;
			end
			4'd10: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_combined_offset0_w;
			end
			4'd11: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_out_offset1_w;
			end
			4'd12: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_out_offset0_w;
			end
			4'd13: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_slow_decimation0_w;
			end
			4'd14: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_analog_out_11_w;
			end
			4'd15: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_analog_out_10_w;
			end
			5'd16: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_analog_out_21_w;
			end
			5'd17: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_analog_out_20_w;
			end
			5'd18: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_analog_out_31_w;
			end
			5'd19: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_analog_out_30_w;
			end
			5'd20: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_slow_value1_w;
			end
			5'd21: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_slow_value0_w;
			end
			5'd22: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_mod_amp1_w;
			end
			5'd23: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_mod_amp0_w;
			end
			5'd24: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_mod_freq3_w;
			end
			5'd25: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_mod_freq2_w;
			end
			5'd26: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_mod_freq1_w;
			end
			5'd27: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_mod_freq0_w;
			end
			5'd28: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_error_signal_min3_w;
			end
			5'd29: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_error_signal_min2_w;
			end
			5'd30: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_error_signal_min1_w;
			end
			5'd31: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_error_signal_min0_w;
			end
			6'd32: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_error_signal_max3_w;
			end
			6'd33: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_error_signal_max2_w;
			end
			6'd34: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_error_signal_max1_w;
			end
			6'd35: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_error_signal_max0_w;
			end
			6'd36: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_fast1_min1_w;
			end
			6'd37: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_fast1_min0_w;
			end
			6'd38: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_fast1_max1_w;
			end
			6'd39: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_fast1_max0_w;
			end
			6'd40: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_fast2_min1_w;
			end
			6'd41: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_fast2_min0_w;
			end
			6'd42: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_fast2_max1_w;
			end
			6'd43: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_limit_fast2_max0_w;
			end
			6'd44: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_setpoint3_w;
			end
			6'd45: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_setpoint2_w;
			end
			6'd46: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_setpoint1_w;
			end
			6'd47: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_setpoint0_w;
			end
			6'd48: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_kp1_w;
			end
			6'd49: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_kp0_w;
			end
			6'd50: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_ki1_w;
			end
			6'd51: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_ki0_w;
			end
			6'd52: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_reset0_w;
			end
			6'd53: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_kd1_w;
			end
			6'd54: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_pid_kd0_w;
			end
			6'd55: begin
				linien_interface7_bank_bus_dat_r <= linien_control_signal_clr_w;
			end
			6'd56: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_control_signal_max1_w;
			end
			6'd57: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_control_signal_max0_w;
			end
			6'd58: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_control_signal_min1_w;
			end
			6'd59: begin
				linien_interface7_bank_bus_dat_r <= linien_csrbank7_control_signal_min0_w;
			end
		endcase
	end
	if (linien_csrbank7_pid_only_mode0_re) begin
		linien_logic_pid_only_mode_storage_full <= linien_csrbank7_pid_only_mode0_r;
	end
	linien_logic_pid_only_mode_re <= linien_csrbank7_pid_only_mode0_re;
	if (linien_csrbank7_chain_a_factor1_re) begin
		linien_logic_chain_a_factor_storage_full[8] <= linien_csrbank7_chain_a_factor1_r;
	end
	if (linien_csrbank7_chain_a_factor0_re) begin
		linien_logic_chain_a_factor_storage_full[7:0] <= linien_csrbank7_chain_a_factor0_r;
	end
	linien_logic_chain_a_factor_re <= linien_csrbank7_chain_a_factor0_re;
	if (linien_csrbank7_chain_b_factor1_re) begin
		linien_logic_chain_b_factor_storage_full[8] <= linien_csrbank7_chain_b_factor1_r;
	end
	if (linien_csrbank7_chain_b_factor0_re) begin
		linien_logic_chain_b_factor_storage_full[7:0] <= linien_csrbank7_chain_b_factor0_r;
	end
	linien_logic_chain_b_factor_re <= linien_csrbank7_chain_b_factor0_re;
	if (linien_csrbank7_chain_a_offset1_re) begin
		linien_logic_chain_a_offset_storage_full[13:8] <= linien_csrbank7_chain_a_offset1_r;
	end
	if (linien_csrbank7_chain_a_offset0_re) begin
		linien_logic_chain_a_offset_storage_full[7:0] <= linien_csrbank7_chain_a_offset0_r;
	end
	linien_logic_chain_a_offset_re <= linien_csrbank7_chain_a_offset0_re;
	if (linien_csrbank7_chain_b_offset1_re) begin
		linien_logic_chain_b_offset_storage_full[13:8] <= linien_csrbank7_chain_b_offset1_r;
	end
	if (linien_csrbank7_chain_b_offset0_re) begin
		linien_logic_chain_b_offset_storage_full[7:0] <= linien_csrbank7_chain_b_offset0_r;
	end
	linien_logic_chain_b_offset_re <= linien_csrbank7_chain_b_offset0_re;
	if (linien_csrbank7_combined_offset1_re) begin
		linien_logic_combined_offset_storage_full[13:8] <= linien_csrbank7_combined_offset1_r;
	end
	if (linien_csrbank7_combined_offset0_re) begin
		linien_logic_combined_offset_storage_full[7:0] <= linien_csrbank7_combined_offset0_r;
	end
	linien_logic_combined_offset_re <= linien_csrbank7_combined_offset0_re;
	if (linien_csrbank7_out_offset1_re) begin
		linien_logic_out_offset_storage_full[13:8] <= linien_csrbank7_out_offset1_r;
	end
	if (linien_csrbank7_out_offset0_re) begin
		linien_logic_out_offset_storage_full[7:0] <= linien_csrbank7_out_offset0_r;
	end
	linien_logic_out_offset_re <= linien_csrbank7_out_offset0_re;
	if (linien_csrbank7_slow_decimation0_re) begin
		linien_logic_slow_decimation_storage_full[4:0] <= linien_csrbank7_slow_decimation0_r;
	end
	linien_logic_slow_decimation_re <= linien_csrbank7_slow_decimation0_re;
	if (linien_csrbank7_analog_out_11_re) begin
		linien_logic_csrstorage0_storage_full[14:8] <= linien_csrbank7_analog_out_11_r;
	end
	if (linien_csrbank7_analog_out_10_re) begin
		linien_logic_csrstorage0_storage_full[7:0] <= linien_csrbank7_analog_out_10_r;
	end
	linien_logic_csrstorage0_re <= linien_csrbank7_analog_out_10_re;
	if (linien_csrbank7_analog_out_21_re) begin
		linien_logic_csrstorage1_storage_full[14:8] <= linien_csrbank7_analog_out_21_r;
	end
	if (linien_csrbank7_analog_out_20_re) begin
		linien_logic_csrstorage1_storage_full[7:0] <= linien_csrbank7_analog_out_20_r;
	end
	linien_logic_csrstorage1_re <= linien_csrbank7_analog_out_20_re;
	if (linien_csrbank7_analog_out_31_re) begin
		linien_logic_csrstorage2_storage_full[14:8] <= linien_csrbank7_analog_out_31_r;
	end
	if (linien_csrbank7_analog_out_30_re) begin
		linien_logic_csrstorage2_storage_full[7:0] <= linien_csrbank7_analog_out_30_r;
	end
	linien_logic_csrstorage2_re <= linien_csrbank7_analog_out_30_re;
	if (linien_csrbank7_mod_amp1_re) begin
		linien_logic_amp_storage_full[13:8] <= linien_csrbank7_mod_amp1_r;
	end
	if (linien_csrbank7_mod_amp0_re) begin
		linien_logic_amp_storage_full[7:0] <= linien_csrbank7_mod_amp0_r;
	end
	linien_logic_amp_re <= linien_csrbank7_mod_amp0_re;
	if (linien_csrbank7_mod_freq3_re) begin
		linien_logic_freq_storage_full[31:24] <= linien_csrbank7_mod_freq3_r;
	end
	if (linien_csrbank7_mod_freq2_re) begin
		linien_logic_freq_storage_full[23:16] <= linien_csrbank7_mod_freq2_r;
	end
	if (linien_csrbank7_mod_freq1_re) begin
		linien_logic_freq_storage_full[15:8] <= linien_csrbank7_mod_freq1_r;
	end
	if (linien_csrbank7_mod_freq0_re) begin
		linien_logic_freq_storage_full[7:0] <= linien_csrbank7_mod_freq0_r;
	end
	linien_logic_freq_re <= linien_csrbank7_mod_freq0_re;
	if (linien_csrbank7_limit_error_signal_min3_re) begin
		linien_logic_limit_error_signal_min_storage_full[24] <= linien_csrbank7_limit_error_signal_min3_r;
	end
	if (linien_csrbank7_limit_error_signal_min2_re) begin
		linien_logic_limit_error_signal_min_storage_full[23:16] <= linien_csrbank7_limit_error_signal_min2_r;
	end
	if (linien_csrbank7_limit_error_signal_min1_re) begin
		linien_logic_limit_error_signal_min_storage_full[15:8] <= linien_csrbank7_limit_error_signal_min1_r;
	end
	if (linien_csrbank7_limit_error_signal_min0_re) begin
		linien_logic_limit_error_signal_min_storage_full[7:0] <= linien_csrbank7_limit_error_signal_min0_r;
	end
	linien_logic_limit_error_signal_min_re <= linien_csrbank7_limit_error_signal_min0_re;
	if (linien_csrbank7_limit_error_signal_max3_re) begin
		linien_logic_limit_error_signal_max_storage_full[24] <= linien_csrbank7_limit_error_signal_max3_r;
	end
	if (linien_csrbank7_limit_error_signal_max2_re) begin
		linien_logic_limit_error_signal_max_storage_full[23:16] <= linien_csrbank7_limit_error_signal_max2_r;
	end
	if (linien_csrbank7_limit_error_signal_max1_re) begin
		linien_logic_limit_error_signal_max_storage_full[15:8] <= linien_csrbank7_limit_error_signal_max1_r;
	end
	if (linien_csrbank7_limit_error_signal_max0_re) begin
		linien_logic_limit_error_signal_max_storage_full[7:0] <= linien_csrbank7_limit_error_signal_max0_r;
	end
	linien_logic_limit_error_signal_max_re <= linien_csrbank7_limit_error_signal_max0_re;
	if (linien_csrbank7_limit_fast1_min1_re) begin
		linien_logic_limit_fast1_min_storage_full[13:8] <= linien_csrbank7_limit_fast1_min1_r;
	end
	if (linien_csrbank7_limit_fast1_min0_re) begin
		linien_logic_limit_fast1_min_storage_full[7:0] <= linien_csrbank7_limit_fast1_min0_r;
	end
	linien_logic_limit_fast1_min_re <= linien_csrbank7_limit_fast1_min0_re;
	if (linien_csrbank7_limit_fast1_max1_re) begin
		linien_logic_limit_fast1_max_storage_full[13:8] <= linien_csrbank7_limit_fast1_max1_r;
	end
	if (linien_csrbank7_limit_fast1_max0_re) begin
		linien_logic_limit_fast1_max_storage_full[7:0] <= linien_csrbank7_limit_fast1_max0_r;
	end
	linien_logic_limit_fast1_max_re <= linien_csrbank7_limit_fast1_max0_re;
	if (linien_csrbank7_limit_fast2_min1_re) begin
		linien_logic_limit_fast2_min_storage_full[13:8] <= linien_csrbank7_limit_fast2_min1_r;
	end
	if (linien_csrbank7_limit_fast2_min0_re) begin
		linien_logic_limit_fast2_min_storage_full[7:0] <= linien_csrbank7_limit_fast2_min0_r;
	end
	linien_logic_limit_fast2_min_re <= linien_csrbank7_limit_fast2_min0_re;
	if (linien_csrbank7_limit_fast2_max1_re) begin
		linien_logic_limit_fast2_max_storage_full[13:8] <= linien_csrbank7_limit_fast2_max1_r;
	end
	if (linien_csrbank7_limit_fast2_max0_re) begin
		linien_logic_limit_fast2_max_storage_full[7:0] <= linien_csrbank7_limit_fast2_max0_r;
	end
	linien_logic_limit_fast2_max_re <= linien_csrbank7_limit_fast2_max0_re;
	if (linien_csrbank7_pid_setpoint3_re) begin
		linien_logic_setpoint_storage_full[24] <= linien_csrbank7_pid_setpoint3_r;
	end
	if (linien_csrbank7_pid_setpoint2_re) begin
		linien_logic_setpoint_storage_full[23:16] <= linien_csrbank7_pid_setpoint2_r;
	end
	if (linien_csrbank7_pid_setpoint1_re) begin
		linien_logic_setpoint_storage_full[15:8] <= linien_csrbank7_pid_setpoint1_r;
	end
	if (linien_csrbank7_pid_setpoint0_re) begin
		linien_logic_setpoint_storage_full[7:0] <= linien_csrbank7_pid_setpoint0_r;
	end
	linien_logic_setpoint_re <= linien_csrbank7_pid_setpoint0_re;
	if (linien_csrbank7_pid_kp1_re) begin
		linien_logic_kp_storage_full[13:8] <= linien_csrbank7_pid_kp1_r;
	end
	if (linien_csrbank7_pid_kp0_re) begin
		linien_logic_kp_storage_full[7:0] <= linien_csrbank7_pid_kp0_r;
	end
	linien_logic_kp_re <= linien_csrbank7_pid_kp0_re;
	if (linien_csrbank7_pid_ki1_re) begin
		linien_logic_ki_storage_full[13:8] <= linien_csrbank7_pid_ki1_r;
	end
	if (linien_csrbank7_pid_ki0_re) begin
		linien_logic_ki_storage_full[7:0] <= linien_csrbank7_pid_ki0_r;
	end
	linien_logic_ki_re <= linien_csrbank7_pid_ki0_re;
	if (linien_csrbank7_pid_reset0_re) begin
		linien_logic_reset_storage_full <= linien_csrbank7_pid_reset0_r;
	end
	linien_logic_reset_re <= linien_csrbank7_pid_reset0_re;
	if (linien_csrbank7_pid_kd1_re) begin
		linien_logic_kd_storage_full[13:8] <= linien_csrbank7_pid_kd1_r;
	end
	if (linien_csrbank7_pid_kd0_re) begin
		linien_logic_kd_storage_full[7:0] <= linien_csrbank7_pid_kd0_r;
	end
	linien_logic_kd_re <= linien_csrbank7_pid_kd0_re;
	linien_interface8_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank8_sel) begin
		case (linien_interface8_bank_bus_adr[3:0])
			1'd0: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_fsm_state_w;
			end
			1'd1: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out3_w;
			end
			2'd2: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out2_w;
			end
			2'd3: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out1_w;
			end
			3'd4: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out0_w;
			end
			3'd5: begin
				linien_interface8_bank_bus_dat_r <= linien_time_command_out_clr_w;
			end
			3'd6: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out_max3_w;
			end
			3'd7: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out_max2_w;
			end
			4'd8: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out_max1_w;
			end
			4'd9: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out_max0_w;
			end
			4'd10: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out_min3_w;
			end
			4'd11: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out_min2_w;
			end
			4'd12: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out_min1_w;
			end
			4'd13: begin
				linien_interface8_bank_bus_dat_r <= linien_csrbank8_time_command_out_min0_w;
			end
		endcase
	end
	linien_interface9_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank9_sel) begin
		case (linien_interface9_bank_bus_adr[4:0])
			1'd0: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_external_trigger0_w;
			end
			1'd1: begin
				linien_interface9_bank_bus_dat_r <= linien_dac_a_clr_w;
			end
			2'd2: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_a_max3_w;
			end
			2'd3: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_a_max2_w;
			end
			3'd4: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_a_max1_w;
			end
			3'd5: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_a_max0_w;
			end
			3'd6: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_a_min3_w;
			end
			3'd7: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_a_min2_w;
			end
			4'd8: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_a_min1_w;
			end
			4'd9: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_a_min0_w;
			end
			4'd10: begin
				linien_interface9_bank_bus_dat_r <= linien_dac_b_clr_w;
			end
			4'd11: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_b_max3_w;
			end
			4'd12: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_b_max2_w;
			end
			4'd13: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_b_max1_w;
			end
			4'd14: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_b_max0_w;
			end
			4'd15: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_b_min3_w;
			end
			5'd16: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_b_min2_w;
			end
			5'd17: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_b_min1_w;
			end
			5'd18: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_dac_b_min0_w;
			end
			5'd19: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_adc_a_sel0_w;
			end
			5'd20: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_adc_b_sel0_w;
			end
			5'd21: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_adc_a_q_sel0_w;
			end
			5'd22: begin
				linien_interface9_bank_bus_dat_r <= linien_csrbank9_adc_b_q_sel0_w;
			end
		endcase
	end
	if (linien_csrbank9_external_trigger0_re) begin
		linien_scopegen_storage_full <= linien_csrbank9_external_trigger0_r;
	end
	linien_scopegen_re <= linien_csrbank9_external_trigger0_re;
	if (linien_csrbank9_adc_a_sel0_re) begin
		linien_csrstorage12_storage_full[3:0] <= linien_csrbank9_adc_a_sel0_r;
	end
	linien_csrstorage12_re <= linien_csrbank9_adc_a_sel0_re;
	if (linien_csrbank9_adc_b_sel0_re) begin
		linien_csrstorage13_storage_full[3:0] <= linien_csrbank9_adc_b_sel0_r;
	end
	linien_csrstorage13_re <= linien_csrbank9_adc_b_sel0_re;
	if (linien_csrbank9_adc_a_q_sel0_re) begin
		linien_csrstorage14_storage_full[3:0] <= linien_csrbank9_adc_a_q_sel0_r;
	end
	linien_csrstorage14_re <= linien_csrbank9_adc_a_q_sel0_re;
	if (linien_csrbank9_adc_b_q_sel0_re) begin
		linien_csrstorage15_storage_full[3:0] <= linien_csrbank9_adc_b_q_sel0_r;
	end
	linien_csrstorage15_re <= linien_csrbank9_adc_b_q_sel0_re;
	linien_interface10_bank_bus_dat_r <= 1'd0;
	if (linien_csrbank10_sel) begin
		case (linien_interface10_bank_bus_adr[3:0])
			1'd0: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_temp1_w;
			end
			1'd1: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_temp0_w;
			end
			2'd2: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_v1_w;
			end
			2'd3: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_v0_w;
			end
			3'd4: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_a1_w;
			end
			3'd5: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_a0_w;
			end
			3'd6: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_b1_w;
			end
			3'd7: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_b0_w;
			end
			4'd8: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_c1_w;
			end
			4'd9: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_c0_w;
			end
			4'd10: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_d1_w;
			end
			4'd11: begin
				linien_interface10_bank_bus_dat_r <= linien_csrbank10_d0_w;
			end
		endcase
	end
	linien_stb <= (linien_sys_wen | linien_sys_ren);
	linien_csr_adr <= linien_sys_addr[31:2];
	linien_csr_we <= linien_sys_wen;
	linien_csr_dat_w <= linien_sys_wdata;
	linien_sys_ack <= linien_stb;
	linien_sys_rdata <= linien_csr_dat_r;
	if (sys_rst) begin
		linien_logic_pid_only_mode_storage_full <= 1'd0;
		linien_logic_pid_only_mode_re <= 1'd0;
		linien_logic_chain_a_factor_storage_full <= 9'd128;
		linien_logic_chain_a_factor_re <= 1'd0;
		linien_logic_chain_b_factor_storage_full <= 9'd128;
		linien_logic_chain_b_factor_re <= 1'd0;
		linien_logic_chain_a_offset_storage_full <= 14'd0;
		linien_logic_chain_a_offset_re <= 1'd0;
		linien_logic_chain_b_offset_storage_full <= 14'd0;
		linien_logic_chain_b_offset_re <= 1'd0;
		linien_logic_combined_offset_storage_full <= 14'd0;
		linien_logic_combined_offset_re <= 1'd0;
		linien_logic_out_offset_storage_full <= 14'd0;
		linien_logic_out_offset_re <= 1'd0;
		linien_logic_slow_decimation_storage_full <= 5'd0;
		linien_logic_slow_decimation_re <= 1'd0;
		linien_logic_csrstorage0_storage_full <= 15'd0;
		linien_logic_csrstorage0_re <= 1'd0;
		linien_logic_csrstorage1_storage_full <= 15'd0;
		linien_logic_csrstorage1_re <= 1'd0;
		linien_logic_csrstorage2_storage_full <= 15'd0;
		linien_logic_csrstorage2_re <= 1'd0;
		linien_logic_amp_storage_full <= 14'd0;
		linien_logic_amp_re <= 1'd0;
		linien_logic_freq_storage_full <= 32'd0;
		linien_logic_freq_re <= 1'd0;
		linien_logic_z <= 32'd0;
		linien_logic_stop <= 1'd0;
		linien_logic_cordic_x1 <= 17'sd0;
		linien_logic_cordic_x2 <= 17'sd0;
		linien_logic_cordic_x3 <= 17'sd0;
		linien_logic_cordic_x4 <= 17'sd0;
		linien_logic_cordic_x5 <= 17'sd0;
		linien_logic_cordic_x6 <= 17'sd0;
		linien_logic_cordic_x7 <= 17'sd0;
		linien_logic_cordic_x8 <= 17'sd0;
		linien_logic_cordic_x9 <= 17'sd0;
		linien_logic_cordic_x10 <= 17'sd0;
		linien_logic_cordic_x11 <= 17'sd0;
		linien_logic_cordic_x12 <= 17'sd0;
		linien_logic_cordic_x13 <= 17'sd0;
		linien_logic_cordic_x14 <= 17'sd0;
		linien_logic_cordic_x15 <= 17'sd0;
		linien_logic_cordic_y1 <= 17'sd0;
		linien_logic_cordic_y2 <= 17'sd0;
		linien_logic_cordic_y3 <= 17'sd0;
		linien_logic_cordic_y4 <= 17'sd0;
		linien_logic_cordic_y5 <= 17'sd0;
		linien_logic_cordic_y6 <= 17'sd0;
		linien_logic_cordic_y7 <= 17'sd0;
		linien_logic_cordic_y8 <= 17'sd0;
		linien_logic_cordic_y9 <= 17'sd0;
		linien_logic_cordic_y10 <= 17'sd0;
		linien_logic_cordic_y11 <= 17'sd0;
		linien_logic_cordic_y12 <= 17'sd0;
		linien_logic_cordic_y13 <= 17'sd0;
		linien_logic_cordic_y14 <= 17'sd0;
		linien_logic_cordic_y15 <= 17'sd0;
		linien_logic_cordic_z1 <= 17'sd0;
		linien_logic_cordic_z2 <= 17'sd0;
		linien_logic_cordic_z3 <= 17'sd0;
		linien_logic_cordic_z4 <= 17'sd0;
		linien_logic_cordic_z5 <= 17'sd0;
		linien_logic_cordic_z6 <= 17'sd0;
		linien_logic_cordic_z7 <= 17'sd0;
		linien_logic_cordic_z8 <= 17'sd0;
		linien_logic_cordic_z9 <= 17'sd0;
		linien_logic_cordic_z10 <= 17'sd0;
		linien_logic_cordic_z11 <= 17'sd0;
		linien_logic_cordic_z12 <= 17'sd0;
		linien_logic_cordic_z13 <= 17'sd0;
		linien_logic_cordic_z14 <= 17'sd0;
		linien_logic_cordic_z15 <= 17'sd0;
		linien_logic_limit_error_signal_limitcsr_y <= 25'sd0;
		linien_logic_limit_error_signal_limitcsr_error <= 1'd0;
		linien_logic_limit_error_signal_min_storage_full <= 25'd16777216;
		linien_logic_limit_error_signal_min_re <= 1'd0;
		linien_logic_limit_error_signal_max_storage_full <= 25'd16777215;
		linien_logic_limit_error_signal_max_re <= 1'd0;
		linien_logic_limit_error_signal_limit_max <= 29'sd0;
		linien_logic_limit_error_signal_limit_min <= 29'sd0;
		linien_logic_limit_fast1_limitcsr_y <= 14'sd0;
		linien_logic_limit_fast1_limitcsr_error <= 1'd0;
		linien_logic_limit_fast1_min_storage_full <= 14'd8192;
		linien_logic_limit_fast1_min_re <= 1'd0;
		linien_logic_limit_fast1_max_storage_full <= 14'd8191;
		linien_logic_limit_fast1_max_re <= 1'd0;
		linien_logic_limit_fast1_limit_max <= 19'sd0;
		linien_logic_limit_fast1_limit_min <= 19'sd0;
		linien_logic_limit_fast2_limitcsr_y <= 14'sd0;
		linien_logic_limit_fast2_limitcsr_error <= 1'd0;
		linien_logic_limit_fast2_min_storage_full <= 14'd8192;
		linien_logic_limit_fast2_min_re <= 1'd0;
		linien_logic_limit_fast2_max_storage_full <= 14'd8191;
		linien_logic_limit_fast2_max_re <= 1'd0;
		linien_logic_limit_fast2_limit_max <= 19'sd0;
		linien_logic_limit_fast2_limit_min <= 19'sd0;
		linien_logic_setpoint_storage_full <= 25'd0;
		linien_logic_setpoint_re <= 1'd0;
		linien_logic_kp_storage_full <= 14'd0;
		linien_logic_kp_re <= 1'd0;
		linien_logic_ki_storage_full <= 14'd0;
		linien_logic_ki_re <= 1'd0;
		linien_logic_reset_storage_full <= 1'd0;
		linien_logic_reset_re <= 1'd0;
		linien_logic_int_reg <= 43'sd0;
		linien_logic_kd_storage_full <= 14'd0;
		linien_logic_kd_re <= 1'd0;
		linien_logic_kd_reg <= 34'sd0;
		linien_logic_kd_reg_r <= 34'sd0;
		linien_logic_output_d <= 34'sd0;
		linien_logic_pid_sum <= 84'sd0;
		linien_analog_adca <= 16'd0;
		linien_analog_adcb <= 16'd0;
		linien_analog_daca <= 14'd0;
		linien_analog_dacb <= 14'd0;
		linien_xadc_temp_status <= 12'd0;
		linien_xadc_v_status <= 12'd0;
		linien_xadc_a_status <= 12'd0;
		linien_xadc_b_status <= 12'd0;
		linien_xadc_c_status <= 12'd0;
		linien_xadc_d_status <= 12'd0;
		linien_gpio_n_o <= 8'd0;
		linien_gpio_n_outs_storage_full <= 8'd0;
		linien_gpio_n_outs_re <= 1'd0;
		linien_gpio_n_oes_storage_full <= 8'd0;
		linien_gpio_n_oes_re <= 1'd0;
		linien_gpio_p_outs_storage_full <= 8'd0;
		linien_gpio_p_outs_re <= 1'd0;
		linien_gpio_p_oes_storage_full <= 8'd0;
		linien_gpio_p_oes_re <= 1'd0;
		linien_dna_status <= 64'd288230376151711744;
		linien_dna_cnt <= 8'd0;
		linien_fast_a_y_tap_storage_full <= 2'd0;
		linien_fast_a_y_tap_re <= 1'd0;
		linien_fast_a_invert_storage_full <= 1'd0;
		linien_fast_a_invert_re <= 1'd0;
		linien_fast_a_dx <= 25'sd0;
		linien_fast_a_dy <= 25'sd0;
		linien_fast_a_delay_storage_full <= 32'd0;
		linien_fast_a_delay_re <= 1'd0;
		linien_fast_a_multiplier_storage_full <= 4'd1;
		linien_fast_a_multiplier_re <= 1'd0;
		linien_fast_a_x3 <= 17'sd0;
		linien_fast_a_x4 <= 17'sd0;
		linien_fast_a_x5 <= 17'sd0;
		linien_fast_a_x6 <= 17'sd0;
		linien_fast_a_x7 <= 17'sd0;
		linien_fast_a_x8 <= 17'sd0;
		linien_fast_a_x9 <= 17'sd0;
		linien_fast_a_x10 <= 17'sd0;
		linien_fast_a_x11 <= 17'sd0;
		linien_fast_a_x12 <= 17'sd0;
		linien_fast_a_x13 <= 17'sd0;
		linien_fast_a_x14 <= 17'sd0;
		linien_fast_a_x15 <= 17'sd0;
		linien_fast_a_x16 <= 17'sd0;
		linien_fast_a_x17 <= 17'sd0;
		linien_fast_a_y1 <= 17'sd0;
		linien_fast_a_y2 <= 17'sd0;
		linien_fast_a_y3 <= 17'sd0;
		linien_fast_a_y4 <= 17'sd0;
		linien_fast_a_y5 <= 17'sd0;
		linien_fast_a_y6 <= 17'sd0;
		linien_fast_a_y7 <= 17'sd0;
		linien_fast_a_y8 <= 17'sd0;
		linien_fast_a_y9 <= 17'sd0;
		linien_fast_a_y10 <= 17'sd0;
		linien_fast_a_y11 <= 17'sd0;
		linien_fast_a_y12 <= 17'sd0;
		linien_fast_a_y13 <= 17'sd0;
		linien_fast_a_y14 <= 17'sd0;
		linien_fast_a_y15 <= 17'sd0;
		linien_fast_a_z1 <= 17'sd0;
		linien_fast_a_z2 <= 17'sd0;
		linien_fast_a_z3 <= 17'sd0;
		linien_fast_a_z4 <= 17'sd0;
		linien_fast_a_z5 <= 17'sd0;
		linien_fast_a_z6 <= 17'sd0;
		linien_fast_a_z7 <= 17'sd0;
		linien_fast_a_z8 <= 17'sd0;
		linien_fast_a_z9 <= 17'sd0;
		linien_fast_a_z10 <= 17'sd0;
		linien_fast_a_z11 <= 17'sd0;
		linien_fast_a_z12 <= 17'sd0;
		linien_fast_a_z13 <= 17'sd0;
		linien_fast_a_z14 <= 17'sd0;
		linien_fast_a_z15 <= 17'sd0;
		linien_fast_a_ya <= 17'sd0;
		linien_fast_a_limitcsr0_limitcsr0_y0 <= 25'sd0;
		linien_fast_a_limitcsr0_limitcsr0_error0 <= 1'd0;
		linien_fast_a_limitcsr0_min_storage_full0 <= 25'd16777216;
		linien_fast_a_limitcsr0_min_re0 <= 1'd0;
		linien_fast_a_limitcsr0_max_storage_full0 <= 25'd16777215;
		linien_fast_a_limitcsr0_max_re0 <= 1'd0;
		linien_fast_a_limitcsr0_limit_max0 <= 26'sd0;
		linien_fast_a_limitcsr0_limit_min0 <= 26'sd0;
		linien_fast_a_iir0_y0 <= 25'sd0;
		linien_fast_a_iir0_error0 <= 1'd0;
		linien_fast_a_iir0_storage_full0 <= 27'd0;
		linien_fast_a_iir0_re0 <= 1'd0;
		linien_fast_a_iir0_a10 <= 25'sd0;
		linien_fast_a_iir0_csrstorage0_storage_full0 <= 25'd0;
		linien_fast_a_iir0_csrstorage0_re0 <= 1'd0;
		linien_fast_a_iir0_b00 <= 25'sd0;
		linien_fast_a_iir0_csrstorage1_storage_full0 <= 25'd0;
		linien_fast_a_iir0_csrstorage1_re0 <= 1'd0;
		linien_fast_a_iir0_b10 <= 25'sd0;
		linien_fast_a_iir0_csrstorage2_storage_full0 <= 25'd0;
		linien_fast_a_iir0_csrstorage2_re0 <= 1'd0;
		linien_fast_a_iir0_z0r0 <= 50'sd0;
		linien_fast_a_iir0_y1 <= 25'sd0;
		linien_fast_a_iir0_zr0 <= 50'sd0;
		linien_fast_a_iir0_zr1 <= 50'sd0;
		linien_fast_a_iir0_zr2 <= 50'sd0;
		linien_fast_a_iir0_y2 <= 25'sd0;
		linien_fast_a_iir0_error1 <= 1'd0;
		linien_fast_a_iir0_storage_full1 <= 27'd0;
		linien_fast_a_iir0_re1 <= 1'd0;
		linien_fast_a_iir0_a11 <= 25'sd0;
		linien_fast_a_iir0_csrstorage0_storage_full1 <= 25'd0;
		linien_fast_a_iir0_csrstorage0_re1 <= 1'd0;
		linien_fast_a_iir0_a2 <= 25'sd0;
		linien_fast_a_iir0_csrstorage1_storage_full1 <= 25'd0;
		linien_fast_a_iir0_csrstorage1_re1 <= 1'd0;
		linien_fast_a_iir0_b01 <= 25'sd0;
		linien_fast_a_iir0_csrstorage2_storage_full1 <= 25'd0;
		linien_fast_a_iir0_csrstorage2_re1 <= 1'd0;
		linien_fast_a_iir0_b11 <= 25'sd0;
		linien_fast_a_iir0_csrstorage3_storage_full <= 25'd0;
		linien_fast_a_iir0_csrstorage3_re <= 1'd0;
		linien_fast_a_iir0_b2 <= 25'sd0;
		linien_fast_a_iir0_csrstorage4_storage_full <= 25'd0;
		linien_fast_a_iir0_csrstorage4_re <= 1'd0;
		linien_fast_a_iir0_z0r1 <= 50'sd0;
		linien_fast_a_iir0_y3 <= 25'sd0;
		linien_fast_a_iir0_zr3 <= 50'sd0;
		linien_fast_a_iir0_zr4 <= 50'sd0;
		linien_fast_a_iir0_zr5 <= 50'sd0;
		linien_fast_a_iir0_zr6 <= 50'sd0;
		linien_fast_a_iir0_zr7 <= 50'sd0;
		linien_fast_a_limitcsr0_limitcsr0_y1 <= 25'sd0;
		linien_fast_a_limitcsr0_limitcsr0_error1 <= 1'd0;
		linien_fast_a_limitcsr0_min_storage_full1 <= 25'd16777216;
		linien_fast_a_limitcsr0_min_re1 <= 1'd0;
		linien_fast_a_limitcsr0_max_storage_full1 <= 25'd16777215;
		linien_fast_a_limitcsr0_max_re1 <= 1'd0;
		linien_fast_a_limitcsr0_limit_max1 <= 28'sd0;
		linien_fast_a_limitcsr0_limit_min1 <= 28'sd0;
		linien_fast_a_limitcsr1_limitcsr1_y0 <= 25'sd0;
		linien_fast_a_limitcsr1_limitcsr1_error0 <= 1'd0;
		linien_fast_a_limitcsr1_min_storage_full0 <= 25'd16777216;
		linien_fast_a_limitcsr1_min_re0 <= 1'd0;
		linien_fast_a_limitcsr1_max_storage_full0 <= 25'd16777215;
		linien_fast_a_limitcsr1_max_re0 <= 1'd0;
		linien_fast_a_limitcsr1_limit_max0 <= 26'sd0;
		linien_fast_a_limitcsr1_limit_min0 <= 26'sd0;
		linien_fast_a_iir1_y0 <= 25'sd0;
		linien_fast_a_iir1_error0 <= 1'd0;
		linien_fast_a_iir1_storage_full0 <= 27'd0;
		linien_fast_a_iir1_re0 <= 1'd0;
		linien_fast_a_iir1_a10 <= 25'sd0;
		linien_fast_a_iir1_csrstorage3_storage_full <= 25'd0;
		linien_fast_a_iir1_csrstorage3_re <= 1'd0;
		linien_fast_a_iir1_b00 <= 25'sd0;
		linien_fast_a_iir1_csrstorage4_storage_full <= 25'd0;
		linien_fast_a_iir1_csrstorage4_re <= 1'd0;
		linien_fast_a_iir1_b10 <= 25'sd0;
		linien_fast_a_iir1_csrstorage5_storage_full0 <= 25'd0;
		linien_fast_a_iir1_csrstorage5_re0 <= 1'd0;
		linien_fast_a_iir1_z0r0 <= 50'sd0;
		linien_fast_a_iir1_y1 <= 25'sd0;
		linien_fast_a_iir1_zr0 <= 50'sd0;
		linien_fast_a_iir1_zr1 <= 50'sd0;
		linien_fast_a_iir1_zr2 <= 50'sd0;
		linien_fast_a_iir1_y2 <= 25'sd0;
		linien_fast_a_iir1_error1 <= 1'd0;
		linien_fast_a_iir1_storage_full1 <= 27'd0;
		linien_fast_a_iir1_re1 <= 1'd0;
		linien_fast_a_iir1_a11 <= 25'sd0;
		linien_fast_a_iir1_csrstorage5_storage_full1 <= 25'd0;
		linien_fast_a_iir1_csrstorage5_re1 <= 1'd0;
		linien_fast_a_iir1_a2 <= 25'sd0;
		linien_fast_a_iir1_csrstorage6_storage_full <= 25'd0;
		linien_fast_a_iir1_csrstorage6_re <= 1'd0;
		linien_fast_a_iir1_b01 <= 25'sd0;
		linien_fast_a_iir1_csrstorage7_storage_full <= 25'd0;
		linien_fast_a_iir1_csrstorage7_re <= 1'd0;
		linien_fast_a_iir1_b11 <= 25'sd0;
		linien_fast_a_iir1_csrstorage8_storage_full <= 25'd0;
		linien_fast_a_iir1_csrstorage8_re <= 1'd0;
		linien_fast_a_iir1_b2 <= 25'sd0;
		linien_fast_a_iir1_csrstorage9_storage_full <= 25'd0;
		linien_fast_a_iir1_csrstorage9_re <= 1'd0;
		linien_fast_a_iir1_z0r1 <= 50'sd0;
		linien_fast_a_iir1_y3 <= 25'sd0;
		linien_fast_a_iir1_zr3 <= 50'sd0;
		linien_fast_a_iir1_zr4 <= 50'sd0;
		linien_fast_a_iir1_zr5 <= 50'sd0;
		linien_fast_a_iir1_zr6 <= 50'sd0;
		linien_fast_a_iir1_zr7 <= 50'sd0;
		linien_fast_a_limitcsr1_limitcsr1_y1 <= 25'sd0;
		linien_fast_a_limitcsr1_limitcsr1_error1 <= 1'd0;
		linien_fast_a_limitcsr1_min_storage_full1 <= 25'd16777216;
		linien_fast_a_limitcsr1_min_re1 <= 1'd0;
		linien_fast_a_limitcsr1_max_storage_full1 <= 25'd16777215;
		linien_fast_a_limitcsr1_max_re1 <= 1'd0;
		linien_fast_a_limitcsr1_limit_max1 <= 28'sd0;
		linien_fast_a_limitcsr1_limit_min1 <= 28'sd0;
		linien_fast_b_y_tap_storage_full <= 2'd0;
		linien_fast_b_y_tap_re <= 1'd0;
		linien_fast_b_invert_storage_full <= 1'd0;
		linien_fast_b_invert_re <= 1'd0;
		linien_fast_b_dx <= 25'sd0;
		linien_fast_b_dy <= 25'sd0;
		linien_fast_b_delay_storage_full <= 32'd0;
		linien_fast_b_delay_re <= 1'd0;
		linien_fast_b_multiplier_storage_full <= 4'd1;
		linien_fast_b_multiplier_re <= 1'd0;
		linien_fast_b_x3 <= 17'sd0;
		linien_fast_b_x4 <= 17'sd0;
		linien_fast_b_x5 <= 17'sd0;
		linien_fast_b_x6 <= 17'sd0;
		linien_fast_b_x7 <= 17'sd0;
		linien_fast_b_x8 <= 17'sd0;
		linien_fast_b_x9 <= 17'sd0;
		linien_fast_b_x10 <= 17'sd0;
		linien_fast_b_x11 <= 17'sd0;
		linien_fast_b_x12 <= 17'sd0;
		linien_fast_b_x13 <= 17'sd0;
		linien_fast_b_x14 <= 17'sd0;
		linien_fast_b_x15 <= 17'sd0;
		linien_fast_b_x16 <= 17'sd0;
		linien_fast_b_x17 <= 17'sd0;
		linien_fast_b_y1 <= 17'sd0;
		linien_fast_b_y2 <= 17'sd0;
		linien_fast_b_y3 <= 17'sd0;
		linien_fast_b_y4 <= 17'sd0;
		linien_fast_b_y5 <= 17'sd0;
		linien_fast_b_y6 <= 17'sd0;
		linien_fast_b_y7 <= 17'sd0;
		linien_fast_b_y8 <= 17'sd0;
		linien_fast_b_y9 <= 17'sd0;
		linien_fast_b_y10 <= 17'sd0;
		linien_fast_b_y11 <= 17'sd0;
		linien_fast_b_y12 <= 17'sd0;
		linien_fast_b_y13 <= 17'sd0;
		linien_fast_b_y14 <= 17'sd0;
		linien_fast_b_y15 <= 17'sd0;
		linien_fast_b_z1 <= 17'sd0;
		linien_fast_b_z2 <= 17'sd0;
		linien_fast_b_z3 <= 17'sd0;
		linien_fast_b_z4 <= 17'sd0;
		linien_fast_b_z5 <= 17'sd0;
		linien_fast_b_z6 <= 17'sd0;
		linien_fast_b_z7 <= 17'sd0;
		linien_fast_b_z8 <= 17'sd0;
		linien_fast_b_z9 <= 17'sd0;
		linien_fast_b_z10 <= 17'sd0;
		linien_fast_b_z11 <= 17'sd0;
		linien_fast_b_z12 <= 17'sd0;
		linien_fast_b_z13 <= 17'sd0;
		linien_fast_b_z14 <= 17'sd0;
		linien_fast_b_z15 <= 17'sd0;
		linien_fast_b_ya <= 17'sd0;
		linien_fast_b_limitcsr0_limitcsr0_y0 <= 25'sd0;
		linien_fast_b_limitcsr0_limitcsr0_error0 <= 1'd0;
		linien_fast_b_limitcsr0_min_storage_full0 <= 25'd16777216;
		linien_fast_b_limitcsr0_min_re0 <= 1'd0;
		linien_fast_b_limitcsr0_max_storage_full0 <= 25'd16777215;
		linien_fast_b_limitcsr0_max_re0 <= 1'd0;
		linien_fast_b_limitcsr0_limit_max0 <= 26'sd0;
		linien_fast_b_limitcsr0_limit_min0 <= 26'sd0;
		linien_fast_b_iir0_y0 <= 25'sd0;
		linien_fast_b_iir0_error0 <= 1'd0;
		linien_fast_b_iir0_storage_full0 <= 27'd0;
		linien_fast_b_iir0_re0 <= 1'd0;
		linien_fast_b_iir0_a10 <= 25'sd0;
		linien_fast_b_iir0_csrstorage0_storage_full0 <= 25'd0;
		linien_fast_b_iir0_csrstorage0_re0 <= 1'd0;
		linien_fast_b_iir0_b00 <= 25'sd0;
		linien_fast_b_iir0_csrstorage1_storage_full0 <= 25'd0;
		linien_fast_b_iir0_csrstorage1_re0 <= 1'd0;
		linien_fast_b_iir0_b10 <= 25'sd0;
		linien_fast_b_iir0_csrstorage2_storage_full0 <= 25'd0;
		linien_fast_b_iir0_csrstorage2_re0 <= 1'd0;
		linien_fast_b_iir0_z0r0 <= 50'sd0;
		linien_fast_b_iir0_y1 <= 25'sd0;
		linien_fast_b_iir0_zr0 <= 50'sd0;
		linien_fast_b_iir0_zr1 <= 50'sd0;
		linien_fast_b_iir0_zr2 <= 50'sd0;
		linien_fast_b_iir0_y2 <= 25'sd0;
		linien_fast_b_iir0_error1 <= 1'd0;
		linien_fast_b_iir0_storage_full1 <= 27'd0;
		linien_fast_b_iir0_re1 <= 1'd0;
		linien_fast_b_iir0_a11 <= 25'sd0;
		linien_fast_b_iir0_csrstorage0_storage_full1 <= 25'd0;
		linien_fast_b_iir0_csrstorage0_re1 <= 1'd0;
		linien_fast_b_iir0_a2 <= 25'sd0;
		linien_fast_b_iir0_csrstorage1_storage_full1 <= 25'd0;
		linien_fast_b_iir0_csrstorage1_re1 <= 1'd0;
		linien_fast_b_iir0_b01 <= 25'sd0;
		linien_fast_b_iir0_csrstorage2_storage_full1 <= 25'd0;
		linien_fast_b_iir0_csrstorage2_re1 <= 1'd0;
		linien_fast_b_iir0_b11 <= 25'sd0;
		linien_fast_b_iir0_csrstorage3_storage_full <= 25'd0;
		linien_fast_b_iir0_csrstorage3_re <= 1'd0;
		linien_fast_b_iir0_b2 <= 25'sd0;
		linien_fast_b_iir0_csrstorage4_storage_full <= 25'd0;
		linien_fast_b_iir0_csrstorage4_re <= 1'd0;
		linien_fast_b_iir0_z0r1 <= 50'sd0;
		linien_fast_b_iir0_y3 <= 25'sd0;
		linien_fast_b_iir0_zr3 <= 50'sd0;
		linien_fast_b_iir0_zr4 <= 50'sd0;
		linien_fast_b_iir0_zr5 <= 50'sd0;
		linien_fast_b_iir0_zr6 <= 50'sd0;
		linien_fast_b_iir0_zr7 <= 50'sd0;
		linien_fast_b_limitcsr0_limitcsr0_y1 <= 25'sd0;
		linien_fast_b_limitcsr0_limitcsr0_error1 <= 1'd0;
		linien_fast_b_limitcsr0_min_storage_full1 <= 25'd16777216;
		linien_fast_b_limitcsr0_min_re1 <= 1'd0;
		linien_fast_b_limitcsr0_max_storage_full1 <= 25'd16777215;
		linien_fast_b_limitcsr0_max_re1 <= 1'd0;
		linien_fast_b_limitcsr0_limit_max1 <= 28'sd0;
		linien_fast_b_limitcsr0_limit_min1 <= 28'sd0;
		linien_fast_b_limitcsr1_limitcsr1_y0 <= 25'sd0;
		linien_fast_b_limitcsr1_limitcsr1_error0 <= 1'd0;
		linien_fast_b_limitcsr1_min_storage_full0 <= 25'd16777216;
		linien_fast_b_limitcsr1_min_re0 <= 1'd0;
		linien_fast_b_limitcsr1_max_storage_full0 <= 25'd16777215;
		linien_fast_b_limitcsr1_max_re0 <= 1'd0;
		linien_fast_b_limitcsr1_limit_max0 <= 26'sd0;
		linien_fast_b_limitcsr1_limit_min0 <= 26'sd0;
		linien_fast_b_iir1_y0 <= 25'sd0;
		linien_fast_b_iir1_error0 <= 1'd0;
		linien_fast_b_iir1_storage_full0 <= 27'd0;
		linien_fast_b_iir1_re0 <= 1'd0;
		linien_fast_b_iir1_a10 <= 25'sd0;
		linien_fast_b_iir1_csrstorage3_storage_full <= 25'd0;
		linien_fast_b_iir1_csrstorage3_re <= 1'd0;
		linien_fast_b_iir1_b00 <= 25'sd0;
		linien_fast_b_iir1_csrstorage4_storage_full <= 25'd0;
		linien_fast_b_iir1_csrstorage4_re <= 1'd0;
		linien_fast_b_iir1_b10 <= 25'sd0;
		linien_fast_b_iir1_csrstorage5_storage_full0 <= 25'd0;
		linien_fast_b_iir1_csrstorage5_re0 <= 1'd0;
		linien_fast_b_iir1_z0r0 <= 50'sd0;
		linien_fast_b_iir1_y1 <= 25'sd0;
		linien_fast_b_iir1_zr0 <= 50'sd0;
		linien_fast_b_iir1_zr1 <= 50'sd0;
		linien_fast_b_iir1_zr2 <= 50'sd0;
		linien_fast_b_iir1_y2 <= 25'sd0;
		linien_fast_b_iir1_error1 <= 1'd0;
		linien_fast_b_iir1_storage_full1 <= 27'd0;
		linien_fast_b_iir1_re1 <= 1'd0;
		linien_fast_b_iir1_a11 <= 25'sd0;
		linien_fast_b_iir1_csrstorage5_storage_full1 <= 25'd0;
		linien_fast_b_iir1_csrstorage5_re1 <= 1'd0;
		linien_fast_b_iir1_a2 <= 25'sd0;
		linien_fast_b_iir1_csrstorage6_storage_full <= 25'd0;
		linien_fast_b_iir1_csrstorage6_re <= 1'd0;
		linien_fast_b_iir1_b01 <= 25'sd0;
		linien_fast_b_iir1_csrstorage7_storage_full <= 25'd0;
		linien_fast_b_iir1_csrstorage7_re <= 1'd0;
		linien_fast_b_iir1_b11 <= 25'sd0;
		linien_fast_b_iir1_csrstorage8_storage_full <= 25'd0;
		linien_fast_b_iir1_csrstorage8_re <= 1'd0;
		linien_fast_b_iir1_b2 <= 25'sd0;
		linien_fast_b_iir1_csrstorage9_storage_full <= 25'd0;
		linien_fast_b_iir1_csrstorage9_re <= 1'd0;
		linien_fast_b_iir1_z0r1 <= 50'sd0;
		linien_fast_b_iir1_y3 <= 25'sd0;
		linien_fast_b_iir1_zr3 <= 50'sd0;
		linien_fast_b_iir1_zr4 <= 50'sd0;
		linien_fast_b_iir1_zr5 <= 50'sd0;
		linien_fast_b_iir1_zr6 <= 50'sd0;
		linien_fast_b_iir1_zr7 <= 50'sd0;
		linien_fast_b_limitcsr1_limitcsr1_y1 <= 25'sd0;
		linien_fast_b_limitcsr1_limitcsr1_error1 <= 1'd0;
		linien_fast_b_limitcsr1_min_storage_full1 <= 25'd16777216;
		linien_fast_b_limitcsr1_min_re1 <= 1'd0;
		linien_fast_b_limitcsr1_max_storage_full1 <= 25'd16777215;
		linien_fast_b_limitcsr1_max_re1 <= 1'd0;
		linien_fast_b_limitcsr1_limit_max1 <= 28'sd0;
		linien_fast_b_limitcsr1_limit_min1 <= 28'sd0;
		linien_out_e <= 25'sd0;
		linien_divider_done <= 1'd0;
		linien_divider_quotient <= 25'sd0;
		linien_divider_r0 <= 26'd0;
		linien_divider_r1 <= 26'd0;
		linien_divider_r2 <= 26'd0;
		linien_divider_r3 <= 26'd0;
		linien_divider_r4 <= 26'd0;
		linien_divider_r5 <= 26'd0;
		linien_divider_r6 <= 26'd0;
		linien_divider_r7 <= 26'd0;
		linien_divider_r8 <= 26'd0;
		linien_divider_r9 <= 26'd0;
		linien_divider_r10 <= 26'd0;
		linien_divider_r11 <= 26'd0;
		linien_divider_r12 <= 26'd0;
		linien_divider_r13 <= 26'd0;
		linien_divider_r14 <= 26'd0;
		linien_divider_r15 <= 26'd0;
		linien_divider_r16 <= 26'd0;
		linien_divider_r17 <= 26'd0;
		linien_divider_r18 <= 26'd0;
		linien_divider_r19 <= 26'd0;
		linien_divider_r20 <= 26'd0;
		linien_divider_r21 <= 26'd0;
		linien_divider_r22 <= 26'd0;
		linien_divider_r23 <= 26'd0;
		linien_divider_r24 <= 26'd0;
		linien_divider_r25 <= 26'd0;
		linien_divider_r26 <= 26'd0;
		linien_divider_r27 <= 26'd0;
		linien_divider_r28 <= 26'd0;
		linien_divider_r29 <= 26'd0;
		linien_divider_r30 <= 26'd0;
		linien_divider_r31 <= 26'd0;
		linien_divider_r32 <= 26'd0;
		linien_divider_r33 <= 26'd0;
		linien_divider_r34 <= 26'd0;
		linien_divider_r35 <= 26'd0;
		linien_divider_quo0 <= 35'd0;
		linien_divider_quo1 <= 35'd0;
		linien_divider_quo2 <= 35'd0;
		linien_divider_quo3 <= 35'd0;
		linien_divider_quo4 <= 35'd0;
		linien_divider_quo5 <= 35'd0;
		linien_divider_quo6 <= 35'd0;
		linien_divider_quo7 <= 35'd0;
		linien_divider_quo8 <= 35'd0;
		linien_divider_quo9 <= 35'd0;
		linien_divider_quo10 <= 35'd0;
		linien_divider_quo11 <= 35'd0;
		linien_divider_quo12 <= 35'd0;
		linien_divider_quo13 <= 35'd0;
		linien_divider_quo14 <= 35'd0;
		linien_divider_quo15 <= 35'd0;
		linien_divider_quo16 <= 35'd0;
		linien_divider_quo17 <= 35'd0;
		linien_divider_quo18 <= 35'd0;
		linien_divider_quo19 <= 35'd0;
		linien_divider_quo20 <= 35'd0;
		linien_divider_quo21 <= 35'd0;
		linien_divider_quo22 <= 35'd0;
		linien_divider_quo23 <= 35'd0;
		linien_divider_quo24 <= 35'd0;
		linien_divider_quo25 <= 35'd0;
		linien_divider_quo26 <= 35'd0;
		linien_divider_quo27 <= 35'd0;
		linien_divider_quo28 <= 35'd0;
		linien_divider_quo29 <= 35'd0;
		linien_divider_quo30 <= 35'd0;
		linien_divider_quo31 <= 35'd0;
		linien_divider_quo32 <= 35'd0;
		linien_divider_quo33 <= 35'd0;
		linien_divider_quo34 <= 35'd0;
		linien_divider_quo35 <= 35'd0;
		linien_divider_q0 <= 35'd0;
		linien_divider_q1 <= 35'd0;
		linien_divider_q2 <= 35'd0;
		linien_divider_q3 <= 35'd0;
		linien_divider_q4 <= 35'd0;
		linien_divider_q5 <= 35'd0;
		linien_divider_q6 <= 35'd0;
		linien_divider_q7 <= 35'd0;
		linien_divider_q8 <= 35'd0;
		linien_divider_q9 <= 35'd0;
		linien_divider_q10 <= 35'd0;
		linien_divider_q11 <= 35'd0;
		linien_divider_q12 <= 35'd0;
		linien_divider_q13 <= 35'd0;
		linien_divider_q14 <= 35'd0;
		linien_divider_q15 <= 35'd0;
		linien_divider_q16 <= 35'd0;
		linien_divider_q17 <= 35'd0;
		linien_divider_q18 <= 35'd0;
		linien_divider_q19 <= 35'd0;
		linien_divider_q20 <= 35'd0;
		linien_divider_q21 <= 35'd0;
		linien_divider_q22 <= 35'd0;
		linien_divider_q23 <= 35'd0;
		linien_divider_q24 <= 35'd0;
		linien_divider_q25 <= 35'd0;
		linien_divider_q26 <= 35'd0;
		linien_divider_q27 <= 35'd0;
		linien_divider_q28 <= 35'd0;
		linien_divider_q29 <= 35'd0;
		linien_divider_q30 <= 35'd0;
		linien_divider_q31 <= 35'd0;
		linien_divider_q32 <= 35'd0;
		linien_divider_q33 <= 35'd0;
		linien_divider_q34 <= 35'd0;
		linien_divider_q35 <= 35'd0;
		linien_divider_d0 <= 25'd0;
		linien_divider_d1 <= 25'd0;
		linien_divider_d2 <= 25'd0;
		linien_divider_d3 <= 25'd0;
		linien_divider_d4 <= 25'd0;
		linien_divider_d5 <= 25'd0;
		linien_divider_d6 <= 25'd0;
		linien_divider_d7 <= 25'd0;
		linien_divider_d8 <= 25'd0;
		linien_divider_d9 <= 25'd0;
		linien_divider_d10 <= 25'd0;
		linien_divider_d11 <= 25'd0;
		linien_divider_d12 <= 25'd0;
		linien_divider_d13 <= 25'd0;
		linien_divider_d14 <= 25'd0;
		linien_divider_d15 <= 25'd0;
		linien_divider_d16 <= 25'd0;
		linien_divider_d17 <= 25'd0;
		linien_divider_d18 <= 25'd0;
		linien_divider_d19 <= 25'd0;
		linien_divider_d20 <= 25'd0;
		linien_divider_d21 <= 25'd0;
		linien_divider_d22 <= 25'd0;
		linien_divider_d23 <= 25'd0;
		linien_divider_d24 <= 25'd0;
		linien_divider_d25 <= 25'd0;
		linien_divider_d26 <= 25'd0;
		linien_divider_d27 <= 25'd0;
		linien_divider_d28 <= 25'd0;
		linien_divider_d29 <= 25'd0;
		linien_divider_d30 <= 25'd0;
		linien_divider_d31 <= 25'd0;
		linien_divider_d32 <= 25'd0;
		linien_divider_d33 <= 25'd0;
		linien_divider_d34 <= 25'd0;
		linien_divider_d35 <= 25'd0;
		linien_divider_v0 <= 1'd0;
		linien_divider_v1 <= 1'd0;
		linien_divider_v2 <= 1'd0;
		linien_divider_v3 <= 1'd0;
		linien_divider_v4 <= 1'd0;
		linien_divider_v5 <= 1'd0;
		linien_divider_v6 <= 1'd0;
		linien_divider_v7 <= 1'd0;
		linien_divider_v8 <= 1'd0;
		linien_divider_v9 <= 1'd0;
		linien_divider_v10 <= 1'd0;
		linien_divider_v11 <= 1'd0;
		linien_divider_v12 <= 1'd0;
		linien_divider_v13 <= 1'd0;
		linien_divider_v14 <= 1'd0;
		linien_divider_v15 <= 1'd0;
		linien_divider_v16 <= 1'd0;
		linien_divider_v17 <= 1'd0;
		linien_divider_v18 <= 1'd0;
		linien_divider_v19 <= 1'd0;
		linien_divider_v20 <= 1'd0;
		linien_divider_v21 <= 1'd0;
		linien_divider_v22 <= 1'd0;
		linien_divider_v23 <= 1'd0;
		linien_divider_v24 <= 1'd0;
		linien_divider_v25 <= 1'd0;
		linien_divider_v26 <= 1'd0;
		linien_divider_v27 <= 1'd0;
		linien_divider_v28 <= 1'd0;
		linien_divider_v29 <= 1'd0;
		linien_divider_v30 <= 1'd0;
		linien_divider_v31 <= 1'd0;
		linien_divider_v32 <= 1'd0;
		linien_divider_v33 <= 1'd0;
		linien_divider_v34 <= 1'd0;
		linien_divider_v35 <= 1'd0;
		linien_safe_to_divide_reg <= 1'd0;
		linien_denominator_reg <= 25'sd0;
		linien_x_target_cmd_storage_full <= 25'd0;
		linien_x_target_cmd_re <= 1'd0;
		linien_f_target_cmd_storage_full <= 25'd0;
		linien_f_target_cmd_re <= 1'd0;
		linien_t_target_cmd_storage_full <= 25'd0;
		linien_t_target_cmd_re <= 1'd0;
		linien_power_threshold_target_cmd_storage_full <= 25'd0;
		linien_power_threshold_target_cmd_re <= 1'd0;
		linien_current_output_time <= 25'sd0;
		linien_sweep_direction <= 1'd1;
		linien_narrow_search_timeout_counter <= 27'd0;
		linien_scopegen_automatic_trigger_signal <= 1'd0;
		linien_scopegen_storage_full <= 1'd0;
		linien_scopegen_re <= 1'd0;
		linien_scopegen_adc_a <= 25'sd0;
		linien_scopegen_adc_a_q <= 25'sd0;
		linien_scopegen_adc_b <= 25'sd0;
		linien_scopegen_adc_b_q <= 25'sd0;
		linien_sine_source_phase <= 32'd0;
		linien_max_status0 <= 25'd0;
		linien_min_status0 <= 25'd0;
		linien_max_status1 <= 25'd0;
		linien_min_status1 <= 25'd0;
		linien_max_status2 <= 25'd0;
		linien_min_status2 <= 25'd0;
		linien_max_status3 <= 25'd0;
		linien_min_status3 <= 25'd0;
		linien_max_status4 <= 25'd0;
		linien_min_status4 <= 25'd0;
		linien_max_status5 <= 25'd0;
		linien_min_status5 <= 25'd0;
		linien_max_status6 <= 25'd0;
		linien_min_status6 <= 25'd0;
		linien_max_status7 <= 25'd0;
		linien_min_status7 <= 25'd0;
		linien_max_status8 <= 25'd0;
		linien_min_status8 <= 25'd0;
		linien_max_status9 <= 25'd0;
		linien_min_status9 <= 25'd0;
		linien_max_status10 <= 14'd0;
		linien_min_status10 <= 14'd0;
		linien_max_status11 <= 25'd0;
		linien_min_status11 <= 25'd0;
		linien_state_status <= 9'd0;
		linien_csrstorage0_storage_full <= 9'd0;
		linien_csrstorage0_re <= 1'd0;
		linien_csrstorage1_storage_full <= 9'd0;
		linien_csrstorage1_re <= 1'd0;
		linien_csrstorage2_storage_full <= 9'd0;
		linien_csrstorage2_re <= 1'd0;
		linien_csrstorage3_storage_full <= 9'd0;
		linien_csrstorage3_re <= 1'd0;
		linien_csrstorage4_storage_full <= 9'd0;
		linien_csrstorage4_re <= 1'd0;
		linien_csrstorage5_storage_full <= 9'd0;
		linien_csrstorage5_re <= 1'd0;
		linien_csrstorage6_storage_full <= 9'd0;
		linien_csrstorage6_re <= 1'd0;
		linien_csrstorage7_storage_full <= 9'd0;
		linien_csrstorage7_re <= 1'd0;
		linien_csrstorage8_storage_full <= 4'd0;
		linien_csrstorage8_re <= 1'd0;
		linien_csrstorage9_storage_full <= 4'd0;
		linien_csrstorage9_re <= 1'd0;
		linien_csrstorage10_storage_full <= 4'd0;
		linien_csrstorage10_re <= 1'd0;
		linien_csrstorage11_storage_full <= 4'd0;
		linien_csrstorage11_re <= 1'd0;
		linien_csrstorage12_storage_full <= 4'd0;
		linien_csrstorage12_re <= 1'd0;
		linien_csrstorage13_storage_full <= 4'd0;
		linien_csrstorage13_re <= 1'd0;
		linien_csrstorage14_storage_full <= 4'd0;
		linien_csrstorage14_re <= 1'd0;
		linien_csrstorage15_storage_full <= 4'd0;
		linien_csrstorage15_re <= 1'd0;
		linien_interface0_bank_bus_dat_r <= 8'd0;
		linien_interface1_bank_bus_dat_r <= 8'd0;
		linien_interface2_bank_bus_dat_r <= 8'd0;
		linien_interface3_bank_bus_dat_r <= 8'd0;
		linien_interface4_bank_bus_dat_r <= 8'd0;
		linien_interface5_bank_bus_dat_r <= 8'd0;
		linien_interface6_bank_bus_dat_r <= 8'd0;
		linien_interface7_bank_bus_dat_r <= 8'd0;
		linien_interface8_bank_bus_dat_r <= 8'd0;
		linien_interface9_bank_bus_dat_r <= 8'd0;
		linien_interface10_bank_bus_dat_r <= 8'd0;
		linien_csr_adr <= 14'd0;
		linien_csr_we <= 1'd0;
		linien_csr_dat_w <= 8'd0;
		linien_sys_rdata <= 32'd0;
		linien_sys_ack <= 1'd0;
		linien_stb <= 1'd0;
		state <= 2'd0;
	end
	xilinxmultiregimpl0_regs0 <= {linien_gpio_n_tstriple7_i, linien_gpio_n_tstriple6_i, linien_gpio_n_tstriple5_i, linien_gpio_n_tstriple4_i, linien_gpio_n_tstriple3_i, linien_gpio_n_tstriple2_i, linien_gpio_n_tstriple1_i, linien_gpio_n_tstriple0_i};
	xilinxmultiregimpl0_regs1 <= xilinxmultiregimpl0_regs0;
	xilinxmultiregimpl1_regs0 <= {linien_gpio_p_tstriple7_i, linien_gpio_p_tstriple6_i, linien_gpio_p_tstriple5_i, linien_gpio_p_tstriple4_i, linien_gpio_p_tstriple3_i, linien_gpio_p_tstriple2_i, linien_gpio_p_tstriple1_i, linien_gpio_p_tstriple0_i};
	xilinxmultiregimpl1_regs1 <= xilinxmultiregimpl1_regs0;
end

always @(posedge sys_double_clk) begin
	linien_deltasigma0_sigma <= ((linien_deltasigma0_data - linien_deltasigma0_delta) + linien_deltasigma0_sigma);
	linien_deltasigma1_sigma <= ((linien_deltasigma1_data - linien_deltasigma1_delta) + linien_deltasigma1_sigma);
	linien_deltasigma2_sigma <= ((linien_deltasigma2_data - linien_deltasigma2_delta) + linien_deltasigma2_sigma);
	linien_deltasigma3_sigma <= ((linien_deltasigma3_data - linien_deltasigma3_delta) + linien_deltasigma3_sigma);
end

always @(posedge sys_ps_clk) begin
	dummyhk_bank_bus_dat_r <= 1'd0;
	if (dummyhk_sel) begin
		case (dummyhk_bank_bus_adr[0])
			1'd0: begin
				dummyhk_bank_bus_dat_r <= dummyhk_id_w;
			end
		endcase
	end
	dummyhk_stb <= (dummyhk_sys_wen | dummyhk_sys_ren);
	dummyhk_csr_adr <= dummyhk_sys_addr[31:2];
	dummyhk_csr_we <= dummyhk_sys_wen;
	dummyhk_csr_dat_w <= dummyhk_sys_wdata;
	dummyhk_sys_ack <= dummyhk_stb;
	dummyhk_sys_rdata <= dummyhk_csr_dat_r;
	if (sys_ps_rst) begin
		dummyhk_bank_bus_dat_r <= 8'd0;
		dummyhk_csr_adr <= 14'd0;
		dummyhk_csr_we <= 1'd0;
		dummyhk_csr_dat_w <= 8'd0;
		dummyhk_sys_rdata <= 32'd0;
		dummyhk_sys_ack <= 1'd0;
		dummyhk_stb <= 1'd0;
	end
end

axi_slave #(
	.AXI_AW(6'd32),
	.AXI_DW(6'd32),
	.AXI_IW(4'd12)
) axi_slave (
	.axi_araddr_i(ps_axi_araddr),
	.axi_arburst_i(ps_axi_arburst),
	.axi_arcache_i(ps_axi_arcache),
	.axi_arid_i(ps_axi_arid),
	.axi_arlen_i(ps_axi_arlen),
	.axi_arlock_i(ps_axi_arlock),
	.axi_arprot_i(ps_axi_arprot),
	.axi_arsize_i(ps_axi_arsize),
	.axi_arvalid_i(ps_axi_arvalid),
	.axi_awaddr_i(ps_axi_awaddr),
	.axi_awburst_i(ps_axi_awburst),
	.axi_awcache_i(ps_axi_awcache),
	.axi_awid_i(ps_axi_awid),
	.axi_awlen_i(ps_axi_awlen),
	.axi_awlock_i(ps_axi_awlock),
	.axi_awprot_i(ps_axi_awprot),
	.axi_awsize_i(ps_axi_awsize),
	.axi_awvalid_i(ps_axi_awvalid),
	.axi_bready_i(ps_axi_bready),
	.axi_clk_i(ps_axi_aclk),
	.axi_rready_i(ps_axi_rready),
	.axi_rstn_i(ps_axi_arstn),
	.axi_wdata_i(ps_axi_wdata),
	.axi_wid_i(ps_axi_wid),
	.axi_wlast_i(ps_axi_wlast),
	.axi_wstrb_i(ps_axi_wstrb),
	.axi_wvalid_i(ps_axi_wvalid),
	.sys_ack_i(ps_sys_ack),
	.sys_err_i(ps_sys_err),
	.sys_rdata_i(ps_sys_rdata),
	.axi_arready_o(ps_axi_arready),
	.axi_awready_o(ps_axi_awready),
	.axi_bid_o(ps_axi_bid),
	.axi_bresp_o(ps_axi_bresp),
	.axi_bvalid_o(ps_axi_bvalid),
	.axi_rdata_o(ps_axi_rdata),
	.axi_rid_o(ps_axi_rid),
	.axi_rlast_o(ps_axi_rlast),
	.axi_rresp_o(ps_axi_rresp),
	.axi_rvalid_o(ps_axi_rvalid),
	.axi_wready_o(ps_axi_wready),
	.sys_addr_o(ps_sys_addr),
	.sys_ren_o(ps_sys_ren),
	.sys_sel_o(ps_sys_sel),
	.sys_wdata_o(ps_sys_wdata),
	.sys_wen_o(ps_sys_wen)
);

system_processing_system7_0_0 system_processing_system7_0_0(
	.M_AXI_GP0_ACLK(ps_axi_aclk),
	.M_AXI_GP0_ARREADY(ps_axi_arready),
	.M_AXI_GP0_AWREADY(ps_axi_awready),
	.M_AXI_GP0_BID(ps_axi_bid),
	.M_AXI_GP0_BRESP(ps_axi_bresp),
	.M_AXI_GP0_BVALID(ps_axi_bvalid),
	.M_AXI_GP0_RDATA(ps_axi_rdata),
	.M_AXI_GP0_RID(ps_axi_rid),
	.M_AXI_GP0_RLAST(ps_axi_rlast),
	.M_AXI_GP0_RRESP(ps_axi_rresp),
	.M_AXI_GP0_RVALID(ps_axi_rvalid),
	.M_AXI_GP0_WREADY(ps_axi_wready),
	.SPI0_MISO_I(1'd0),
	.SPI0_MOSI_I(1'd0),
	.SPI0_SCLK_I(1'd0),
	.SPI0_SS_I(1'd0),
	.USB0_VBUS_PWRFAULT(1'd0),
	.DDR_Addr(cpu_DDR_addr),
	.DDR_BankAddr(cpu_DDR_ba),
	.DDR_CAS_n(cpu_DDR_cas_n),
	.DDR_CKE(cpu_DDR_cke),
	.DDR_CS_n(cpu_DDR_cs_n),
	.DDR_Clk(cpu_DDR_ck_p),
	.DDR_Clk_n(cpu_DDR_ck_n),
	.DDR_DM(cpu_DDR_dm),
	.DDR_DQ(cpu_DDR_dq),
	.DDR_DQS(cpu_DDR_dqs_p),
	.DDR_DQS_n(cpu_DDR_dqs_n),
	.DDR_DRSTB(cpu_DDR_reset_n),
	.DDR_ODT(cpu_DDR_odt),
	.DDR_RAS_n(cpu_DDR_ras_n),
	.DDR_VRN(cpu_ddr_vrn),
	.DDR_VRP(cpu_ddr_vrp),
	.DDR_WEB(cpu_DDR_we_n),
	.MIO(cpu_mio),
	.PS_CLK(cpu_ps_clk),
	.PS_PORB(cpu_ps_porb),
	.PS_SRSTB(cpu_ps_srstb),
	.FCLK_CLK0(ps_fclk[0]),
	.FCLK_CLK1(ps_fclk[1]),
	.FCLK_CLK2(ps_fclk[2]),
	.FCLK_CLK3(ps_fclk[3]),
	.FCLK_RESET0_N(ps_frstn[0]),
	.FCLK_RESET1_N(ps_frstn[1]),
	.FCLK_RESET2_N(ps_frstn[2]),
	.FCLK_RESET3_N(ps_frstn[3]),
	.M_AXI_GP0_ARADDR(ps_axi_araddr),
	.M_AXI_GP0_ARBURST(ps_axi_arburst),
	.M_AXI_GP0_ARCACHE(ps_axi_arcache),
	.M_AXI_GP0_ARID(ps_axi_arid),
	.M_AXI_GP0_ARLEN(ps_axi_arlen),
	.M_AXI_GP0_ARLOCK(ps_axi_arlock),
	.M_AXI_GP0_ARPROT(ps_axi_arprot),
	.M_AXI_GP0_ARQOS(ps_axi_arqos),
	.M_AXI_GP0_ARSIZE(ps_axi_arsize),
	.M_AXI_GP0_ARVALID(ps_axi_arvalid),
	.M_AXI_GP0_AWADDR(ps_axi_awaddr),
	.M_AXI_GP0_AWBURST(ps_axi_awburst),
	.M_AXI_GP0_AWCACHE(ps_axi_awcache),
	.M_AXI_GP0_AWID(ps_axi_awid),
	.M_AXI_GP0_AWLEN(ps_axi_awlen),
	.M_AXI_GP0_AWLOCK(ps_axi_awlock),
	.M_AXI_GP0_AWPROT(ps_axi_awprot),
	.M_AXI_GP0_AWQOS(ps_axi_awqos),
	.M_AXI_GP0_AWSIZE(ps_axi_awsize),
	.M_AXI_GP0_AWVALID(ps_axi_awvalid),
	.M_AXI_GP0_BREADY(ps_axi_bready),
	.M_AXI_GP0_RREADY(ps_axi_rready),
	.M_AXI_GP0_WDATA(ps_axi_wdata),
	.M_AXI_GP0_WID(ps_axi_wid),
	.M_AXI_GP0_WLAST(ps_axi_wlast),
	.M_AXI_GP0_WSTRB(ps_axi_wstrb),
	.M_AXI_GP0_WVALID(ps_axi_wvalid)
);

IBUFGDS IBUFGDS(
	.I(clk125_p),
	.IB(clk125_n),
	.O(clk_adci)
);

BUFG BUFG(
	.I(clk_adci),
	.O(clk_adcb)
);

PLLE2_BASE #(
	.BANDWIDTH("OPTIMIZED"),
	.CLKFBOUT_MULT(4'd8),
	.CLKFBOUT_PHASE(0.0),
	.CLKIN1_PERIOD(8.0),
	.CLKOUT0_DIVIDE(2'd2),
	.CLKOUT0_DUTY_CYCLE(0.5),
	.CLKOUT0_PHASE(0.0),
	.CLKOUT1_DIVIDE(3'd4),
	.CLKOUT1_DUTY_CYCLE(0.5),
	.CLKOUT1_PHASE(0.0),
	.CLKOUT2_DIVIDE(4'd8),
	.CLKOUT2_DUTY_CYCLE(0.5),
	.CLKOUT2_PHASE(0.0),
	.CLKOUT3_DIVIDE(7'd120),
	.CLKOUT3_DUTY_CYCLE(0.5),
	.CLKOUT3_PHASE(0.0),
	.CLKOUT4_DIVIDE(3'd4),
	.CLKOUT4_DUTY_CYCLE(0.5),
	.CLKOUT4_PHASE(0.0),
	.CLKOUT5_DIVIDE(3'd4),
	.CLKOUT5_DUTY_CYCLE(0.5),
	.CLKOUT5_PHASE(0.0),
	.DIVCLK_DIVIDE(1'd1),
	.REF_JITTER1(0.01),
	.STARTUP_WAIT("FALSE")
) PLLE2_BASE (
	.CLKFBIN(clk_fbb),
	.CLKIN1(clk_adcb),
	.PWRDWN(1'd0),
	.RST((~ps_frstn[0])),
	.CLKFBOUT(clk_fb),
	.CLKOUT0(clk[0]),
	.CLKOUT1(clk[1]),
	.CLKOUT2(clk[2]),
	.CLKOUT3(clk[3]),
	.CLKOUT4(clk[4]),
	.CLKOUT5(clk[5]),
	.LOCKED(locked)
);

BUFG BUFG_1(
	.I(clk_fb),
	.O(clk_fbb)
);

BUFG BUFG_2(
	.I(clk[0]),
	.O(sys_quad_clk)
);

BUFG BUFG_3(
	.I(clk[1]),
	.O(sys_double_clk)
);

BUFG BUFG_4(
	.I(clk[2]),
	.O(sys_clk)
);

BUFG BUFG_5(
	.I(clk[3]),
	.O(sys_slow_clk)
);

FD #(
	.INIT(1'd1)
) FD (
	.C(sys_clk),
	.D((~locked)),
	.Q(sys_rst)
);

ODDR ODDR(
	.C(sys_double_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_clk)
);

ODDR ODDR_1(
	.C(sys_double_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_wrt)
);

ODDR ODDR_2(
	.C(sys_clk),
	.CE(1'd1),
	.D1(1'd0),
	.D2(1'd1),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_sel)
);

ODDR ODDR_3(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[0]),
	.D2(linien_analog_dacb[0]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[0])
);

ODDR ODDR_4(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[1]),
	.D2(linien_analog_dacb[1]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[1])
);

ODDR ODDR_5(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[2]),
	.D2(linien_analog_dacb[2]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[2])
);

ODDR ODDR_6(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[3]),
	.D2(linien_analog_dacb[3]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[3])
);

ODDR ODDR_7(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[4]),
	.D2(linien_analog_dacb[4]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[4])
);

ODDR ODDR_8(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[5]),
	.D2(linien_analog_dacb[5]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[5])
);

ODDR ODDR_9(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[6]),
	.D2(linien_analog_dacb[6]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[6])
);

ODDR ODDR_10(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[7]),
	.D2(linien_analog_dacb[7]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[7])
);

ODDR ODDR_11(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[8]),
	.D2(linien_analog_dacb[8]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[8])
);

ODDR ODDR_12(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[9]),
	.D2(linien_analog_dacb[9]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[9])
);

ODDR ODDR_13(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[10]),
	.D2(linien_analog_dacb[10]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[10])
);

ODDR ODDR_14(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[11]),
	.D2(linien_analog_dacb[11]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[11])
);

ODDR ODDR_15(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[12]),
	.D2(linien_analog_dacb[12]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[12])
);

ODDR ODDR_16(
	.C(sys_clk),
	.CE(1'd1),
	.D1(linien_analog_daca[13]),
	.D2(linien_analog_dacb[13]),
	.R(1'd0),
	.S(1'd0),
	.Q(dac_data[13])
);

XADC #(
	.INIT_40(1'd0),
	.INIT_41(14'd12047),
	.INIT_42(11'd1024),
	.INIT_48(12'd2304),
	.INIT_49(10'd771),
	.INIT_4A(15'd18400),
	.INIT_4B(1'd0),
	.INIT_4C(12'd2048),
	.INIT_4D(10'd771),
	.INIT_4E(1'd0),
	.INIT_4F(1'd0),
	.INIT_50(16'd46573),
	.INIT_51(15'd22500),
	.INIT_52(16'd41287),
	.INIT_53(16'd51763),
	.INIT_54(16'd43322),
	.INIT_55(15'd21190),
	.INIT_56(16'd38229),
	.INIT_57(16'd44622),
	.INIT_58(15'd22937),
	.INIT_59(15'd21845),
	.INIT_5A(16'd39321),
	.INIT_5B(15'd27306),
	.INIT_5C(15'd20753),
	.INIT_5D(15'd20753),
	.INIT_5E(16'd37355),
	.INIT_5F(15'd26214)
) XADC (
	.CONVST(1'd0),
	.CONVSTCLK(1'd0),
	.DADDR(linien_xadc_channel),
	.DCLK(sys_clk),
	.DEN(linien_xadc_eoc),
	.DI(1'd0),
	.DWE(1'd0),
	.RESET(sys_rst),
	.VAUXN(slice_proxy0[15:0]),
	.VAUXP(slice_proxy1[15:0]),
	.VN(slice_proxy2[16]),
	.VP(slice_proxy3[16]),
	.ALM(linien_xadc_alarm),
	.BUSY(linien_xadc_busy),
	.CHANNEL(linien_xadc_channel),
	.DO(linien_xadc_data),
	.DRDY(linien_xadc_drdy),
	.EOC(linien_xadc_eoc),
	.EOS(linien_xadc_eos),
	.OT(linien_xadc_ot)
);

assign exp_n[0] = linien_gpio_n_tstriple0_oe ? linien_gpio_n_tstriple0_o : 1'bz;
assign linien_gpio_n_tstriple0_i = exp_n[0];

assign exp_n[1] = linien_gpio_n_tstriple1_oe ? linien_gpio_n_tstriple1_o : 1'bz;
assign linien_gpio_n_tstriple1_i = exp_n[1];

assign exp_n[2] = linien_gpio_n_tstriple2_oe ? linien_gpio_n_tstriple2_o : 1'bz;
assign linien_gpio_n_tstriple2_i = exp_n[2];

assign exp_n[3] = linien_gpio_n_tstriple3_oe ? linien_gpio_n_tstriple3_o : 1'bz;
assign linien_gpio_n_tstriple3_i = exp_n[3];

assign exp_n[4] = linien_gpio_n_tstriple4_oe ? linien_gpio_n_tstriple4_o : 1'bz;
assign linien_gpio_n_tstriple4_i = exp_n[4];

assign exp_n[5] = linien_gpio_n_tstriple5_oe ? linien_gpio_n_tstriple5_o : 1'bz;
assign linien_gpio_n_tstriple5_i = exp_n[5];

assign exp_n[6] = linien_gpio_n_tstriple6_oe ? linien_gpio_n_tstriple6_o : 1'bz;
assign linien_gpio_n_tstriple6_i = exp_n[6];

assign exp_n[7] = linien_gpio_n_tstriple7_oe ? linien_gpio_n_tstriple7_o : 1'bz;
assign linien_gpio_n_tstriple7_i = exp_n[7];

assign exp_p[0] = linien_gpio_p_tstriple0_oe ? linien_gpio_p_tstriple0_o : 1'bz;
assign linien_gpio_p_tstriple0_i = exp_p[0];

assign exp_p[1] = linien_gpio_p_tstriple1_oe ? linien_gpio_p_tstriple1_o : 1'bz;
assign linien_gpio_p_tstriple1_i = exp_p[1];

assign exp_p[2] = linien_gpio_p_tstriple2_oe ? linien_gpio_p_tstriple2_o : 1'bz;
assign linien_gpio_p_tstriple2_i = exp_p[2];

assign exp_p[3] = linien_gpio_p_tstriple3_oe ? linien_gpio_p_tstriple3_o : 1'bz;
assign linien_gpio_p_tstriple3_i = exp_p[3];

assign exp_p[4] = linien_gpio_p_tstriple4_oe ? linien_gpio_p_tstriple4_o : 1'bz;
assign linien_gpio_p_tstriple4_i = exp_p[4];

assign exp_p[5] = linien_gpio_p_tstriple5_oe ? linien_gpio_p_tstriple5_o : 1'bz;
assign linien_gpio_p_tstriple5_i = exp_p[5];

assign exp_p[6] = linien_gpio_p_tstriple6_oe ? linien_gpio_p_tstriple6_o : 1'bz;
assign linien_gpio_p_tstriple6_i = exp_p[6];

assign exp_p[7] = linien_gpio_p_tstriple7_oe ? linien_gpio_p_tstriple7_o : 1'bz;
assign linien_gpio_p_tstriple7_i = exp_p[7];

DNA_PORT DNA_PORT(
	.CLK(linien_dna_cnt[0]),
	.DIN(linien_dna_status[63]),
	.READ((linien_dna_cnt < 2'd2)),
	.SHIFT(1'd1),
	.DOUT(linien_dna_do)
);

red_pitaya_scope red_pitaya_scope(
	.adc_a_i((linien_scopegen_adc_a >>> 4'd11)),
	.adc_a_q_i((linien_scopegen_adc_a_q >>> 4'd11)),
	.adc_b_i((linien_scopegen_adc_b >>> 4'd11)),
	.adc_b_q_i((linien_scopegen_adc_b_q >>> 4'd11)),
	.adc_clk_i(sys_clk),
	.adc_rstn_i((~sys_rst)),
	.automatically_rearm_i(linien_scopegen_automatically_rearm),
	.sys_addr_i(linien_scopegen_scope_sys_addr),
	.sys_clk_i(linien_scopegen_scope_sys_clk),
	.sys_ren_i(linien_scopegen_scope_sys_ren),
	.sys_rstn_i(linien_scopegen_scope_sys_rstn),
	.sys_sel_i(linien_scopegen_scope_sys_sel),
	.sys_wdata_i(linien_scopegen_scope_sys_wdata),
	.sys_wen_i(linien_scopegen_scope_sys_wen),
	.trig_asg_i(linien_scopegen_asg_trig),
	.trig_ext_i((array_muxed | linien_scopegen_automatic_trigger_signal)),
	.scope_position(linien_scopegen_scope_position),
	.scope_writing_now(linien_scopegen_writing_data_now),
	.sys_ack_o(linien_scopegen_scope_sys_ack),
	.sys_err_o(linien_scopegen_scope_sys_err),
	.sys_rdata_o(linien_scopegen_scope_sys_rdata),
	.written_data(linien_scopegen_scope_written_data)
);

bus_clk_bridge bus_clk_bridge(
	.ack_i(linien_target_ack),
	.clk_i(linien_target_clk),
	.err_i(linien_target_err),
	.rdata_i(linien_target_rdata),
	.rstn_i(linien_target_rstn),
	.sys_addr_i(linien_source_addr),
	.sys_clk_i(linien_source_clk),
	.sys_ren_i(linien_source_ren),
	.sys_rstn_i(linien_source_rstn),
	.sys_sel_i(linien_source_sel),
	.sys_wdata_i(linien_source_wdata),
	.sys_wen_i(linien_source_wen),
	.addr_o(linien_target_addr),
	.ren_o(linien_target_ren),
	.sys_ack_o(linien_source_ack),
	.sys_err_o(linien_source_err),
	.sys_rdata_o(linien_source_rdata),
	.wdata_o(linien_target_wdata),
	.wen_o(linien_target_wen)
);

endmodule
