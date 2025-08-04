module encod_8_3_dat(output [2:0] a, input [7:0] d);
   assign a[2]=d[4]|d[5]|d[6]|d[7];
   assign a[1]=d[2]|d[3]|d[6]|d[7];
   assign a[0]=d[1]|d[3]|d[5]|d[7];
endmodule