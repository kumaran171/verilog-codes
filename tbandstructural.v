module tb_and_structural;
  reg A, B;          
  wire Y;           

  and_gate_structural uut(Y, A, B);

  initial begin
    $dumpfile("test.vcd");       
    $dumpvars(0, tb_and_structural); 

    $display("A B | Y (AND)");
    $monitor("%b %b |   %b", A, B, Y);


    A = 0; B = 0; #10;
    A = 0; B = 1; #10;
    A = 1; B = 0; #10;
    A = 1; B = 1; #10;

    $finish;
  end
endmodule
    