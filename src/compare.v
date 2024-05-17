module compare16 (A, B, Abigger, Bbigger, Equal);

  input [15:0] A, B;
  output Abigger, Bbigger, Equal;
  
  wire abigger1, abigger2;
  wire bbigger1, bbigger2;
  wire equal1, equal2;
  wire ab1, bb1;
  
  compare8 c1(A[7:0], B[7:0], abigger1, bbigger1, equal1);
  compare8 c2(A[15:8], B[15:8], abigger2, bbigger2, equal2); 
  
  and a1(ab1, equal2, abigger1);
  or o1(Abigger, abigger2, ab1);
  
  and b1(bb1, equal2, bbigger1);
  or o2(Bbigger, bbigger2, bb1);
  
  and (Equal, equal1 , equal2);   
  
endmodule

module compare8 (A, B, Abigger, Bbigger, Equal);
  
  input [7:0] A, B;
  output Abigger, Bbigger, Equal;
  wire abigger1, abigger2, abigger3, abigger4;
  wire bbigger1, bbigger2, bbigger3, bbigger4;
  wire equal1, equal2, equal3, equal4;
  wire ab1, ab2, ab3, bb1, bb2, bb3;

  compare2 c1(A[1:0], B[1:0], abigger1, equal1, bbigger1);
  compare2 c2(A[3:2], B[3:2], abigger2, equal2, bbigger2);
  compare2 c3(A[5:4], B[5:4], abigger3, equal3, bbigger3);
  compare2 c4(A[7:6], B[7:6], abigger4, equal4, bbigger4);

  and a1(ab1, equal4, abigger3);
  and a2(ab2, equal4, equal3, abigger2);
  and a3(ab3, equal4, equal3, equal2, abigger1);
  assign Abigger=(abigger4|ab1|ab2|ab3);
  
  and b1(bb1, equal4, bbigger3);
  and b2(bb2, equal4, equal3, bbigger2);
  and b3(bb3, equal4, equal3, equal2, bbigger1);
  assign Bbigger=(bbigger4|bb1|bb2|bb3);
  
  assign Equal=(equal1&equal2&equal3&equal4);

endmodule

module compare2 (A, B, abigger, equal, bbigger);

  input [1:0] A, B;
  output abigger, equal, bbigger;
  wire a_b0, a_b1, b_b0, b_b1;
  wire q1, q2, q3, q4, q5, q6, q7, q8;

  not n1(a_b0, A[0]);
  not n2(a_b1, A[1]);
  not n3(b_b0, B[0]);
  not n4(b_b1, B[1]);

  nor r1(q1, a_b1, B[1]);
  nand a1(q2, a_b1, B[1]);
  nand a2(q3, a_b0, B[0]);
  nand a3(q4, A[1], b_b1);
  nand a4(q5, A[0], b_b0);
  nor r2(q6, b_b1, A[1]);

  or r3(q7, q1, q3);
  or r4(q8, q5, q6);

  nand a5(bbigger, q2, q7);
  nand a6(abigger, q4, q8);
  nor r5(equal, abigger, bbigger);

endmodule