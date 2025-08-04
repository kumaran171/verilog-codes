module i2c_top_tb;

    reg clk;
    reg rst;
    reg newd;
    reg op;
    reg [6:0] addr;
    reg [7:0] din;

    wire [7:0] dout;
    wire busy;
    wire ack_err;
    wire done;

    // Instantiate the DUT
    i2c_top dut (
        .clk(clk),
        .rst(rst),
        .newd(newd),
        .op(op),
        .addr(addr),
        .din(din),
        .dout(dout),
        .busy(busy),
        .ack_err(ack_err),
        .done(done)
    );

    // 100 MHz clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        newd = 0;
        op = 0;
        addr = 7'd0;
        din = 8'd0;

        $display("Time\tclk\trst\tnewd\top\taddr\tdin\tdout\tbusy\tack_err\tdone");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%0d\t%0d\t%0d\t%b\t%b\t%b",
                  $time, clk, rst, newd, op, addr, din, dout, busy, ack_err, done);

        // Reset
        #20;
        rst = 0;

        // ----------------------
        // Write to address 2 (data 55)
        #20;
        addr = 7'd2;
        din = 8'd55;
        op = 0;        // write
        newd = 1;
        #10;
        newd = 0;
        wait_for_busy_and_done();

        // ----------------------
        // Write to address 3 (data 99)
        #20;
        addr = 7'd3;
        din = 8'd99;
        op = 0;
        newd = 1;
        #10;
        newd = 0;
        wait_for_busy_and_done();

        // ----------------------
        // Read from address 2
        #20;
        addr = 7'd2;
        op = 1;        // read
        newd = 1;
        #10;
        newd = 0;
        wait_for_busy_and_done();
        $display("READ: Address 2 = %0d", dout);

        // ----------------------
        // Read from address 3
        #20;
        addr = 7'd3;
        op = 1;
        newd = 1;
        #10;
        newd = 0;
        wait_for_busy_and_done();
        $display("READ: Address 3 = %0d", dout);

        $display("✅ Finished all transactions.");
        #20;
        $finish;
    end

    task wait_for_busy_and_done;
        integer timeout;
        begin
            timeout = 0;

            // Wait until busy goes high
            while (!busy && timeout < 1000) begin
                @(posedge clk);
                timeout = timeout + 1;
            end

            // Then wait for done
            timeout = 0;
            while (!done && timeout < 1000) begin
                @(posedge clk);
                timeout = timeout + 1;
            end

            if (timeout >= 1000)
                $display("⚠️ TIMEOUT: 'done' not asserted by time %0t", $time);
            else
                $display("✅ DONE at time %0t", $time);
        end
    endtask

endmodule
