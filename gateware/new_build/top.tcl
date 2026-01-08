create_project -force -name top -part xc7z010-clg400-1
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
add_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/red_pitaya_scope.v}
set_property library work [get_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/red_pitaya_scope.v}]
add_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/axi_slave.v}
set_property library work [get_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/axi_slave.v}]
add_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/system_processing_system7_0_0.v}
set_property library work [get_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/system_processing_system7_0_0.v}]
add_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/processing_system7_v5_4_processing_system7.v}
set_property library work [get_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/processing_system7_v5_4_processing_system7.v}]
add_files {top.v}
set_property library work [get_files {top.v}]
add_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/bus_clk_bridge.v}
set_property library work [get_files {/home/goblin/projects/projects/linien/linien/gateware/verilog/bus_clk_bridge.v}]
read_xdc top.xdc
read_xdc -ref processing_system7_v5_4_processing_system7 ../verilog/system_processing_system7_0_0.xdc
synth_design -top top -part xc7z010-clg400-1
report_timing_summary -file top_timing_synth.rpt
report_utilization -hierarchical -file top_utilization_hierarchical_synth.rpt
report_utilization -file top_utilization_synth.rpt
opt_design
place_design
phys_opt_design -directive AddRetime
report_utilization -hierarchical -file top_utilization_hierarchical_place.rpt
report_utilization -file top_utilization_place.rpt
report_io -file top_io.rpt
report_control_sets -verbose -file top_control_sets.rpt
report_clock_utilization -file top_clock_utilization.rpt
route_design
phys_opt_design
report_timing_summary -no_header -no_detailed_paths
write_checkpoint -force top_route.dcp
report_route_status -file top_route_status.rpt
report_drc -file top_drc.rpt
report_timing_summary -datasheet -max_paths 10 -file top_timing.rpt
report_power -file top_power.rpt
write_bitstream -force top.bit 
quit