module full_sub_dat(output D,Bout,input A,Bin,C);
  wire y1,y2,y3,y4,y5;
  assign y1=A^Bin;
  assign D=y1^C;
  assign y2=Bin&C;
  assign y3=Bin^C;
  assign y4=~A;
  assign y5=y4&y3;
  assign Bout=y2|y5;
endmodule