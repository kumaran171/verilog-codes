module tb_hs_dat;
   reg A,Bin;
   wire D,Bout;
   half_sub_dat uut(.A(A),.Bin(Bin),.D(D),.Bout(Bout));
   initial begin
     $dumpfile("z6.vcd");
     $dumpvars(0,tb_hs_dat);
     $display("A Bin| D Bout");
     $monitor("%b %b| %b %b",A,Bin,D,Bout);
     A=0;Bin=0;#10;
     A=0;Bin=1;#10;
     A=1;Bin=0;#10;
     A=1;Bin=1;#10;
     $finish;
   end
endmodule
