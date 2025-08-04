module seq_1001_moore(
  output reg d,
  input clk,
  input rst,
  input in
);

  // State encoding
  parameter [1:0]
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11;

  reg [1:0] state, next;

  // State register update
  always @(posedge clk or negedge rst) begin
    if (!rst)
      state <= S0;
    else
      state <= next;
  end

  // Next state logic and output logic
  always @(state or in) begin
    next = 2'b00;   // Default next state
    d = 1'b0;    // Default output

    case (state)
      S0: begin
        if (in == 1) 
          next = S1;
        else
          next = S0;
        d = 1'b0;
      end
      S1: begin
        if (in == 0) 
          next = S2;
        else 
          next = S1;
        d = 1'b0;
      end
      S2: begin
        if (in == 0) 
          next = S3;
        else 
          next = S1;
        d = 1'b0;
      end
      S3: begin
        if (in == 1) begin
          next = S0;
          d = 1'b1;  // Sequence 1001 detected, output 1 here
        end else begin
          next = S0;
          d = 1'b0;
        end
      end
    endcase
  end

endmodule
