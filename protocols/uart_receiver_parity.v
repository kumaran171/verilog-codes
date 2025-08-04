module uart_receiver_parity(
    output reg done,
    output reg [7:0] dout,
    input d,
    input clk,
    input rst
);

    parameter [1:0] IDLE=2'b00,
                    DATA=2'b01,
                    PARITY=2'b10,
                    STOP=2'b11;

    reg [1:0] next, state;
    reg [7:0] temp;
    reg [2:0] bit_cnt;
    reg par;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
            bit_cnt <= 3'b0;
            temp <= 8'b0;
            done <= 1'b0;
            dout <= 8'b0;
        end
        else begin
            state <= next;

            if (state == IDLE) begin
                done <= 1'b0;
                if (d == 0) begin
                    bit_cnt <= 3'b0;
                end
            end
            else if (state == DATA) begin
               temp <= {d, temp[7:1]};
               bit_cnt <= bit_cnt + 1;

            end
            else if (state == PARITY) begin
                if (d == (^temp)) begin
                    dout <= temp;
                end
                else begin
                    $display("Parity error: data was not transmitted properly");
                end
            end
            else if (state == STOP) begin
                if (d == 1) begin
                    done <= 1;
                end
            end
        end
    end


    always @(state or d or bit_cnt) begin
        next = state;
        case (state)
            IDLE: begin
                if (d == 0)
                    next = DATA;
            end
            DATA: begin
                if (bit_cnt == 3'b111)
                    next = PARITY;
            end
            PARITY: begin
                next = STOP;
            end
            STOP: begin
                if (d == 1)
                    next = IDLE;
            end
        endcase
    end

endmodule
