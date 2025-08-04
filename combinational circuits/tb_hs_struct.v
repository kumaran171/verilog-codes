module tb_hs_struct;
   reg A,Bin;
   wire D,Bout;
   half_sub_struct uut(.A(A),.Bin(Bin),.D(D),.Bout(Bout));
   initial begin
     $dumpfile("z5.vcd");
     $dumpvars(0,tb_hs_struct);
     $display("A Bin| D Bout");
     $monitor("%b %b| %b %b",A,Bin,D,Bout);
     A=0;Bin=0;#10;
     A=0;Bin=1;#10;
     A=1;Bin=0;#10;
     A=1;Bin=1;#10;
     $finish;
   end
endmodule



     
    