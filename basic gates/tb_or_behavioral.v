module tb_or_behavioral;
  reg A,B;
  wire Y;
  or_beh uut(Y, A, B);
  initial begin
    $dumpfile("t.vcd");
    $dumpvars(0,tb_or_behavioral);
    $display("A B| Y(OR)");
    $monitor("%b %b| %b", A, B, Y);

    A=0;B=0;#10;
    A=0;B=1;#10;
    A=1;B=0;#10;
    A=1;B=1;#10;
    $finish;
  end
endmodule
    