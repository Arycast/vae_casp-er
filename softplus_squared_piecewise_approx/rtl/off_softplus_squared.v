//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Offset SoftPlus
// Module Name : off_softplus
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module off_softplus_squared (
   input [15:0] operand, 
   output reg [15:0] offset
);

	wire [7:0] x;
	wire sign;
	reg [15:0] outpos;
	reg [15:0] outneg;
	assign sign = operand[15];
	assign x = operand[15:8];

	always @ (*) begin
		case(x)
		  8'h00   	: outpos = 16'h008c; 		// > 0
		  8'h01   	: outpos = 16'h008d; 		// > 1
		  8'h02   	: outpos = 16'h0095; 		// > 2
		  8'h03   	: outpos = 16'h00a4; 		// > 3
		  8'h04   	: outpos = 16'h00b8; 		// > 4
		  8'h05		: outpos = 16'h00c6;		// > 5
		  8'h06		: outpos = 16'h00d7;		// > 6
		  default  	: outpos = 16'h00e7; 		// Default (> 7)
		endcase
		
		case(x)
		  8'hff   	: outneg = 16'h008c; 		// > -1
		  8'hfe   	: outneg = 16'h0081; 		// > -2
		  8'hfd   	: outneg = 16'h006a; 		// > -3
		  8'hfc   	: outneg = 16'h0050; 		// > -4
		  8'hfb   	: outneg = 16'h003a; 		// > -5
		  8'hfa		: outneg = 16'h0028;		// > -6
		  8'hf9		: outneg = 16'h0019;		// > -7
		  8'hf8  	: outneg = 16'h0013; 		// > -8
		  default	: outneg = 16'h0000;		// Default (< -8)
		endcase
		
		case(sign)
		  0   		: offset = outpos; 		// Positve
		  default   : offset = outneg; 		// Default
		endcase
	end
endmodule