module tb_8_1_mux;
  reg [7:0] d;
  reg [2:0] s;
  wire Y;

  mux_8_1_d uut(.d(d), .s(s), .Y(Y));

  initial begin
    $dumpfile("z20.vcd");
    $dumpvars(0, tb_8_1_mux);
    $display("I7 I6 I5 I4 I3 I2 I1 I0 S2 S1 S0 | Y");
    $monitor("%b  %b  %b  %b  %b  %b  %b  %b   %b  %b  %b | %b", 
              d[7], d[6], d[5], d[4], d[3], d[2], d[1], d[0],
              s[2], s[1], s[0], Y);

    d = 8'b00000000; s = 3'b000; #10;
    d = 8'b00000001; s = 3'b000; #10;
    d = 8'b00000000; s = 3'b001; #10;
    d = 8'b00000010; s = 3'b001; #10;
    d = 8'b00000000; s = 3'b010; #10;
    d = 8'b00000100; s = 3'b010; #10;
    d = 8'b00000000; s = 3'b011; #10;
    d = 8'b00001000; s = 3'b011; #10;
    d = 8'b00000000; s = 3'b100; #10;
    d = 8'b00010000; s = 3'b100; #10;
    d = 8'b00000000; s = 3'b101; #10;
    d = 8'b00100000; s = 3'b101; #10;
    d = 8'b00000000; s = 3'b110; #10;
    d = 8'b01000000; s = 3'b110; #10;
    d = 8'b00000000; s = 3'b111; #10;
    d = 8'b10000000; s = 3'b111; #10;

    $finish;
  end
endmodule
