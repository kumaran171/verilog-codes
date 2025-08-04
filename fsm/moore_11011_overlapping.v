module moore_11011_overlapping(output reg d, input clk, input rst, input n);
  parameter [2:0] S0 = 3'b000,
                  S1 = 3'b001,
                  S2 = 3'b010,
                  S3 = 3'b011,
                  S4 = 3'b100,
                  S5 = 3'b101;

  reg [2:0] state, next;

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      state <= S0;
    end else begin
      state <= next;
    end
  end

  always @(state or n) begin
    next = 3'bx;
    d = 1'b0;  // ✅ 'd' must be declared as reg (already fixed above)
    case (state)
      S0: begin
        if (n == 0) begin
          next = S0;
        end else begin
          next = S1;
        end
      end
      S1: begin
        if (n == 0) begin
          next = S0;
        end else begin
          next = S2;
        end
      end
      S2: begin
        if (n == 0) begin
          next = S3;
        end else begin
          next = S2;
        end
      end
      S3: begin
        if (n == 0) begin
          next = S0;
        end else begin
          next = S4;
        end
      end
      S4: begin
        if (n == 0) begin
          next = S0;
        end else begin
          next = S5;
        end
      end
      S5: begin
        d = 1'b1;  // ✅ Still allowed here (Moore-style output per your structure)
        if (n == 0) begin
          next = S3;
        end else begin
          next = S2;
        end
      end
    endcase
  end
endmodule








      
