`include "carry_skip_adder.v"
`include "compare.v"
`include "Div.v"
`include "one_picture.v"
`include "pixel_adder.v"
`include "pixel_in_compare.v"
`include "sort_reg.v"
`include "sorting.v"
`include "strength_adder.v"

`timescale 1ns/10ps
module ISE( clk, reset, image_in_index, pixel_in, busy, out_valid, color_index, image_out_index);
  input           clk;
  input           reset;
  input   [4:0]   image_in_index;
  input   [23:0]  pixel_in;
  
  output          busy;
  output          out_valid;
  output  [1:0]   color_index;
  output  [4:0]   image_out_index;

  //   1
  //   input: pixel_in
  //   output: Radd_en, Gadd_en, Badd_en, strength_input
  //***color comparator***//
  pixel_in_compare pic(pixel_in, Radd_en, Gadd_en, Badd_en, strength_input);
  
  //   1.5
  //   input: Radd_en, Gadd_en, Badd_en, reset, clk
  //   output: one_picture
  //***one picture***//
  RGBadd_enable_timer (Radd_en, Gadd_en, Badd_en, reset, clk, one_picture);  
  
  //   2
  //   input: Radd_en, Gadd_en, Badd_en(from color comparator), clk, reset;
  //   output: Rpixel_num, Gpixel_num, Bpixel_num
  //***pixel adder***//
  pixel_adder pa(Radd_en, Gadd_en, Badd_en, clk, reset, Rpixel_num, Gpixel_num, Bpixel_num);
  //***output dividend(15-bits)***//
  pixel_number_compare pnc(Rpixel_num, Gpixel_num, Bpixel_num, one_picture, Rd_en, Gd_en, Bd_en, dividend); 
  
  //   3
  //   input: Radd_en, Gadd_en, Badd_en, strength_input(from color comparator), clk, reset
  //   output: Rstrength, Gstrength, Bstrength
  //***pixel's strength adder***//
  strength_adder sa(strength_input, Radd_en, Gadd_en, Badd_en, clk, reset, Rstrength, Gstrength, Bstrength);
  //***output divisor(22-bits)***//
  pixel_strength_compare psc(Rstrength, Gstrength, Bstrength, one_picture, Rd_en, Gd_en, Bd_en, divisor); 
  
  //   4
  //   input: 
  //   output:
  //***Divider***//
  Div_0 div(DV, DVN, clk, reset, Q, R);
  //***Divider Timer***// 
  div_counter (one_picture, clk, sort_reg_en, renew_index);
  
  //   input: old_index, Q, clk, reset 
  //   output: s1~s32
  //***save average value from divider***//
  sort_reg sr(old_index, Q, clk, reset, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32, start_count);  
  
  //   5
  //   input: s1~s32
  //   output: s_1~s_32
  //***Sorting***//
  odd_even_merge_sort oems(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32, 
s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32);
  //***sort result***//
  sort_result(start_count, clk, reset, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32, color_index, image_out_index);

endmodule