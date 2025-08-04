module tb_xnor_struct;
  reg A,B;
  wire Y;
  xnor_gate_struct uut(.Y(Y),.A(A),.B(B));
  
  initial begin
    $dumpfile("Test2.vcd");
    $dumpvars(0,tb_xnor_struct);
    $display("A B | Y(AND)");
    $monitor("%b %b | %b", A, B, Y);
    
    A=0;B=0;#10;
    A=0;B=1;#10;
    A=1;B=0;#10;
    A=1;B=1;#10;
    $finish;
  end
endmodule