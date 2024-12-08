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

	wire [7:0] x;		// Bit Integer
	wire [2:0] x1;		// Bit 2 - 0
	wire [2:0] x2;		// Bit 3 - 1
	wire [2:0] x3;		// Bit 4 - 2
	wire [2:0] x4;		// Bit 5 - 3
	wire [2:0] x5;		// Bit 6 - 4
	wire sign;
	reg [15:0] outpos;
	reg [15:0] outneg;
	reg [15:0] y1;		// Output dari 0 - 8
	reg [15:0] y2;		// Output dari 8 - 16
	reg [15:0] y3;		// Output dari 16 - 32
	reg [15:0] y4;		// Output dari 32 - 64
	assign sign = operand[15];
	assign x = operand[14:8];
	assign x1 = operand[10:8];
	assign x2 = operand[11:9];
	assign x3 = operand[12:10];
	assign x4 = operand[13:11];
	assign x5 = operand[14:12];
	
	always @ (*) begin
		// Jarak 1
		case(x1)
		  3'b001   	: y1 = 16'h008d; 		// > 1
		  3'b010   	: y1 = 16'h0095; 		// > 2
		  3'b011   	: y1 = 16'h00a4; 		// > 3
		  3'b100   	: y1 = 16'h00b8; 		// > 4
		  3'b101	: y1 = 16'h00c6;		// > 5
		  3'b110	: y1 = 16'h00d7;		// > 6
		  3'b111  	: y1 = 16'h00e7; 		// > 7
		  3'b000   	: y1 = 16'h008c; 		// > 0
		endcase
		
		// Jarak 2
		case(x2)
		  3'b100   	: y2 = 16'h00FB; 		// > 8
		  3'b101	: y2 = 16'h0116;		// > 10
		  3'b110	: y2 = 16'h012F;		// > 12
		  3'b111  	: y2 = 16'h0154; 		// > 14
		  default	: y2 = y1;				// < 8
		endcase
		
		// Jarak 4
		case(x3)
		  3'b100   	: y3 = 16'h0177; 		// > 16
		  3'b101	: y3 = 16'h018A;		// > 20
		  3'b110	: y3 = 16'h01BE;		// > 24
		  3'b111  	: y3 = 16'h01DB; 		// > 28
		  default	: y3 = y2;				// < 16
		endcase
		
		// Jarak 8
		case(x4)
		  3'b100   	: y4 = 16'h01F7; 		// > 32
		  3'b101	: y4 = 16'h0252;		// > 40
		  3'b110	: y4 = 16'h0289;		// > 48
		  3'b111  	: y4 = 16'h02C4; 		// > 56
		  default	: y4 = y3;				// < 32
		endcase

		// Jarak 16
		case(x5)
		  3'b100   	: outpos = 16'h030F; 	// > 64
		  3'b101	: outpos = 16'h0314;	// > 80
		  3'b110	: outpos = 16'h037A;	// > 96
		  3'b111  	: outpos = 16'h03F0; 	// > 112
		  default	: outpos = y4;			// < 64
		endcase
		
		// Negatif
		case(x)
		  7'b111_1111	: outneg = 16'h008c; 		// > -1
		  7'b111_1110	: outneg = 16'h0081; 		// > -2
		  7'b111_1101	: outneg = 16'h006a; 		// > -3
		  7'b111_1100 	: outneg = 16'h0050; 		// > -4
		  7'b111_1011	: outneg = 16'h003a; 		// > -5
		  7'b111_1010	: outneg = 16'h0028;		// > -6
		  7'b111_1001	: outneg = 16'h0019;		// > -7
		  7'b111_1000	: outneg = 16'h0013; 		// > -8
		  7'b111_0111	: outneg = 16'h000C;		// > -9
		  default		: outneg = 16'h0000;		// Default (< -9)
		endcase
		
		case(sign)
		  0   		: offset = outpos; 		// Positve
		  default   : offset = outneg; 		// Default
		endcase
	end
endmodule