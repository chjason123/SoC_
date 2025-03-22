set_property IOSTANDARD LVCMOS25 [get_ports clk]
set_property PACKAGE_PIN Y9 [get_ports clk]


set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS25} [get_ports {rst}]

set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS25} [get_ports {h_sync}]  
set_property -dict {PACKAGE_PIN AB9 IOSTANDARD LVCMOS25} [get_ports {v_sync}] 

set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVCMOS25} [get_ports {red_out[0]}] 
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS25} [get_ports {red_out[1]}] 
set_property -dict {PACKAGE_PIN Y10 IOSTANDARD LVCMOS25} [get_ports {red_out[2]}]
set_property -dict {PACKAGE_PIN AB6 IOSTANDARD LVCMOS25} [get_ports {red_out[3]}]  

set_property -dict {PACKAGE_PIN Y4 IOSTANDARD LVCMOS25} [get_ports {green_out[0]}] 
set_property -dict {PACKAGE_PIN AA4 IOSTANDARD LVCMOS25} [get_ports {green_out[1]}] 
set_property -dict {PACKAGE_PIN R6 IOSTANDARD LVCMOS25} [get_ports {green_out[2]}] 
set_property -dict {PACKAGE_PIN T6 IOSTANDARD LVCMOS25} [get_ports {green_out[3]}] 

set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS25} [get_ports {blue_out[0]}] 
set_property -dict {PACKAGE_PIN AA11 IOSTANDARD LVCMOS25} [get_ports {blue_out[1]}] 
set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVCMOS25} [get_ports {blue_out[2]}]
set_property -dict {PACKAGE_PIN AA7 IOSTANDARD LVCMOS25} [get_ports {blue_out[3]}]

