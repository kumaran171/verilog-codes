module tb_not_dat;
 reg a;
 wire y;
 not_gate_dat uut(.Y(y),.A(a));
 
 initial begin
   $dumpfile("test5.v");
   $dumpvars(0,tb_not_dat);
   $display("A | Y(NOT)");
   $monitor("%b | %b",a, y);
   a=0;#10;
   a=1;#10;
   $finish;
 end
endmodule