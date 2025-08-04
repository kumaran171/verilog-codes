module count(output [7:0] c, input [7:0] n);

  function [7:0] ones;
    input [7:0] n;
    integer i;
    integer k;
    begin
      k = 0;
      i = 0;
      while (i < 8) begin
        if (n[i])
          k = k + 1;
        i = i + 1;
      end
      ones = k; // Assign final result to function name
    end
  endfunction

  assign c = ones(n);

endmodule
 
  