module tb_i2c_controller;
    reg clk = 0, rst = 1, enable = 0, rw = 0;
    reg [6:0] addr = 7'b1010101;
    reg [7:0] data_in = 8'b10101010;
    wire [7:0] data_out;
    wire ready;

    wire i2c_sda_wire, i2c_scl_wire;
    tri1 i2c_sda = i2c_sda_wire;
    tri1 i2c_scl = i2c_scl_wire;
    pullup(i2c_sda);
    pullup(i2c_scl);

    i2c_controller master (
        .clk(clk),
        .rst(rst),
        .addr(addr),
        .data_in(data_in),
        .enable(enable),
        .rw(rw),
        .data_out(data_out),
        .ready(ready),
        .i2c_sda(i2c_sda_wire),
        .i2c_scl(i2c_scl_wire)
    );

    i2c_slave_controller slave (
        .sda(i2c_sda_wire),
        .scl(i2c_scl_wire)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("i2c.vcd");
        $dumpvars(0, tb_i2c_controller);
        $display("Time\tclk\trst\ten\trw\taddr\tdata_in\tdata_out\tready");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%07b\t%08b\t%08b\t%b",
                 $time, clk, rst, enable, rw, addr, data_in, data_out, ready);

        #20 rst = 0;

        #30 enable = 1;
        #10 enable = 0;

        #1000 $finish;
    end
endmodule
