//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Offset SoftPlus
// Module Name : off_softplus
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module off_softplus (
   input [15:0] operand, 
   output reg [15:0] offset
);

	wire [2:0] x;
	wire sign;
	reg [15:0] outpos;
	reg [15:0] outneg;
	assign sign = operand[15];
	assign x = operand[14:8];

	always @ (*) begin
		case(x)
		  7'h00   	: outpos = 16'h004d; 		// 0
		  7'h01  	: outpos = 16'h0037; 		// 1
		  7'h02   	: outpos = 16'h001f; 		// 2
		  7'h03   	: outpos = 16'h000f; 		// 3
		  7'h04   	: outpos = 16'h0007; 		// 4
		  default  	: outpos = 16'h004d; 		// Default
		endcase
		
		case(x)
		  7'hff   	: outneg = 16'h004d; 		// -1
		  7'hfe   	: outneg = 16'h0037; 		// -2
		  7'hfd   	: outneg = 16'h001f; 		// -3
		  7'hfc   	: outneg = 16'h000f; 		// -4
		  7'hfb   	: outneg = 16'h0007; 		// -5
		  default  	: outneg = 16'h0002; 		// Default
		endcase
		
		case(sign)
		  0   		: offset = outpos; 		// Positve
		  default   : offset = outneg; 		// Default
		endcase
	end
endmodule