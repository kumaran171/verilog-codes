module less_comparison (
    input  [7:0] val1,
    input  [7:0] val2,
    output less  // Must be reg if assigned in always
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
                $display("%0d is greater than %0d",k1,k);
            else
                $display("%0d is greater than %0d",k,k1);
        end
    endfunction

    assign less = lesser(val1, val2); // assign to output
    

endmodule