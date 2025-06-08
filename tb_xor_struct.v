module tb_xor_struct;
  reg A,B;
  wire Y;
  
  xor_gate_struc uut(Y, A, B);
  initial begin
     $dumpfile("t1.vcd");
     $dumpvars(0,tb_xor_struct);
     $display("A B| Y(XOR)");
     $monitor("%b %b| %b", A, B,Y);
     
     A=0;B=0;#10;
     A=0;B=1;#10;
     A=1;B=0;#10;
     A=1;B=1;#10;
     $finish;
   end
endmodule
