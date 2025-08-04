module even_parity_function(output out,input [7:0] n);
  function automatic noones(input [7:0] N);
     begin
      noones=^N;
     end
  endfunction
 assign out=noones(n);
endmodule