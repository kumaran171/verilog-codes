module apb_top (
    input clk,
    input reset,
    input transfer,
    input write_en,
    input [7:0] din,
    input [7:0] addr_in,
    output [7:0] dout        
);

  
    wire psel, penable, pwrite, pready;
    wire [7:0] pwdata, paddr, prdata;


    apb_master master_inst (
        .clk(clk),
        .reset(reset),
        .transfer(transfer),
        .write_en(write_en),
        .pready(pready),
        .prdata(prdata),
        .din(din),
        .addr_in(addr_in),
        .psel(psel),
        .penable(penable),
        .pwrite(pwrite),
        .pwdata(pwdata),
        .paddr(paddr),
        .dout(dout)              
    );

 
    apb_slave slave_inst (
        .clk(clk),
        .reset(reset),
        .psel(psel),
        .penable(penable),
        .pwrite(pwrite),
        .paddr(paddr),
        .pwdata(pwdata),
        .prdata(prdata),
        .pready(pready)
    );

endmodule
