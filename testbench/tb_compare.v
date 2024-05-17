`timescale 1ns/100ps
`include "compare.v"

module tb_compare;
reg signed [15:0] A;
reg signed [15:0] B;
wire signed Abigger, Bbigger, Equal;

compare16 cmp(A, B, Abigger, Bbigger, Equal);

//initial $sdf_annotate("mcd.sdf", mcd);

initial
begin
    A=8'b10000000;B=8'b00000010;
    #20 A=8'b10000000;B=8'b00000100;
    #20 A=8'b10000000;B=8'b00001000;
    #20 A=8'b10000000;B=8'b00010000;
    #20 A=8'b00000100;B=8'b00100000;
    #20 A=8'b00000100;B=8'b01000000;
    #20 A=8'b00000001;B=8'b00010000;
    #20 A=8'b00010000;B=8'b00000010;
    #20 A=8'b00100000;B=8'b00100000;
    #20 A=8'b01000000;B=8'b01000000;
    #20 A=8'b10000000;B=8'b10000000;
    #20 A=8'b01000000;B=8'b01000000;
    #20 $finish;
end 

/*initial
begin
    A=16'b10000000;B=16'b00000010;
    #20 A=16'b10000000;B=16'b00000100;
    #20 A=16'b10000000;B=16'b00001000;
    #20 A=16'b10000000;B=16'b00010000;
    #20 A=16'b00000100;B=16'b00100000;
    #20 A=16'b00000100;B=16'b01000000;
    #20 A=16'b00000001;B=16'b00010000;
    #20 A=16'b00010000;B=16'b00000010;
    #20 A=16'b00100000;B=16'b00100000;
    #20 A=16'b01000000;B=16'b01000000;
    #20 A=16'b10000000;B=16'b10000000;
    #20 A=16'b01000000;B=16'b01000000;
    #20 $finish;
end   */

initial
$monitor($time,"'ns| A=%b B=%b Abigger=%b Bbigger=%b Equal=%b",A,B,Abigger,Bbigger,Equal);

/*initial begin
//$dumpfile("MCD.vcd");
$dumpfile("MCD_syn.vcd");
$dumpvars;
end         */

endmodule