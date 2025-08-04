module tb_xor_dataflow;
  reg A,B;
  wire Y;
  xor_data uut(.Y(Y),.A(A),.B(B));
  
  initial begin
    $dumpfile("test2.vcd");
    $dumpvars(0,tb_xor_dataflow);
    $display("A B | Y(AND)");
    $monitor("%b %b | %b", A, B, Y);
    
    A=0;B=0;#10;
    A=0;B=1;#10;
    A=1;B=0;#10;
    A=1;B=1;#10;
    $finish;
  end
endmodule