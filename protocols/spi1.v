module spi_N (
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

    spi_M uut (
        .clk(clk),
        .rst(rst),
        .din(din1),
        .miso(miso_slave_to_master),
        .mosi(mosi_master_to_slave),
        .dout(dout2),
        .done(done2)
    );

    spi_S uut1 (
        .clk(clk),
        .rst(rst),
        .din(din2),
        .mosi(mosi_master_to_slave),
        .miso(miso_slave_to_master),
        .dout(dout1),
        .done(done1)
    );

endmodule
