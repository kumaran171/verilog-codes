module even_parity;
  reg [7:0] in;
  reg out;
  task automatic par(input [7:0] n,output reg l);
   begin
    l=^n;
   end
 endtask
 initial begin
   $dumpfile("lewis.vcd");
   $dumpvars(0,even_parity);
   in=8'b10101110;
   par(in,out);
   $display("even parity is :%b",out);
   in=8'b10101111;
   par(in,out);
   $display("even parity is :%b",out);
   in=8'b11101110;
   par(in,out);
   $display("even parity is :%b",out);
   $finish;
  end
endmodule

   
