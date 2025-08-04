module less_comparison (
    input  [7:0] val1,
    input  [7:0] val2,
    output reg   less  // Must be reg if assigned in always
);

    function automatic integer lesser;
        input [7:0] n1;
        input [7:0] n2;
        integer k, k1;
        integer i;
        begin
            k  = 0;
            k1 = 0;
            for(i = 0; i < 8; i = i + 1)
                k = k + ((2 ** i) * n1[i]);
            for(i = 0; i < 8; i = i + 1)
                k1 = k1 + ((2 ** i) * n2[i]);

            if (k < k1)
                lesser = 1;
            else
                lesser = 0;
        end
    endfunction

    always @(*) begin
        less = lesser(val1, val2); // assign to output
    end

endmodule

