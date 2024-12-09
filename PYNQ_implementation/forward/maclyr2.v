//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Multiplier Fixed Point
// Module Name : maclyr2
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////
// `include "mult.v"

module maclyr2(
    input  wire clk,rst,          // Clock
    input  wire [15:0] d1,		// Data 1
	input  wire [15:0] d2,		// Data 2
	input  wire [15:0] w1,		// Weight 1
	input  wire [15:0] w2,		// Weight 2
	input  wire [15:0] b,		// Bias
    output wire [15:0] res  	// Hasil
);
	// Multiplier result
    wire [15:0] mul1;
	wire [15:0] mul2;

	// Pipeline
	wire [15:0] temp_mul1;
	wire [15:0] temp_mul2;

    mult mult1
		(
			.Operand_1(d1),
			.Operand_2(w1),
			.result(temp_mul1)
		);
	mult mult2
		(
			.Operand_1(d2),
			.Operand_2(w2),
			.result(temp_mul2)
		);

	register #(16) reg_mult1(clk, ~rst, 1'b1, 1'b0, temp_mul1, mul1);
	register #(16) reg_mult2(clk, ~rst, 1'b1, 1'b0, temp_mul2, mul2);

	assign res = mul1 + mul2 + b;
endmodule
