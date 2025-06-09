module half_sub_struct(output D,Bout,input A,Bin);
    wire y;
    xor g1(D,A,Bin);
    not g2(y,A);
    and(Bout,y,Bin);
endmodule
    
    