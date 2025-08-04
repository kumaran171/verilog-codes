module tb_uart_transmitter_parity;
  reg [7:0] din;
  reg clk, rst, start, stop;
  wire d;

  uart_transmitter_parity uut(d, din, clk, rst, start, stop);

  // Generate 10ns clock
  always #5 clk = ~clk;

  initial begin
    $dumpfile("csk.vcd");
    $dumpvars(0, tb_uart_transmitter_parity);
    $display("clk rst start stop din       d");
    $monitor("%b   %b    %b     %b   %b   %b", clk, rst, start, stop, din, d);

    // Initialization
    clk = 0;
    rst = 0;
    start = 1;  // idle
    stop = 0;
    din = 8'b0;

    // Apply reset
    #10;
    rst = 1;

    // Load data and trigger transmission
    din = 8'b10000001;
    start = 0;
    #100;  // wait 11+ bits

    // Trigger stop to go back to IDLE
    start = 1;
    stop = 1;
    #10;
    stop = 0;

    // End simulation
    #10;
    $finish;
  end
endmodule
