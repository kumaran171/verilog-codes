module transmitter_uart_receiver(
    output reg done,
    output reg [7:0] dout,
    input clk,
    input rst,
    input d
);

    parameter [1:0] IDLE = 2'b00,
                    DATA = 2'b01,
                    STOP = 2'b10;

    reg [1:0] state, next;
    reg [7:0] temp;
    reg [2:0] bit_cnt;
    parameter clockspeed=50000000;
    parameter baudrate=9600;
    parameter baud_clock=clockspeed/(baudrate*16);
    parameter mid_tick=baud_clock/2;
    reg [12:0] baud_count;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
            bit_cnt <= 3'b0;
            temp <= 8'b0;
            dout <= 8'b0;
            done <= 1'b0;
            baud_count<=13'b0;
        end else begin
          if(baud_count==mid_tick) begin
            state <= next;
            if (state == IDLE) begin
                done <= 1'b0;
                if (d == 0)
                    bit_cnt <= 3'b0;
            end else if (state == DATA) begin
               temp<={d,temp[7:1]};
               bit_cnt <= bit_cnt + 1;
            end 
            else begin
                if (d == 1) begin
                    dout <= temp;
                    done <= 1'b1;
                end
            end
          else begin
            baud_count<=baud_count+1;
          end
        end
    end

    always @(state or d or bit_cnt) begin
        next = state;
        case (state)
            IDLE: if (d == 0) next = DATA;
            DATA: if (bit_cnt == 3'b111) next = STOP;
            STOP: if (d == 1) next = IDLE;
        endcase
    end

endmodule

