module sccb_master(
    input clk, rst, newd,
    input [7:0] reg_addr,
    input [7:0] data,
    output reg busy, done,
    inout sda,
    output scl
);

    wire clk_24mhz;
    xclk_clock xgen(
        .clk(clk),
        .rst(rst),
        .clk_24mhz(clk_24mhz)
    );

    reg scl_t = 1;
    reg sda_t = 1;

    parameter sccb_freq = 100000;
    parameter clk_count4 = (24000000/sccb_freq);
    parameter clk_count1 = clk_count4/4;

    integer count1 = 0;
    reg [1:0] pulse = 0;

    always @(posedge clk_24mhz) begin
     if (rst || busy == 0) begin
        count1 <= 0;
        pulse <= 0;
     end 
     else begin
        if (count1 == clk_count1 - 1) begin
            pulse <= 1;
        end else if (count1 == clk_count1*2 - 1) begin
            pulse <= 2;
        end else if (count1 == clk_count1*3 - 1) begin
            pulse <= 3;
        end else if (count1 == clk_count1*4 - 1) begin
            count1 <= 0;
            pulse <= 0;
        end
        else begin
            count1 <= count1 + 1;
        end
     end
    end

    reg [2:0] bitcount = 0;
    reg [7:0] byte1 = 8'h42; // OV7670 slave addr + write bit
    reg [7:0] byte2;
    reg [7:0] byte3;
    reg sda_en = 0;
    reg ack_bit;

    parameter idle       = 3'b000,
              start      = 3'b001,
              send_byte1 = 3'b010,
              ack1       = 3'b011,
              send_byte2 = 3'b100,
              ack2       = 3'b101,
              send_byte3 = 3'b110,
              ack3       = 3'b111,
              stop       = 3'b1000; // unique stop state

    reg [3:0] state = idle;

    always @(posedge clk_24mhz) begin
        if (rst) begin
            bitcount <= 0;
            scl_t <= 1;
            sda_t <= 1;
            state <= idle;
            busy <= 0;
            done <= 0;
        end else begin
            case (state)
                idle: begin
                    done <= 0;
                    if (newd) begin
                        byte2 <= reg_addr;
                        byte3 <= data;
                        busy <= 1;
                        state <= start;
                    end
                end
                start: begin
                    sda_en <= 1;
                    case (pulse)
                        0,1: begin scl_t <= 1; sda_t <= 1; end
                        2,3: begin scl_t <= 1; sda_t <= 0; end
                    endcase
                    if (count1 == clk_count1*4 - 1) begin
                        scl_t <= 0;
                        bitcount <= 0;
                        state <= send_byte1;
                    end
                end
                send_byte1: begin
                    sda_en <= 1;
                    if (bitcount <= 7) begin
                        case (pulse)
                            0: scl_t <= 0;
                            1: sda_t <= byte1[7 - bitcount];
                            2,3: scl_t <= 1;
                        endcase
                        if (count1 == clk_count1*4 - 1)
                            bitcount <= bitcount + 1;
                    end else begin
                        bitcount <= 0;
                        sda_en <= 0;
                        state <= ack1;
                    end
                end
                ack1: begin
                    sda_en <= 0;
                    if (pulse == 2) ack_bit <= sda;
                    if (count1 == clk_count1*4 - 1) state <= send_byte2;
                end
                send_byte2: begin
                    sda_en <= 1;
                    if (bitcount <= 7) begin
                        case (pulse)
                            0: scl_t <= 0;
                            1: sda_t <= byte2[7 - bitcount];
                            2,3: scl_t <= 1;
                        endcase
                        if (count1 == clk_count1*4 - 1)
                            bitcount <= bitcount + 1;
                    end else begin
                        bitcount <= 0;
                        sda_en <= 0;
                        state <= ack2;
                    end
                end
                ack2: begin
                    sda_en <= 0;
                    if (pulse == 2) ack_bit <= sda;
                    if (count1 == clk_count1*4 - 1) state <= send_byte3;
                end
                send_byte3: begin
                    sda_en <= 1;
                    if (bitcount <= 7) begin
                        case (pulse)
                            0: scl_t <= 0;
                            1: sda_t <= byte3[7 - bitcount];
                            2,3: scl_t <= 1;
                        endcase
                        if (count1 == clk_count1*4 - 1)
                            bitcount <= bitcount + 1;
                    end else begin
                        bitcount <= 0;
                        sda_en <= 0;
                        state <= ack3;
                    end
                end
                ack3: begin
                    sda_en <= 0;
                    if (pulse == 2) ack_bit <= sda;
                    if (count1 == clk_count1*4 - 1) state <= stop;
                end
                stop: begin
                    sda_en <= 1;
                    case (pulse)
                        0,1: begin scl_t <= 1; sda_t <= 0; end
                        2,3: begin scl_t <= 1; sda_t <= 1; end
                    endcase
                    if (count1 == clk_count1*4 - 1) begin
                        busy <= 0;
                        done <= 1;
                        state <= idle;
                    end
                end
                default: state <= idle;
            endcase
        end
    end

    assign sda = (sda_en) ? ((sda_t == 0) ? 1'b0 : 1'b1) : 1'bz;
    assign scl = scl_t;

endmodule
