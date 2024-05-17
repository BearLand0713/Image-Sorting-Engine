module sort_reg (old_index, Q, Gd_en, Bd_en, sort_reg_en, reset, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32, start_count);

  input [4:0]  old_index;
  input Gd_en, Bd_en;
  input [21:0] Q;
  input sort_reg_en, reset;
  
  output [28:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32;
  output start_count;

  wire [31:0] asi;
  wire [1:0] c;

  // decoder: average strength need to save at which place
  assign asi[0] =~old_index[4]&~old_index[3]&~old_index[2]&~old_index[1]&~old_index[0];
  assign asi[1] =~old_index[4]&~old_index[3]&~old_index[2]&~old_index[1]& old_index[0];
  assign asi[2] =~old_index[4]&~old_index[3]&~old_index[2]& old_index[1]&~old_index[0];
  assign asi[3] =~old_index[4]&~old_index[3]&~old_index[2]& old_index[1]& old_index[0];
  assign asi[4] =~old_index[4]&~old_index[3]& old_index[2]&~old_index[1]&~old_index[0];
  assign asi[5] =~old_index[4]&~old_index[3]& old_index[2]&~old_index[1]& old_index[0];
  assign asi[6] =~old_index[4]&~old_index[3]& old_index[2]& old_index[1]&~old_index[0];
  assign asi[7] =~old_index[4]&~old_index[3]& old_index[2]& old_index[1]& old_index[0];
  assign asi[8] =~old_index[4]& old_index[3]&~old_index[2]&~old_index[1]&~old_index[0];
  assign asi[9] =~old_index[4]& old_index[3]&~old_index[2]&~old_index[1]& old_index[0];
  assign asi[10]=~old_index[4]& old_index[3]&~old_index[2]& old_index[1]&~old_index[0];
  assign asi[11]=~old_index[4]& old_index[3]&~old_index[2]& old_index[1]& old_index[0];
  assign asi[12]=~old_index[4]& old_index[3]& old_index[2]&~old_index[1]&~old_index[0];
  assign asi[13]=~old_index[4]& old_index[3]& old_index[2]&~old_index[1]& old_index[0];
  assign asi[14]=~old_index[4]& old_index[3]& old_index[2]& old_index[1]&~old_index[0];
  assign asi[15]=~old_index[4]& old_index[3]& old_index[2]& old_index[1]& old_index[0];
  assign asi[16]= old_index[4]&~old_index[3]&~old_index[2]&~old_index[1]&~old_index[0];
  assign asi[17]= old_index[4]&~old_index[3]&~old_index[2]&~old_index[1]& old_index[0];
  assign asi[18]= old_index[4]&~old_index[3]&~old_index[2]& old_index[1]&~old_index[0];
  assign asi[19]= old_index[4]&~old_index[3]&~old_index[2]& old_index[1]& old_index[0];
  assign asi[20]= old_index[4]&~old_index[3]& old_index[2]&~old_index[1]&~old_index[0];
  assign asi[21]= old_index[4]&~old_index[3]& old_index[2]&~old_index[1]& old_index[0];
  assign asi[22]= old_index[4]&~old_index[3]& old_index[2]& old_index[1]&~old_index[0];
  assign asi[23]= old_index[4]&~old_index[3]& old_index[2]& old_index[1]& old_index[0];
  assign asi[24]= old_index[4]& old_index[3]&~old_index[2]&~old_index[1]&~old_index[0];
  assign asi[25]= old_index[4]& old_index[3]&~old_index[2]&~old_index[1]& old_index[0];
  assign asi[26]= old_index[4]& old_index[3]&~old_index[2]& old_index[1]&~old_index[0];
  assign asi[27]= old_index[4]& old_index[3]&~old_index[2]& old_index[1]& old_index[0];
  assign asi[28]= old_index[4]& old_index[3]& old_index[2]&~old_index[1]&~old_index[0];
  assign asi[29]= old_index[4]& old_index[3]& old_index[2]&~old_index[1]& old_index[0];
  assign asi[30]= old_index[4]& old_index[3]& old_index[2]& old_index[1]&~old_index[0];
  assign asi[31]= old_index[4]& old_index[3]& old_index[2]& old_index[1]& old_index[0];
  
  assign c[0]=Gd_en;
  assign c[1]=Bd_en;

  // enable=1 -> A(new strength) | enable=0 -> B(old strength)
  mux_reg a1({old_index, c, Q}, asi[0], sort_reg_en, reset, s1);
  mux_reg a2({old_index, c, Q}, asi[1], sort_reg_en, reset, s2);
  mux_reg a3({old_index, c, Q}, asi[2], sort_reg_en, reset, s3);
  mux_reg a4({old_index, c, Q}, asi[3], sort_reg_en, reset, s4);
  mux_reg a5({old_index, c, Q}, asi[4], sort_reg_en, reset, s5);
  mux_reg a6({old_index, c, Q}, asi[5], sort_reg_en, reset, s6);
  mux_reg a7({old_index, c, Q}, asi[6], sort_reg_en, reset, s7);
  mux_reg a8({old_index, c, Q}, asi[7], sort_reg_en, reset, s8);
  mux_reg a9({old_index, c, Q}, asi[8], sort_reg_en, reset, s9);
  mux_reg a10({old_index, c, Q}, asi[9], sort_reg_en, reset, s10);
  mux_reg a11({old_index, c, Q}, asi[10], sort_reg_en, reset, s11);
  mux_reg a12({old_index, c, Q}, asi[11], sort_reg_en, reset, s12);
  mux_reg a13({old_index, c, Q}, asi[12], sort_reg_en, reset, s13);
  mux_reg a14({old_index, c, Q}, asi[13], sort_reg_en, reset, s14);
  mux_reg a15({old_index, c, Q}, asi[14], sort_reg_en, reset, s15);
  mux_reg a16({old_index, c, Q}, asi[15], sort_reg_en, reset, s16);
  mux_reg a17({old_index, c, Q}, asi[16], sort_reg_en, reset, s17);
  mux_reg a18({old_index, c, Q}, asi[17], sort_reg_en, reset, s18);
  mux_reg a19({old_index, c, Q}, asi[18], sort_reg_en, reset, s19);
  mux_reg a20({old_index, c, Q}, asi[19], sort_reg_en, reset, s20);
  mux_reg a21({old_index, c, Q}, asi[20], sort_reg_en, reset, s21);
  mux_reg a22({old_index, c, Q}, asi[21], sort_reg_en, reset, s22);
  mux_reg a23({old_index, c, Q}, asi[22], sort_reg_en, reset, s23);
  mux_reg a24({old_index, c, Q}, asi[23], sort_reg_en, reset, s24);
  mux_reg a25({old_index, c, Q}, asi[24], sort_reg_en, reset, s25);
  mux_reg a26({old_index, c, Q}, asi[25], sort_reg_en, reset, s26);
  mux_reg a27({old_index, c, Q}, asi[26], sort_reg_en, reset, s27);
  mux_reg a28({old_index, c, Q}, asi[27], sort_reg_en, reset, s28);
  mux_reg a29({old_index, c, Q}, asi[28], sort_reg_en, reset, s29);
  mux_reg a30({old_index, c, Q}, asi[29], sort_reg_en, reset, s30);
  mux_reg a31({old_index, c, Q}, asi[30], sort_reg_en, reset, s31);
  mux_reg a32({old_index, c, Q}, asi[31], sort_reg_en, reset, s32);
  
  assign start_count=(s32[28]&s32[27]&s32[26]&s32[25]&s32[24]);

endmodule

module mux_reg (Q, asi, clk, reset, S);

  input [28:0] Q;
  input asi, clk, reset;
  output [28:0] S;
  
  wire [28:0] S, result, old_avg;

  mux2_1x29 m1(Q, S, asi, result);
  Dff29 dff1(result, clk, reset, S);
    
endmodule 
  
// 29-bits mux2_1
// enable=1 -> A(new strength) | enable=0 -> B(old strength)
module mux2_1x29 (A, B, enable, result);
  input [28:0] A, B;
  input enable;
  
  output [28:0] result;
  
  // enable=1 -> A(new strength) | enable=0 -> B(old strength)
  assign result[28]=enable?A[28]:B[28];
  assign result[27]=enable?A[27]:B[27];
  assign result[26]=enable?A[26]:B[26];
  assign result[25]=enable?A[25]:B[25];
  assign result[24]=enable?A[24]:B[24];
  assign result[23]=enable?A[23]:B[23];
  assign result[22]=enable?A[22]:B[22];
  assign result[21]=enable?A[21]:B[21];
  assign result[20]=enable?A[20]:B[20];
  assign result[19]=enable?A[19]:B[19];
  assign result[18]=enable?A[18]:B[18];
  assign result[17]=enable?A[17]:B[17];
  assign result[16]=enable?A[16]:B[16];
  assign result[15]=enable?A[15]:B[15];
  assign result[14]=enable?A[14]:B[14];
  assign result[13]=enable?A[13]:B[13];
  assign result[12]=enable?A[12]:B[12];
  assign result[11]=enable?A[11]:B[11];
  assign result[10]=enable?A[10]:B[10];
  assign result[9]=enable?A[9]:B[9];
  assign result[8]=enable?A[8]:B[8];
  assign result[7]=enable?A[7]:B[7];
  assign result[6]=enable?A[6]:B[6];
  assign result[5]=enable?A[5]:B[5];
  assign result[4]=enable?A[4]:B[4];
  assign result[3]=enable?A[3]:B[3];
  assign result[2]=enable?A[2]:B[2];
  assign result[1]=enable?A[1]:B[1];
  assign result[0]=enable?A[0]:B[0];
  
endmodule

// 29 bits D flip-flop with reset
module Dff29 (in, clk, reset, out);
  input [28:0] in;
  input clk, reset;
  
  output [28:0] out;
  
  Dff d28(out[28], in[28], clk, reset);
  Dff d27(out[27], in[27], clk, reset);
  Dff d26(out[26], in[26], clk, reset);
  Dff d25(out[25], in[25], clk, reset);
  Dff d24(out[24], in[24], clk, reset);
  Dff d23(out[23], in[23], clk, reset);
  Dff d22(out[22], in[22], clk, reset);
  Dff d21(out[21], in[21], clk, reset);
  Dff d20(out[20], in[20], clk, reset);
  Dff d19(out[19], in[19], clk, reset);
  Dff d18(out[18], in[18], clk, reset);
  Dff d17(out[17], in[17], clk, reset);
  Dff d16(out[16], in[16], clk, reset);
  Dff d15(out[15], in[15], clk, reset);
  Dff d14(out[14], in[14], clk, reset);
  Dff d13(out[13], in[13], clk, reset);
  Dff d12(out[12], in[12], clk, reset);
  Dff d11(out[11], in[11], clk, reset);
  Dff d10(out[10], in[10], clk, reset);
  Dff d9(out[9], in[9], clk, reset);
  Dff d8(out[8], in[8], clk, reset);
  Dff d7(out[7], in[7], clk, reset);
  Dff d6(out[6], in[6], clk, reset);
  Dff d5(out[5], in[5], clk, reset);
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