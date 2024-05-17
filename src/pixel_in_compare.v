`include "compare.v"
`include "carry_skip_adder.v"

/***color comparator***/
module pixel_in_compare(index_pixel, Radd_en, Gadd_en, Badd_en, strength_input);

  input  [23:0] index_pixel;
  output        Radd_en, Gadd_en, Badd_en;
  output [7:0]  strength_input;
  
  wire   [1:0]  c;
  wire   [7:0]  R, G, B;
  wire          RbiggerG, GbiggerR, RG_Equal, RbiggerB, BbiggerR, RB_Equal, GbiggerB, BbiggerG, GB_Equal;
  wire   [7:0]  Rstrength, Gstrength, Bstrength;

  assign  R=index_pixel[23:16];
  assign  G=index_pixel[15:8];
  assign  B=index_pixel[7:0];
  
  compare8 cp1(R, G, RbiggerG, GbiggerR, RG_Equal);
  compare8 cp2(R, B, RbiggerB, BbiggerR, RB_Equal);
  compare8 cp3(G, B, GbiggerB, BbiggerG, GB_Equal);
  
  // Red(R)=00(red first) Green(G)=01 Blue(B)=10
  assign  c[0]=(GbiggerB|GB_Equal) & GbiggerR;
  assign  c[1]=BbiggerG & BbiggerR;
  
  // color strength add_enable control
  assign Radd_en=(~c[1]&~c[0]);
  assign Gadd_en=(~c[1]&c[0]);
  assign Badd_en=(c[1]&~c[0]);
  
  // choose color strength
  //output: Rstrength, Gstrength, Bstrength, strength_input
  mux2_1x8 R_m1(index_pixel[23:16], Radd_en, Rstrength);
  mux2_1x8 G_m1(index_pixel[15:8], Gadd_en, Gstrength);
  mux2_1x8 B_m1(index_pixel[7:0], Badd_en, Bstrength);
  assign strength_input=(Rstrength|Gstrength|Bstrength);    

endmodule

// 8-bits mux2_1
module mux2_1x8 (A, enable, result);
  input [7:0] A;
  input enable;
  
  output [7:0] result;
  
  // enable=0 -> A, enable=1 -> 8'b0
  assign result[7]=enable?1'b0:A[7];
  assign result[6]=enable?1'b0:A[6];
  assign result[5]=enable?1'b0:A[5];
  assign result[4]=enable?1'b0:A[4];
  assign result[3]=enable?1'b0:A[3];
  assign result[2]=enable?1'b0:A[2];
  assign result[1]=enable?1'b0:A[1];
  assign result[0]=enable?1'b0:A[0];
  
endmodule

module RGBadd_enable_timer (Radd_en, Gadd_en, Badd_en, reset, clk, one_picture);
  input Radd_en, Gadd_en, Badd_en;
  input reset, clk;
  
  output one_picture;
    
  wire pixel_add_en;
  wire [13:0] pixel_num;
  wire [13:0] pixel_num1;
  wire [13:0] pixel_num2;
  wire [13:0] pixel_renew_num;

  or r1(pixel_add_en, Radd_en, Gadd_en, Badd_en);
  
  //enable=1 -> A(renew pixel number), enable=0 -> B(old pixel number)
  mux2_1x14 m1(pixel_renew_num, pixel_num, pixel_add_en, pixel_num1);
  
  // count pixel number
  Dff14 dff(pixel_num1, clk, reset, pixel_num);
  
  // choose which color's pixel need to do addition
  mux2_1x14_zero m2(pixel_num, pixel_add_en, pixel_num2);
  
  // ripple carry adder with * carry out *
  cska14_count cska(pixel_num2, pixel_renew_num, one_picture);

endmodule

// 14-bits mux2_1
// enable=1 -> A(renew pixel number), enable=0 -> B(old pixel number)
module mux2_1x14 (A, B, enable, result);
  input [13:0] A, B;
  input enable;
  
  output [13:0] result;
  
  // enable=1 -> A(renew pixel number), enable=0 -> B(old pixel number)
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

// 14-bits mux2_1 with zero input
// enable=1 -> A(pixel number which need to add), enable=0 -> 14'b0
module mux2_1x14_zero (A, enable, result);
  input [13:0] A;
  input enable;
  
  output [13:0] result;
  
  // enable=1 -> A, enable=0 -> 14'b0
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

// 14-bits D flip-flop with reset
module Dff14 (in, clk, reset, out);
  input [13:0] in;
  input clk, reset;
  
  output [13:0] out;
  
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