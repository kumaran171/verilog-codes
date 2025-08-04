module not_gate_dat;
 reg A;
 wire Y;
 not_gate_struct uut(.Y(Y),.A(A));
 initial begin
   $dumpfile("Test3.vcd");
   $dumpvars(0,not_gate_dat);
   $display("A | Y(NOT)");
   $monitor("%b | %b", A, Y);
   A=0;#10;
   A=1;#10;
   $finish;
 end
endmodule