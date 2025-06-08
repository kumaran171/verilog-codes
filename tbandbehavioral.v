module tb_and_behavioral;
  reg A,B;
  wire Y;
  and_gate_behavioral uut(Y,A,B);
  
  initial begin
    $dumpfile("test2.vcd");
    $dumpvars(0,tb_and_behavioral);
    $display("A B | Y(AND)");
    $monitor("%b %b | %b", A, B, Y);
    
    A=0;B=0;#10;
    A=0;B=1;#10;
    A=1;B=0;#10;
    A=1;B=1;#10;
    $finish;
  end
endmodule