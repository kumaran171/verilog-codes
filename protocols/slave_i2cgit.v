module i2c_slave_controller (
    inout wire sda,
    inout wire scl
);

    parameter ADDRESS = 7'b1010101;

    localparam READ_ADDR = 0, SEND_ACK = 1, READ_DATA = 2, WRITE_DATA = 3, SEND_ACK2 = 4;

    reg [7:0] addr;
    reg [2:0] counter = 7;
    reg [2:0] state = READ_ADDR;
    reg [7:0] data_in;
    reg [7:0] data_out = 8'b11001100;
    reg sda_out = 1;
    reg write_enable = 0;
    reg start = 0;

    assign sda = write_enable ? sda_out : 1'bz;

    always @(negedge sda) begin
        if (scl == 1) begin
            start <= 1;
            counter <= 7;
            state <= READ_ADDR;
        end
    end

    always @(posedge sda) begin
        if (scl == 1) begin
            start <= 0;
            write_enable <= 0;
        end
    end

    always @(posedge scl) begin
        if (start) begin
            case (state)
                READ_ADDR: begin
                    addr[counter] <= sda;
                    if (counter == 0)
                        state <= SEND_ACK;
                    else
                        counter <= counter - 1;
                end

                READ_DATA: begin
                    data_in[counter] <= sda;
                    if (counter == 0)
                        state <= SEND_ACK2;
                    else
                        counter <= counter - 1;
                end

                WRITE_DATA: begin
                    if (counter == 0)
                        state <= READ_ADDR;
                    else
                        counter <= counter - 1;
                end
            endcase
        end
    end

    always @(negedge scl) begin
        case (state)
            SEND_ACK: begin
                if (addr[7:1] == ADDRESS) begin
                    sda_out <= 0;
                    write_enable <= 1;
                    counter <= 7;
                    state <= (addr[0] == 0) ? READ_DATA : WRITE_DATA;
                    $display("SLAVE: Address matched, sending ACK");
                end else begin
                    $display("SLAVE: Address mismatch");
                    state <= READ_ADDR;
                end
            end

            SEND_ACK2: begin
                sda_out <= 0;
                write_enable <= 1;
                state <= READ_ADDR;
                $display("SLAVE: Data received: %b", data_in);
            end

            WRITE_DATA: begin
                sda_out <= data_out[counter];
                write_enable <= 1;
            end

            default: begin
                write_enable <= 0;
                sda_out <= 1;
            end
        endcase
    end
endmodule


