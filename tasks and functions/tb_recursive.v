module tb_factorial_function;

    reg [2:0] N;
    wire [15:0] fact_out;

    factorial_function uut (
        .N(N),
        .fact_out(fact_out)
    );

    initial begin
        $dumpfile("factorial.vcd");
        $dumpvars(0, tb_factorial_function);

        // Test all values 0 to 6
        for (N = 0; N <= 6; N = N + 1) begin
            #10; // wait 10 time units
            $display("Factorial(%0d) = %0d", N, fact_out);
        end

        $finish;
    end

endmodule
