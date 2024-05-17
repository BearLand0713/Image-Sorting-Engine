// reuse the above block modules to build the final adder
// The adder is a 22 bit adder which will make use of six blocks of 4 bit each
// carry skip adder 22-bits
module cska22(A, B, Sum);
  input [21:0] A, B;
  
  output [21:0] Sum;
  
  wire [3:0] p1, p2, p3, p4;
  wire w1, w2, w3, w4, w5, w6, w7, w8, c4, c7, c12, c16, c20;
  
  // ripple carry adder without * carry in *
  rca4_wci  r1(A[3:0], B[3:0], Sum[3:0], c4);
  
  // ripple carry adder with port * p * and * carry out *
  rca4p r2(A[7:4], B[7:4], c4, Sum[7:4], w1, p1);
  and   a1(w2, p1[0], p1[1], p1[2], p1[3], c4);
  or    o1(c7, w1, w2);
  
  // ripple carry adder with port * p * and * carry out *
  rca4p r3(A[11:8], B[11:8], c7, Sum[11:8], w3, p2);
  and   a2(w4, p2[0], p2[1], p2[2], p2[3], c7);
  or    o2(c12, w3, w4);
  
  // ripple carry adder with port * p * and * carry out *
  rca4p r4(A[15:12], B[15:12], c12, Sum[15:12], w5, p3);
  and   a3(w6, p3[0], p3[1], p3[2], p3[3], c12);
  or    o3(c16, w5, w6);
  
  // ripple carry adder with port * p * and * carry out *
  rca4p r5( A[19:16], B[19:16], c16, Sum[19:16], w7, p4);
  and   a4(w8, p4[0], p4[1], p4[2], p4[3], c16);
  or    o4(c20, w7, w8);
  
  // ripple carry adder without * carry out *
  rca2_wco  r6(A[21:20], B[21:20], c20, Sum[21:20]);

endmodule

// carry skip adder 15-bits, for counter, just add 1-bit every time
module cska15_count (A, Sum);
  input [14:0] A;
  
  output [14:0] Sum;
  
  wire w1, w2, w3, w4, w5, w6, w7, w8, c4, c7, c12, c16, c20;
  
  // ripple carry adder for count
  rca4_count  r1(A[3:0], Sum[3:0], c4);
  
  // ripple carry adder with for counter
  rca4_middle_count r2(A[7:4], c4, Sum[7:4], c7);
  
  // ripple carry adder with port * p *
  rca4_middle_count r3(A[11:8], c7, Sum[11:8], c12);
  
  rca3_wco  r4(A[14:12], c12, Sum[14:12]);
  
endmodule

// carry skip adder 14-bits, for counter, just add 1-bit every time
/***for RGBadd_enable_timer***/
module cska14_count (A, Sum, one_picture);
  input [13:0] A;
  
  output [13:0] Sum;
  output one_picture;
  
  wire w1, w2, w3, w4, w5, w6, w7, w8, c4, c7, c12, c13, c20;
  
  // ripple carry adder for count
  rca4_count  r1(A[3:0], Sum[3:0], c4);
  
  // ripple carry adder with for counter
  rca4_middle_count r2(A[7:4], c4, Sum[7:4], c7);
  
  // ripple carry adder with port * p *
  rca4_middle_count r3(A[11:8], c7, Sum[11:8], c12);
  
  ha ha1(A[12], c12, Sum[12], c13);
  ha ha2(A[13], c13, Sum[13], one_picture);
  
endmodule

// *** for counter ***
// 5-bits ripple carry adder *without* carry out
module rca5_count (A, Sum);
  input [4:0] A;
  
  output [4:0] Sum;
  
  wire [4:0] c;
  wire p, c4;
  wire Cin;
  
  assign Cin=1'b1;
  
  ha ha1(A[0], Cin, Sum[0], c[0]);
  ha ha2(A[1], c[0], Sum[1], c[1]);
  ha ha3(A[2], c[1], Sum[2], c[2]);
  ha ha4(A[3], c[2], Sum[3], c[3]);
  
  and a1(c[4], A[4], c[3]);
  not n1(c4, c[4]);
  or o1(p, A[4], c[3]);
  and a2(Sum[4], c4, p);
  
endmodule

// *** for counter ***
// 4-bits ripple carry adder * with * carry out 
module rca4_middle_count (A, Cin, Sum, Cout);
  input [3:0] A;
  input Cin;
  
  output [3:0] Sum;
  output Cout;
  
  wire [2:0] c;
  
  ha ha1(A[0], Cin, Sum[0], c[0]);
  ha ha2(A[1], c[0], Sum[1], c[1]);
  ha ha3(A[2], c[1], Sum[2], c[2]);
  ha ha4(A[3], c[2], Sum[3], Cout);
  
endmodule

// 4-bits ripple carry adder with port * p * and * carry out *
module rca4p (A, B, Cin, Sum, w, p);
  input [3:0] A, B;
  input       Cin;
  
  output [3:0] Sum, p;
  output       w;
  
  wire c1, c2, c3;

  pfa pfa1(A[0], B[0], Cin, Sum[0], c1, p[0]);
  pfa pfa2(A[1], B[1], c1, Sum[1], c2, p[1]);
  pfa pfa3(A[2], B[2], c2, Sum[2], c3, p[2]);
  pfa pfa4(A[3], B[3], c3, Sum[3], w, p[3]);

endmodule  

// (PFA)propagate full adder, with port * p * and * g *
module pfa (A, B, Cin, Sum, Cout, p);
  input  A, B, Cin;
  output Sum, Cout, p;
  
  wire s1, p, g1, g2;
  
  pha pha1 (A, B, s1, g1, p);
  ha  ha1  (s1, Cin, Sum, g2);
  or o1(Cout, g1, g2); 
   
endmodule

// (PHA)propagate half adder, with port * p * and * g *
module pha (A, B, Sum, g, p);
  input A, B;
  output Sum, g, p;
  
  wire gbar;
  
  and a1(g, A, B);
  not n1(gbar, g);
  
  or  o1(p, A, B);
  and a2(Sum, gbar, p);
    
endmodule

// (PHA)propagate half adder, with port * p *
module pha_count (A, Cin, Sum, p);
  input A, Cin;
  output Sum, p;
  
  wire g, gbar;
  
  and a1(g, A, Cin);
  not n1(gbar, g);
  
  or  o1(p, A, Cin);
  and a2(Sum, gbar, p);
    
endmodule

// *** for counter ***
// 3-bits ripple carry adder without carry-out
module rca3_wco (A, Cin, Sum);
  input [2:0] A;
  input Cin;
  
  output [2:0] Sum;
  
  wire c1, c2;
  
  ha     ha1(A[0], Cin, Sum[0], c1);
  ha     ha2(A[1], c1, Sum[1], c2);
  ha_wco ha3(A[2], c2, Sum[2]);
  
endmodule

// 2-bits ripple carry adder without carry-out
module rca2_wco(A, B, Cin, Sum);
  input [1:0] A, B;
  input Cin;
  
  output [1:0] Sum;
  
  wire c1;

  fa     fa1(A[0],B[0], Cin, Sum[0], c1);
  fa_wco fa2(A[1],B[1], c1, Sum[1]);
  
endmodule

// full adder without carry-out
module fa_wco (A, B, Cin, Sum);
  input A, B, Cin;
  output Sum;
  
  wire c1, s1, c2;
  
  ha     ha1 (A, B, s1, c1);
  ha_wco ha2 (s1, Cin, Sum); 
   
endmodule

// half adder without carry-out
module ha_wco(A, B, Sum);
  input A, B;
  output Sum;          
  
  wire Cout, Cbar, p;
  
  and a1 (Cout, A, B);
  not i1 (Cbar, Cout);
  or o1 (p, A, B);
  and a2 (Sum, Cbar, p);
    
endmodule

// 4-bits ripple carry adder without carry in
module rca4_wci (A, B, Sum, Cout);
  input [3:0] A, B;
  
  output [3:0] Sum;
  output Cout;
  
  wire [2:0] c;

  ha ha1(A[0],B[0], Sum[0], c[0]) ;
  fa fa2(A[1],B[1], c[0], Sum[1], c[1]) ;
  fa fa3(A[2],B[2], c[1], Sum[2], c[2]) ;
  fa fa4(A[3],B[3], c[2], Sum[3], Cout) ;

endmodule

// *** for counter ***
// 4-bits ripple carry adder
module rca4_count (A, Sum, Cout);
  input [3:0] A;
  output [3:0] Sum;
  output Cout;
  
  wire [2:0] c;
  wire Cin;
  
  assign Cin=1'b1;
  
  ha ha1(A[0], Cin, Sum[0], c[0]);
  ha ha2(A[1], c[0], Sum[1], c[1]);
  ha ha3(A[2], c[1], Sum[2], c[2]);
  ha ha4(A[3], c[2], Sum[3], Cout);
  
endmodule  

// full adder
module fa (A, B, Cin, Sum, Cout);
  input A, B, Cin;
  output Cout, Sum;
  
  wire c1, s1, c2;
  
  ha ha1 (A, B, s1, c1);
  ha ha2 (s1, Cin, Sum, c2);
  or o1 (Cout, c1, c2); 
   
endmodule

// half adder
module ha(A, B, Sum, Cout);
  input A, B;
  output Cout, Sum;
  
  wire Cbar, p;
  
  and a1 (Cout, A, B);
  not i1 (Cbar, Cout);
  or o1 (p, A, B);
  and a2 (Sum, Cbar, p);
    
endmodule