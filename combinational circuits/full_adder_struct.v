module full_adder_struct(output S,Cout,input A,B,Cin);
   wire y1,y2,y3,y4,y5;
   xor g1(y1,A,B);
   xor g2(S,y1,Cin);
   and g3(y2,A,B);
   and g4(y3,B,Cin);
   and g5(y4,A,Cin);
   or g6(y5,y2,y3);
   or g7(Cout,y5,y4);
endmodule