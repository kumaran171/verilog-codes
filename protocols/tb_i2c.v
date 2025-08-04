module tb_i2c;

  reg clk, rst, chk, start, stop;
  reg [7:0] din;
  wire done, ack;
  wire [7:0] dout;

  i2c_top dut (
    .clk(clk), .rst(rst), .chk(chk),
    .din(din), .done(done), .ack(ack), .dout(dout),
    .start(start), .stop(stop)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("i2c_dump.vcd");
    $dumpvars(0, tb_i2c);

    $display("Time\tclk\trst\tstart\tstop\tchk\tdin\t\tdout\tdone\tack");
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%08b\t%08b\t%b\t%b",
              $time, clk, rst, start, stop, chk, din, dout, done, ack);

    rst = 1; start = 0; stop = 0; chk = 0; din = 8'h00;
    #20 rst = 0;

    // Start Write Sequence
    #10 start = 1;
    #10 start = 0;
    #10;chk=1;
    // Wait for 8 address bits to complete
    repeat (8) begin
      #10;
    end

    // Send Data after address
    din = 8'b11001100;
    repeat (8) begin
      #10;
    end

    #10 stop = 1;
    #10 stop = 0;
    #50;

    // Start Read Sequence
    #10 start = 1;
    #10 start = 0;
    // Wait for 8 address bits to complete
    #10;chk=0;
    repeat (8) begin
      #10;
    end

    repeat (8) begin
      #10 ;
    end

    #10 stop = 1;
    #10 stop = 0;

    #50;
    $display("Final received data = %08b", dout);
    $finish;
  end
endmodule
