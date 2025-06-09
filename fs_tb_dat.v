module tb_fs_dat;
  reg A,Bin,C;
  wire D,Bout;
  full_sub_dat uut(.A(A),.Bin(Bin),.C(C),.D(D),.Bout(Bout));
  initial begin
    $dumpfile("z7.vcd");
    $dumpvars(0,tb_fs_dat);
    $display("A Bin C| D Bout");
    $monitor("%b %b %b| %b %b",A,Bin,C,D,Bout);
    A=0;Bin=0;C=0;#10;
    A=0;Bin=0;C=1;#10;
    A=0;Bin=1;C=0;#10;
    A=0;Bin=1;C=1;#10;
    A=1;Bin=0;C=0;#10;
    A=1;Bin=0;C=1;#10;
    A=1;Bin=1;C=0;#10;
    A=1;Bin=1;C=1;#10;
    $finish;
  end
endmodule
    