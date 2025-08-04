module tb_nor_dataflow;
  reg A,B;
  wire Y;
  nor_gate_dataflow uut(Y,A,B);
 
  initial begin
    $dumpfile("t4.vcd");
    $dumpvars(0,tb_nor_dataflow);
    $display("A B| Y(NOR)");
    $monitor("%b %b| %b",A ,B, Y);
    A=0;B=0;#10;
    A=0;B=1;#10;
    A=1;B=0;#10;
    A=1;B=1;#10;
    $finish;
  end
endmodule