module i2c_slave (
    input wire clk,
    input wire rst,
    inout wire sda,
    inout wire scl,
    output reg [7:0] received_data
);

    parameter [6:0] SLAVE_ADDR = 7'b1010101;

    // State definitions using parameters
    parameter [2:0] IDLE  = 3'd0,
                    START = 3'd1,
                    ADDR  = 3'd2,
                    RW    = 3'd3,
                    DATA  = 3'd4,
                    ACK   = 3'd5,
                    STOP  = 3'd6;

    reg [2:0] state;
    reg [6:0] addr;
    reg [7:0] data_buf;
    reg [2:0] count;
    reg sda_out, sda_en;

    assign sda = sda_en ? sda_out : 1'bz;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            sda_en <= 0;
            received_data <= 0;
        end else begin
            case (state)
                IDLE: begin
                    sda_en <= 0;
                    if (sda == 0 && scl == 1)
                        state <= START;
                end

                START: begin
                    count <= 3'd6;
                    state <= ADDR;
                end

                ADDR: begin
                    addr[count] <= sda;
                    if (count == 0)
                        state <= RW;
                    else
                        count <= count - 1;
                end

                RW: begin
                    if (addr == SLAVE_ADDR) begin
                        state <= DATA;
                        count <= 3'd7;
                    end else begin
                        state <= IDLE;
                    end
                end

                DATA: begin
                    data_buf[count] <= sda;
                    if (count == 0) begin
                        received_data <= data_buf;
                        state <= ACK;
                    end else begin
                        count <= count - 1;
                    end
                end

                ACK: begin
                    sda_en <= 1;
                    sda_out <= 0;
                    state <= STOP;
                end

                STOP: begin
                    sda_en <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
