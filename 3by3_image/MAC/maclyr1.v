//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Multiplier Fixed Point
// Module Name : maclyr1
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////
`include "mult.v"

module maclyr1(
    //input  wire clk,          // Clock
    input  wire [15:0] d1,		// Data 1
	input  wire [15:0] d2,		// Data 2
	input  wire [15:0] d3,		// Data 3
	input  wire [15:0] d4,		// Data 4
	input  wire [15:0] d5,		// Data 5
	input  wire [15:0] d6,		// Data 6
	input  wire [15:0] d7,		// Data 7
	input  wire [15:0] d8,		// Data 8
	input  wire [15:0] d9,		// Data 9
	input  wire [15:0] w1,		// Weight 1
	input  wire [15:0] w2,		// Weight 2
	input  wire [15:0] w3,		// Weight 3
	input  wire [15:0] w4,		// Weight 4
	input  wire [15:0] w5,		// Weight 5
	input  wire [15:0] w6,		// Weight 6
	input  wire [15:0] w7,		// Weight 7
	input  wire [15:0] w8,		// Weight 8
	input  wire [15:0] w9,		// Weight 9
	input  wire [15:0] b,		// Bias
    output wire [15:0] res  	// Hasil
);
	// Multiplier result
    wire [15:0] mul1;
	wire [15:0] mul2;
	wire [15:0] mul3;
	wire [15:0] mul4;
	wire [15:0] mul5;
	wire [15:0] mul6;
	wire [15:0] mul7;
	wire [15:0] mul8;
	wire [15:0] mul9;
	
	// Tree adder result
	wire [15:0] s1;
	wire [15:0] s2;
	wire [15:0] s3;
	wire [15:0] s4;
	wire [15:0] s5;
	wire [15:0] s6;
	wire [15:0] s7;
	
	// Module multiplier
    mult mult1
		(
			.Operand_1(d1),
			.Operand_2(w1),
			.result(mul1)
		);
	mult mult2
		(
			.Operand_1(d2),
			.Operand_2(w2),
			.result(mul2)
		);
	mult mult3
		(
			.Operand_1(d3),
			.Operand_2(w3),
			.result(mul3)
		);
	mult mult4
		(
			.Operand_1(d4),
			.Operand_2(w4),
			.result(mul4)
		);
	mult mult5
		(
			.Operand_1(d5),
			.Operand_2(w5),
			.result(mul5)
		);
	mult mult6
		(
			.Operand_1(d6),
			.Operand_2(w6),
			.result(mul6)
		);
	mult mult7
		(
			.Operand_1(d7),
			.Operand_2(w7),
			.result(mul7)
		);
	mult mult8
		(
			.Operand_1(d8),
			.Operand_2(w8),
			.result(mul8)
		);
	mult mult9
		(
			.Operand_1(d9),
			.Operand_2(w9),
			.result(mul9)
		);
	
	// Tree adder
	assign s1 = mul1 + mul2;
	assign s2 = mul3 + mul4;
	assign s3 = mul5 + mul6;
	assign s4 = mul7 + mul8;
	assign s5 = mul9 + b;
	assign s6 = s1 + s2;
	assign s7 = s3 + s4;
	assign res = s5 + s6 + s7;
endmodule
