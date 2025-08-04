module spi (
    output [7:0] dout1,
    output [7:0] dout2,
    output done1,
    output done2,
    input clk,
    input rst,
    input [7:0] din1,
    input [7:0] din2
);

    wire mosi_master_to_slave;
    wire miso_slave_to_master;

    spi_master master (
        .clk(clk),
        .rst(rst),
        .din(din1),
        .miso(miso_slave_to_master),
        .mosi(mosi_master_to_slave),
        .dout(dout2),
        .done(done2)
    );

    spi_slave slave (
        .clk(clk),
        .rst(rst),
        .din(din2),
        .mosi(mosi_master_to_slave),
        .done(done1),
        .dout(dout1),
        .miso(miso_slave_to_master)
    );

endmodule
