module dec_2_4_s(output [0:3] d,input [1:0] A,En);
    wire y1,y2,y3,y4y5,y6;
    not g1(y1,A[0]);
    not g2(y2,A[1]);
    and g3(y3,y2,y1);
    and g4(d[0],En,y3);
    and g5(y4,y2,A[0]);
    and g6(d[1],En,y4);
    and g7(y5,A[1],y1);
    and g8(d[2],En,y5);
    and g9(y6,A[1],A[0]);
    and g10(d[3],y6,En);
endmodule
   
   
    