module transmitter_uart_1_fsm(output reg d,input [7:0] din,input clk,input rst,input start,input stop);
  parameter [1:0] IDLE=2'b00,
                  TX=2'b01,
                  STOP=2'b10;
  reg [1:0] next,state;
  reg [2:0] bit_cnt;
  reg [7:0] temp;
  always@(posedge clk or negedge rst) begin
    if(!rst) begin
      bit_cnt<=3'b0;
      temp<=8'b0;
      state<=IDLE;
    end
    else begin
      state<=next;
      if(state==IDLE && start==0) begin
         bit_cnt<=3'b0;
         temp<=din;
      end
      else if(state==TX) begin
         temp<=temp>>1;
         bit_cnt<=bit_cnt+1;
      end
    end
   end
   always@(state or start or stop or bit_cnt) begin
        next=state;
        d=1'b1;
        case(state)
         IDLE: begin
          d=1'b0;
          if(start==0) begin
            next=TX;
          end
         end
         TX: begin
          d=temp[0];
          if(bit_cnt==3'b111) begin
              next=STOP;
          end
         end
         STOP: begin
           d=1'b1;
           if(stop==1) begin
               next=IDLE;
           end
         end
        endcase
    end
endmodule