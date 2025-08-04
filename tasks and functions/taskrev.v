module tb_reverse;
  reg [7:0] a;
  reg [7:0] y; 

  task automatic rev;
    input  [7:0] n;
    output [7:0] out;
    integer i;
    integer k; // Fixed typo
    begin
      k = 7;
      for(i = 0; i < 8; i = i + 1) begin // Fixed loop (was only 7 iterations)
        out[i] = n[k];
        k = k - 1;
      end
    end
  endtask

  initial begin
    a = 8'b10111001;
    rev(a, y);
    $display("A        Y");
    $monitor("%b %b", a, y);
  end
endmodule
