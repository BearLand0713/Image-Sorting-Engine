`include "Div.v"
module Div_tb;
reg reset,clk;
reg [31:0] DV,DVN;
wire [31:0] Q,R;

Div32 D1(DV,DVN,clk,reset,Q,R);

initial
begin
clk=1'b0; reset=1'b0; DV=32'd0; DVN=32'd0;
#10 DV=32'd6971645; DVN=32'd5739;
#50 reset=1'b1;   
#2000 reset=0; 
#10 DV=32'd49267485; DVN=32'd15384;
#50 reset=1'b1; 
#2000 $finish;
end

always begin
 #10 clk=~clk;
end
initial begin
$dumpfile("Div.vcd");
$dumpvars;
end

initial
$monitor ($time,"  DV=%d DVN=%d Q=%d R=%d",DV,DVN,Q,R);

endmodule