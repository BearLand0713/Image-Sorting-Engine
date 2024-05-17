`include "carry_skip_adder.v"

module strength_adder (strength_input, Radd_en, Gadd_en, Badd_en, clk, strength_reset, Rstrength, Gstrength, Bstrength);
  input [7:0] strength_input;
  input Radd_en, Gadd_en, Badd_en;
  input clk, strength_reset;

  output wire [21:0] Rstrength, Gstrength, Bstrength;

  wire [21:0] sum, Rstrength1, Gstrength1, Bstrength1;
  wire [21:0] old_pixel_strength, Rstrength2, Gstrength2, Bstrength2; 
    
  // use enable to choose which color strength need to renew
  // output: Rstrength1, Gstrength1, Bstrength1 
  mux2_1x22 R_m1(sum, Rstrength, Radd_en, Rstrength1);
  mux2_1x22 G_m1(sum, Gstrength, Gadd_en, Gstrength1);
  mux2_1x22 B_m1(sum, Bstrength, Badd_en, Bstrength1);
  
  // save RGB strength
  // output: Rstrength, Gstrength, Bstrength
  Dff22 R_dff(Rstrength1, clk, strength_reset, Rstrength);
  Dff22 G_dff(Gstrength1, clk, strength_reset, Gstrength);
  Dff22 B_dff(Bstrength1, clk, strength_reset, Bstrength);
  
  // use enable to choose which color strength need to do addition
  // output: Rstrength2, Gstrength2, Bstrength2, old_pixel_strength 
  mux2_1x22_zero R_m2(Rstrength, Radd_en, Rstrength2);
  mux2_1x22_zero G_m2(Gstrength, Gadd_en, Gstrength2);
  mux2_1x22_zero B_m2(Bstrength, Badd_en, Bstrength2);
  assign old_pixel_strength=(Rstrength2|Gstrength2|Bstrength2);
  
  // carry skip adder 22-bits
  // old strength + strength input
  cska22 csa(old_pixel_strength, {14'b0, strength_input}, sum);

endmodule

module pixel_strength_compare (Rstrength, Gstrength, Bstrength, one_picture, Rd_en, Gd_en, Bd_en, divisor);

  input [21:0] Rstrength, Gstrength, Bstrength;
  input one_picture;
  input Rd_en, Gd_en, Bd_en;
  
  output [21:0] divisor;
  
  wire   [21:0] Rstrength1, Gstrength1, Bstrength1, divisor1;

  // choose color strength
  //output: divisor
  mux2_1x22_zero R_m1(Rstrength, Rd_en, Rstrength1);
  mux2_1x22_zero G_m1(Gstrength, Gd_en, Gstrength1);
  mux2_1x22_zero B_m1(Bstrength, Bd_en, Bstrength1);
  assign divisor1=(Rstrength1|Gstrength1|Bstrength1);
  
  mux2_1x22_zero dvn(divisor1, one_picture, divisor);

endmodule

// 22-bits mux2_1
// enable=1 -> A(new strength) | enable=0 -> B(old strength)
module mux2_1x22 (A, B, enable, result);
  input [21:0] A, B;
  input enable;
  
  output [21:0] result;
  
  // enable=1 -> A(new strength) | enable=0 -> B(old strength)
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

// 22-bits mux2_1 with zero input
// enable=1 -> A(old strength), enable=0 -> 22'b0
module mux2_1x22_zero (A, enable, result);
  input [21:0] A;
  input enable;
  
  output [21:0] result;
  
  // enable=1 -> A, enable=0 -> 22'b0
  assign result[21]=enable?A[21]:1'b0;
  assign result[20]=enable?A[20]:1'b0;
  assign result[19]=enable?A[19]:1'b0;
  assign result[18]=enable?A[18]:1'b0;
  assign result[17]=enable?A[17]:1'b0;
  assign result[16]=enable?A[16]:1'b0;
  assign result[15]=enable?A[15]:1'b0;
  assign result[14]=enable?A[14]:1'b0;
  assign result[13]=enable?A[13]:1'b0;
  assign result[12]=enable?A[12]:1'b0;
  assign result[11]=enable?A[11]:1'b0;
  assign result[10]=enable?A[10]:1'b0;
  assign result[9]=enable?A[9]:1'b0;
  assign result[8]=enable?A[8]:1'b0;
  assign result[7]=enable?A[7]:1'b0;
  assign result[6]=enable?A[6]:1'b0;
  assign result[5]=enable?A[5]:1'b0;
  assign result[4]=enable?A[4]:1'b0;
  assign result[3]=enable?A[3]:1'b0;
  assign result[2]=enable?A[2]:1'b0;
  assign result[1]=enable?A[1]:1'b0;
  assign result[0]=enable?A[0]:1'b0;
  
  
endmodule

// 22 bits D flip-flop with reset
module Dff22 (in, clk, reset, out);
  input [21:0] in;
  input clk, reset;
  
  output [21:0] out;
  
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