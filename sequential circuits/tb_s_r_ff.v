module tb_s_r_ff;
  reg s,r,clk;
  wire q,qbar;
  s_r_flip_flop uut(.s(s),.r(r),.clk(clk),.q(q),.qbar(qbar));
  initial begin
    $dumpfile("lewis.vcd");
    $dumpvars(0,tb_s_r_ff);
    $display("Clk S R | Q QBAR");
    $monitor("%b %b %b | %b %b",clk,s,r,q,qbar);
    clk=0;s=0;r=0;#5;
    clk=1;#5;
    clk=0;s=0;r=1;#5;
    clk=1;#5;
    clk=0;s=1;r=0;#5;
    clk=1;#5;
    clk=0;s=1;r=1;#5;
    clk=1;
    $finish;
  end
endmodule

    