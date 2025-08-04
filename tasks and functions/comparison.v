module less_comparison(output less,input [7:0] val1,input [7:0] val2);
   function automatic lesser:
       input [7:0] n1;
       input [7:0] n2;
       integer k;
       integer k1;
       integer i;
       begin
       k=0;
       for(i=0;i<8;i++) begin
            k=k+((2**(i))*n1[i]);
       end
       for(i=0;i<8;i++) begin
            k1=k1+((2**(i))*n2[i]);
       end
       if(k<k1) begin
            lesser=1;
       end
       else begin
            lesser=0;
       end
   endfunction
   assign less=lesser(val1,val2);
   if(less==1) begin
     $display("%0d is greater than %0d",k1,k);
   end
   else begin
     $display("%0d is greater than %0d",k,k1);
   end
endmodule
   


        