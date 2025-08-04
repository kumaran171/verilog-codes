module i2c_Slave (
    input scl,
    input clk,
    input rst,
    inout sda,
    output reg ack_err,
    output reg done
);

    // Memory and registers
    reg [7:0] mem [0:127];
    reg [7:0] r_addr;
    reg [6:0] addr;
    reg [7:0] dout, din;
    reg r_mem, w_mem;

    // Tri-state I/O control
    reg sda_t;
    reg sda_en;

    // Bit counters and FSM
    reg [3:0] bitcnt = 0;
    reg busy = 0;

    reg [3:0] state;
    localparam IDLE = 0, READ_ADDR = 1, SEND_ACK1 = 2, SEND_DATA = 3,
               MASTER_ACK = 4, READ_DATA = 5, SEND_ACK2 = 6,
               WAIT_P = 7, DETECT_STOP = 8;

    // Initialize memory and handle read/write
    integer i;
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 128; i = i + 1)
                mem[i] <= i;
            dout <= 0;
        end else begin
            if (r_mem)
                dout <= mem[addr];
            if (w_mem)
                mem[addr] <= din;
        end
    end

    // Clock phase logic
    parameter sys_freq = 4000000;
    parameter i2c_freq = 100000;
    parameter clk_count4 = (sys_freq / i2c_freq);
    parameter clk_count1 = clk_count4 / 4;

    reg [15:0] count1 = 0;
    reg [1:0] pulse = 0;

    always @(posedge clk) begin
        if (rst || !busy) begin
            pulse <= 2;
            count1 <= clk_count1 * 2;
        end else if (count1 == clk_count1 - 1) begin
            pulse <= 1;
            count1 <= 0;
        end else if (count1 == clk_count1 * 2 - 1) begin
            pulse <= 2;
            count1 <= 0;
        end else if (count1 == clk_count1 * 3 - 1) begin
            pulse <= 3;
            count1 <= 0;
        end else if (count1 == clk_count1 * 4 - 1) begin
            pulse <= 0;
            count1 <= 0;
        end else begin
            count1 <= count1 + 1;
        end
    end

    // Start condition detection (falling edge on SDA while SCL is high)
    reg sda_prev = 1;
    always @(posedge clk) begin
        sda_prev <= sda;
    end
    wire start_condition = (sda_prev == 1 && sda == 0 && scl);

    reg r_ack;

    // Main FSM
    always @(posedge clk) begin
        if (rst) begin
            bitcnt <= 0;
            state <= IDLE;
            r_addr <= 0;
            sda_en <= 0;
            sda_t <= 0;
            addr <= 0;
            r_mem <= 0;
            w_mem <= 0;
            din <= 0;
            ack_err <= 0;
            done <= 0;
            busy <= 0;
        end else begin
            // Default deassertions
            r_mem <= 0;
            w_mem <= 0;
            done <= 0;

            case (state)
                IDLE: begin
                    if (start_condition) begin
                        busy <= 1;
                        state <= READ_ADDR;
                        bitcnt <= 0;
                    end
                end

                READ_ADDR: begin
                    sda_en <= 0;
                    if (bitcnt < 8) begin
                        if (pulse == 2)
                            r_addr <= {r_addr[6:0], sda};
                        if (pulse == 3)
                            bitcnt <= bitcnt + 1;
                    end else begin
                        addr <= r_addr[7:1];
                        state <= SEND_ACK1;
                        sda_en <= 1;
                        sda_t <= 0;
                        bitcnt <= 0;
                    end
                end

                SEND_ACK1: begin
                    if (pulse == 3) begin
                        if (r_addr[0]) begin
                            r_mem <= 1;
                            state <= SEND_DATA;
                        end else begin
                            state <= READ_DATA;
                        end
                        sda_en <= 0;
                    end
                end

                READ_DATA: begin
                    sda_en <= 0;
                    if (bitcnt < 8) begin
                        if (pulse == 2)
                            din <= {din[6:0], sda};
                        if (pulse == 3)
                            bitcnt <= bitcnt + 1;
                    end else begin
                        w_mem <= 1;
                        state <= SEND_ACK2;
                        bitcnt <= 0;
                        sda_en <= 1;
                        sda_t <= 0;
                    end
                end

                SEND_ACK2: begin
                    if (pulse == 3) begin
                        sda_en <= 0;
                        state <= DETECT_STOP;
                    end
                end

                SEND_DATA: begin
                    sda_en <= 1;
                    if (bitcnt < 8) begin
                        if (pulse == 1)
                            sda_t <= dout[7 - bitcnt];
                        if (pulse == 3)
                            bitcnt <= bitcnt + 1;
                    end else begin
                        bitcnt <= 0;
                        sda_en <= 0;
                        state <= MASTER_ACK;
                    end
                end

                MASTER_ACK: begin
                    if (pulse == 2)
                        r_ack <= sda;
                    if (pulse == 3) begin
                        ack_err <= (r_ack == 0) ? 1 : 0;
                        state <= DETECT_STOP;
                    end
                end

                DETECT_STOP: begin
                    if (start_condition == 0 && sda == 1 && scl == 1) begin
                        busy <= 0;
                        done <= 1;
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

    // Open-drain SDA output
    assign sda = (sda_en && sda_t == 0) ? 1'b0 : 1'bz;

endmodule
