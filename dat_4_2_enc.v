module enc_2_4_dat(output [1:0] a,input [3:0] d);
   assign a[1]=d[2]+d[3];
   assign a[0]=d[1]+d[3];
endmodule
