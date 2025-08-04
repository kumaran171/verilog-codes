module uart_transmitter_fsm (
    output reg d,
    output reg out, 
    input start,
    input stop,
    input [7:0] din,
    input clk,
    input rst
);

    parameter [1:0] IDLE = 2'b00,
                    TX = 2'b01,
                    STOP = 2'b10;
    parameter clockspeed=50000000;
    parameter baudrate=9600;
    parameter baud_clock=clockspeed/(baudrate*16);
    parameter mid_tick=baud_clock/2;
    reg [1:0] state, next;
    reg [7:0] temp;
    reg [2:0] bit_cnt;
    reg [12:0] baud_count;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
            bit_cnt <= 3'd0;
            temp <= 8'd0;
            baud_count <=13'b0;
        end 
        else begin
          if(baud_count==mid_tick) begin
            state <= next;
            if (state == IDLE && start == 0) begin
                temp <= din;
                bit_cnt <= 3'd0;
            end 
            else if (state == TX) begin
                temp <= temp >> 1;
                bit_cnt <= bit_cnt + 1;
            end
          end
          else begin
             baud_count<=baud_count+1;
          end
        end
    end

    always @(*) begin
        next = state;
        d = 1'b1;  
        case (state)
            IDLE: begin
                d = 1'b0;  
                if (start == 0)
                    next = TX;
            end
            TX: begin
                d = temp[0];
                if (bit_cnt == 3'd7)
                    next = STOP;
            end
            STOP: begin
                d = 1'b1;
                if (stop)
                    next = IDLE;
            end
        endcase
    end

endmodule
