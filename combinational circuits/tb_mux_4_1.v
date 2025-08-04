module tb_mux_4_1_s;
 reg [3:0] I;
 reg [1:0] s;
 wire Y;
 mux_4_1_s uut(.I(I),.s(s),.Y(Y));
 initial begin
   $dumpfile("z20.vcd");
   $dumpvars(0,tb_mux_4_1_s);
   $display("I3 I2 I1 I0 S1 S0 | Y");
   $monitor("%b %b %b %b %b %b | %b", I[3],I[2],I[1],I[0],s[1],s[0],Y);
   I=4'b0000;s=2'b00;#10;
   I=4'b0001;s=2'b00;#10;
   I=4'b0000;s=2'b01;#10;
   I=4'b0010;s=2'b01;#10;
   I=4'b0000;s=2'b10;#10;
   I=4'b0100;s=2'b10;#10;
   I=4'b0000;s=2'b11;#10;
   I=4'b1000;s=2'b11;#10;
   $finish;
 end
endmodule
