//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : PLA Sigmoid
// Module Name : sigmoid
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

`include "mult.v"
`include "sign_based_mux.v"
`include "minus_offset.v"

module sigmoid_noLUT #(
	parameter BITS = 16
)(
	input [BITS-1:0] x,
	input [BITS-1:0] gradient,
	input [BITS-1:0] offset,
	output reg [BITS-1:0] alfa
);
	// Initialize wire
	wire [BITS-1:0] mult_result;		// Multiplication result;	
	wire [BITS-1:0] neg_offset;			// Negative offset
	wire [BITS-1:0] selected_offset;	// Selected offset based on the value of x
	
	// Multiplier
	mult mult_inst (
	.Operand_1(x), .Operand_2(gradient),
	.result(mult_result)
	);
	
	// Offset adder
	minus_offset min_offset_inst (
	.offset(offset),
	.sum(neg_offset)
	);
	
	// Multiplexer
	sign_based_mux mux_inst (
	.sign_bit(x), .minus_offset(neg_offset), .plus_offset(offset),
	.out(selected_offset)
	);
	
	// Calculate alfa
    always @(*) begin
        alfa = mult_result + selected_offset; // Update alfa based on the combinational logic
    end
endmodule
	

	
	
	

