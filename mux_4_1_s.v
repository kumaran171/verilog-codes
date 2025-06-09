module mux_4_1_s(input [3:0] I, input [1:0] s, output Y);
  wire y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12;

  not g1(y1, s[0]);
  not g2(y2, s[1]);

  and g3(y3, y1, y2);       
  and g4(y4, y3, I[0]);

  and g5(y5, y2, s[0]);     
  and g6(y6, y5, I[1]);

  and g7(y7, s[1], y1);     
  and g8(y8, y7, I[2]);

  and g9(y9, s[1], s[0]);   
  and g10(y10, y9, I[3]);

  or g11(y11, y4, y6);
  or g12(y12, y11, y8);
  or g13(Y, y12, y10);      

endmodule



  
   
   