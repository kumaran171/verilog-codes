module s_r_flip_flop(output reg q,output reg qbar,input clk,input s,input r);
   initial begin
     q=1'b0;
     qbar=1'b1;
   end
   always @(posedge clk) begin
     if(s==0 && r==0) begin
       q=q;
       qbar=~q;
     end
     else if(s==0 && r==1) begin
       q=1'b0;
       qbar=1'b1;
     end
     else if(s==1 && r==0) begin
       q=1'b1;
       qbar=1'b0;
     end
     else begin
       q=1'bx;
       qbar=1'bx;
     end
   end
endmodule

  