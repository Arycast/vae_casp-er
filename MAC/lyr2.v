`include "mult.v"
`include "sigmoid.v"
module lyr2(
    //input  wire clk,          // Clock
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
	wire [15:0] sumres;
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
	sumres = mul1 + mul2 + b;
	sigmoid sigmoid1
		(
			.x(sumres);
			.alfa(res)
		);
endmodule
