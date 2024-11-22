//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Min value from the offset + 2
// Module Name : minus_offset
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module minus_offset (
    input [15:0] offset,      // 16-bit signed fixed-point input
    output [15:0] sum    // 16-bit signed fixed-point sum
);
	wire [15:0] min_offset ;
	assign min_offset = ~offset;

    localparam constant_value = 16'b0000_0000_0000_0010; // Constant value of 2

    // Perform signed addition (a + 2)
    assign sum = min_offset + constant_value;

endmodule