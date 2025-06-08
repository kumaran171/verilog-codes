module nor_gate_dataflow(output Y, input A, B);
   assign Y=~(A | B);
endmodule