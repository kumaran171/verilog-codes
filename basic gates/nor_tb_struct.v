module tb_nor_struct;
 reg A,B;
 wire Y;
 nor_gate_struct uut(.Y(Y),.A(A),.B(B));
 initial begin
   $dumpfile("Test.vcd");
   $dumpvars(0,tb_nor_struct);
   $display("A B| Y(NOR)");
   $monitor("%b %b| %b",A,B,Y);
   A=0;B=0;#10;
   A=0;B=1;#10;
   A=1;B=0;#10;
   A=1;B=1;#10;
   $finish;
 end
endmodule