module tb_nand_dataflow;
  reg A,B;
  wire Y;
  
  nand_dat uut(Y, A, B);
  initial begin
     $dumpfile("t3.vcd");
     $dumpvars(0,tb_nand_dataflow);
     $display("A B| Y(NAND)");
     $monitor("%b %b| %b",A ,B, Y);
     A=0;B=0;#10;
     A=0;B=1;#10;
     A=1;B=0;#10;
     A=1;B=1;#10;
     $finish;
  end
endmodule
