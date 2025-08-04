module tb_uart_half_duplex;
 reg clk,rst,start,stop;
 reg [1:0] tx_mode;
 reg [7:0] din;
 wire [7:0] dout;
 wire done;
 uart_half_duplex uut(done,dout,din,clk,rst,start,stop,tx_mode);
 always #5 clk=~clk;
 initial begin
  $dumpfile("Canada.vcd");
  $dumpvars(0,tb_uart_half_duplex);
  $display(" clk rst tx_mode start stop din dout done");
  $monitor("%b %b %b %b %b %b           %b         %b",clk,rst,tx_mode,start,stop,din,dout,done);
  rst=0;
  clk=0;
  start=1;
  stop=0;
  tx_mode=2'b00;
  din=8'b0;
  #10;
  rst=1;
  tx_mode=2'b01;
  start=0;
  din=8'b11000011;
  #10;
  start=1;
  #80;
  stop=1;
  #20;
  rst=0;
  clk=0;
  start=1;
  stop=0;
  tx_mode=2'b00;
  din=8'b0;
  #10;
  rst=1;
  tx_mode=2'b10;
  start=0;
  din=8'b11000001;
  #10;
  start=1;
  #80;
  stop=1;
  $finish;
 end
endmodule
  