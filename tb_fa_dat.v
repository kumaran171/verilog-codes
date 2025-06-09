module tb_fa_dat;
   reg A,B,C;
   wire S,Cout;
   full_adder_dat uut(.A(A),.B(B),.C(C),.S(S),.Cout(Cout));
   initial begin
     $dumpfile("z4.vcd");
     $dumpvars(0,tb_fa_dat);
     $display("A B C|S Cout");
     $monitor("%b %b %b|%b %b",A,B,C,S,Cout);
     A=0;B=0;C=0;#10;
     A=0;B=0;C=1;#10;
     A=0;B=1;C=0;#10;
     A=0;B=1;C=1;#10;
     A=1;B=0;C=0;#10;
     A=1;B=0;C=1;#10;
     A=1;B=1;C=0;#10;
     A=1;B=1;C=1;#10;
     $finish;
   end
endmodule

   