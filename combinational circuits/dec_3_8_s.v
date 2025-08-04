module dec_3_8_struct(output [7:0] d, input [2:0] a, input En);
    wire [18:0] y;

    // Inverters for a[0], a[1], a[2]
    not g1(y[0], a[0]);
    not g2(y[1], a[1]);
    not g3(y[2], a[2]);

    // d[0] = ~a[2] & ~a[1] & ~a[0] & En
    and g4(y[3], y[0], y[1]);
    and g5(y[4], y[3], y[2]);
    and g6(d[0], y[4], En);

    // d[1] = ~a[2] & ~a[1] &  a[0] & En
    and g7(y[5], y[1], a[0]);
    and g8(y[6], y[5], y[2]);
    and g9(d[1], y[6], En);

    // d[2] = ~a[2] &  a[1] & ~a[0] & En
    and g10(y[7], a[1], y[0]);
    and g11(y[8], y[7], y[2]);
    and g12(d[2], y[8], En);

    // d[3] = ~a[2] &  a[1] &  a[0] & En
    and g13(y[9], a[1], a[0]);
    and g14(y[10], y[9], y[2]);
    and g15(d[3], y[10], En);

    // d[4] =  a[2] & ~a[1] & ~a[0] & En
    and g16(y[11], y[0], y[1]);
    and g17(y[12], a[2], y[11]);
    and g18(d[4], y[12], En);

    // d[5] =  a[2] & ~a[1] &  a[0] & En
    and g19(y[13], y[1], a[0]);
    and g20(y[14], a[2], y[13]);
    and g21(d[5], y[14], En);

    // d[6] =  a[2] &  a[1] & ~a[0] & En
    and g22(y[15], a[1], y[0]);
    and g23(y[16], a[2], y[15]);
    and g24(d[6], y[16], En);

    // d[7] =  a[2] &  a[1] &  a[0] & En
    and g25(y[17], a[1], a[0]);
    and g26(y[18], a[2], y[17]);
    and g27(d[7], y[18], En);
endmodule







   
   
   
   
   