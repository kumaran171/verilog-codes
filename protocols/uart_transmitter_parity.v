module uart_transmitter_parity(
    output reg d,
    input [7:0] din,
    input clk,
    input rst,
    input start,
    input stop
);

    parameter [1:0] IDLE = 2'b00,
                    SEND = 2'b01,
                    PARITY = 2'b10,
                    STOP = 2'b11;

    reg [1:0] state, next;
    reg [2:0] bit_cnt;
    reg [7:0] temp;

  
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            temp <= 8'b0;
            bit_cnt <= 3'b0;
            state <= IDLE;
        end
        else begin
            state <= next;
            if (state == IDLE && start == 0) begin
                temp <= din;
                bit_cnt <= 3'b0;
            end
            else if (state == SEND) begin
                temp <= temp >> 1;
                bit_cnt <= bit_cnt + 1;
            end
        end
    end

    
    always @(state or start or stop or bit_cnt or din or temp) begin
        next = state;
        d = 1'b1;  

        case(state) 
            IDLE: begin
                d = 1'b0;  
                if (start == 0)
                    next = SEND;
            end

            SEND: begin
                d = temp[0];  
                if (bit_cnt == 3'b111)
                    next = PARITY;
            end

            PARITY: begin
                d = ^din;  
                next = STOP;
            end

            STOP: begin
                d = 1'b1;  
                if (stop == 1)
                    next = IDLE;
            end
        endcase
    end

endmodule
