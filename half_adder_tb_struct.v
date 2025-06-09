module tb_halfadder_structural;
   reg A,B;
   wire sum,carry;
   half_adder uut(.Sum(sum),.Carry(carry),.A(A),.B(B));
   initial begin
      $dumpfile("z1.vcd");
      $dumpvars(0,tb_halfadder_structural);
      $display("A B| S C(HA)");
      $monitor("%b %b| %b %b",A,B,sum,carry);
      A=0;B=0;#10;
      A=0;B=1;#10;
      A=1;B=0;#10;
      A=1;B=1;#10;
      $finish;
    end
endmodule
      