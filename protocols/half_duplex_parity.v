module half_duplex_parity(output done ,output [7:0] dout,input [7:0] din,input start,input stop,input clk,input rst,input[1:0] tx_mode);
 wire tx_d,tx_d1;
 wire [7:0] dout0,dout1;
 wire done0,done1;
 uart_transmitter_parity uut(
    tx_d,
    din,
    clk,
    rst,
    start,
    stop
);
 uart_receiver_parity uut1(
    done1,
    dout1,
    tx_d1,
    clk,
    rst
);
uart_receiver_parity1 uut2(
    done0,
    dout0,
    tx_d,
    clk,
    rst
);
 uart_transmitter_parity1 uut3(
    tx_d1,
    din,
    clk,
    rst,
    start,
    stop
);
   assign done=(tx_mode==2'b01)?done0:(tx_mode==2'b10)?done1:2'b0;
   assign dout=(tx_mode==2'b01)?dout0:(tx_mode==2'b10)?dout1:8'b0;
endmodule