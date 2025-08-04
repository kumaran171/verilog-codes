module factorial_function (
    input  [2:0] N,
    output [15:0] fact_out
);

    function automatic [15:0] factorial(input [2:0] n);
        begin
            if (n <= 1)
                factorial = 1;
            else
                factorial = n * factorial(n - 1);
        end
    endfunction

    assign fact_out = factorial(N);

endmodule
