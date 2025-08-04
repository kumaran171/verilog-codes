module tb_j_ff;
  reg clk,t;
  wire q,qbar;
  T_flip uut(.q(q),.qbar(qbar),.clk(clk),.t(t));
  initial begin
   $dumpfile("Charles.vcd");
   $dumpvars(0,tb_j_ff);
   $display("T CLK | Q QBAR");
   $monitor("%b %b | %b %b",t,clk,q,qbar);
   clk=0;t=0;#5;
   clk=1;#5;
   clk=0;t=1;#5;
   clk=1;#5;
   $finish;
  end
endmodule