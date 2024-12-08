//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Gradien SoftPlus
// Module Name : grad_softplus
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module grad_softplus_squared (
    
   input [15:0] operand, 
   output reg [15:0] grad
);

	wire [7:0] x;
	wire sign;
	reg [15:0] outpos;
	reg [15:0] outneg;
	assign sign = operand[15];
	assign x = operand[15:8];

	always @ (*) begin
		case(x)
		  8'h00   	: outpos = 16'h0035; 		// > 0
		  8'h01   	: outpos = 16'h0035; 		// > 1
		  8'h02   	: outpos = 16'h0031; 		// > 2
		  8'h03   	: outpos = 16'h002c; 		// > 3
		  8'h04   	: outpos = 16'h0027; 		// > 4
		  8'h05		: outpos = 16'h0024;		// > 5
		  8'h06		: outpos = 16'h0021;		// > 6
		  default  	: outpos = 16'h001f; 		// Default (> 7)
		endcase
		
		case(x)
		  8'hff   	: outneg = 16'h002e; 		// > -1
		  8'hfe   	: outneg = 16'h0022; 		// > -2
		  8'hfd   	: outneg = 16'h0017; 		// > -3
		  8'hfc   	: outneg = 16'h000e; 		// > -4
		  8'hfb   	: outneg = 16'h0009; 		// > -5
		  8'hfa		: outneg = 16'h0005;		// > -6
		  8'hf9		: outneg = 16'h0003;		// > -7
		  8'hf8  	: outneg = 16'h0002; 		// > -8
		  default	: outneg = 16'h0000;		// (< -8)
		endcase
		
		case(sign)
		  0   		: grad = outpos; 		// Positve
		  default   : grad = outneg; 		// Default
		endcase
	end
endmodule