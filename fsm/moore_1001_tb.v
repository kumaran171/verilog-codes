module tb_moore_1011;

    reg clk, rst, in;
    wire out_2block, out_3block;

    // Instantiate 2-block FSM
    moore_1011_2block uut2 (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out_2block)
    );

    // Instantiate 3-block FSM
    moore_1011_3block uut3 (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out_3block)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units clock period
    end

    // Stimulus
    initial begin
        $display("Time\tIn\tOut_2B\tOut_3B\tState Comparison");
        $monitor("%4t\t%b\t%b\t%b", $time, in, out_2block, out_3block);

        rst = 1; in = 0;
        #10 rst = 0;

        // Apply input sequence: 1 0 1 1 (should detect "1011")
        in = 1; #10;
        in = 0; #10;
        in = 1; #10;
        in = 1; #10;

        // Try overlapping test: input continues
        in = 1; #10;
        in = 0; #10;
        in = 1; #10;
        in = 1; #10;

        in = 0; #10;
        in = 0; #10;
        in = 1; #10;
        in = 0; #10;
        in = 1; #10;
        in = 1; #10;

        $finish;
    end

endmodule
