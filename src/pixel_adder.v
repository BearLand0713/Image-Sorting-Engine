`include "carry_skip_adder.v"
`include "compare.v"

module pixel_adder (Radd_en, Gadd_en, Badd_en, clk, one_picture, Rpixel_num, Gpixel_num, Bpixel_num);
  input Radd_en, Gadd_en, Badd_en;
  input clk, pixel_reset;
  
  output wire [14:0] Rpixel_num, Gpixel_num, Bpixel_num;
  
  wire [14:0] Rpixel_num2, Gpixel_num2, Bpixel_num2;
  wire [14:0] Rpixel_num1, Gpixel_num1, Bpixel_num1;
  wire [14:0] R_renew_num, G_renew_num, B_renew_num;

  mux2_1x15 R_mux1(R_renew_num, Rpixel_num, Radd_en, Rpixel_num1);
  mux2_1x15 G_mux1(G_renew_num, Gpixel_num, Gadd_en, Gpixel_num1);
  mux2_1x15 B_mux1(B_renew_num, Bpixel_num, Badd_en, Bpixel_num1);
        
  // save pixel number
  Dff15 R_dff(Rpixel_num1, clk, one_picture, Rpixel_num);
  Dff15 G_dff(Gpixel_num1, clk, one_picture, Gpixel_num);
  Dff15 B_dff(Bpixel_num1, clk, one_picture, Bpixel_num);
  
  // choose which color's pixel need to do addition
  mux2_1x15_zero R_mux2(Rpixel_num, Radd_en, Rpixel_num2);
  mux2_1x15_zero G_mux2(Gpixel_num, Gadd_en, Gpixel_num2);
  mux2_1x15_zero B_mux2(Bpixel_num, Badd_en, Bpixel_num2);
  
  // ripple carry adder without * carry out *
  cska15_count R_cska(Rpixel_num2, R_renew_num);
  cska15_count G_cska(Gpixel_num2, G_renew_num);
  cska15_count B_cska(Bpixel_num2, B_renew_num);   

endmodule

module pixel_number_compare (Rpixel_num, Gpixel_num, Bpixel_num, one_picture, Rd_en, Gd_en, Bd_en, dividend);

  input [14:0] Rpixel_num, Gpixel_num, Bpixel_num;
  input one_picture;
  
  output [14:0] dividend;
  output Rd_en, Gd_en, Bd_en;
  
  wire   [1:0]  c;
  wire   [14:0] Rpixel_num1, Gpixel_num1, Bpixel_num1, dividend1;
  wire          Rd_en, Gd_en, Bd_en;
  wire          RbiggerG, GbiggerR, RG_Equal, RbiggerB, BbiggerR, RB_Equal, GbiggerB, BbiggerG, GB_Equal;
  
  compare16 c1({1'b0, Rpixel_num}, {1'b0, Gpixel_num}, RbiggerG, GbiggerR, RGequal);
  compare16 c2({1'b0, Gpixel_num}, {1'b0, Bpixel_num}, GbiggerB, BbiggerG, GBequal);
  compare16 c3({1'b0, Rpixel_num}, {1'b0, Bpixel_num}, RbiggerB, BbiggerR, RBequal);
  
  // Red(R)=00(red first) Green(G)=01 Blue(B)=10
  assign  c[0]=(GbiggerB|GB_Equal) & GbiggerR;
  assign  c[1]=BbiggerG & BbiggerR;
  
  // color strength add_enable control
  assign Rd_en=(~c[1]&~c[0]);
  assign Gd_en=(~c[1]&c[0]);
  assign Bd_en=(c[1]&~c[0]);

  // choose color pixel
  //output: dividend
  mux2_1x15_zero R_m1(Rpixel_num, Rd_en, Rpixel_num1);
  mux2_1x15_zero G_m1(Gpixel_num, Gd_en, Gpixel_num1);
  mux2_1x15_zero B_m1(Bpixel_num, Bd_en, Bpixel_num1);
  assign dividend1=(Rpixel_num1|Gpixel_num1|Bpixel_num1);
  
  mux2_1x15_zero dvn(dividend1, one_picture, dividend);

endmodule

// 15-bits mux2_1
// enable=1 -> A(renew pixel number), enable=0 -> B(old pixel number)
module mux2_1x15 (A, B, enable, result);
  input [14:0] A, B;
  input enable;
  
  output [14:0] result;
  
  // enable=1 -> A(renew pixel number), enable=0 -> B(old pixel number)
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

// 15-bits mux2_1 with zero input
// enable=1 -> A(pixel number which need to add), enable=0 -> 15'b0
module mux2_1x15_zero (A, enable, result);
  input [14:0] A;
  input enable;
  
  output [14:0] result;
  
  // enable=1 -> A, enable=0 -> 15'b0
  assign result[14]=enable?A[14]:0;
  assign result[13]=enable?A[13]:0;
  assign result[12]=enable?A[12]:0;
  assign result[11]=enable?A[11]:0;
  assign result[10]=enable?A[10]:0;
  assign result[9]=enable?A[9]:0;
  assign result[8]=enable?A[8]:0;
  assign result[7]=enable?A[7]:0;
  assign result[6]=enable?A[6]:0;
  assign result[5]=enable?A[5]:0;
  assign result[4]=enable?A[4]:0;
  assign result[3]=enable?A[3]:0;
  assign result[2]=enable?A[2]:0;
  assign result[1]=enable?A[1]:0;
  assign result[0]=enable?A[0]:0;
  
endmodule

// 15-bits D flip-flop with reset
module Dff15 (in, clk, reset, out);
  input [14:0] in;
  input clk, reset;
  
  output [14:0] out;
  
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