module uart_interface(
    input clk,
    input rst,
    input [7:0] data_in,       
    input rx,              
    output tx,             
    output rx_done,        
    output [7:0] data_out  
);

    // Internal wires
    wire d_tx;
    wire done_rx;

    // Transmitter instance
    uart_transmitter_fsm tx_inst (
        .d(d_tx),
        .out(),                // Not used
        .start(1'b0),          // Always start (can be modified to trigger from button)
        .stop(1'b1),
        .din(data_in),
        .clk(clk),
        .rst(rst)
    );

    // Receiver instance
    transmitter_uart_receiver rx_inst (
        .done(done_rx),
        .dout(data_out),
        .clk(clk),
        .rst(rst),
        .d(rx)
    );

    assign tx = d_tx;
    assign rx_done = done_rx;

endmodule
