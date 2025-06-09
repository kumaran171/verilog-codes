module tb_fa_struct;
  reg A, B, C;
  wire S, Cout;
  full_adder_struct uut(.S(S),.Cout(Cout),.A(A),.B(B),.Cin(C));
  initial begin
    $dumpfile("z3.vcd");
    $dumpvars(0,tb_fa_struct);
    $display("A B Cin| S Cout");
    $monitor("%b %b %b| %b %b",A,B,C,S,Cout);
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
   
   