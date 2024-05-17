`include "carry_skip_adder.v"

module sort_result(start_count, clk, reset, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32, color_index, image_out_index);

  input [28:0] s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32;
  input start_count, clk, reset;
  output [1:0] color_index;
  output [4:0] image_out_index;
  
  // ci => color_index & image_out_index
  wire [6:0] out_c_i, ci1, ci2, ci3, ci4, ci5, ci6, ci7, ci8, ci9, ci10, ci11, ci12, ci13, ci14, ci15, ci16, ci17, ci18, ci19, ci20, ci21, ci22, ci23, ci24, ci25, ci26, ci27, ci28, ci29, ci30, ci31, ci32;
  wire [6:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31, out32;
  wire [4:0] new_count, count, count1, result;
  wire [31:0] output_en;

  assign ci1=s_1[28:22];
  assign ci2=s_2[28:22];
  assign ci3=s_3[28:22];
  assign ci4=s_4[28:22];
  assign ci5=s_5[28:22];
  assign ci6=s_6[28:22];
  assign ci7=s_7[28:22];
  assign ci8=s_8[28:22];
  assign ci9=s_9[28:22];
  assign ci10=s_10[28:22];
  assign ci11=s_11[28:22];
  assign ci12=s_12[28:22];
  assign ci13=s_13[28:22];
  assign ci14=s_14[28:22];
  assign ci15=s_15[28:22];
  assign ci16=s_16[28:22];
  assign ci17=s_17[28:22];
  assign ci18=s_18[28:22];
  assign ci19=s_19[28:22];
  assign ci20=s_20[28:22];
  assign ci21=s_21[28:22];
  assign ci22=s_22[28:22];
  assign ci23=s_23[28:22];
  assign ci24=s_24[28:22];
  assign ci25=s_25[28:22];
  assign ci26=s_26[28:22];
  assign ci27=s_27[28:22];
  assign ci28=s_28[28:22];
  assign ci29=s_29[28:22];
  assign ci30=s_30[28:22];
  assign ci31=s_31[28:22];
  assign ci32=s_32[28:22];

  mux2_1x5 m1(new_count, count, clk, result);
  Dff5 dff1(result, clk, reset, count);
  mux2_1x5_zero m2(count, start_count, count1);
  rca5_count rca5(count1, new_count);

  // decoder: average strength need to save at which place
  assign output_en[0]  =~count[4]&~count[3]&~count[2]&~count[1]&~count[0];
  assign output_en[1]  =~count[4]&~count[3]&~count[2]&~count[1]& count[0];
  assign output_en[2]  =~count[4]&~count[3]&~count[2]& count[1]&~count[0];
  assign output_en[3]  =~count[4]&~count[3]&~count[2]& count[1]& count[0];
  assign output_en[4]  =~count[4]&~count[3]& count[2]&~count[1]&~count[0];
  assign output_en[5]  =~count[4]&~count[3]& count[2]&~count[1]& count[0];
  assign output_en[6]  =~count[4]&~count[3]& count[2]& count[1]&~count[0];
  assign output_en[7]  =~count[4]&~count[3]& count[2]& count[1]& count[0];
  assign output_en[8]  =~count[4]& count[3]&~count[2]&~count[1]&~count[0];
  assign output_en[9]  =~count[4]& count[3]&~count[2]&~count[1]& count[0];
  assign output_en[10] =~count[4]& count[3]&~count[2]& count[1]&~count[0];
  assign output_en[11] =~count[4]& count[3]&~count[2]& count[1]& count[0];
  assign output_en[12] =~count[4]& count[3]& count[2]&~count[1]&~count[0];
  assign output_en[13] =~count[4]& count[3]& count[2]&~count[1]& count[0];
  assign output_en[14] =~count[4]& count[3]& count[2]& count[1]&~count[0];
  assign output_en[15] =~count[4]& count[3]& count[2]& count[1]& count[0];
  assign output_en[16] = count[4]&~count[3]&~count[2]&~count[1]&~count[0];
  assign output_en[17] = count[4]&~count[3]&~count[2]&~count[1]& count[0];
  assign output_en[18] = count[4]&~count[3]&~count[2]& count[1]&~count[0];
  assign output_en[19] = count[4]&~count[3]&~count[2]& count[1]& count[0];
  assign output_en[20] = count[4]&~count[3]& count[2]&~count[1]&~count[0];
  assign output_en[21] = count[4]&~count[3]& count[2]&~count[1]& count[0];
  assign output_en[22] = count[4]&~count[3]& count[2]& count[1]&~count[0];
  assign output_en[23] = count[4]&~count[3]& count[2]& count[1]& count[0];
  assign output_en[24] = count[4]& count[3]&~count[2]&~count[1]&~count[0];
  assign output_en[25] = count[4]& count[3]&~count[2]&~count[1]& count[0];
  assign output_en[26] = count[4]& count[3]&~count[2]& count[1]&~count[0];
  assign output_en[27] = count[4]& count[3]&~count[2]& count[1]& count[0];
  assign output_en[28] = count[4]& count[3]& count[2]&~count[1]&~count[0];
  assign output_en[29] = count[4]& count[3]& count[2]&~count[1]& count[0];
  assign output_en[30] = count[4]& count[3]& count[2]& count[1]&~count[0];
  assign output_en[31] = count[4]& count[3]& count[2]& count[1]& count[0];

  mux2_1x7_zero mm1(ci1, output_en[0], out1);
  mux2_1x7_zero mm2(ci2, output_en[1], out2);
  mux2_1x7_zero mm3(ci3, output_en[2], out3);
  mux2_1x7_zero mm4(ci4, output_en[3], out4);
  mux2_1x7_zero mm5(ci5, output_en[4], out5);
  mux2_1x7_zero mm6(ci6, output_en[5], out6);
  mux2_1x7_zero mm7(ci7, output_en[6], out7);
  mux2_1x7_zero mm8(ci8, output_en[7], out8);
  mux2_1x7_zero mm9(ci9, output_en[8], out9);
  mux2_1x7_zero mm10(ci10, output_en[9], out10);
  mux2_1x7_zero mm11(ci11, output_en[10], out11);
  mux2_1x7_zero mm12(ci12, output_en[11], out12);
  mux2_1x7_zero mm13(ci13, output_en[12], out13);
  mux2_1x7_zero mm14(ci14, output_en[13], out14);
  mux2_1x7_zero mm15(ci15, output_en[14], out15);
  mux2_1x7_zero mm16(ci16, output_en[15], out16);
  mux2_1x7_zero mm17(ci17, output_en[16], out17);
  mux2_1x7_zero mm18(ci18, output_en[17], out18);
  mux2_1x7_zero mm19(ci19, output_en[18], out19);
  mux2_1x7_zero mm20(ci20, output_en[19], out20);
  mux2_1x7_zero mm21(ci21, output_en[20], out21);
  mux2_1x7_zero mm22(ci22, output_en[21], out22);
  mux2_1x7_zero mm23(ci23, output_en[22], out23);
  mux2_1x7_zero mm24(ci24, output_en[23], out24);
  mux2_1x7_zero mm25(ci25, output_en[24], out25);
  mux2_1x7_zero mm26(ci26, output_en[25], out26);
  mux2_1x7_zero mm27(ci27, output_en[26], out27);
  mux2_1x7_zero mm28(ci28, output_en[27], out28);
  mux2_1x7_zero mm29(ci29, output_en[28], out29);
  mux2_1x7_zero mm30(ci30, output_en[29], out30);
  mux2_1x7_zero mm31(ci31, output_en[30], out31);
  mux2_1x7_zero mm32(ci32, output_en[31], out32);
  
  assign out_c_i=(out1|out2|out3|out4|out5|out6|out7|out8|out9|out10|out11|out12|out13|out14|out15|out16|out17|out18|out19|out20|out21|out22|out23|out24|out25|out26|out27|out28|out29|out30|out31|out32);

  assign color_index = out_c_i[1:0];
  assign image_out_index = out_c_i[6:2];

endmodule

// 5-bits mux2_1
// enable=1 -> A(renew count number), enable=0 -> B(old count number)
module mux2_1x5 (A, B, enable, result);
  input [4:0] A, B;
  input enable;
  
  output [4:0] result;
  
  // enable=1 -> A(renew count), enable=0 -> B(old count)
  assign result[4]=enable?A[4]:B[4];
  assign result[3]=enable?A[3]:B[3];
  assign result[2]=enable?A[2]:B[2];
  assign result[1]=enable?A[1]:B[1];
  assign result[0]=enable?A[0]:B[0];
  
endmodule

// 7-bits mux2_1 with zero input
// enable=1 -> A(color index and image out index), enable=0 -> 7'b0
module mux2_1x7_zero (A, enable, result);
  input [6:0] A;
  input enable;
  
  output [6:0] result;
  
  // enable=1 -> A, enable=0 -> 7'b0
  assign result[6]=enable?A[6]:0;
  assign result[5]=enable?A[5]:0;
  assign result[4]=enable?A[4]:0;
  assign result[3]=enable?A[3]:0;
  assign result[2]=enable?A[2]:0;
  assign result[1]=enable?A[1]:0;
  assign result[0]=enable?A[0]:0;
  
endmodule

// 5-bits mux2_1 with zero input
// enable=1 -> A(pixel number which need to add), enable=0 -> 5'b0
module mux2_1x5_zero (A, enable, result);
  input [4:0] A;
  input enable;
  
  output [4:0] result;
  
  // enable=1 -> A, enable=0 -> 15'b0
  assign result[4]=enable?A[4]:0;
  assign result[3]=enable?A[3]:0;
  assign result[2]=enable?A[2]:0;
  assign result[1]=enable?A[1]:0;
  assign result[0]=enable?A[0]:0;
  
endmodule

// 5-bits D flip-flop with reset
module Dff5 (in, clk, reset, out);
  input [4:0] in;
  input clk, reset;
  
  output [4:0] out;
  
  Dff d4(out[4], in[4], clk, reset);
  Dff d3(out[3], in[3], clk, reset);
  Dff d2(out[2], in[2], clk, reset);
  Dff d1(out[1], in[1], clk, reset);
  Dff d0(out[0], in[0], clk, reset);
   
endmodule 

// 1 bit D flip-flop with reset
module Dff (Q, D, clk, reset);
  input D, clk, reset;
  output reg Q;
  wire rst;
  
  not n1(rst, reset);
  
  always@(posedge clk, negedge rst)
  if (!rst)    //same as if (rst==0)
    Q <= 1'b0;   
  else 
    Q <= D;                                      
endmodule

module odd_even_merge_sort (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32, 
s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32);

  //29-bits = 5-bits(index) + 2-bits(00,01,10) + 22-bits(average color strength)
  input [28:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32;
  output [28:0] s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32;
  wire [28:0] a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32;
  wire [28:0] b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32;
  wire [28:0] c2, c3, c6, c7, c10, c11, c14, c15, c18, c19, c22, c23, c26, c27, c30, c31;
  wire [28:0] d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31, d32;
  wire [28:0] e3, e4, e5, e6, e11, e12, e13, e14, e19, e20, e21, e22, e27, e28, e29, e30;
  wire [28:0] f2, f3, f4, f5, f6, f7, f10, f11, f12, f13, f14, f15, f18, f19, f20, f21, f22, f23, f26, f27, f28, f29, f30, f31;
  wire [28:0] g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15, g16, g17, g18, g19, g20, g21, g22, g23, g24, g25, g26, g27, g28, g29, g30, g31, g32;
  wire [28:0] h5, h6, h7, h8, h9, h10, h11, h12, h21, h22, h23, h24, h25, h26, h27, h28;
  wire [28:0] i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30;
  wire [28:0] j2, j3, j4, j5, j6, j7, j8, j9, j10, j11, j12, j13, j14, j15, j18, j19, j20, j21, j22, j23, j24, j25, j26, j27, j28, j29, j30, j31;
  wire [28:0] k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16, k17, k18, k19, k20, k21, k22, k23, k24, k25, k26, k27, k28, k29, k30, k31, k32;
  wire [28:0] l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24;
  wire [28:0] m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18, m19, m20, m21, m22, m23, m24, m25, m26, m27, m28;
  wire [28:0] n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30;
  
  //round 1, A
  sort2x3pair A1(s1, s2, s3, s4, s5, s6, a1, a2, a3, a4, a5, a6);
  sort2x3pair A2(s7, s8, s9, s10, s11, s12, a7, a8, a9, a10, a11, a12);
  sort2x3pair A3(s13, s14, s15, s16, s17, s18, a13, a14, a15, a16, a17, a18);
  sort2x3pair A4(s19, s20, s21, s22, s23, s24, a19, a20, a21, a22, a23, a24);
  sort2x3pair A5(s25, s26, s27, s28, s29, s30, a25, a26, a27, a28, a29, a30);
  sort2       A6(s31, s32, a31, a32);

  //round 2, B
  sort4x3pair B1(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12);
  sort4x3pair B2(a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24);
  sort4       B3(a25, a26, a27, a28, b25, b26, b27, b28);
  sort4       B4(a29, a30, a31, a32, b29, b30, b31, b32);
  
  //round 3, C
  sort2 C1(b2, b3, c2, c3);
  sort2 C2(b6, b7, c6, c7);
  sort2 C3(b10, b11, c10, c11);
  sort2 C4(b14, b15, c14, c15);
  sort2 C5(b18, b19, c18, c19);
  sort2 C6(b22, b23, c22, c23);
  sort2 C7(b26, b27, c26, c27);
  sort2 C8(b30, b31, c30, c31);
  
  //round 4, D
  sort8 D1(b1, c2, c3, b4, b5, c6, c7, b8, d1, d2, d3, d4, d5, d6, d7, d8);
  sort8 D2(b9, c10, c11, b12, b13, c14, c15, b16, d9, d10, d11, d12, d13, d14, d15, d16);
  sort8 D3(b17, c18, c19, b20, b21, c22, c23, b24, d17, d18, d19, d20, d21, d22, d23, d24);
  sort8 D4(b25, c26, c27, b28, b29, c30, c31, b32, d25, d26, d27, d28, d29, d30, d31, d32);

  //round 5, E
  sort4 E1(d3, d4, d5, d6, e3, e4, e5, e6);
  sort4 E2(d11, d12, d13, d14, e11, e12, e13, e14);
  sort4 E3(d19, d20, d21, d22, e19, e20, e21, e22);
  sort4 E4(d27, d28, d29, d30, e27, e28, e29, e30);
  
  //round 6, F
  sort2x3pair F1(d2, e3, e4, e5, e6, d7, f2, f3, f4, f5, f6, f7);
  sort2x3pair F2(d10, e11, e12, e13, e14, d15, f10, f11, f12, f13, f14, f15);
  sort2x3pair F3(d18, e19, e20, e21, e22, d23, f18, f19, f20, f21, f22, f23);
  sort2x3pair F4(d26, e27, e28, e29, e30, d31, f26, f27, f28, f29, f30, f31);
  
  //round 7, G                   
  sort16 G1(d1, f2, f3, f4, f5, f6, f7, d8, d9, f10, f11, f12, f13, f14, f15, d16, g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15, g16);
  sort16 G2(d17, f18, f19, f20, f21, f22, f23, d24, d25, f26, f27, f28, f29, f30, f31, d32, g17, g18, g19, g20, g21, g22, g23, g24, g25, g26, g27, g28, g29, g30, g31, g32);
  
  //round 8, H
  sort8 H1(g5, g6, g7, g8, g9, g10, g11, g12, h5, h6, h7, h8, h9, h10, h11, h12);
  sort8 H2(g21, g22, g23, g24, g25, g26, g27, g28, h21, h22, h23, h24, h25, h26, h27, h28);
  
  //round 9, I
  sort4x3pair I1(g3, g4, h5, h6, h7, h8, h9, h10, h11, h12, g13, g14, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14);
  sort4x3pair I2(g19, g20, h21, h22, h23, h24, h25, h26, h27, h28, g29, g30, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30);
  
  //round 10, J
  sort2x3pair J1(g2, i3, i4, i5, i6, i7, j2, j3, j4, j5, j6, j7);
  sort2x3pair J2(i8, i9, i10, i11, i12, i13, j8, j9, j10, j11, j12, j13);
  sort2       J3(i14, g15, j14, j15);  
  sort2x3pair J4(g18, i19, i20, i21, i22, i23, j18, j19, j20, j21, j22, j23);
  sort2x3pair J5(i24, i25, i26, i27, i28, i29, j24, j25, j26, j27, j28, j29);
  sort2       J6(i30, g31, j30, j31);
  
  //round 11, K
  sort32 K1(g1, j2, j3, j4, j5, j6, j7, j8, j9, j10, j11, j12, j13, j14, j15, g16, g17, j18, j19, j20, j21, j22, j23, j24, j25, j26, j27, j28, j29, j30, j31, g32
, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16, k17, k18, k19, k20, k21, k22, k23, k24, k25, k26, k27, k28, k29, k30, k31, k32);
  
  //round 12, L
  sort16 L1(k9, k10, k11, k12, k13, k14, k15, k16, k17, k18, k19, k20, k21, k22, k23, k24, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24);
  
  //round 13, M
  sort8 M1(k5, k6, k7, k8, l9, l10, l11, l12, m5, m6, m7, m8, m9, m10, m11, m12);
  sort8 M2(l13, l14, l15, l16, l17, l18, l19, l20, m13, m14, m15, m16, m17, m18, m19, m20);
  sort8 M3(l21, l22, l23, l24, k25, k26, k27, k28, m21, m22, m23, m24, m25, m26, m27, m28);
    
  //round 14, N
  sort4x3pair N1(k3, k4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14);
  sort4x3pair N2(m15, m16, m17, m18, m19, m20, m21, m22, m23, m24, m25, m26, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26);
  sort4       N3(m27, m28, k29, k30, n27, n28, n29, n30);
  
  //round 15, S_
  assign s_1=k1;
  sort2x3pair S_1(k2, n3, n4, n5, n6, n7, s_2, s_3, s_4, s_5, s_6, s_7);
  sort2x3pair S_2(n8, n9, n10, n11, n12, n13, s_8, s_9, s_10, s_11, s_12, s_13);
  sort2x3pair S_3(n14, n15, n16, n17, n18, n19, s_14, s_15, s_16, s_17, s_18, s_19);  
  sort2x3pair S_4(n20, n21, n22, n23, n24, n25, s_20, s_21, s_22, s_23, s_24, s_25);
  sort2x3pair S_5(n26, n27, n28, n29, n30, k31, s_26, s_27, s_28, s_29, s_30, s_31);
  assign s_32=k32;

endmodule

module sort32 (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32
, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18, m19, m20, m21, m22, m23, m24, m25, m26, m27, m28, m29, m30, m31, m32);

  input [28:0] A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32;
  output [28:0] m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18, m19, m20, m21, m22, m23, m24, m25, m26, m27, m28, m29, m30, m31, m32;
  
  sort2 s1(A1, A17, m1, m17);
  sort2 s2(A2, A18, m2, m18);
  sort2 s3(A3, A19, m3, m19);
  sort2 s4(A4, A20, m4, m20);
  sort2 s5(A5, A21, m5, m21);
  sort2 s6(A6, A22, m6, m22);
  sort2 s7(A7, A23, m7, m23);
  sort2 s8(A8, A24, m8, m24);
  sort2 s9(A9, A25, m9, m25);
  sort2 s10(A10, A26, m10, m26);
  sort2 s11(A11, A27, m11, m27);
  sort2 s12(A12, A28, m12, m28);
  sort2 s13(A13, A29, m13, m29);
  sort2 s14(A14, A30, m14, m30);
  sort2 s15(A15, A31, m15, m31);
  sort2 s16(A16, A32, m16, m32);

endmodule

module sort16 (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16);

  input [28:0] A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16;
  output [28:0] m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16;

  sort2 s1(A1, A9, m1, m9);
  sort2 s2(A2, A10, m2, m10);
  sort2 s3(A3, A11, m3, m11);
  sort2 s4(A4, A12, m4, m12);
  sort2 s5(A5, A13, m5, m13);
  sort2 s6(A6, A14, m6, m14);
  sort2 s7(A7, A15, m7, m15);
  sort2 s8(A8, A16, m8, m16);

endmodule

module sort8 (A1, A2, A3, A4, A5, A6, A7, A8, m1, m2, m3, m4, m5, m6, m7, m8);

  input [28:0] A1, A2, A3, A4, A5, A6, A7, A8;
  output [28:0] m1, m2, m3, m4, m5, m6, m7, m8;

  sort2 s1(A1, A5, m1, m5);
  sort2 s2(A2, A6, m2, m6);
  sort2 s3(A3, A7, m3, m7);
  sort2 s4(A4, A8, m4, m8);

endmodule

module sort4x3pair (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12);

  input [28:0] A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12;
  output [28:0] m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12;

  sort4 s1(A1, A2, A3, A4, m1, m2, m3, m4);
  sort4 s2(A5, A6, A7, A8, m5, m6, m7, m8);
  sort4 s3(A9, A10, A11, A12, m9, m10, m11, m12);

endmodule

module sort4 (A1, A2, A3, A4, m1, m2, m3, m4);

  input [28:0] A1, A2, A3, A4;
  output [28:0] m1, m2, m3, m4;

  sort2 s1(A1, A3, m1, m3);
  sort2 s2(A2, A4, m2, m4);

endmodule

module sort2x3pair (A1, A2, A3, A4, A5, A6, m1, m2, m3, m4, m5, m6);
  input [28:0] A1, A2, A3, A4, A5, A6;
  output [28:0] m1, m2, m3, m4, m5, m6;
  
  sort2 s1(A1, A2, m1, m2);
  sort2 s2(A3, A4, m3, m4);
  sort2 s3(A5, A6, m5, m6);
  
endmodule

module sort2 (A, B, min, max);

  input [28:0] A, B;
  output [28:0] min, max;
  wire Abigger;

  compare24srt cpr(A[23:0], B[23:0], Abigger);
  
  assign min=(Abigger)?B:A;
  assign max=(Abigger)?A:B;
  
endmodule

// 24-bits sort for 2 numbers
module compare24srt (A, B, Abigger);

  input [23:0] A, B;
  output Abigger;
  wire abigger3, abigger2, abigger1;
  wire equal3, equal2, equal1;
  wire ab1, ab2;

  compare8 c1(A[23:16], B[23:16], abigger3, equal3);
  compare8 c2(A[15:8], B[15:8], abigger2, equal2);
  compare8 c3(A[7:0], B[7:0], abigger1, equal1);

  and a1(ab1, equal3, abigger2);
  and a2(ab2, equal2, abigger1);
  or o1(Abigger, abigger3, ab1, ab2);

endmodule

/*
module compare16srt (A, B, Abigger);

  input [17:0] A, B;
  output Abigger;
  wire abigger3, abigger2, abigger1;
  wire equal3, equal2, equal1;
  wire ab1, ab2;

  compare2_no_bbigger c1(A[17:16], B[17:16], abigger3, equal3);
  compare8 c2(A[15:8], B[15:8], abigger2, equal2);
  compare8 c3(A[7:0], B[7:0], abigger1, equal1);

  and a1(ab1, equal3, abigger2);
  and a2(ab2, equal2, abigger1);
  or o1(Abigger, abigger3, ab1, ab2);

endmodule  */

// 8-bits comparater
module compare8 (A, B, Abigger, Equal);
  
  input [7:0] A, B;
  output Abigger, Equal;
  wire abigger1, abigger2, abigger3, abigger4;
  wire bbigger1, bbigger2, bbigger3, bbigger4;
  wire equal1, equal2, equal3, equal4;

  compare2 c1(A[1:0], B[1:0], abigger1, equal1, bbigger1);
  compare2 c2(A[3:2], B[3:2], abigger2, equal2, bbigger2);
  compare2 c3(A[5:4], B[5:4], abigger3, equal3, bbigger3);
  compare2 c4(A[7:6], B[7:6], abigger4, equal4, bbigger4);

  and a1(ab1, equal4, abigger3);
  and a2(ab2, equal4, equal3, abigger2);
  and a3(ab3, equal4, equal3, equal2, abigger1);
  assign Abigger=(abigger4|ab1|ab2|ab3);
  
  assign Equal=(equal1&equal2&equal3&equal4);

endmodule

// 2-bits compare just A-bigger or Equal
/*module compare2_no_bbigger (A, B, abigger, equal);

  input [1:0] A, B;
  output abigger, equal;
  wire bbigger;
  wire a_b0, a_b1, b_b0, b_b1;
  wire q1, q2, q3, q4, q5, q6, q7, q8;

  not n1(a_b0, A[0]);
  not n2(a_b1, A[1]);
  not n3(b_b0, B[0]);
  not n4(b_b1, B[1]);

  nor r1(q1, a_b1, B[1]);
  nand a1(q2, a_b1, B[1]);
  nand a2(q3, a_b0, B[0]);
  nand a3(q4, A[1], b_b1);
  nand a4(q5, A[0], b_b0);
  nor r2(q6, b_b1, A[1]);

  or r3(q7, q1, q3);
  or r4(q8, q5, q6);

  nand a5(bbigger, q2, q7);
  nand a6(abigger, q4, q8);
  nor r5(equal, abigger, bbigger);

endmodule    */

// 2-bits comparater
module compare2 (A, B, abigger, equal, bbigger);

  input [1:0] A, B;
  output abigger, equal, bbigger;
  wire a_b0, a_b1, b_b0, b_b1;
  wire q1, q2, q3, q4, q5, q6, q7, q8;

  not n1(a_b0, A[0]);
  not n2(a_b1, A[1]);
  not n3(b_b0, B[0]);
  not n4(b_b1, B[1]);

  nor r1(q1, a_b1, B[1]);
  nand a1(q2, a_b1, B[1]);
  nand a2(q3, a_b0, B[0]);
  nand a3(q4, A[1], b_b1);
  nand a4(q5, A[0], b_b0);
  nor r2(q6, b_b1, A[1]);

  or r3(q7, q1, q3);
  or r4(q8, q5, q6);

  nand a5(bbigger, q2, q7);
  nand a6(abigger, q4, q8);
  nor r5(equal, abigger, bbigger);

endmodule

