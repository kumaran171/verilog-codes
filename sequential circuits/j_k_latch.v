module j_k_latch(output reg q,output reg qbar,input Clk,input J,input K);
   always @ (*) begin
     if(Clk==0) begin
       q=1'b0;
       qbar=1'b1;
     end
     else if(J==0 && K==0 && Clk==1) begin
        q=q;
        qbar=~q;
     end
     else if(J==1 && K==0 && Clk==1) begin
        q=1'b1;
        qbar=1'b0;
     end
     else if(J==0 && K==1 && Clk==1) begin
        q=1'b0;
        qbar=1'b1;
     end
     else begin
        q=~q;
        qbar=~q;
     end
   end
endmodule