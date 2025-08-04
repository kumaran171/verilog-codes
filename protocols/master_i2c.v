module i2c_master (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [6:0] slave_addr,
    input wire [7:0] data_in,
    input wire rw, // 0: write, 1: read
    output reg [7:0] data_out,
    output reg done,

    inout wire sda,
    inout wire scl
);

    // State encoding using 3-bit parameters
    parameter [2:0] IDLE     = 3'd0,
                    START    = 3'd1,
                    ADDR     = 3'd2,
                    RW_PHASE = 3'd3,
                    DATA     = 3'd4,
                    ACK      = 3'd5,
                    STOP     = 3'd6;

    reg [2:0] state;
    reg [3:0] count;
    reg [7:0] tx_reg;
    reg sda_out, sda_en;
    reg scl_out;

    assign sda = sda_en ? sda_out : 1'bz;
    assign scl = scl_out;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            sda_en <= 0;
            scl_out <= 1;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (start) begin
                        state <= START;
                    end
                end

                START: begin
                    sda_en <= 1;
                    sda_out <= 0; // Start condition
                    scl_out <= 1;
                    state <= ADDR;
                    tx_reg <= {slave_addr, rw};
                    count <= 7;
                end

                ADDR: begin
                    scl_out <= 0;
                    sda_out <= tx_reg[count];
                    scl_out <= 1;
                    if (count == 0)
                        state <= RW_PHASE;
                    else
                        count <= count - 1;
                end

                RW_PHASE: begin
                    scl_out <= 0;
                    sda_en <= 0; // Release SDA for ACK
                    scl_out <= 1;
                    state <= DATA;
                    tx_reg <= data_in;
                    count <= 7;
                end

                DATA: begin
                    scl_out <= 0;
                    sda_en <= 1;
                    sda_out <= tx_reg[count];
                    scl_out <= 1;
                    if (count == 0)
                        state <= ACK;
                    else
                        count <= count - 1;
                end

                ACK: begin
                    scl_out <= 0;
                    sda_en <= 0;
                    scl_out <= 1;
                    state <= STOP;
                end

                STOP: begin
                    sda_en <= 1;
                    sda_out <= 1;
                    scl_out <= 1;
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
