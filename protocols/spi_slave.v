module spi_slave (
    input clk,
    input rst,
    input [7:0] din,
    input mosi,
    output reg done,
    output reg [7:0] dout,
    output reg miso
);
    parameter IDLE = 2'b00, TRANSFER = 2'b01, DONE = 2'b10;

    reg [1:0] state;
    reg [2:0] bit_cnt;
    reg [7:0] shift_out, shift_in;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= IDLE;
            bit_cnt <= 0;
            shift_out <= 0;
            shift_in <= 0;
            miso <= 0;
            dout <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    shift_out <= din;
                    shift_in <= 0;
                    bit_cnt <= 0;
                    done <= 0;
                    state <= TRANSFER;
                end

                TRANSFER: begin
                    shift_in <= {mosi, shift_in[7:1]};      // Receive LSB first
                    shift_out <= shift_out >> 1;
                    miso <= shift_out[1];                   // Prepare next LSB
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 3'd7)
                        state <= DONE;
                end

                DONE: begin
                    dout <= shift_in;
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
