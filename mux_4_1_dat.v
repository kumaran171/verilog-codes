module mux_4_1_dat(output Y, input [3:0] I, input [1:0] s);
    assign Y = (s == 2'b00) ? I[0] :
               (s == 2'b01) ? I[1] :
               (s == 2'b10) ? I[2] :
                              I[3];
endmodule
