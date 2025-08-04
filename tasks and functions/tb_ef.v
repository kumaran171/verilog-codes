module tb_ef;
  reg [7:0] n;
  wire out;

  even_parity_function uut(.n(n), .out(out));

  initial begin
    $dumpfile("lewis.vcd");
    $dumpvars(0, tb_ef);
    
    n = 8'b10110101; #10;
    
    $display("The even parity of %b is %0d", n, out);
    $finish;
  end
endmodule
