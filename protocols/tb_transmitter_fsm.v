// UART Transmitter Testbench (Matches FSM Design with STOP support)

module tb_transmitter_fsm;

    reg clk, rst, start, stop;
    reg [7:0] din;
    wire d;
    wire out;
    // Instantiate the UART transmitter FSM
    uart_transmitter_fsm uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .stop(stop),
        .din(din),
        .d(d),.out(out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0, tb_transmitter_fsm);
        $display("Time\tclk\trst\tstart\tstop\tdin\t\td");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%8b\t%b\t%b", $time, clk, rst, start, stop, din, d,out);

        clk = 0;
        rst = 0;
        start = 1;
        stop = 0;
        din = 8'b00000000;
        #10;
        rst=1'b1;
        din = 8'b10101010;
        start = 0;
        stop = 0;
        #80;
        start = 1;
        stop = 1;#10;
        

        $finish;
    end

endmodule

