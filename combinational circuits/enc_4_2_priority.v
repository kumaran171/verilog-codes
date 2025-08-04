module priority_4_2_enc(output reg [1:0] a,output reg valid, input [3:0] d);
   always @(*) begin
      a=2'b00;
      valid=1'b0;
      casez(d)
        4'b1???:begin a=2'b00; valid=1'b1; end
        4'b01??:begin a=2'b01; valid=1'b1; end
        4'b001?:begin a=2'b10; valid=1'b1; end
        4'b0001:begin a=2'b11; valid=1'b1; end
        default:begin a=2'b00; valid=1'b0; end
      endcase
  end
endmodule
        
     
   