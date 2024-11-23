//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Gradien SoftPlus
// Module Name : grad_softplus
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module grad_softplus (
    
   input [15:0] operand, 
   output reg [15:0] grad
);

	wire [6:0] x;
	wire sign;
	reg [15:0] outpos;
	reg [15:0] outneg;
	assign sign = operand[15];
	assign x = operand[14:8];

	always @ (*) begin
		case(x)
		  7'h00   	: outpos = 16'h0044; 		// 0
		  7'h01   	: outpos = 16'h005a; 		// 1
		  7'h02   	: outpos = 16'h0066; 		// 2
		  7'h03   	: outpos = 16'h006b; 		// 3
		  7'h04   	: outpos = 16'h006d; 		// 4
		  default  	: outpos = 16'h006e; 		// Default
		endcase
		
		case(x)
		  7'hff   	: outneg = 16'h0001; 		// -1
		  7'hfe   	: outneg = 16'h0003; 		// -2
		  7'hfd   	: outneg = 16'h0008; 		// -3
		  7'hfc   	: outneg = 16'h0014; 		// -4
		  7'bhfb   	: outneg = 16'h002a; 		// -5
		  default  	: outneg = 16'h0000; 		// Default
		endcase
		
		case(sign)
		  0   		: grad = outpos; 		// Positve
		  default   : grad = outneg; 		// Default
		endcase
	end
endmodule