module max_of_numbers;
  reg [7:0] a;
  reg [7:0] b;
  reg [7:0] c;
  reg [2:0] out;

  task automatic maxer;
    input [7:0] a;
    input [7:0] b;
    input [7:0] c;
    output [2:0] outer;
    begin
      if (a > b && a > c)
        outer = 2;
      else if (b > a && b > c)
        outer = 1;
      else
        outer = 0;
    end
  endtask

  initial begin
    $dumpfile("lewis.vcd");
    $dumpvars(0, max_of_numbers);

    a = 8'b10000000;
    b = 8'b00001100;
    c = 8'b00000001;

    maxer(a, b, c, out);
    #10;

    if (out == 2)
      $display("%0d is the greatest", a);
    else if (out == 1)
      $display("%0d is the greatest", b);
    else
      $display("%0d is the greatest", c);
  end
endmodule
