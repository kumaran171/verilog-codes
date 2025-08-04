module fact_task(
    input [7:0] n,
    output reg [7:0] out
);

    reg [7:0] temp;

    task automatic factorial;
        input [7:0] num;
        output [7:0] result;
        integer i;
        integer f;
        begin
            f = 1;
            for (i = 1; i <= num; i = i + 1)
                f = f * i;
            result = f;
        end
    endtask

    always @(*) begin
        factorial(n, temp);  // Use internal temp
        out = temp;          // Assign to output
    end

endmodule
