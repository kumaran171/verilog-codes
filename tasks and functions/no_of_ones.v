module no_of_ones(input [7:0] N,output [3:0] out);
  function automatic [3:0] oner(input [7:0] n);
    integer count;
    integer i;
    begin
      count=0;
      for(i=0;i<8;i=i+1) begin
        if(n[i]) begin
            count=count+1;
        end
      end
      oner=count;
  end
  endfunction
  assign out=oner(N);
endmodule