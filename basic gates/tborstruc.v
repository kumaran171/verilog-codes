module tb_or_struc;
  reg A,B;
  wire Y;
  or_gate_structural uut(Y, A, B);
  initial begin
     $dumpfile("test3.vcd");
     $dumpvars(0,tb_or_struc);
     $display("A B| Y(OR)");
     $monitor("%b %b| %b", A, B,Y);
     
     A=0;B=0;#10;
     A=0;B=1;#10;
     A=1;B=0;#10;
     A=1;B=1;#10;
     $finish;
  end
endmodule
     