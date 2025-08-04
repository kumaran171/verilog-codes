module tb_fsm;
 reg clk,rst,dly,done,req;
 wire gnt;
 fsm uut(.clk(clk),.rst(rst),.dly(dly),.done(done),.req(req),.gnt(gnt));
 always #5 clk=~clk;
 initial begin
   $dumpfile("lewis.vcd");
   $dumpvars(0,tb_fsm);
   $display("clk rst dly done req gnt");
   $monitor("%b  %b  %b  %b  %b  %b",clk,rst,dly,done,req,gnt);
   clk=0;
   rst=0;
   dly=0;
   done=0;
   req=0;
   rst=1;dly=0;done=1;req=0;#10;
   rst=1;dly=1;done=0;req=0;#10;
   rst=1;dly=0;done=1;req=1;#10;
   rst=1;dly=1;done=0;req=1;#10;
   rst=1;dly=0;done=1;req=0;#10;
   rst=1;dly=1;done=0;req=0;#10;
   rst=1;dly=0;done=1;req=1;#10;
   rst=1;dly=1;done=0;req=1;#10;
   $finish;
 end
endmodule