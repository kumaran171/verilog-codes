module tb_dec_3_8_dat;
  reg [2:0] a;
  reg En;
  wire [0:7] d;
  dec_3_8_struct uut(.a(a),.En(En),.d(d));
  initial begin 
     $dumpfile("z12.vcd");
     $dumpvars(0,tb_dec_3_8_dat);
     $display("A2 A1 A0 En| D0 D1 D2 D3 D4 D5 D6 D7");
     $monitor("%b  %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b", 
              a[2], a[1], a[0], En, 
              d[0], d[1], d[2], d[3], d[4], d[5], d[6], d[7]);
     a[2]=0;a[1]=0;a[0]=0;En=0;#10;
     a[2]=0;a[1]=0;a[0]=1;En=0;#10;
     a[2]=0;a[1]=1;a[0]=0;En=0;#10;
     a[2]=0;a[1]=1;a[0]=1;En=0;#10;
     a[2]=1;a[1]=0;a[0]=0;En=0;#10;
     a[2]=1;a[1]=0;a[0]=1;En=0;#10;
     a[2]=1;a[1]=1;a[0]=0;En=0;#10;
     a[2]=1;a[1]=1;a[0]=1;En=0;#10;
     a[2]=0;a[1]=0;a[0]=0;En=1;#10;
     a[2]=0;a[1]=0;a[0]=1;En=1;#10;
     a[2]=0;a[1]=1;a[0]=0;En=1;#10;
     a[2]=0;a[1]=1;a[0]=1;En=1;#10;
     a[2]=1;a[1]=0;a[0]=0;En=1;#10;
     a[2]=1;a[1]=0;a[0]=1;En=1;#10;
     a[2]=1;a[1]=1;a[0]=0;En=1;#10;
     a[2]=1;a[1]=1;a[0]=1;En=1;#10;
     $finish;
   end
endmodule