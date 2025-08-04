module tb_transmitter1_fsm;
 reg [7:0] din;
 reg clk,rst,start,stop;
 wire d;
 transmitter_uart_1_fsm uut(d,din,clk,rst,start,stop);
 always #5 clk=~clk;
 initial begin
   $dumpfile("csk.vcd");
   $dumpvars(0,tb_transmitter1_fsm);
   $display("clk  rst  start  stop  din       d");
   $monitor("%b   %b   %b    %b     %b       %b",clk,rst,start,stop,din,d);
   clk=0;
   rst=0;
   din=8'b0;
   start=1;
   stop=0;
   #10;
   rst=1;
   start=0;
   din=8'b11000011;#10;
   start=1;
   #80;
   stop=1;
   #20;
   $finish;
  end
endmodule
