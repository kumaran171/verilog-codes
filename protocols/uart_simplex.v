module uart_simplex(
    output [7:0] dout,
    output done,
    input [7:0] din,
    input clk,
    input rst,
    input start,
    input stop
);
    wire tx_d, out_unused;

    uart_transmitter_fsm tx(
        .d(tx_d),
        .out(out_unused),
        .start(start),
        .stop(stop),
        .din(din),
        .clk(clk),
        .rst(rst)
    );

    transmitter_uart_receiver rx(
        .done(done),
        .dout(dout),
        .clk(clk),
        .rst(rst),
        .d(tx_d)
    );
endmodule
