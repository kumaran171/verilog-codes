module tb_fact_task;
  reg [7:0] n;
  wire [7:0] out;

  fact_task uut(.n(n), .out(out));

  initial begin
    $dumpfile("lewis.vcd");
    $dumpvars(0, tb_fact_task);

    // Initial display (header)
    $display("Time | Input (n) | Factorial (out)");
    // Monitor value changes
    $monitor("%0t    |    %0d     |      %0d", $time, n, out);

    // Test values
    n = 1; #10;
    n = 2; #10;
    n = 3; #10;
    n = 4; #10;
    n = 5; #10;
    n = 6; #10;
    
    $display("Simulation complete.");
    $finish;
  end
endmodule

