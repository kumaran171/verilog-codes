module tb_uart_simplex_parity;
 reg [7:0] din;
 reg clk,rst,start,stop;
 wire done;
 wire [7:0] dout;
 uart_simplex_parity dut(done,dout,din,clk,rst,start,stop);
 always #5 clk=~clk;
 initial begin
  $dumpfile("csk.vcd");
  $dumpvars(0,tb_uart_simplex_parity);
  $display("clk rst start stop din dout done");
  $monitor("%b %b %b %b %b         %b         %b",clk,rst,start,stop,din,dout,done);
  clk=0;
  rst=0;
  start=1;
  stop=0;
  din=8'b0;
  #10;
  rst=1;
  start=0;
  din=8'b10000001;
  #90;
  stop=1;
  start=1;
  #20;
  $finish;
 end
endmodule