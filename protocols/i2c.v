module i2c_top (
  output wire done,
  output wire [7:0] dout,
  output wire ack,
  input [7:0] din,
  input clk,
  input rst,
  input chk,
  input start,
  input stop
);

  wire sda;

  master_i2c master_inst (
    .sda(sda),
    .done(done),
    .ack(ack),
    .dout(dout),
    .din(din),
    .clk(clk),
    .rst(rst),
    .chk(chk),
    .start(start),
    .stop(stop)
  );

  slave_i2c slave_inst (
    .sda(sda),
    .dout(),
    .ack(),
    .done(),
    .clk(clk),
    .rst(rst),
    .chk(chk),
    .start(start),
    .stop(stop)
  );
endmodule
