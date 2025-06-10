module T_latch (
    input T,
    input clk,       // level-sensitive enable
    output reg q,
    output wire qbar
);
    assign qbar = ~q;

    initial q = 0;   // initialize Q at simulation start

    always @(*) begin
        if (clk) begin
            if (T)
                q <= ~q;   // toggle
            // else: hold Q
        end
        // else: hold Q
    end
endmodule
