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
	assign x = operand[10:8];

	always @ (*) begin
		case(x)
		  3'b000   	: outpos = 16'h004d; 		// 0
		  3'b001   	: outpos = 16'h0037; 		// 1
		  3'b010   	: outpos = 16'h001f; 		// 2
		  3'b011   	: outpos = 16'h000f; 		// 3
		  3'b100   	: outpos = 16'h0007; 		// 4
		  default  	: outpos = 16'h004d; 		// Default
		endcase
		
		case(x)
		  3'b111   	: outneg = 16'h004d; 		// -1
		  3'b110   	: outneg = 16'h0037; 		// -2
		  3'b101   	: outneg = 16'h001f; 		// -3
		  3'b100   	: outneg = 16'h000f; 		// -4
		  3'b011   	: outneg = 16'h0007; 		// -5
		  default  	: outneg = 16'h0002; 		// Default
		endcase
		
		case(sign)
		  0   		: offset = outpos; 		// Positve
		  default   : offset = outneg; 		// Default
		endcase
	end
endmodule