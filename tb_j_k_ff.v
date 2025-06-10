module tb_j_ff;
  reg clk,j,k;
  wire q,qbar;
  j_k_flip uut(.q(q),.qbar(qbar),.clk(clk),.j(j),.k(k));
  initial begin
   $dumpfile("Charles.vcd");
   $dumpvars(0,tb_j_ff);
   $display("J K CLK | Q QBAR");
   $monitor("%b %b %b | %b %b",j,k,clk,q,qbar);
   clk=0;j=0;k=0;#5;
   clk=1;#5;
   clk=0;j=0;k=1;#5;
   clk=1;#5;
   clk=0;j=1;k=0;#5;
   clk=1;#5;
   clk=0;j=1;k=1;#5;
   clk=1;#5;
   $finish;
  end
endmodule