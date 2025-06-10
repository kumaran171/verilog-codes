module tb_s_r_latch;
 reg s,r,En;
 wire q,qbar;
 S_R_Latch uut(.s(s),.r(r),.q(q),.qbar(qbar),.En(En));
 initial begin
   $dumpfile("z.vcd");
   $dumpvars(0,tb_s_r_latch);
   $display("S R |Q Qn");
   $monitor("%b %b |%b %b",s,r,q,qbar);
   En=0;s=0;r=0;#10;
   En=0;s=0;r=1;#10;
   En=0;s=1;r=0;#10;
   En=0;s=1;r=1;#10;
   En=1;s=0;r=0;#10;
   En=1;s=0;r=1;#10;
   En=1;s=1;r=0;#10;
   En=1;s=1;r=1;#10;
   $finish;
 end
endmodule