module tb_uart_receiver_parity;
 reg d,clk,rst;
 wire [7:0] dout;
 wire done;
 always #5 clk=~clk;
 uart_receiver_parity uut(done,dout,d,clk,rst);
 initial begin
   $dumpfile("csk.vcd");
   $dumpvars(0,tb_uart_receiver_parity);
   $display("clk rst d dout       done");
   $monitor("%b %b %b %b         %b",clk,rst,d,dout,done);
   clk=0;
   rst=0;
   #10;
   rst=1;
   d=0;#10;
   d=1;#10;
   d=0;#10;
   d=0;#10;
   d=0;#10;
   d=0;#10;
   d=0;#10;
   d=0;#10;
   d=1;#10;
   d=1;#10;
   d=1;#10;
   #10;
   $finish;
 end
endmodule