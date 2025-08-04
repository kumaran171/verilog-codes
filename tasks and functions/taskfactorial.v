module factorial_task_example;

    reg [7:0] number;
    reg [31:0] fact_result;
    task factorial(input reg [7:0] n,output reg[31:0] result);
        integer i;
        begin
            result = 1;
            for (i = 1; i <= n; i = i + 1) begin
                result = result * i;
            end
        end
    endtask

    initial begin
        number = 5;
        factorial(number, fact_result);
        $display("Factorial of %0d is %0d", number, fact_result);
        $finish;
    end

endmodule
