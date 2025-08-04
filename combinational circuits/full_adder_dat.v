module full_adder_dat(output S,Cout,input A,B,C);
   wire y1,y2,y3,y4,y5;
   assign y1=A^B;
   assign S=y1^C;
   assign y2=A&B;
   assign y3=B&C;
   assign y4=A&C;
   assign y5=y2|y3;
   assign Cout=y5|y4;
endmodule
   