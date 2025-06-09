module tb_comparator_4bit;

    reg a3, a2, a1, a0;
    reg b3, b2, b1, b0;
    wire ceq, clt, cgt;

    comparator_4bit uut (
        .a3(a3), .a2(a2), .a1(a1), .a0(a0),
        .b3(b3), .b2(b2), .b1(b1), .b0(b0),
        .ceq(ceq), .clt(clt), .cgt(cgt)
    );

    initial begin
        $dumpfile("comparator_4bit.vcd");
        $dumpvars(0, tb_comparator_4bit);

        $display("Time | a3 a2 a1 a0 | b3 b2 b1 b0 | ceq clt cgt");
        $monitor("%4t |  %b  %b  %b  %b |  %b  %b  %b  %b |  %b   %b   %b",
                 $time, a3, a2, a1, a0, b3, b2, b1, b0, ceq, clt, cgt);

        // Test cases
        {a3, a2, a1, a0} = 4'b0000; {b3, b2, b1, b0} = 4'b0000; #10;
        {a3, a2, a1, a0} = 4'b0010; {b3, b2, b1, b0} = 4'b0100; #10;
        {a3, a2, a1, a0} = 4'b1010; {b3, b2, b1, b0} = 4'b0101; #10;
        {a3, a2, a1, a0} = 4'b1111; {b3, b2, b1, b0} = 4'b1111; #10;
        {a3, a2, a1, a0} = 4'b1000; {b3, b2, b1, b0} = 4'b0111; #10;
        {a3, a2, a1, a0} = 4'b0001; {b3, b2, b1, b0} = 4'b0010; #10;

        $finish;
    end

endmodule
