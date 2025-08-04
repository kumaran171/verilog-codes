module apb_slave (
    input clk,
    input reset,
    input psel,
    input penable,
    input pwrite,
    input [7:0] paddr,
    input [7:0] pwdata,
    output reg [7:0] prdata,
    output wire pready
);

    reg [7:0] mem [0:255];
    assign pready = 1'b1;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            prdata <= 8'h00;
            mem[8'hA5] <= 8'h5A;  
        end else if (psel && penable) begin
            if (pwrite)
                mem[paddr] <= pwdata;
            else
                prdata <= mem[paddr];
        end
    end

endmodule
