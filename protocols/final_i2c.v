module i2c_top (
    input clk,
    input rst,
    input newd,
    input op,
    input [6:0] addr,
    input [7:0] din,
    output [7:0] dout,
    output busy,
    output ack_err,
    output done
);

    wire sda;       // Open-drain shared SDA
    wire scl;       // Driven by master only

    wire ack_errm, ack_errs;
    wire master_done, slave_done;

    // Master instance
    i2c_master master_inst (
        .clk(clk),
        .rst(rst),
        .newd(newd),
        .addr(addr),
        .op(op),
        .sda(sda),
        .scl(scl),
        .din(din),
        .dout(dout),
        .busy(busy),
        .ack_err(ack_errm),
        .done(master_done)
    );

    // Slave instance
    i2c_Slave slave_inst (
        .scl(scl),
        .clk(clk),
        .rst(rst),
        .sda(sda),
        .ack_err(ack_errs),
        .done(slave_done)
    );

    // Combine errors
    assign ack_err = ack_errm | ack_errs;

    // Output done signal (master drives bus protocol)
    assign done = master_done;

endmodule
