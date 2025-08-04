module tb_counter;
 reg [7:0] n;
 wire [7:0] c;
 count_pop uut(.n(n),.c(c));
 initial begin
   $dumpfile("lewis.vcd");
   $dumpvars(0,tb_counter);
   $display("N Count");
   $monitor("%b %0d",n,c);
   n=8'b01010101;#10;
   n=8'b00110011;#10;
   n=8'b10101100;#10;
   n=8'b11001011;#10;
   $finish;
 end
endmodule