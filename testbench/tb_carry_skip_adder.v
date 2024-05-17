//`include "carry_skip_adder.v"
//`include "pixel_in_compare.v"
`include "Div.v"

`define CYCLE 10

module carryskipaddertb;

// 22-bits adder
/*  reg [21:0] A, B;
  wire [21:0] Sum;    */
  
  /*reg Radd_en, Gadd_en, Badd_en, reset, clk;
  wire one_picture;
  wire [13:0] pixel_renew_num;     */
  
  reg one_picture, clk, reset;
  wire [4:0] num1;
  wire sort_reg_en, renew_index;
  
  //cska22 cska(A, B, Sum);
  
  always #(`CYCLE/2) clk = ~clk;
  
  /*14-bit timer*/
  //RGBadd_enable_timer t(Radd_en, Gadd_en, Badd_en, reset, clk, pixel_renew_num, one_picture);
  
  //5-bits timer
  div_counter dc(one_picture, clk, sort_reg_en, renew_index); 
  
  initial
  begin
  //A = 22'b010101_01010101_01010101;
  //A = 22'b011111_11111111_11111110; //set A=4194302 , max is 4194303
  //B = 22'b000000_00000000_00000000;
  //A = 22'd4194300;
  //B = 22'd1;
  
  /*14-bit timer*/
  /*Radd_en=1; Gadd_en=0; Badd_en=0; reset=1; clk=1;
  #15 reset=0;   */
  
  /*5-bits timer*/
  one_picture=1; clk=1;
  #11 one_picture=0;
  
  end

  always #10 begin
  //A = Sum;
  //$monitor($time,"'ns| A=%d | B=%d | Sum=%d", A, B, Sum);
  
  //14-bit timer
  //$monitor($time,"'ns| pixel_renew_num=%d | one_picture=%d | ", pixel_renew_num, one_picture);
  
  //5-bits timer
  $monitor($time,"'ns| sort_reg_en=%d | renew_index=%d ", sort_reg_en, renew_index);
  end
  
  initial #400 $finish;     

// 14-bits adder  
/*  reg [14:0] A;
  wire [14:0] Sum; 
  
  cska15_count cska(A, Sum);
  
  initial
  begin
  //A = 14'b011111_11111110;
  //A = 14'b111111_11111110; //set A=4194302 , max is 16383
  A = 15'd 126;
  end

  always #10 begin
  A=Sum;
  $monitor($time,"'ns| A=%d | Sum=%d", A, Sum);
  end

  initial #100 $finish;  */    

endmodule