module melay_1001_overlapping(output reg d,input n,input clk,input rst);
   parameter [1:0] S0=2'b00,
                   S1=2'b01,
                   S2=2'b10,
                   S3=2'b11;
   reg [1:0] state,next;
   always @(posedge clk or negedge rst) begin
      if(!rst) begin
        state<=S0; 
      end
      else begin
        state<=next;
      end
   end
   always @(state or n) begin
     next=2'bx;
     d=1'b0;
     case(state) 
        S0: begin
         if(n==0) begin
            next=S0;
            d=1'b0;
         end
         else begin
            next=S1;
            d=1'b0;
         end
        end
        S1: begin
         if(n==0) begin
            next=S2;
            d=1'b0;
         end
         else begin
            next=S1;
            d=1'b0;
         end
        end
        S2: begin
         if(n==0) begin
            next=S3;
            d=1'b0;
         end
         else begin
            next=S1;
            d=1'b0;
         end
        end
        S3: begin
         if(n==1) begin
            next=S1;
            d=1'b1;
         end
         else begin
            next=S0;
            d=1'b0;
         end
        end
      endcase
    end
endmodule


     
    
      