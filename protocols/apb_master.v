module apb_master (
    input clk,
    input reset,
    input transfer,
    input write_en,                
    input pready,
    input [7:0] prdata,            

    input [7:0] din,              
    input [7:0] addr_in,           

    output reg psel,
    output reg penable,
    output reg pwrite,
    output reg [7:0] pwdata,       
    output reg [7:0] paddr,        
    output reg [7:0] dout          
);

    
    parameter IDLE = 2'b00, SETUP = 2'b01, ACCESS = 2'b10;
    reg [1:0] state, next_state;


    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end


    always @(*) begin
        next_state = state;
        psel = 0;
        penable = 0;
        pwrite = write_en;
        paddr = addr_in;
        pwdata = din;

        case (state)
            IDLE: begin
                if (transfer)
                    next_state = SETUP;
            end
            SETUP: begin
                psel = 1;
                next_state = ACCESS;
            end
            ACCESS: begin
                psel = 1;
                penable = 1;
                if (pready)
                    next_state = transfer ? SETUP : IDLE;
            end
        endcase
    end


    always @(posedge clk or posedge reset) begin
        if (reset) begin
            dout <= 8'h00;
        end else if (state == ACCESS && penable && pready && write_en == 0) begin
            dout <= prdata;
        end
    end

endmodule

