module tb_mealy_1001_seq;
  reg n,clk,rst;
  wire d;
  melay_1001_overlapping uut(.n(n),.clk(clk),.rst(rst),.d(d));
  always #5 clk=~clk;
  initial begin
   $dumpfile("lh.vcd");
   $dumpvars(0,tb_mealy_1001_seq);
   $display("clk rst in out");
   $monitor("%b %b %b %b",clk,rst,n,d);
   clk=0;
   rst=0;
   n=0;
   #10;
   rst=1;
   n=1;#10;
   n=0;#10;
   n=0;#10;
   n=1;#10;
   $finish;
  end
endmodule
  