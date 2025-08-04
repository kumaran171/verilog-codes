module half_adder_dat(output SUM, CARRY, input A,B);
    assign SUM=A ^ B;
    assign CARRY=A & B;
endmodule