module S_R_Latch (
    output reg q,
    output reg qbar,
    input s,
    input r,
    input En
);

always @(*) begin
    if(En==0) begin
        q=1'bx;
        qbar=1'bx;
    end
    else if (s == 0 && r == 0 && En==1) begin
        q = q; 
        qbar = ~q;
    end 
    else if (s == 0 && r == 1 && En==1) begin
        q = 1'b0;
        qbar = 1'b1;
    end 
    else if (s == 1 && r == 0 && En==1) begin
        q = 1'b1;
        qbar = 1'b0;
    end 
    else begin
        q = 1'bx;        
        qbar = 1'bx;
    end
end

endmodule
