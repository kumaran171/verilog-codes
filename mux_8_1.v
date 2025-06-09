module mux_8_1_d(output reg Y,input [7:0] d,input [2:0] s);
   always @(*) begin
     if(s==3'b000)
       Y=d[0];
     else if(s==3'b001)
       Y=d[1];
     else if(s==3'b010)
       Y=d[2];
     else if(s==3'b011)
       Y=d[3];
     else if(s==3'b100)
       Y=d[4];
     else if(s==3'b101)
       Y=d[5];
     else if(s==3'b110)
       Y=d[6];
     else 
       Y=d[7];
    end
endmodule







