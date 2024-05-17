`timescale 1ns/100ps
`include "pixel_adder.v"

`define CYCLE 10

module tb_pixel_adder;

  reg Radd_en, Gadd_en, Badd_en;
  reg clk, reset;
  
  wire [14:0] Rpixel_num, Gpixel_num, Bpixel_num;
  
  pixel_adder pa1(Radd_en, Gadd_en, Badd_en, clk, reset, Rpixel_num, Gpixel_num, Bpixel_num);

  always #(`CYCLE/2) clk = ~clk;

  initial
  begin
  Radd_en=0; Gadd_en=0; Badd_en=0; clk=1; reset=1; #5 reset=0;
  #10 Radd_en=1; Gadd_en=0; Badd_en=0; 
  #10 Radd_en=1; Gadd_en=0; Badd_en=0;
  #10 Radd_en=1; Gadd_en=0; Badd_en=0;
  #10 Radd_en=0; Gadd_en=1; Badd_en=0;
  #10 Radd_en=0; Gadd_en=1; Badd_en=0;
  #10 Radd_en=0; Gadd_en=1; Badd_en=0;
  #10 Radd_en=0; Gadd_en=0; Badd_en=1;
  #10 Radd_en=0; Gadd_en=0; Badd_en=1;
  #10 Radd_en=0; Gadd_en=0; Badd_en=1;
  #10 Radd_en=0; Gadd_en=0; Badd_en=1;
  #10 Radd_en=0; Gadd_en=0; Badd_en=1;
  #10 Radd_en=0; Gadd_en=0; Badd_en=1;
  #10 Radd_en=0; Gadd_en=0; Badd_en=1;
  #10 Radd_en=0; Gadd_en=0; Badd_en=1;
  #10 Radd_en=1; Gadd_en=0; Badd_en=0;
  #10 Radd_en=0; Gadd_en=0; Badd_en=0;
  //#10 Radd_en=; Gadd_en=; Badd_en=;
  
  end
  
  //always #10 Badd_en=1;
  
  initial
  $monitor($time,"'ns| Rpixel_num=%d | Gpixel_num=%d | Bpixel_num=%d", Rpixel_num, Gpixel_num, Bpixel_num);
  
  initial #200 $finish;

endmodule