module tb_full_duplex_uart_parity;
 reg clk,rst,start1,stop1,start2,stop2;
 reg [7:0] din1,din2;
 wire done1,done2;
 wire [7:0] dout1,dout2;
 always #5 clk=~clk;
 full_duplex_uart_parity uut(done1,done2,dout1,dout2,din1,din2,clk,rst,start1,stop1,start2,stop2);
 initial begin
  $dumpfile("Ferrari.vcd");
  $dumpvars(0,tb_full_duplex_uart_parity);
  $display("clk rst start1 start2 stop1 stop2 din1         din2         dout1             dout2            done1 done2");
  $monitor("%b %b %b %b %b %b %b          %b          %b          %b          %b %b",clk,rst,start1,start2,stop1,stop2,din1,din2,dout1,dout2,done1,done2);
  clk=0;
  rst=0;
  din1=8'b0;
  din2=8'b0; 
  start1=1;
  start2=1;
  stop1=0;
  stop2=0;
  #10;
  rst=1;
  din1=8'b11000001;
  din2=8'b10000001;
  start1=0;
  start2=0;
  #10;
  start1=1;
  start2=1;
  #80;
  stop1=1; 
  stop2=1;
  #20;
  $finish;
 end
endmodule