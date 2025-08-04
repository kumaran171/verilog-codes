module tb_1001_moore_overlapping;
  reg clk, rst, in;
  wire d;
  moore_1001_overlapping uut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .d(d)
  );
  always #5 clk = ~clk;
  initial begin
    $dumpfile("kop.vcd");
    $dumpvars(0, tb_1001_moore_overlapping);
    $display("clk rst in out");
    $monitor("%b  %b  %b  %b", clk, rst, in, d);
    clk = 0;
    rst = 1;
    in = 0;
    #10 rst = 0;
    #10 rst = 1;
    in = 1; #10;
    in = 0; #10;
    in = 0; #10;
    in = 1; #10;
    in = 0; #10;
    in = 0; #10;
    in = 1; #10;
    $finish;
  end
endmodule
