module enc_8_3_priority(
    output reg [2:0] a,
    output reg valid,
    input [7:0] d
);
    always @(*) begin
        valid = 1'b1;
        if (d[7])       a = 3'b111;
        else if (d[6])  a = 3'b110;
        else if (d[5])  a = 3'b101;
        else if (d[4])  a = 3'b100;
        else if (d[3])  a = 3'b011;
        else if (d[2])  a = 3'b010;
        else if (d[1])  a = 3'b001;
        else if (d[0])  a = 3'b000;
        else begin
            a = 3'b000;   
            valid = 1'b0;
        end
    end
endmodule
