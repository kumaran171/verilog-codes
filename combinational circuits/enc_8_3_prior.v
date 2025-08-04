module tb_enc_8_3_priority; 
  reg [7:0] d;
  wire [2:0] a;
  wire valid;


  enc_8_3_priority uut (.d(d), .a(a), .valid(valid));

  initial begin
    $dumpfile("z21.vcd");
    $dumpvars(0, tb_enc_8_3_priority);
    
    $display("D0 D1 D2 D3 D4 D5 D6 D7 | A2 A1 A0 V");
    $monitor("%b  %b  %b  %b  %b  %b  %b  %b  |  %b  %b  %b  %b",
              d[0], d[1], d[2], d[3], d[4], d[5], d[6], d[7],
              a[2], a[1], a[0], valid);

    d = 8'b00000001; #10;
    d = 8'b0000001x; #10;
    d = 8'b000001xx; #10;
    d = 8'b00001xxx; #10;
    d = 8'b0001xxxx; #10;
    d = 8'b001xxxxx; #10;
    d = 8'b01xxxxxx; #10;
    d = 8'b1xxxxxxx; #10;
    d = 8'b00000000; #10;
    
    $finish;
  end
endmodule
