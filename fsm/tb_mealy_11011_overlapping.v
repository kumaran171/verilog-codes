module tb_mealy_11011_overlapping;
  reg n,clk,rst;
  wire d;
  mealy_11011_overlapping uut(.d(d),.clk(clk),.n(n),.rst(rst));
  always #5 clk=~clk;
  initial begin
   $dumpfile("lh.vcd");
   $dumpvars(0,tb_mealy_11011_overlapping);
   $display("clk rst n out");
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
   