module uart_simplex_parity(output done,output [7:0] dout,input [7:0] din,input clk,input rst,input start,input stop);
   wire tx_d;
   uart_transmitter_parity uut(tx_d,din,clk,rst,start,stop);
   uart_receiver_parity uut1(done,dout,tx_d,clk,rst);
endmodule