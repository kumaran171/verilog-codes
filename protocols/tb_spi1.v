module tb_spi;
    reg clk, rst;
    reg [7:0] din1, din2;
    wire [7:0] dout1, dout2;
    wire done1, done2;
    spi_N uut (
        .dout1(dout1),
        .dout2(dout2),
        .done1(done1),
        .done2(done2),
        .clk(clk),
        .rst(rst),
        .din1(din1),
        .din2(din2)
    );
    always #5 clk = ~clk;

    initial begin
        $dumpfile("spi.vcd");
        $dumpvars(0, tb_spi);
        $display("clk rst  din1        din2        dout1       dout2       done1 done2");
        $monitor("%b   %b   %b   %b   %b   %b   %b     %b", clk, rst, din1, din2, dout1, dout2, done1, done2);

        // Initialize signals
        clk = 0;
        rst = 0;   // Apply reset first
        din1 = 8'b0;
        din2 = 8'b0;

        #10;
        rst = 1;   
        din1 = 8'b10101010;  // Master sends this
        din2 = 8'b11001100;  // Slave sends this
        #100;
        $finish;
    end
endmodule
