module mealy_11011_overlapping(output reg d,input clk,input rst,input n);
  parameter [2:0] S0=3'b000,
                  S1=3'b001,
                  S2=3'b010,
                  S3=3'b011,
                  S4=3'b100;
  reg [2:0] state,next;
  always @(posedge clk or negedge rst) begin
     if(!rst) begin
       state<=S0;
     end
     else begin
       state<=next;
     end
   end
  always @(state or n) begin
    next=3'bx;
    d=1'b0;
    case(state)
     S0:
      if(n==0) begin
        next=S0;
        d=1'b0;
      end
      else begin
        next=S1;
        d=1'b0;
      end
     S1:
      if(n==0) begin
        next=S0;
        d=1'b0;
      end
      else begin
        next=S2;
        d=1'b0;
      end
     S2:
      if(n==0) begin
        next=S3;
        d=1'b0;
      end
      else begin
        next=S2;
        d=1'b0;
      end
     S3:
      if(n==0) begin
        next=S0;
        d=1'b0;
      end
      else begin
        next=S4;
        d=1'b0;
      end
     S4:
      if(n==0) begin
        next=S0;
        d=1'b0;
      end
      else begin
        next=S0;
        d=1'b1;
      end
    endcase
  end
endmodule




       
     