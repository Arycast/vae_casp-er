`include "maclyr1.v"
module maclyr1_tb();
	// Input
	reg [15:0] x1;
	reg [15:0] x2;
	reg [15:0] x3;
	reg [15:0] x4;
	reg [15:0] x5;
	reg [15:0] x6;
	reg [15:0] x7;
	reg [15:0] x8;
	reg [15:0] x9;
	reg [15:0] w1;
	reg [15:0] w2;
	reg [15:0] w3;
	reg [15:0] w4;
	reg [15:0] w5;
	reg [15:0] w6;
	reg [15:0] w7;
	reg [15:0] w8;
	reg [15:0] w9;
	reg [15:0] b;
	// Output
	wire [15:0] result;
	
	maclyr1 uut(
		.d1(x1),
		.d2(x2),
		.d3(x3),
		.d4(x4),
		.d5(x5),
		.d6(x6),
		.d7(x7),
		.d8(x8),
		.d9(x9),
		.w1(w1),
		.w2(w2),
		.w3(w3),
		.w4(w4),
		.w5(w5),
		.w6(w6),
		.w7(w7),
		.w8(w8),
		.w9(w9),
		.b(b),
		.res(result)
	);

	initial begin
	$dumpfile("maclyr1_tb.vcd");
	$dumpvars(0, maclyr1_tb);
		x1 = 16'h0400;	
		x2 = 16'h0400; 
		x3 = 16'h0400;
		x4 = 16'h0400; 
		x5 = 16'h0400; 
		x6 = 16'h0800; 
		x7 = 16'h0800; 
		x8 = 16'h0800; 
		x9 = 16'h0800;
		w1 = 16'h0040;	
		w2 = 16'h0040; 
		w3 = 16'h0040;
		w4 = 16'h0040; 
		w5 = 16'h0040; 
		w6 = 16'h0020; 
		w7 = 16'h0020; 
		w8 = 16'h0020; 
		w9 = 16'h0020;
		b = $random;
		#10;
		x1 = 16'h0100;	
		x2 = 16'h0100; 
		x3 = 16'h0100;
		x4 = 16'h0100; 
		x5 = 16'h0100; 
		x6 = 16'h0100; 
		x7 = 16'h0100; 
		x8 = 16'h0100; 
		x9 = 16'h0100;
		w1 = 16'h0080;	
		w2 = 16'h0080; 
		w3 = 16'h0080;
		w4 = 16'h0080; 
		w5 = 16'h0080; 
		w6 = 16'h0080; 
		w7 = 16'h0080; 
		w8 = 16'h0080; 
		w9 = 16'h0080;
		b = 16'h0100;
		#10;
	end
	
endmodule