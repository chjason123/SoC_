set_property IOSTANDARD LVCMOS25 [get_ports clk]
set_property PACKAGE_PIN Y9 [get_ports clk]


set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS25} [get_ports {rst}]

set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS25} [get_ports {hsync_sig}]  
set_property -dict {PACKAGE_PIN AB9 IOSTANDARD LVCMOS25} [get_ports {vsync_sig}] 

set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS25} [get_ports {o_led[0]}]
set_property -dict {PACKAGE_PIN T21 IOSTANDARD LVCMOS25} [get_ports {o_led[1]}]
set_property -dict {PACKAGE_PIN U22 IOSTANDARD LVCMOS25} [get_ports {o_led[2]}]
set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS25} [get_ports {o_led[3]}]
set_property -dict {PACKAGE_PIN V22 IOSTANDARD LVCMOS25} [get_ports {o_led[4]}]
set_property -dict {PACKAGE_PIN W22 IOSTANDARD LVCMOS25} [get_ports {o_led[5]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS25} [get_ports {o_led[6]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS25} [get_ports {o_led[7]}]

set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVCMOS25} [get_ports {red_sig[0]}] 
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS25} [get_ports {red_sig[1]}] 
set_property -dict {PACKAGE_PIN Y10 IOSTANDARD LVCMOS25} [get_ports {red_sig[2]}]
set_property -dict {PACKAGE_PIN AB6 IOSTANDARD LVCMOS25} [get_ports {red_sig[3]}]  

set_property -dict {PACKAGE_PIN Y4 IOSTANDARD LVCMOS25} [get_ports {green_sig[0]}] 
set_property -dict {PACKAGE_PIN AA4 IOSTANDARD LVCMOS25} [get_ports {green_sig[1]}] 
set_property -dict {PACKAGE_PIN R6 IOSTANDARD LVCMOS25} [get_ports {green_sig[2]}] 
set_property -dict {PACKAGE_PIN T6 IOSTANDARD LVCMOS25} [get_ports {green_sig[3]}] 

set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS25} [get_ports {blue_sig[0]}] 
set_property -dict {PACKAGE_PIN AA11 IOSTANDARD LVCMOS25} [get_ports {blue_sig[1]}] 
set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVCMOS25} [get_ports {blue_sig[2]}]
set_property -dict {PACKAGE_PIN AA7 IOSTANDARD LVCMOS25} [get_ports {blue_sig[3]}]

set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS25} [get_ports {i_R_button}]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS25} [get_ports {i_L_button}]

set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS25} [get_ports {i_Start_button}]