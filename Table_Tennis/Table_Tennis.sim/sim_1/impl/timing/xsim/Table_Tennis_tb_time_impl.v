// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Tue Jan 21 01:35:54 2025
// Host        : guanhau running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/USER/Desktop/lab_5/test/Table_Tennis/Table_Tennis.sim/sim_1/impl/timing/xsim/Table_Tennis_tb_time_impl.v
// Design      : Table_Tennis
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "76f06f81" *) 
(* NotValidForBitStream *)
(* \DesignAttr:ENABLE_NOC_NETLIST_VIEW  *) 
(* \DesignAttr:ENABLE_AIE_NETLIST_VIEW  *) 
module Table_Tennis
   (i_clk,
    i_rst,
    i_R_button,
    i_L_button,
    o_FSM_state,
    o_led);
  input i_clk;
  input i_rst;
  input i_R_button;
  input i_L_button;
  output [2:0]o_FSM_state;
  output [7:0]o_led;

  wire \FSM_onehot_FSM_state[0]_i_1_n_0 ;
  wire \FSM_onehot_FSM_state[1]_i_1_n_0 ;
  wire \FSM_onehot_FSM_state[1]_i_2_n_0 ;
  wire \FSM_onehot_FSM_state[1]_i_3_n_0 ;
  wire \FSM_onehot_FSM_state[2]_i_1_n_0 ;
  wire \FSM_onehot_FSM_state[2]_i_2_n_0 ;
  wire \FSM_onehot_FSM_state[2]_i_3_n_0 ;
  wire \FSM_onehot_FSM_state[3]_i_1_n_0 ;
  wire \FSM_onehot_FSM_state[4]_i_1_n_0 ;
  wire \FSM_onehot_FSM_state[4]_i_2_n_0 ;
  wire \FSM_onehot_FSM_state[4]_i_3_n_0 ;
  wire \FSM_onehot_FSM_state[4]_i_4_n_0 ;
  wire \FSM_onehot_FSM_state[4]_i_5_n_0 ;
  wire \FSM_onehot_FSM_state[4]_i_6_n_0 ;
  wire \FSM_onehot_FSM_state[4]_i_7_n_0 ;
  wire \FSM_onehot_FSM_state_reg_n_0_[0] ;
  wire \FSM_onehot_FSM_state_reg_n_0_[1] ;
  wire \FSM_onehot_FSM_state_reg_n_0_[2] ;
  wire \FSM_onehot_FSM_state_reg_n_0_[3] ;
  wire \ball_reg_n_0_[0] ;
  wire \ball_reg_n_0_[1] ;
  wire \ball_reg_n_0_[2] ;
  wire \ball_reg_n_0_[3] ;
  wire \ball_reg_n_0_[4] ;
  wire \ball_reg_n_0_[5] ;
  wire \ball_reg_n_0_[6] ;
  wire \ball_reg_n_0_[7] ;
  wire \counter[0]_i_1_n_0 ;
  wire [0:0]counter_reg;
  wire i_L_button;
  wire i_L_button_IBUF;
  wire i_R_button;
  wire i_R_button_IBUF;
  wire i_clk;
  wire i_clk_IBUF;
  wire i_clk_IBUF_BUFG;
  wire i_rst;
  wire i_rst_IBUF;
  wire [3:0]l_score;
  wire l_score__0;
  wire \l_score_reg[0]_i_1_n_0 ;
  wire \l_score_reg[1]_i_1_n_0 ;
  wire \l_score_reg[2]_i_1_n_0 ;
  wire \l_score_reg[3]_i_1_n_0 ;
  wire \l_score_reg[3]_i_2_n_0 ;
  wire [2:0]o_FSM_state;
  wire [2:0]o_FSM_state_OBUF;
  wire [7:0]o_led;
  wire [7:0]o_led_OBUF;
  wire \o_led_reg[0]_i_1_n_0 ;
  wire \o_led_reg[1]_i_1_n_0 ;
  wire \o_led_reg[2]_i_1_n_0 ;
  wire \o_led_reg[3]_i_1_n_0 ;
  wire \o_led_reg[4]_i_1_n_0 ;
  wire \o_led_reg[5]_i_1_n_0 ;
  wire \o_led_reg[6]_i_1_n_0 ;
  wire \o_led_reg[7]_i_1_n_0 ;
  wire \o_led_reg[7]_i_2_n_0 ;
  wire [7:0]p_0_in;
  wire [3:0]plusOp;
  wire [3:0]r_score;

initial begin
 $sdf_annotate("Table_Tennis_tb_time_impl.sdf",,,,"tool_control");
end
  LUT6 #(
    .INIT(64'h40FF404040404040)) 
    \FSM_onehot_FSM_state[0]_i_1 
       (.I0(\FSM_onehot_FSM_state[2]_i_2_n_0 ),
        .I1(l_score[3]),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[3] ),
        .I3(\FSM_onehot_FSM_state[1]_i_2_n_0 ),
        .I4(r_score[3]),
        .I5(o_FSM_state_OBUF[2]),
        .O(\FSM_onehot_FSM_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFF8CFFFFFF8CFF8C)) 
    \FSM_onehot_FSM_state[1]_i_1 
       (.I0(\FSM_onehot_FSM_state[1]_i_2_n_0 ),
        .I1(o_FSM_state_OBUF[2]),
        .I2(r_score[3]),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_FSM_state[1]_i_3_n_0 ),
        .I5(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .O(\FSM_onehot_FSM_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \FSM_onehot_FSM_state[1]_i_2 
       (.I0(r_score[1]),
        .I1(r_score[0]),
        .I2(r_score[2]),
        .O(\FSM_onehot_FSM_state[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hFFF7)) 
    \FSM_onehot_FSM_state[1]_i_3 
       (.I0(i_R_button_IBUF),
        .I1(\ball_reg_n_0_[0] ),
        .I2(\ball_reg_n_0_[7] ),
        .I3(\FSM_onehot_FSM_state[4]_i_6_n_0 ),
        .O(\FSM_onehot_FSM_state[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hA2FFA2A2)) 
    \FSM_onehot_FSM_state[2]_i_1 
       (.I0(\FSM_onehot_FSM_state_reg_n_0_[3] ),
        .I1(l_score[3]),
        .I2(\FSM_onehot_FSM_state[2]_i_2_n_0 ),
        .I3(\FSM_onehot_FSM_state[2]_i_3_n_0 ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .O(\FSM_onehot_FSM_state[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \FSM_onehot_FSM_state[2]_i_2 
       (.I0(l_score[1]),
        .I1(l_score[0]),
        .I2(l_score[2]),
        .O(\FSM_onehot_FSM_state[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hFFBF)) 
    \FSM_onehot_FSM_state[2]_i_3 
       (.I0(\ball_reg_n_0_[0] ),
        .I1(\ball_reg_n_0_[7] ),
        .I2(i_L_button_IBUF),
        .I3(\FSM_onehot_FSM_state[4]_i_6_n_0 ),
        .O(\FSM_onehot_FSM_state[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hEFFF0000)) 
    \FSM_onehot_FSM_state[3]_i_1 
       (.I0(\FSM_onehot_FSM_state[4]_i_6_n_0 ),
        .I1(\ball_reg_n_0_[7] ),
        .I2(\ball_reg_n_0_[0] ),
        .I3(i_R_button_IBUF),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .O(\FSM_onehot_FSM_state[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFEEEA)) 
    \FSM_onehot_FSM_state[4]_i_1 
       (.I0(\FSM_onehot_FSM_state[4]_i_4_n_0 ),
        .I1(i_R_button_IBUF),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_FSM_state[0]_i_1_n_0 ),
        .I5(\FSM_onehot_FSM_state[4]_i_5_n_0 ),
        .O(\FSM_onehot_FSM_state[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hFFBF0000)) 
    \FSM_onehot_FSM_state[4]_i_2 
       (.I0(\FSM_onehot_FSM_state[4]_i_6_n_0 ),
        .I1(i_L_button_IBUF),
        .I2(\ball_reg_n_0_[7] ),
        .I3(\ball_reg_n_0_[0] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .O(\FSM_onehot_FSM_state[4]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_FSM_state[4]_i_3 
       (.I0(i_rst_IBUF),
        .O(\FSM_onehot_FSM_state[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h88888888888F8888)) 
    \FSM_onehot_FSM_state[4]_i_4 
       (.I0(o_FSM_state_OBUF[2]),
        .I1(i_R_button_IBUF),
        .I2(\FSM_onehot_FSM_state[4]_i_6_n_0 ),
        .I3(\ball_reg_n_0_[7] ),
        .I4(\FSM_onehot_FSM_state[4]_i_7_n_0 ),
        .I5(\ball_reg_n_0_[0] ),
        .O(\FSM_onehot_FSM_state[4]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hE0)) 
    \FSM_onehot_FSM_state[4]_i_5 
       (.I0(\FSM_onehot_FSM_state_reg_n_0_[3] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I2(i_L_button_IBUF),
        .O(\FSM_onehot_FSM_state[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \FSM_onehot_FSM_state[4]_i_6 
       (.I0(\ball_reg_n_0_[5] ),
        .I1(\ball_reg_n_0_[6] ),
        .I2(\ball_reg_n_0_[3] ),
        .I3(\ball_reg_n_0_[4] ),
        .I4(\ball_reg_n_0_[2] ),
        .I5(\ball_reg_n_0_[1] ),
        .O(\FSM_onehot_FSM_state[4]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_onehot_FSM_state[4]_i_7 
       (.I0(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .O(\FSM_onehot_FSM_state[4]_i_7_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:10000,iSTATE0:01000,iSTATE1:00100,iSTATE2:00010,iSTATE3:00001" *) 
  FDPE #(
    .INIT(1'b1)) 
    \FSM_onehot_FSM_state_reg[0] 
       (.C(i_clk_IBUF_BUFG),
        .CE(\FSM_onehot_FSM_state[4]_i_1_n_0 ),
        .D(\FSM_onehot_FSM_state[0]_i_1_n_0 ),
        .PRE(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .Q(\FSM_onehot_FSM_state_reg_n_0_[0] ));
  (* FSM_ENCODED_STATES = "iSTATE:10000,iSTATE0:01000,iSTATE1:00100,iSTATE2:00010,iSTATE3:00001" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_FSM_state_reg[1] 
       (.C(i_clk_IBUF_BUFG),
        .CE(\FSM_onehot_FSM_state[4]_i_1_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\FSM_onehot_FSM_state[1]_i_1_n_0 ),
        .Q(\FSM_onehot_FSM_state_reg_n_0_[1] ));
  (* FSM_ENCODED_STATES = "iSTATE:10000,iSTATE0:01000,iSTATE1:00100,iSTATE2:00010,iSTATE3:00001" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_FSM_state_reg[2] 
       (.C(i_clk_IBUF_BUFG),
        .CE(\FSM_onehot_FSM_state[4]_i_1_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\FSM_onehot_FSM_state[2]_i_1_n_0 ),
        .Q(\FSM_onehot_FSM_state_reg_n_0_[2] ));
  (* FSM_ENCODED_STATES = "iSTATE:10000,iSTATE0:01000,iSTATE1:00100,iSTATE2:00010,iSTATE3:00001" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_FSM_state_reg[3] 
       (.C(i_clk_IBUF_BUFG),
        .CE(\FSM_onehot_FSM_state[4]_i_1_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\FSM_onehot_FSM_state[3]_i_1_n_0 ),
        .Q(\FSM_onehot_FSM_state_reg_n_0_[3] ));
  (* FSM_ENCODED_STATES = "iSTATE:10000,iSTATE0:01000,iSTATE1:00100,iSTATE2:00010,iSTATE3:00001" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_FSM_state_reg[4] 
       (.C(i_clk_IBUF_BUFG),
        .CE(\FSM_onehot_FSM_state[4]_i_1_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\FSM_onehot_FSM_state[4]_i_2_n_0 ),
        .Q(o_FSM_state_OBUF[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hAAAAFABB)) 
    \ball[0]_i_1 
       (.I0(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[3] ),
        .I2(\ball_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .O(p_0_in[0]));
  LUT5 #(
    .INIT(32'h0000ACA0)) 
    \ball[1]_i_1 
       (.I0(\ball_reg_n_0_[0] ),
        .I1(\ball_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .O(p_0_in[1]));
  LUT5 #(
    .INIT(32'h0000ACA0)) 
    \ball[2]_i_1 
       (.I0(\ball_reg_n_0_[1] ),
        .I1(\ball_reg_n_0_[3] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .O(p_0_in[2]));
  LUT5 #(
    .INIT(32'h0000ACA0)) 
    \ball[3]_i_1 
       (.I0(\ball_reg_n_0_[2] ),
        .I1(\ball_reg_n_0_[4] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .O(p_0_in[3]));
  LUT5 #(
    .INIT(32'h0000ACA0)) 
    \ball[4]_i_1 
       (.I0(\ball_reg_n_0_[3] ),
        .I1(\ball_reg_n_0_[5] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .O(p_0_in[4]));
  LUT5 #(
    .INIT(32'h0000ACA0)) 
    \ball[5]_i_1 
       (.I0(\ball_reg_n_0_[4] ),
        .I1(\ball_reg_n_0_[6] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .O(p_0_in[5]));
  LUT5 #(
    .INIT(32'h0000ACA0)) 
    \ball[6]_i_1 
       (.I0(\ball_reg_n_0_[5] ),
        .I1(\ball_reg_n_0_[7] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h00A300A0)) 
    \ball[7]_i_1 
       (.I0(\ball_reg_n_0_[6] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[3] ),
        .O(p_0_in[7]));
  FDPE #(
    .INIT(1'b1)) 
    \ball_reg[0] 
       (.C(counter_reg),
        .CE(\o_led_reg[7]_i_2_n_0 ),
        .D(p_0_in[0]),
        .PRE(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .Q(\ball_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \ball_reg[1] 
       (.C(counter_reg),
        .CE(\o_led_reg[7]_i_2_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(p_0_in[1]),
        .Q(\ball_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \ball_reg[2] 
       (.C(counter_reg),
        .CE(\o_led_reg[7]_i_2_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(p_0_in[2]),
        .Q(\ball_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \ball_reg[3] 
       (.C(counter_reg),
        .CE(\o_led_reg[7]_i_2_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(p_0_in[3]),
        .Q(\ball_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \ball_reg[4] 
       (.C(counter_reg),
        .CE(\o_led_reg[7]_i_2_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(p_0_in[4]),
        .Q(\ball_reg_n_0_[4] ));
  FDCE #(
    .INIT(1'b0)) 
    \ball_reg[5] 
       (.C(counter_reg),
        .CE(\o_led_reg[7]_i_2_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(p_0_in[5]),
        .Q(\ball_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \ball_reg[6] 
       (.C(counter_reg),
        .CE(\o_led_reg[7]_i_2_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(p_0_in[6]),
        .Q(\ball_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \ball_reg[7] 
       (.C(counter_reg),
        .CE(\o_led_reg[7]_i_2_n_0 ),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(p_0_in[7]),
        .Q(\ball_reg_n_0_[7] ));
  LUT1 #(
    .INIT(2'h1)) 
    \counter[0]_i_1 
       (.I0(counter_reg),
        .O(\counter[0]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[0] 
       (.C(i_clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\counter[0]_i_1_n_0 ),
        .Q(counter_reg));
  IBUF i_L_button_IBUF_inst
       (.I(i_L_button),
        .O(i_L_button_IBUF));
  IBUF i_R_button_IBUF_inst
       (.I(i_R_button),
        .O(i_R_button_IBUF));
  BUFG i_clk_IBUF_BUFG_inst
       (.I(i_clk_IBUF),
        .O(i_clk_IBUF_BUFG));
  IBUF i_clk_IBUF_inst
       (.I(i_clk),
        .O(i_clk_IBUF));
  IBUF i_rst_IBUF_inst
       (.I(i_rst),
        .O(i_rst_IBUF));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \l_score_reg[0] 
       (.CLR(l_score__0),
        .D(\l_score_reg[0]_i_1_n_0 ),
        .G(\l_score_reg[3]_i_2_n_0 ),
        .GE(1'b1),
        .Q(l_score[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \l_score_reg[0]_i_1 
       (.I0(l_score[0]),
        .O(\l_score_reg[0]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \l_score_reg[1] 
       (.CLR(l_score__0),
        .D(\l_score_reg[1]_i_1_n_0 ),
        .G(\l_score_reg[3]_i_2_n_0 ),
        .GE(1'b1),
        .Q(l_score[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \l_score_reg[1]_i_1 
       (.I0(l_score[0]),
        .I1(l_score[1]),
        .O(\l_score_reg[1]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \l_score_reg[2] 
       (.CLR(l_score__0),
        .D(\l_score_reg[2]_i_1_n_0 ),
        .G(\l_score_reg[3]_i_2_n_0 ),
        .GE(1'b1),
        .Q(l_score[2]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \l_score_reg[2]_i_1 
       (.I0(l_score[1]),
        .I1(l_score[0]),
        .I2(l_score[2]),
        .O(\l_score_reg[2]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \l_score_reg[3] 
       (.CLR(l_score__0),
        .D(\l_score_reg[3]_i_1_n_0 ),
        .G(\l_score_reg[3]_i_2_n_0 ),
        .GE(1'b1),
        .Q(l_score[3]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \l_score_reg[3]_i_1 
       (.I0(l_score[2]),
        .I1(l_score[0]),
        .I2(l_score[1]),
        .I3(l_score[3]),
        .O(\l_score_reg[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \l_score_reg[3]_i_2 
       (.I0(\FSM_onehot_FSM_state_reg_n_0_[3] ),
        .I1(o_FSM_state_OBUF[2]),
        .O(\l_score_reg[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \l_score_reg[3]_i_3 
       (.I0(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I1(i_rst_IBUF),
        .O(l_score__0));
  OBUF \o_FSM_state_OBUF[0]_inst 
       (.I(o_FSM_state_OBUF[0]),
        .O(o_FSM_state[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \o_FSM_state_OBUF[0]_inst_i_1 
       (.I0(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[3] ),
        .O(o_FSM_state_OBUF[0]));
  OBUF \o_FSM_state_OBUF[1]_inst 
       (.I(o_FSM_state_OBUF[1]),
        .O(o_FSM_state[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \o_FSM_state_OBUF[1]_inst_i_1 
       (.I0(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[3] ),
        .O(o_FSM_state_OBUF[1]));
  OBUF \o_FSM_state_OBUF[2]_inst 
       (.I(o_FSM_state_OBUF[2]),
        .O(o_FSM_state[2]));
  OBUF \o_led_OBUF[0]_inst 
       (.I(o_led_OBUF[0]),
        .O(o_led[0]));
  OBUF \o_led_OBUF[1]_inst 
       (.I(o_led_OBUF[1]),
        .O(o_led[1]));
  OBUF \o_led_OBUF[2]_inst 
       (.I(o_led_OBUF[2]),
        .O(o_led[2]));
  OBUF \o_led_OBUF[3]_inst 
       (.I(o_led_OBUF[3]),
        .O(o_led[3]));
  OBUF \o_led_OBUF[4]_inst 
       (.I(o_led_OBUF[4]),
        .O(o_led[4]));
  OBUF \o_led_OBUF[5]_inst 
       (.I(o_led_OBUF[5]),
        .O(o_led[5]));
  OBUF \o_led_OBUF[6]_inst 
       (.I(o_led_OBUF[6]),
        .O(o_led[6]));
  OBUF \o_led_OBUF[7]_inst 
       (.I(o_led_OBUF[7]),
        .O(o_led[7]));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \o_led_reg[0] 
       (.CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\o_led_reg[0]_i_1_n_0 ),
        .G(\o_led_reg[7]_i_2_n_0 ),
        .GE(1'b1),
        .Q(o_led_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hAAABAAA8)) 
    \o_led_reg[0]_i_1 
       (.I0(\ball_reg_n_0_[0] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(r_score[0]),
        .O(\o_led_reg[0]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \o_led_reg[1] 
       (.CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\o_led_reg[1]_i_1_n_0 ),
        .G(\o_led_reg[7]_i_2_n_0 ),
        .GE(1'b1),
        .Q(o_led_OBUF[1]));
  LUT5 #(
    .INIT(32'hAAABAAA8)) 
    \o_led_reg[1]_i_1 
       (.I0(\ball_reg_n_0_[1] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(r_score[1]),
        .O(\o_led_reg[1]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \o_led_reg[2] 
       (.CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\o_led_reg[2]_i_1_n_0 ),
        .G(\o_led_reg[7]_i_2_n_0 ),
        .GE(1'b1),
        .Q(o_led_OBUF[2]));
  LUT5 #(
    .INIT(32'hAAABAAA8)) 
    \o_led_reg[2]_i_1 
       (.I0(\ball_reg_n_0_[2] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(r_score[2]),
        .O(\o_led_reg[2]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \o_led_reg[3] 
       (.CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\o_led_reg[3]_i_1_n_0 ),
        .G(\o_led_reg[7]_i_2_n_0 ),
        .GE(1'b1),
        .Q(o_led_OBUF[3]));
  LUT5 #(
    .INIT(32'hAAABAAA8)) 
    \o_led_reg[3]_i_1 
       (.I0(\ball_reg_n_0_[3] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(r_score[3]),
        .O(\o_led_reg[3]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \o_led_reg[4] 
       (.CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\o_led_reg[4]_i_1_n_0 ),
        .G(\o_led_reg[7]_i_2_n_0 ),
        .GE(1'b1),
        .Q(o_led_OBUF[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hAAABAAA8)) 
    \o_led_reg[4]_i_1 
       (.I0(\ball_reg_n_0_[4] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(l_score[0]),
        .O(\o_led_reg[4]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \o_led_reg[5] 
       (.CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\o_led_reg[5]_i_1_n_0 ),
        .G(\o_led_reg[7]_i_2_n_0 ),
        .GE(1'b1),
        .Q(o_led_OBUF[5]));
  LUT5 #(
    .INIT(32'hAAABAAA8)) 
    \o_led_reg[5]_i_1 
       (.I0(\ball_reg_n_0_[5] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(l_score[1]),
        .O(\o_led_reg[5]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \o_led_reg[6] 
       (.CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\o_led_reg[6]_i_1_n_0 ),
        .G(\o_led_reg[7]_i_2_n_0 ),
        .GE(1'b1),
        .Q(o_led_OBUF[6]));
  LUT5 #(
    .INIT(32'hAAABAAA8)) 
    \o_led_reg[6]_i_1 
       (.I0(\ball_reg_n_0_[6] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(l_score[2]),
        .O(\o_led_reg[6]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \o_led_reg[7] 
       (.CLR(\FSM_onehot_FSM_state[4]_i_3_n_0 ),
        .D(\o_led_reg[7]_i_1_n_0 ),
        .G(\o_led_reg[7]_i_2_n_0 ),
        .GE(1'b1),
        .Q(o_led_OBUF[7]));
  LUT5 #(
    .INIT(32'hAAABAAA8)) 
    \o_led_reg[7]_i_1 
       (.I0(\ball_reg_n_0_[7] ),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I4(l_score[3]),
        .O(\o_led_reg[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \o_led_reg[7]_i_2 
       (.I0(o_FSM_state_OBUF[2]),
        .I1(\FSM_onehot_FSM_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_FSM_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_FSM_state_reg_n_0_[1] ),
        .I4(\FSM_onehot_FSM_state_reg_n_0_[2] ),
        .O(\o_led_reg[7]_i_2_n_0 ));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \r_score_reg[0] 
       (.CLR(l_score__0),
        .D(plusOp[0]),
        .G(o_FSM_state_OBUF[2]),
        .GE(1'b1),
        .Q(r_score[0]));
  LUT1 #(
    .INIT(2'h1)) 
    \r_score_reg[0]_i_1 
       (.I0(r_score[0]),
        .O(plusOp[0]));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \r_score_reg[1] 
       (.CLR(l_score__0),
        .D(plusOp[1]),
        .G(o_FSM_state_OBUF[2]),
        .GE(1'b1),
        .Q(r_score[1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \r_score_reg[1]_i_1 
       (.I0(r_score[0]),
        .I1(r_score[1]),
        .O(plusOp[1]));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \r_score_reg[2] 
       (.CLR(l_score__0),
        .D(plusOp[2]),
        .G(o_FSM_state_OBUF[2]),
        .GE(1'b1),
        .Q(r_score[2]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \r_score_reg[2]_i_1 
       (.I0(r_score[1]),
        .I1(r_score[0]),
        .I2(r_score[2]),
        .O(plusOp[2]));
  (* XILINX_LEGACY_PRIM = "LDC" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE" *) 
  LDCE #(
    .INIT(1'b0)) 
    \r_score_reg[3] 
       (.CLR(l_score__0),
        .D(plusOp[3]),
        .G(o_FSM_state_OBUF[2]),
        .GE(1'b1),
        .Q(r_score[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \r_score_reg[3]_i_1 
       (.I0(r_score[2]),
        .I1(r_score[0]),
        .I2(r_score[1]),
        .I3(r_score[3]),
        .O(plusOp[3]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
