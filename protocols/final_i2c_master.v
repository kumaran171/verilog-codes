module i2c_master(
    input clk,
    input rst,
    input newd,
    input [6:0] addr,
    input op, // 1 - read, 0 - write
    inout sda,
    output scl,
    input [7:0] din,
    output [7:0] dout,
    output reg busy,
    output reg ack_err,
    output reg done
);

    reg scl_t = 0;
    reg sda_t = 0;

    parameter sys_freq = 4000000;
    parameter i2c_freq = 100000;
    parameter clk_count4 = (sys_freq / i2c_freq);
    parameter clk_count1 = clk_count4 / 4;

    integer count1 = 0;
    reg [1:0] pulse = 0;
    always @(posedge clk) begin
        if (rst || busy == 0) begin
            pulse <= 0;
            count1 <= 0;
        end else if (count1 == clk_count1 - 1) begin
            pulse <= 1;
            count1 <= count1 + 1;
        end else if (count1 == clk_count1 * 2 - 1) begin
            pulse <= 2;
            count1 <= count1 + 1;
        end else if (count1 == clk_count1 * 3 - 1) begin
            pulse <= 3;
            count1 <= count1 + 1;
        end else if (count1 == clk_count1 * 4 - 1) begin
            pulse <= 0;
            count1 <= 0;
        end else begin
            count1 <= count1 + 1;
        end
    end

    reg [3:0] bitcount = 0;
    reg [7:0] data_addr = 0, data_tx = 0;
    reg r_ack = 0;
    reg [7:0] rx_data = 0;
    reg [7:0] data_out = 0;  // ✅ Registered output
    reg sda_en = 0;

    reg [3:0] state = 0;
    localparam IDLE = 0, START = 1, WRITE_ADDR = 2, ACK_1 = 3, WRITE_DATA = 4,
               READ_DATA = 5, STOP = 6, ACK_2 = 7, MASTER_ACK = 8;

    always @(posedge clk) begin
        if (rst) begin
            bitcount <= 0;
            data_addr <= 0;
            data_tx <= 0;
            scl_t <= 1;
            sda_t <= 1;
            state <= IDLE;
            busy <= 0;
            ack_err <= 0;
            done <= 0;
            rx_data <= 0;
            data_out <= 0;
        end else begin
            if (state != IDLE)
                done <= 0;

            case (state)
                IDLE: begin
                    done <= 0;
                    if (newd) begin
                        data_addr <= {addr, op};
                        data_tx <= din;
                        busy <= 1;
                        state <= START;
                        ack_err <= 0;
                    end else begin
                        busy <= 0;
                    end
                end
                START: begin
                    sda_en <= 1;
                    case (pulse)
                        0, 1: begin scl_t <= 1; sda_t <= 1; end
                        2, 3: begin scl_t <= 1; sda_t <= 0; end
                    endcase
                    if (count1 == clk_count1 * 4 - 1)
                        state <= WRITE_ADDR;
                end
                WRITE_ADDR: begin
                    sda_en <= 1;
                    if (bitcount <= 7) begin
                        case (pulse)
                            0, 1: sda_t <= data_addr[7 - bitcount];
                            2, 3: scl_t <= 1;
                        endcase
                        if (count1 == clk_count1 * 4 - 1) begin
                            bitcount <= bitcount + 1;
                            scl_t <= 0;
                        end
                    end else begin
                        state <= ACK_1;
                        bitcount <= 0;
                        sda_en <= 0;
                    end
                end
                ACK_1: begin
                    sda_en <= 0;
                    if (pulse == 2) r_ack <= sda;
                    if (count1 == clk_count1 * 4 - 1) begin
                        if (r_ack == 0 && data_addr[0] == 0)
                            state <= WRITE_DATA;
                        else if (r_ack == 0)
                            state <= READ_DATA;
                        else begin
                            state <= STOP;
                            ack_err <= 1;
                            sda_en <= 1;
                        end
                    end
                end
                WRITE_DATA: begin
                    if (bitcount <= 7) begin
                        if (pulse == 1)
                            sda_t <= data_tx[7 - bitcount];
                        if (pulse == 2 || pulse == 3)
                            scl_t <= 1;
                        if (count1 == clk_count1 * 4 - 1) begin
                            bitcount <= bitcount + 1;
                            scl_t <= 0;
                        end
                    end else begin
                        state <= ACK_2;
                        bitcount <= 0;
                        sda_en <= 0;
                    end
                end
                READ_DATA: begin
                    sda_en <= 0;
                    if (bitcount <= 7) begin
                        if (pulse == 2)
                            rx_data <= {rx_data[6:0], sda};
                        if (pulse == 3)
                            scl_t <= 1;
                        if (count1 == clk_count1 * 4 - 1) begin
                            bitcount <= bitcount + 1;
                            scl_t <= 0;
                        end
                    end else begin
                        state <= MASTER_ACK;
                        bitcount <= 0;
                        sda_en <= 1;
                    end
                end
                MASTER_ACK: begin
                    sda_en <= 1;
                    if (pulse == 0 || pulse == 1) sda_t <= 1;
                    if (pulse == 2 || pulse == 3) scl_t <= 1;
                    if (count1 == clk_count1 * 4 - 1) begin
                        state <= STOP;
                        sda_en <= 1;
                    end
                end
                ACK_2: begin
                    sda_en <= 0;
                    if (pulse == 2) r_ack <= sda;
                    if (count1 == clk_count1 * 4 - 1) begin
                        state <= STOP;
                        ack_err <= ~r_ack;
                        sda_en <= 1;
                    end
                end
                STOP: begin
                    sda_en <= 1;
                    if (pulse == 2 || pulse == 3) sda_t <= 1;
                    if (count1 == clk_count1 * 4 - 1) begin
                        state <= IDLE;
                        busy <= 0;
                        done <= 1;
                        data_out <= rx_data;  // ✅ latch data AFTER read completes
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end

    assign sda = (sda_en) ? (sda_t ? 1'b1 : 1'b0) : 1'bz;
    assign scl = scl_t;
    assign dout = data_out;  // ✅ stable, latched output

endmodule

