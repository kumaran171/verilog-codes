module uart_half_duplex (
    output wire done,
    output wire [7:0] dout,
    input wire [7:0] din,
    input wire clk,
    input wire rst,
    input wire start,
    input wire stop,
    input wire [1:0] tx_mode  // 2'b01 or 2'b10
);

    // Shared wires
    wire tx_d0, tx_d1;
    wire done0, done1;
    wire [7:0] dout0, dout1;

    // Mode 01: Uses uart_transmitter_fsm + receiver1_uart_fsm
    uart_transmitter_fsm uut (
        .d(tx_d0),
        .out(),               // unused
        .start(start),
        .stop(stop),
        .din(din),
        .clk(clk),
        .rst(rst)
    );

    receiver1_uart_fsm uut1 (
        .dout(dout0),
        .done(done0),
        .d(tx_d0),
        .clk(clk),
        .rst(rst)
    );

    // Mode 10: Uses transmitter_uart_1_fsm + transmitter_uart_receiver
    transmitter_uart_1_fsm uut2 (
        .d(tx_d1),
        .din(din),
        .clk(clk),
        .rst(rst),
        .start(start),
        .stop(stop)
    );

    transmitter_uart_receiver uut3 (
        .done(done1),
        .dout(dout1),
        .clk(clk),
        .rst(rst),
        .d(tx_d1)
    );

    // Mux the outputs based on tx_mode
    assign done = (tx_mode == 2'b01) ? done0 :
                  (tx_mode == 2'b10) ? done1 : 1'b0;

    assign dout = (tx_mode == 2'b01) ? dout0 :
                  (tx_mode == 2'b10) ? dout1 : 8'd0;

endmodule
