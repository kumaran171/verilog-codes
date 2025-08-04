module T_latch (
    input T,
    input clk,        
    output reg q,
    output wire qbar
);
    assign qbar = ~q;

    initial q = 0;    
    always @(*) begin
        if (clk) begin
            if (T)
                q = ~q;         
            else
                q = q;          
        end
    end
endmodule
