module comp_tb_1;
  reg [7:0] val1;
  reg [7:0] val2;
  wire less;

  // Instantiate DUT
  less_comparison uut(.val1(val1), .val2(val2), .less(less));

  initial begin
    $dumpfile("lewis.vcd");
    $dumpvars(0, comp_tb_1);

    val1 = 8'b10000000;  // 128
    val2 = 8'b00000001;  // 1

    #10;
    $display("val1 = %0d, val2 = %0d, less = %0b", val1, val2, less);

    $finish;
  end
endmodule
