//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Sign-Based Multiplexer
// Module Name : sign_based_mux
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module sign_based_mux #(
	parameter BITS = 16
)(
	input [BITS-1:0] sign_bit,
	input [BITS-1:0] minus_offset,
	input [BITS-1:0] plus_offset,
	output reg [BITS-1:0] out
);

	always @(*) begin
		// Check the MSB on the sign_bit
		// If the MSB is non-negative
		if (sign_bit[BITS-1] == 1'b0) begin
			out = plus_offset;
		end else begin 
			// If the MSB is negative
			out = minus_offset;
		end
	end
endmodule


	