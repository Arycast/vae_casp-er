`include "mult.v"
module mac3(
    //input  wire clk,            // Clock
    input  wire [15:0] d1,		// Data 1
	input  wire [15:0] d2,		// Data 2
	input  wire [15:0] d3,		// Data 3
	input  wire [15:0] w1,		// Weight 1
	input  wire [15:0] w2,		// Weight 2
	input  wire [15:0] w3,		// Weight 3
    output wire [15:0] res  	// Hasil
);
    wire [15:0] mul1;
	wire [15:0] mul2;
	wire [15:0] mul3;
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
	res = mul1 + mul2 + mul3;
endmodule
