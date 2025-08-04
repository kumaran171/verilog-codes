module tb_moore_11011_nonoverlapping;
 reg in,clk,rst;
 wire d;
 moore_11011_nonoverlapping uut(.clk(clk),.d(d),.in(in),.rst(rst));
 always #5 clk=~clk;
 initial begin
  $dumpfile("lh.vcd");
  $dumpvars(0,tb_moore_11011_nonoverlapping);
  $display("clk rst in out");
  $monitor("%b %b %b %b",clk,rst,in,d);
  clk=0;
  rst=0;
  in=0;
  #10;
  rst=1;in=1;#10;
  rst=1;in=1;#10;
  rst=1;in=0;#10;
  rst=1;in=1;#10;
  rst=1;in=1;#10;
  $finish;
 end
endmodule


  
 