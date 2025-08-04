module enco_8_3_s(output [2:0] a,input [7:0] d);
  wire y1,y2,y4,y5,y7,y8;
  or g1(y1,d[4],d[5]);
  or g2(y2,y1,d[6]);
  or g3(a[2],y2,d[7]);
  or g4(y4,d[2],d[3]);
  or g5(y5,y4,d[6]);
  or g6(a[1],y2,d[7]);
  or g7(y7,d[1],d[3]);
  or g8(y8,y7,d[5]);
  or g9(a[0],y8,d[7]);
endmodule