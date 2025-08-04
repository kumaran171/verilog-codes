
module tb_apb;

    reg clk;
    reg reset;
    reg transfer;
    reg write_en;
    reg [7:0] din;
    reg [7:0] addr_in;

    wire [7:0] dout;


    apb_top uut (
        .clk(clk),
        .reset(reset),
        .transfer(transfer),
        .write_en(write_en),
        .din(din),
        .addr_in(addr_in),
        .dout(dout)  
    );

   
    always #5 clk = ~clk;

    initial begin
        $display("TIME\tRESET\tWRITE_EN\tTRANSFER\tADDR\tDIN\tDOUT");
        $monitor("%0t\t%b\t%b\t\t%b\t\t%h\t%h\t%h",
                  $time, reset, write_en, transfer, addr_in, din, dout);

        // Initial
        clk = 0;
        reset = 1;
        transfer = 0;
        write_en = 0;
        addr_in = 8'h00;
        din = 8'h00;

        #10 reset = 0;

        #10;
        write_en = 1;
        addr_in = 8'hA5;
        din = 8'h3C;
        transfer = 1;

        #50 transfer = 0;
        #20;
        write_en = 0;
        addr_in = 8'hA5;
        transfer = 1;

        #50 transfer = 0;

        #50;
        $finish;
    end

endmodule
