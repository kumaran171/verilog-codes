module uart_transmitter_fsm(
    input clk,
    input rst,
    input start,            // 1 when you want to start sending din
    input [7:0] din,        // data byte to send
    output reg tx,          // UART serial output
    output reg ready        // 1 when transmitter is idle
);

    parameter [1:0] IDLE=2'b00, TX=2'b01, STOP=2'b10;
    parameter clockspeed=50000000, baudrate=9600;
    parameter baud_clock=clockspeed/(baudrate*16);
    parameter mid_tick=baud_clock/2;

    reg [1:0] state, next;
    reg [2:0] bit_cnt;
    reg [12:0] baud_count;
    reg [7:0] temp;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            baud_count <= 0;
            bit_cnt <= 0;
            temp <= 0;
            tx <= 1'b1; // idle level
        end else begin
            if (baud_count >= baud_clock-1) begin
                baud_count <= 0;
                state <= next;
                case (state)
                    IDLE: begin
                        if (start) begin
                            temp <= din;
                            bit_cnt <= 0;
                        end
                    end
                    TX: begin
                        tx <= temp[0];
                        temp <= {1'b0, temp[7:1]};
                        bit_cnt <= bit_cnt + 1;
                    end
                    STOP: begin
                        tx <= 1'b1; // stop bit
                    end
                endcase
            end else begin
                baud_count <= baud_count + 1;
            end
        end
    end

    always @(*) begin
        next = state;
        ready = 0;
        case (state)
            IDLE: begin
                tx = 1'b1;
                ready = 1;
                if (start) next = TX;
            end
            TX: begin
                if (bit_cnt == 7) next = STOP;
            end
            STOP: begin
                next = IDLE;
            end
        endcase
    end
endmodule
