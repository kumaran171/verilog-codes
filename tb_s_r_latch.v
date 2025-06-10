module tb_s_r_latch;
 reg s,r;
 wire q,qbar;
 S_R_Latch uut(.s(s),.r(r),.q(q),.qbar(qbar));
 initial begin
   $dumpfile("z.vcd");
   $dumpvars(0,tb_s_r_latch);
   $display("S R |Q Qn");
   $monitor("%b %b |%b %b",s,r,q,qbar);
   s=0;r=0;#10;
   s=0;r=1;#10;
   s=1;r=0;#10;
   s=1;r=1;#10;
   $finish;
 end
endmodule
   