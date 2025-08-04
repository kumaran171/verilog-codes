module i2c_controller (
    input wire clk,
    input wire rst,
    input wire [6:0] addr,
    input wire [7:0] data_in,
    input wire enable,
    input wire rw,

    output reg [7:0] data_out,
    output wire ready,

    inout wire i2c_sda,
    inout wire i2c_scl
);

    localparam IDLE = 0, START = 1, ADDRESS = 2, READ_ACK = 3, WRITE_DATA = 4,
               READ_ACK2 = 5, READ_DATA = 6, WRITE_ACK = 7, STOP = 8;

    localparam DIVIDE_BY = 4;

    reg [3:0] state = IDLE;
    reg [7:0] saved_addr;
    reg [7:0] saved_data;
    reg [2:0] counter;
    reg [2:0] clk_div = 0;
    reg i2c_clk = 1;
    reg i2c_scl_en = 0;
    reg write_enable = 0;
    reg sda_out = 1;

    assign ready = (state == IDLE);
    assign i2c_scl = i2c_scl_en ? i2c_clk : 1'b1;
    assign i2c_sda = write_enable ? sda_out : 1'bz;

    // Clock divider
    always @(posedge clk) begin
        if (clk_div == (DIVIDE_BY/2 - 1)) begin
            clk_div <= 0;
            i2c_clk <= ~i2c_clk;
        end else begin
            clk_div <= clk_div + 1;
        end
    end

    // FSM
    always @(posedge i2c_clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            write_enable <= 1;
            sda_out <= 1;
        end else begin
            case (state)
                IDLE: begin
                    if (enable) begin
                        saved_addr <= {addr, rw};
                        saved_data <= data_in;
                        counter <= 7;
                        state <= START;
                        $display("MASTER: Starting transaction");
                    end
                end

                START: begin
                    sda_out <= 0;
                    write_enable <= 1;
                    state <= ADDRESS;
                end

                ADDRESS: begin
                    sda_out <= saved_addr[counter];
                    if (counter == 0) begin
                        state <= READ_ACK;
                        write_enable <= 0;
                    end else begin
                        counter <= counter - 1;
                    end
                end

                READ_ACK: begin
                    $display("MASTER: Checking ACK, SDA = %b", i2c_sda);
                    if (i2c_sda == 0) begin
                        counter <= 7;
                        if (saved_addr[0] == 0) begin
                            state <= WRITE_DATA;
                            write_enable <= 1;
                        end else begin
                            state <= READ_DATA;
                            write_enable <= 0;
                        end
                    end else begin
                        $display("MASTER: No ACK received.");
                        state <= STOP;
                    end
                end

                WRITE_DATA: begin
                    sda_out <= saved_data[counter];
                    if (counter == 0) begin
                        state <= READ_ACK2;
                        write_enable <= 0;
                    end else begin
                        counter <= counter - 1;
                    end
                end

                READ_ACK2: begin
                    state <= STOP;
                end

                READ_DATA: begin
                    data_out[counter] <= i2c_sda;
                    if (counter == 0) begin
                        state <= WRITE_ACK;
                        write_enable <= 1;
                        sda_out <= 0;
                    end else begin
                        counter <= counter - 1;
                    end
                end

                WRITE_ACK: begin
                    state <= STOP;
                end

                STOP: begin
                    sda_out <= 1;
                    write_enable <= 1;
                    state <= IDLE;
                    $display("MASTER: Transaction Complete, Data Out = %b", data_out);
                end
            endcase
        end
    end
endmodule
