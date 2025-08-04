module tb_d_ff;
  reg d, clk;
  wire q, qbar;

  d_ff uut(.d(d), .clk(clk), .q(q), .qbar(qbar));

  initial begin
    $dumpfile("max.vcd");
    $dumpvars(0, tb_d_ff);
    $display("Clk D | Q QBAR");
    $monitor("%b %b | %b %b", clk, d, q, qbar);

    clk = 0; d = 0; #5;
    clk = 1;        #5;
    clk = 0; d = 1; #5;
    clk = 1;        #5;
    clk = 0; d = 0; #5;
    clk = 1;        #5;
    clk = 0; d = 1; #5;
    clk = 1;        #5;

    $finish;
  end
endmodule
