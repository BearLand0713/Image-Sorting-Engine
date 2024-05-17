`include "carry_skip_adder.v"

//***Divider counter***//
module div_counter (one_picture, clk, sort_reg_en, renew_index);
  
  input one_picture, clk, reset;
  output sort_reg_en, renew_index;
  output [4:0] num1;
  
  wire [4:0] num, num1, num2;
  wire [4:0] A;
  
  `define A=4'b0;
  
  mux2_1x5 mux(A, num1, one_picture, num2);
  
  Dff5 dff(num2, clk, one_picture, num);
  
  rca5_count rca5(num, num1);
  
  assign sort_reg_en=~num1[0]&num1[1]&num1[2]&num1[3]&num1[4];
  assign renew_index=num1[0]&num1[1]&num1[2]&num1[3]&num1[4];
  
endmodule

// 5-bits mux2_1
// enable=1 -> A, enable=0 -> B
module mux2_1x5 (A, B, enable, result);
  input [4:0] A, B;
  input enable;
  
  output [4:0] result;
  
  // enable=1 -> A(renew image index), enable=0 -> B(old image index)
  assign result[4]=enable?A[4]:B[4];
  assign result[3]=enable?A[3]:B[3];
  assign result[2]=enable?A[2]:B[2];
  assign result[1]=enable?A[1]:B[1];
  assign result[0]=enable?A[0]:B[0];
  
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

module Div_0(DV,DVN,clk,reset,Q,R);
input [21:0] DV;                                          
input [14:0] DVN;                                          
input clk,reset;
output [21:0] Q,R;                                            
wire  [35:0] DV0,DVN0,Q0,R0;                                    

assign DV0={DV,14'd0};                                           
assign DVN0={21'd0,DVN};                                        
  Div P0(DV0,DVN0,clk,reset,Q0,R0);
assign Q=Q0[21:0];                                              
assign R=R0[21:0];

endmodule

module Div(DV,DVN,clk,reset,Q,R);
input [35:0] DV,DVN;     
input clk,reset;
output [35:0] Q,R;
wire z,z2,Qb;
wire [5:0] d,_d,d2;
wire [35:0] _DVN,DVNTs;
reg [5:0] count0,count1;
reg [35:0] DVT,DVNT,Q; 

Penc36 U1 (DV,d2,z2);
Penc36 U0 (DVN,d,z);
assign _d = (d2-d);
assign _DVN = DVN <<_d;

always@(posedge clk)
if (reset==1'b0)
 DVT<=DV;
else 
 DVT<=DVNTs;

always@(posedge clk)
if(reset==1'b0)
begin
 count0<=6'd0;
 DVNT<=_DVN;
end
else if(count0<_d)
begin
 count0<=count0+1;
 DVNT<={1'b0,DVNT[35:1]};
end

always@(posedge clk)
if(reset==0)
begin
 Q<=36'd0;
 count1<=6'd0;
end
else if(count1<=_d)
begin
 Q<={Q[34:0],Qb};
 count1<=count1+1;
end

assign DVNTs=(DVT>=DVNT)?(DVT-DVNT):DVT;
assign R=DVT;
assign Qb = (DVT>=DVNT)?1'b1:1'b0;

endmodule

module Penc36(B,Y,Z);
input [35:0]B;
output Z;
output [5:0]Y;
wire Z0,Z1;
wire [4:0]Y0;
wire [1:0]Y1;
wire [5:0]Y_;

assign Y_={4'd0,Y1}+6'd32;
Penc32 U0(B[31:0],Y0,Z0);
Penc4  U1(B[35:32],Y1,Z1);

assign Y=(Z1)?{1'b0,Y0}:Y_;

assign Z=Z0&Z1;

endmodule

module Penc32(B,Y,Z);
input [31:0]B;
output Z;
output [4:0]Y;
wire Z0,Z1;
wire [3:0]Y0,Y1;

Penc16 U0(B[15:0],Y0,Z0);
Penc16 U1(B[31:16],Y1,Z1);

assign Y=(Z1)?{1'b0,Y0}:{1'b1,Y1};

assign Z=Z0&Z1;

endmodule

module Penc16(B,Y,Z);
input [15:0]B;
output Z;
output [3:0]Y;
wire Z0,Z1;
wire [2:0]Y0,Y1;

Penc8 U0(B[7:0],Y0,Z0);
Penc8 U1(B[15:8],Y1,Z1);

assign Y=(Z1)?{1'b0,Y0}:{1'b1,Y1};

assign Z=Z0&Z1;

endmodule

module Penc8(B,Y,Z);
input [7:0]B;
output Z;
output [2:0]Y;
wire Z0,Z1;
wire [1:0]Y0,Y1;

Penc4 U0(B[3:0],Y0,Z0);
Penc4 U1(B[7:4],Y1,Z1);

assign Y=(Z1)?{1'b0,Y0}:{1'b1,Y1};

assign Z=Z0&Z1;

endmodule

module Penc4 (B,Y,Z);
input [3:0]B;
output Z;
output [1:0]Y;
assign Z=~(B[0]|B[1]|B[2]|B[3]);
assign Y[0]=B[3]|((~B[2])&B[1]);
assign Y[1]=B[2]|B[3];

endmodule 
