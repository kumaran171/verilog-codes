module tb_prior_4_2;
  reg [3:0] d;
  wire [1:0] a;
  wire valid;

 
  priority_4_2_enc uut (.d(d), .a(a), .valid(valid));

  initial begin 
    $dumpfile("priority.vcd");
    $dumpvars(0, tb_prior_4_2);
    
    $display("D3 D2 D1 D0 | A1 A0 Valid");
    $monitor("%b  %b  %b  %b  |  %b  %b  %b", d[3], d[2], d[1], d[0], a[1], a[0], valid);

    d = 4'b0001; #10;
    d = 4'b001x; #10;
    d = 4'b01xx; #10;
    d = 4'b1xxx; #10;
    d = 4'b0000; #10;

    $finish;
  end
endmodule
