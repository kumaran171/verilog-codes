module tb_dec_struct;  
  reg [1:0] A;
  reg En;
  wire [0:3] d;

  dec_2_4_s uut(.A(A), .d(d), .En(En));  

  initial begin 
    $dumpfile("z8.vcd");
    $dumpvars(0, tb_dec_struct);  

    $display("En A1 A0| D0 D1 D2 D3");
    $monitor("%b  %b  %b |  %b  %b  %b  %b", En, A[1], A[0], d[0], d[1], d[2], d[3]);

    
    A=2'b00; En=0; #10;
    A=2'b01; En=0; #10;
    A=2'b10; En=0; #10;
    A=2'b11; En=0; #10;
    A=2'b00; En=1; #10;
    A=2'b01; En=1; #10;
    A=2'b10; En=1; #10;
    A=2'b11; En=1; #10;
    
    $finish;
  end
endmodule
