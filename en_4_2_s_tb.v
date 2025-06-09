module en_2_4_s_tb;
  reg [3:0] d;
  wire [1:0] a;
  en_2_4_s uut(.d(d),.a(a));
  initial begin
    $dumpfile("z14.vcd");
    $dumpvars(0,en_2_4_s_tb);
    $display("D3 D2 D1 D0| A1 A0");
    $monitor("%b %b %b %b| %b %b",d[3],d[2],d[1],d[0],a[1],a[0]);
    d[3]=1;d[2]=0;d[1]=0;d[0]=0;#10;
    d[3]=0;d[2]=1;d[1]=0;d[0]=0;#10;
    d[3]=0;d[2]=0;d[1]=1;d[0]=0;#10;
    d[3]=0;d[2]=0;d[1]=0;d[0]=1;#10;
    d[3]=0;d[2]=0;d[1]=0;d[0]=0;#10;
    $finish;
 end
endmodule
    
    