module tb_uart_simplex;
    reg [7:0] din;
    reg clk, rst, start, stop;
    wire [7:0] dout;
    wire done;

    uart_simplex uut(
        .dout(dout),
        .done(done),
        .din(din),
        .clk(clk),
        .rst(rst),
        .start(start),
        .stop(stop)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0, tb_uart_simplex);
        $display("clk rst start stop din dout done");
        $monitor("%b  %b    %b     %b   %b  %b  %b", clk, rst, start, stop, din, dout, done);

        clk = 0;
        rst = 0;
        start = 1;
        stop = 0;
        din = 8'b0;

        // Reset
        #10;
        rst = 1;

        // Start transmission
        din = 8'b10000001;
        start = 0;  // trigger transmission
        #100;
        start = 1; 
        stop = 1;
        #10;
        stop = 0;

        #50;
        $finish;
    end
endmodule
