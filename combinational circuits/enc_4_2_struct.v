module en_2_4_s(output [1:0] a,input [3:0] d);
    or g1(a[1],d[2],d[3]);
    or g2(a[0],d[1],d[3]);
endmodule