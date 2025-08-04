module tb_receiver1_uart_fsm;
 reg clk,rst,d;
 wire [7:0] dout;
 wire done;
 receiver1_uart_fsm uut(dout,done,d,clk,rst);
 always #5 clk=~clk;
 initial begin
  $dumpfile("csk.vcd");
  $dumpvars(0,tb_receiver1_uart_fsm);
  $display("clk  rst  d  dout           done");
  $monitor("%b    %b   %b  %b            %b",clk,rst,d,dout,done);
  clk=0;
  rst=0;
  d=1;
  #10;
  rst=1;
  d=0;#10;
  d=1;#10;
  d=1;#10;
  d=0;#10;
  d=0;#10;
  d=0;#10;
  d=0;#10;
  d=1;#10;
  d=1;#10;
  d=1;#10;
  $finish;
 end
endmodule
  
