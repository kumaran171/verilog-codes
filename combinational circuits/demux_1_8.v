module demux_8_1(output [7:0] d,input [2:0] s,input A);
  assign d[0]=~s[2]&~s[1]&~s[0]&A;
  assign d[1]=~s[2]&~s[1]&s[0]&A;
  assign d[2]=~s[2]&s[1]&~s[0]&A;
  assign d[3]=~s[2]&s[1]&s[0]&A;
  assign d[4]=s[2]&~s[1]&~s[0]&A;
  assign d[5]=s[2]&~s[1]&s[0]&A;
  assign d[6]=s[2]&s[1]&~s[0]&A;
  assign d[7]=s[2]&s[1]&s[0]&A;
endmodule
  