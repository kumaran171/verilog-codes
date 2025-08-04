module D_latch(output reg q,output reg qbar,input D,input En);
  always @(*) begin
    if(En==0) begin
      q=1'b0;
      qbar=1'b1;
    end
    else if(D==0) begin
      q=1'b0;
      qbar=1'b1;
    end
    else begin
      q=1'b1;
      qbar=1'b0;
    end
  end
endmodule
 