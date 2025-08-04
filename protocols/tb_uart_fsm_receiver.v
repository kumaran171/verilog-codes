module tb_uart_fsm_receiver;
 reg clk,rst,d;
 wire done;
 wire [7:0] dout;
 transmitter_uart_receiver uut(.clk(clk),.rst(rst),.d(d),.done(done),.dout(dout));
 always #5 clk=~clk;
 initial begin
    $dumpfile("seb.vcd");
    $dumpvars(0, tb_uart_fsm_receiver);
    $display("clk rst d done dout");
    $monitor("%b %b %b %b %b", clk, rst, d, done, dout);

    clk = 0;
    rst = 0;
    d = 1; // idle
    #10;
    rst = 1;

    d = 0; #10;

    // Data bits (LSB first)
    d = 1; #10;
    d = 1; #10;
    d = 0; #10;
    d = 1; #10;
    d = 0; #10;
    d = 1; #10;
    d = 0; #10;
    d = 1; #10;

    // Stop bit
    d = 1; #10;

    #20;
    $finish;
 end
endmodule
