module tb_onesz;
 reg [7:0] N;
 wire [3:0] out;
 no_of_ones uut(.N(N),.out(out));
 initial begin
   $dumpfile("lewis.vcd");
   $dumpvars(0,tb_onesz);
   N=8'b10010111;#10;
   $display("no of ones of %b is : %0d",N,out);
 end
endmodule
  