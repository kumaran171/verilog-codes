module tb_xnor_dataflow;
  reg A,B;
  wire Y;
  
  xnor_dataflow uut(Y,A,B);
  initial begin
    $dumpfile("t5.vcd");
    $dumpvars(0,tb_xnor_dataflow);
    $display("A B| Y(XNOR");
    $monitor("%b %b| %b", A, B, Y);
    A=0;B=0;#10;
    A=0;B=1;#10;
    A=1;B=0;#10;
    A=1;B=1;#10;
    $finish;
  end
endmodule