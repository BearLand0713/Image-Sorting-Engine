`timescale 1ns/100ps
`include "pixel_in_compare.v"

module tb_pixel_in_compare;

  reg [23:0] index_pixel;
  wire       Radd_en, Gadd_en, Badd_en;
  wire [7:0] strength_input;
  
  pixel_in_compare p1(index_pixel, Radd_en, Gadd_en, Badd_en, strength_input);

  initial
  begin
  index_pixel = 24'b00000000_00000000_00000000;
  #20 index_pixel = 24'b00000001_00000001_00000000;
  #20 index_pixel = 24'b00001000_00000000_00001000;
  #20 index_pixel = 24'b01000000_00011000_00010000;
  #20 index_pixel = 24'b11100001_00011001_00011100;
  #20 index_pixel = 24'b00111001_00000001_00001100;
  #20 index_pixel = 24'b11111101_00000001_00000110;
  #20 index_pixel = 24'b00000001_01111001_00111000;
  #20 index_pixel = 24'b00100001_00000001_11111111;
  #20 index_pixel = 24'b10000001_01111111_11111110;
  #20 index_pixel = 24'b00111101_00011101_00110000;
  #20 index_pixel = 24'b11110001_11110001_11110000;
  end
  
  initial
  $monitor($time,"'ns| Radd_en=%b | Gadd_en=%b | Badd_en=%b | strength_input=%b", Radd_en, Gadd_en, Badd_en, strength_input);
  
  initial #500 $finish;

endmodule  