module half_adder(output Sum,Carry,input A,B);
   xor g1(Sum,A,B);
   and g2(Carry,A,B);
endmodule
