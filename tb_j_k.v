module tb_j_k;
  reg Clk,J,K;
  wire q,qbar;
  j_k_latch uut(.Clk(Clk),.J(J),.K(K),.q(q),.qbar(qbar));
  initial begin
    $dumpfile("latch.vcd");
    $dumpvars(0,tb_j_k);
    $display("Clk J K | Q Qbar");
    $monitor("%b %b %b | %b %b",Clk,J,K,q,qbar);
    Clk=0;J=0;K=0;#10;
    Clk=0;J=0;K=1;#10;
    Clk=0;J=1;K=0;#10;
    Clk=0;J=1;K=1;#10;
    Clk=1;J=0;K=0;#10;
    Clk=1;J=0;K=1;#10;
    Clk=1;J=1;K=0;#10;
    Clk=1;J=1;K=1;#10;
    $finish;
  end
endmodule
    