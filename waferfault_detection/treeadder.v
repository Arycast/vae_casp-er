//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Tree Adder
// Module Name : treeadder
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module treeadder #(
    parameter WIDTH = 16;
)
(
    input   [WIDTH-1:0] in0, in1, in2, in3, in4, in5, in6, in7;
    output  [WIDTH-1:0] out;
);
    wire [WIDTH-1:0] s11, s12, s13, s14; // Layer 1
    wire [WIDTH-1:0] s21, s22; // Layer 2

    assign s11 = in0 + in1;
    assign s12 = in2 + in3;
    assign s13 = in4 + in5;
    assign s14 = in6 + in7;
    assign s21 = s11 + s12;
    assign s22 = s13 + s14;
    assign out = s21 + s22;

endmodule