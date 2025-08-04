module half_sub_dat(output D,Bout,input A,Bin);
  wire y;
  assign D=A ^ Bin;
  assign y=~A;
  assign Bout=y & Bin;
endmodule