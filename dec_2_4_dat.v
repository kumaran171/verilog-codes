module dec_2_4_dat(output d3,d2,d1,d0,input a1,a0,En);
   wire y1,y2,y3,y4,y5,y6;
   assign y1=~a1;
   assign y2=~a0;
   assign y3=y1&y2;
   assign d0=En&y3;
   assign y4=y1&a0;
   assign d1=En&y4;
   assign y5=a1&y2;
   assign d2=En&y5;
   assign y6=a1&a0;
   assign d3=En&y6;
endmodule