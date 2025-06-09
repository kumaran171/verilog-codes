module tb_demux_8_1_dat;
 reg A;
 reg [2:0] s;
 wire [7:0] d;
 demux_8_1 uut(.A(A).s(s),.d(d));
 initial begin
  $dumpfile("z.vcd");
  $dumpvars(0,demux,8_1_dat);
  $display("A S2 S1 S0 | D7 D6 D5 D4 D23 D2 D1 D0");
  $monitor("%b %b %b %b | %b %b %b %b %b %b %b %b",A,s[2],s[1],s[0],d[7],d[6],d[5],d[4],d[3],d[2],d[1],d[0]);
  A=0;s=3'b000;#10;
  A=1;s=3'b000;#10;
  A=0;s=3'b001;#10;
  A=1;s=3'b001;#10;
  A=0;s=3'b010;#10;
  A=1;s=3'b010;#10;
  A=0;s=3'b011;#10;
  A=1;s=3'b011;#10; 
  A=0;s=3'b100;#10;
  A=1;s=3'b100;#10;
  A=0;s=3'b101;#10;
  A=1;s=3'b101;#10;
  A=0;s=3'b110;#10;
  A=1;s=3'b110;#10;
  A=1;s=3'b111;#10;
  A=1;s=3'b111;#10;
  $finish;
 end
endmodule





  