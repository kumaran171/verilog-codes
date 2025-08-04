module moore_1011_2block (
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

    // Combined Next-State and Output Logic
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

    // State and Output Update
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S0;
            out <= 0;
        end else begin
            state <= next;
            case (next)
                S4: out <= 1;
                default: out <= 0;
            endcase
        end
    end
endmodule
