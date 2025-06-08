module or_beh(output reg Y, input A, input B);
     always @(*) begin
        Y=A | B;
     end
endmodule