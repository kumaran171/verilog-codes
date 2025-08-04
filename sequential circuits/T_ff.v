module T_flip(output reg q, output reg qbar, input t, input clk);
   initial begin
    q = 1'b0;
    qbar = 1'b1;
   end

   always @(posedge clk) begin
    if (t==0) begin
       q = q;
       qbar = ~q;
    end
    else begin
       q = ~q;
       qbar = ~q;
    end
   end
endmodule