module tb_encod_8_3_dat;
 reg [7:0] d;
 wire [2:0] a;
 encod_8_3_dat uut(.a(a),.d(d));
 initial begin
  $dumpfile("z20.vcd");
  $dumpvars(0,tb_encod_8_3_dat);
  $display("D0 D1 D2 D3 D4 D5 D6 D7 | A2 A1 A0");
  $monitor("%b %b %b %b %b %b %b %b | %b %b %b",d[0],d[1],d[2],d[3],d[4],d[5],d[6],d[7],a[2],a[1],a[0]);
  d=8'b00000001;#10;
  d=8'b00000010;#10;
  d=8'b00000100;#10;
  d=8'b00001000;#10;
  d=8'b00010000;#10;
  d=8'b00100000;#10;
  d=8'b01000000;#10;
  d=8'b10000000;#10;
  d=8'b00000000;#10;
  $finish;
 end
endmodule





