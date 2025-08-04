module count_pop (
    output  [7:0] c,
    input  [7:0] n
);

    function automatic [7:0] count(input [7:0] n);
        integer i;
        integer k;
        begin
            k = 0;  
            for (i = 0; i < 8; i = i + 1) begin
                if (n[i])
                    k = k + 1;
            end
            count = k;        
        end
    endfunction

    assign c = count(n);

endmodule
