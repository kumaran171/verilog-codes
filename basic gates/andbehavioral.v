module and_gate_behavioral(output reg Y, input A, input B);
    always @(*) begin
       Y=A & B;
    end
endmodule