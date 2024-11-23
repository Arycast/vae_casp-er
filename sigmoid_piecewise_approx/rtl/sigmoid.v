//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : PLA Sigmoid
// Module Name : sigmoid
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////


module sigmoid #(
	parameter BITS = 16
)(
	input [BITS-1:0] x,
	output  [BITS-1:0] alfa
);
	// Initialize wire
	wire [BITS-1:0] mult_result;	
	wire [BITS-1:0] gradient;	
	wire [BITS-1:0] offset;

	wire [BITS-1:0] not_in;	
	wire [BITS-1:0] abs;	


assign not_in = x[15]? ~x[BITS-1:0]:x[BITS-1:0]; //absolute operation 
assign abs = not_in + x[15]; //absolute operation

    gradient_offset gradient_0 (
        .input_grad(x),
        .out_grad(gradient),
        .out_offset(offset)

    );
	
	// Multiplier
	mult mult_inst (
	.Operand_1(x), .Operand_2(gradient),
	.result(mult_result)
	);
	
	// Calculate alfa
    assign alfa = mult_result + offset; // Update alfa based on the combinational logic
endmodule
	

	
	
	

