module tb_d_latch;
   reg D,En;
   wire q,qbar;
   D_latch uut(.D(D),.En(En),.q(q),.qbar(qbar));
   initial begin
    $dumpfile("Z.vcd");
    $dumpvars(0,tb_d_latch);
    $display("EN D | Q Qn");
    $monitor("%b %b | %b %b",En,D,q,qbar);
    En=0;D=0;#10;
    En=0;D=1;#10; 
    En=1;D=0;#10;
    En=1;D=1;#10;
    $finish;
   end
endmodule