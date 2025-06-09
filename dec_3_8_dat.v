module dec_3_8_dat(d, a, En);
  input [2:0] a;
  input En;
  output [7:0] d;

  assign d[0] = En & ~a[2] & ~a[1] & ~a[0];
  assign d[1] = En & ~a[2] & ~a[1] &  a[0];
  assign d[2] = En & ~a[2] &  a[1] & ~a[0];
  assign d[3] = En & ~a[2] &  a[1] &  a[0];
  assign d[4] = En &  a[2] & ~a[1] & ~a[0];
  assign d[5] = En &  a[2] & ~a[1] &  a[0];
  assign d[6] = En &  a[2] &  a[1] & ~a[0];
  assign d[7] = En &  a[2] &  a[1] &  a[0];
endmodule
