module full_duplex_uart_parity(output done1,output done2,output [7:0] dout1,output [7:0] dout2,input[7:0] din1,input [7:0] din2,input clk,input rst,input start1,input stop1,input start2,input stop2);
  wire tx_d1,tx_d2,out;
  uart_transmitter_parity uut(
    tx_d1, 
    din1,
    clk,
    rst,
    start1,
    stop1);
 uart_receiver_parity uut1(
    done2,
    dout2,
    tx_d2,
    clk,
    rst
 );
 uart_transmitter_parity1 uut2(tx_d2,din2,clk,rst,start2,stop2);
 uart_receiver_parity1 uut3(done1,dout1,tx_d1,clk,rst);
endmodule