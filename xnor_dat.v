module xnor_dataflow(output Y,input A, B);
  assign Y=~(A ^ B);
endmodule