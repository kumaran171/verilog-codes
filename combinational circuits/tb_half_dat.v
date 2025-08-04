module tb_ha_dat;
   reg A,B;
   wire sum,carry;
   half_adder_dat uut(.A(A),.B(B),.SUM(sum),.CARRY(carry));
   initial begin
     $dumpfile("z2.vcd");
     $dumpvars(0,tb_ha_dat);
     $display("A B| S C");
     $monitor("%b %b| %b %b",A,B,sum,carry);
     A=0;B=0;#10;
     A=0;B=1;#10;
     A=1;B=0;#10;
     A=1;B=1;#10;
     $finish;
  end
endmodule