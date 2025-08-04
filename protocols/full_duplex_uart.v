module full_duplex_uart(output done1,output done2,output [7:0] dout1,output [7:0] dout2,input[7:0] din1,input [7:0] din2,input clk,input rst,input start1,input stop1,input start2,input stop2);
  wire tx_d1,tx_d2,out;
  uart_transmitter_fsm uut(
    tx_d1,
    out, 
    start1,
    stop1,
    din1,
    clk,
    rst
 );
 transmitter_uart_receiver uut1(
    done2,
    dout2,
    clk,
    rst,
    tx_d2
 );
 transmitter_uart_1_fsm uut2(tx_d2,din2,clk,rst,start2,stop2);
 receiver1_uart_fsm uut3(dout1,done1,tx_d1,clk,rst);
endmodule
