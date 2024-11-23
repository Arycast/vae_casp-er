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

	wire [2:0] x;
	wire sign;
	reg [15:0] outpos;
	reg [15:0] outneg;
	assign sign = operand[15];
	assign x = operand[10:8];

	always @ (*) begin
		case(x)
		  3'b000   	: outpos = 16'h0044; 		// 0
		  3'b001   	: outpos = 16'h005a; 		// 1
		  3'b010   	: outpos = 16'h0066; 		// 2
		  3'b011   	: outpos = 16'h006b; 		// 3
		  3'b100   	: outpos = 16'h006d; 		// 4
		  default  	: outpos = 16'h006e; 		// Default
		endcase
		
		case(x)
		  3'b111   	: outneg = 16'h0001; 		// -1
		  3'b110   	: outneg = 16'h0003; 		// -2
		  3'b101   	: outneg = 16'h0008; 		// -3
		  3'b100   	: outneg = 16'h0014; 		// -4
		  3'b011   	: outneg = 16'h002a; 		// -5
		  default  	: outneg = 16'h0000; 		// Default
		endcase
		
		case(sign)
		  0   		: grad = outpos; 		// Positve
		  default   : grad = outneg; 		// Default
		endcase
	end
endmodule