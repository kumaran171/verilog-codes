module full_sub_struct(output D,Bout,input A,Bin,C);
   wire y1,y2,y3,y4,y5;
   xor g1(y1,A,Bin);
   xor g2(D,y1,C);
   and g3(y2,Bin,C);
   not g4(y3,A);
   xor g5(y4,Bin,C);
   and g6(y5,y3,y4);
   or g7(Bout,y2,y5);
endmodule