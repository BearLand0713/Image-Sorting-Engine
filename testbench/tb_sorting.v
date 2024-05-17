`timescale 1ns/100ps
`include "sorting.v"

module tb_sorting;
reg [28:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32;
wire [28:0] s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32;

odd_even_merge_sort msort1(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, 
s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32, 
s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, 
s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32);

//initial $sdf_annotate("sorting.sdf", msort1);

initial
begin  //
    s1=29'b00000_00_000001_00000010_00000010; s2=29'b00001_00_000001_00000010_00010000; s3=29'b00010_00_000001_00000011_00000000; s4=29'b00011_00_000001_00000100_00000000;
    s5=29'b00100_00_000001_00000100_00000001; s6=29'b00101_00_000001_00000101_00000100; s7=29'b00110_00_000001_00000110_00000000; s8=29'b00111_00_000001_00000111_00000000;
    s9=29'b01000_00_000001_00001001_00000000; s10=29'b01001_00_000001_00001001_00000111;s11=29'b01010_00_000001_00001011_00000000;s12=29'b01011_00_000001_00001100_00000000;
    s13=29'b01100_00_000001_00001110_00000000;s14=29'b01101_01_000001_00000001_00000000;s15=29'b01110_01_000001_00000010_00000000;s16=29'b01111_01_000001_00000100_00000000;
    s17=29'b10000_01_000001_00000100_00000001;s18=29'b10001_01_000001_00000101_00000100;s19=29'b10010_01_000001_00000110_00000000;s20=29'b10011_01_000001_00000111_00000000;
    s21=29'b10100_01_000001_00001001_00000000;s22=29'b10101_01_000001_00001001_00000111;s23=29'b10110_01_000001_00001011_00000000;s24=29'b10111_01_000001_00001100_00000000;
    s25=29'b11000_10_000001_00000100_00000001;s26=29'b11001_10_000001_00000101_00000100;s27=29'b11010_10_000001_00000110_00000000;s28=29'b11011_10_000001_00000111_00000000;
    s29=29'b11100_10_000001_00001001_00000000;s30=29'b11101_10_000001_00001001_00000111;s31=29'b11110_10_000001_00001011_00000000;s32=29'b11111_10_000001_00001100_00000000;
    
    #5 $finish;
end

initial
$monitor($time,"'ns| \n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b",s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9, s_10, s_11, s_12, s_13, s_14, s_15, s_16, s_17, s_18, s_19, s_20, s_21, s_22, s_23, s_24, s_25, s_26, s_27, s_28, s_29, s_30, s_31, s_32);

/*initial begin
//$dumpfile("MCD.vcd");
$dumpfile("MCD_syn.vcd");
$dumpvars;
end         */

endmodule