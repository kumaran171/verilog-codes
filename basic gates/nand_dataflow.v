module nand_dat(output Y, input A,input B);
   assign Y=~(A & B);
endmodule