`include "maclyr2.v"
module maclyr2_tb();
	// Input
	reg [15:0] x1;
	reg [15:0] x2;
	reg [15:0] w1;
	reg [15:0] w2;
	reg [15:0] b;
	// Output
	wire [15:0] result;
	
	maclyr2 uut(
		.d1(x1),
		.d2(x2),
		.w1(w1),
		.w2(w2),
		.b(b),
		.res(result)
	);

	initial begin
	$dumpfile("maclyr2_tb.vcd");
	$dumpvars(0, maclyr2_tb);
		x1 = 16'h0400;	
		x2 = 16'h0400; 
		w1 = 16'h0040;	
		w2 = 16'h0040;
		b = $random;
		#10;
		x1 = 16'h0100;	
		x2 = 16'h0100; 
		w1 = 16'h0080;	
		w2 = 16'h0080; 
		b = 16'h0100;
		#10;
	end
	
endmodule