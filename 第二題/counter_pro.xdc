set_property IOSTANDARD LVCMOS25 [get_ports i_clk]
set_property PACKAGE_PIN Y9 [get_ports i_clk]

set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS25} [get_ports {i_reset}]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS25} [get_ports {i_enable_1}]

set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS25} [get_ports {i_1_SetMinNumber[3]}]
set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS25} [get_ports {i_1_SetMinNumber[2]}]
set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS25} [get_ports {i_1_SetMinNumber[1]}]
set_property -dict {PACKAGE_PIN F21 IOSTANDARD LVCMOS25} [get_ports {i_1_SetMinNumber[0]}]
set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVCMOS25} [get_ports {i_1_SetMaxNumber[3]}]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS25} [get_ports {i_1_SetMaxNumber[2]}]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS25} [get_ports {i_1_SetMaxNumber[1]}]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS25} [get_ports {i_1_SetMaxNumber[0]}]

set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS25} [get_ports {o_1_count[3]}]
set_property -dict {PACKAGE_PIN T21 IOSTANDARD LVCMOS25} [get_ports {o_1_count[2]}]
set_property -dict {PACKAGE_PIN U22 IOSTANDARD LVCMOS25} [get_ports {o_1_count[1]}]
set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS25} [get_ports {o_1_count[0]}]

set_property -dict {PACKAGE_PIN V22 IOSTANDARD LVCMOS25} [get_ports {o_2_count[3]}]
set_property -dict {PACKAGE_PIN W22 IOSTANDARD LVCMOS25} [get_ports {o_2_count[2]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS25} [get_ports {o_2_count[1]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS25} [get_ports {o_2_count[0]}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets i_reset_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets i_enable_1_IBUF]
