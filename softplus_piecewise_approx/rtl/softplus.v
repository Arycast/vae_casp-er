//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : SoftPlus
// Module Name : softplus
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

`include "mult.v"
`include "grad_softplus.v"
`include "off_softplus.v"
module softplus (
   input [15:0] operand, 
   output [15:0] out
);
	wire [15:0] grad;
	wire [15:0] offset;
	wire [15:0] mulres;
	
	grad_softplus softgrad
		(
			.operand(operand),
			.grad(grad)
		);
		
	off_softplus softoff
		(
			.operand(operand),
			.offset(offset)
		);
	
	mult softmul
		(
			.Operand_1(operand),
			.Operand_2(grad),
			.result(mulres)
		);
	
	assign out = mulres + offset;
endmodule