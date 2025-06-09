module tb_2_4_enc_dat;
  reg [3:0] d;
  wire [1:0] a;
  enc_2_4_dat uut(.d(d),.a(a));
  initial begin
   $dumpfile("z15.vcd");
   $dumpvars(0,tb_2_4_enc_dat);
   $display(" D3 D2 D1 D0 | A1 A0");
   $monitor("%b %b %b %b | %b %b",d[3],d[2],d[1],d[0],a[1],a[0]);
   d[0]=1;d[1]=0;d[2]=0;d[3]=0;#10;
   d[0]=0;d[1]=1;d[2]=0;d[3]=0;#10;
   d[0]=0;d[1]=0;d[2]=1;d[3]=0;#10;
   d[0]=0;d[1]=0;d[2]=0;d[3]=1;#10;
   d[0]=0;d[1]=0;d[2]=0;d[3]=0;#10;
   $finish;
  end
endmodule
   
   