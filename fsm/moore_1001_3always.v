module moore_1011_3block (
    input clk, rst, in,
    output reg out
);

    // State Encoding
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;

    reg [2:0] state, next;

    // 1. State Update Block
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next;
    end

    // 2. Next-State Logic
    always @(*) begin
        case (state)
            S0: next = (in == 1) ? S1 : S0;
            S1: next = (in == 0) ? S2 : S1;
            S2: next = (in == 1) ? S3 : S0;
            S3: next = (in == 1) ? S4 : S2;
            S4: next = (in == 1) ? S1 : S2;
            default: next = S0;
        endcase
    end

    // 3. Output Logic (Moore-style)
    always @(*) begin
        case (state)
            S4: out = 1;
            default: out = 0;
        endcase
    end
endmodule
