module tb_L_latch;
   reg clk,T;
   wire q,qbar;
   T_latch uut(.clk(clk),.T(T),.q(q),.qbar(qbar));
   initial begin
    $dumpfile("c.vcd");
    $dumpvars(0,tb_L_latch);
    $display("clk T | q qbar");
    $monitor("%b %b | %b %b",clk,T,q,qbar);
    clk=0;T=0;#10;
    clk=0;T=1;#10;
    clk=1;T=0;#10;
    clk=1;T=1;#10;
    $finish;
   end
endmodule


