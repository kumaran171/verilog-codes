module tb_moore_11011_overlapping;
  reg clk,rst,n;
  wire d;
  moore_11011_overlapping uut(.clk(clk),.rst(rst),.n(n),.d(d)); 
  always #5 clk=~clk;
  initial begin
   $dumpfile("lh.vcd");
   $dumpvars(0,tb_moore_11011_overlapping);
   $display("clk rst in out");
   $monitor("%b  %b  %b  %b",clk,rst,n,d);
   clk=0;
   rst=0;
   n=0;
   #10;
   rst=1;n=1;#10;
   rst=1;n=1;#10;
   rst=1;n=0;#10;
   rst=1;n=1;#10;
   rst=1;n=1;#10;
   $finish;
  end
endmodule