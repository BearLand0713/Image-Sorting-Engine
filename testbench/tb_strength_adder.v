`timescale 1ns/100ps
`include "strength_adder.v"

`define CYCLE 10

module tb_strength_adder;

  reg [7:0] strength_input;
  reg Radd_en, Gadd_en, Badd_en;
  reg clk, reset;

  wire [21:0] Rstrength, Gstrength, Bstrength;
  
  strength_adder s_add(strength_input, Radd_en, Gadd_en, Badd_en, clk, reset, Rstrength, Gstrength, Bstrength);
  
  always #(`CYCLE/2) clk = ~clk;
  
  initial
  begin
  Radd_en=0 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd0; clk=1; reset=1; #5 reset=0;      
  #10 Radd_en=0 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=0 ; Gadd_en=1 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=0 ; Gadd_en=0 ; Badd_en=1 ; strength_input=8'd100;
  #10 Radd_en=0 ; Gadd_en=0 ; Badd_en=1 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=0 ; Gadd_en=1 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=0 ; Gadd_en=0 ; Badd_en=1 ; strength_input=8'd100;
  #10 Radd_en=0 ; Gadd_en=0 ; Badd_en=1 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd100;
  #10 Radd_en=0 ; Gadd_en=0 ; Badd_en=0 ; strength_input=8'd0;      
  end
 
/*  always #40 begin
  Radd_en=1 ; Gadd_en=0 ; Badd_en=0 ;
  #10 Radd_en=0 ; Gadd_en=1 ; Badd_en=0 ;
  #10 Radd_en=0 ; Gadd_en=0 ; Badd_en=1 ;
  end     */
  
  initial
  $monitor($time,"'ns| Rstrength=%d | Gstrength=%d | Bstrength=%d", Rstrength, Gstrength, Bstrength);
  
  initial #4000 $finish;

endmodule