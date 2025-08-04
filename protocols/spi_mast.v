module spi_M (
    input clk,
    input rst,
    input [7:0] din,
    input miso,
    output reg mosi,
    output reg [7:0] dout,
    output reg done
);
    parameter IDLE = 2'b00, TRANSFER = 2'b01, DONE = 2'b10;

    reg [1:0] state, next;
    reg [2:0] bit_cnt;
    reg [7:0] shift_out, shift_in;

    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
            bit_cnt <= 0;
            shift_out <= 0;
            shift_in <= 0;
            mosi <= 0;
            dout <= 0;
            done <= 0;
        end else begin
            state <= next;
            if (state == IDLE) begin
                shift_out <= din;
                shift_in <= 0;
                bit_cnt <= 0;
                done <= 0;
            end else if (state == TRANSFER) begin
                shift_out <= shift_out >> 1;              
                shift_in <= {miso, shift_in[7:1]};        
                bit_cnt <= bit_cnt + 1;
            end else begin 
                dout <= shift_in;
                done <= 1;
            end
        end
    end

    always @(state or bit_cnt or miso) begin
        next = state;
        case (state)
            IDLE: begin
                next = TRANSFER;
            end
            TRANSFER: begin
                mosi = shift_out[0];  
                if (bit_cnt == 3'd7)
                    next = DONE;
            end
            DONE: begin
                next = IDLE;
            end
        endcase
    end
endmodule
