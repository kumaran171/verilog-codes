module d_ff(output reg q, output reg qbar, input d, input clk);
  initial begin
    q = 1'b0;
    qbar = 1'b1;
  end

  always @(posedge clk) begin
      q = d;
      qbar = ~q;
  end
endmodule
