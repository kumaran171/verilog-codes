module comparator_4bit (
    input a3, a2, a1, a0,
    input b3, b2, b1, b0,
    output ceq, clt, cgt
);

    wire [3:0] a, b;

    assign a = {a3, a2, a1, a0};
    assign b = {b3, b2, b1, b0};

    assign ceq = (a == b);
    assign clt = (a < b);
    assign cgt = (a > b);

endmodule
