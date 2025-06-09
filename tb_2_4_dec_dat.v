module tb_2_4_dec_dat;
  reg a1,a0;
  reg En;
  wire d3,d2,d1,d0;
  dec_2_4_dat uut(.a1(a1),.a0(a0),.En(En),.d3(d3),.d2(d2),.d1(d1),.d0(d0));
  initial begin
    $dumpfile("z9.vcd");
    $dumpvars(0,tb_2_4_dec_dat);
    $display("En A1 A0| D3 D2 D1 D0");
    $monitor("%b %b %b| %b %b %b %b",En,a1,a0,d3,d2,d1,d0);
    En=0;a1=0;a0=0;#10;
    En=0;a1=0;a0=1;#10;
    En=0;a1=1;a0=0;#10;
    En=0;a1=1;a0=1;#10;
    En=1;a1=0;a0=0;#10;
    En=1;a1=0;a0=1;#10;
    En=1;a1=1;a0=0;#10;
    En=1;a1=1;a0=1;#10;
    $finish;
  end
endmodule

  
