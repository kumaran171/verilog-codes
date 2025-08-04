module j_k_flip(output reg q, output reg qbar, input j, input k, input clk);
   initial begin
    q = 1'b0;
    qbar = 1'b1;
   end

   always @(posedge clk) begin
    if (j == 0 && k == 1) begin
       q = 1'b0;
       qbar = 1'b1;
    end
    else if (j == 1 && k == 0) begin
       q = 1'b1;
       qbar = 1'b0;
    end
    else if (j == 0 && k == 0) begin
       q = q;       // holds value (but can omit)
       qbar = ~q;
    end
    else begin
       q = ~q;      // toggle
       qbar = ~q;
    end
   end
endmodule
