`timescale 1ns / 1ps
// `include "softplus.v"


module tb_softplus_squared;

	// Inputs
	reg [15:0] x;
	wire [15:0] gradient;
	wire [15:0] offset;

	// Output
	wire [15:0] alfa;

	// Instantiate the Unit Under Test (UUT)
	softplus_squared #() uut (
		.operand(x),
		.out(alfa)
	);



	// Stimulus process
	initial begin
		// Initialize inputs
		x = 0;

		// Test case 1: 
		x = 16'h0000;     // 0
		//  gradient = 16'h003B; // 0.23106
		// offset = 16'h0080; // 0.5
		#10; // Wait for 10 time units
		$display("Test Case 1 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

		x = 16'h0080;     // 0
		//  gradient = 16'h003B; // 0.23106
		// offset = 16'h0080; // 0.5
		#10; // Wait for 10 time units
		$display("Test Case 1 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

		// Test case 2: 
		x = 16'h0100;     // 1
		// gradient = 16'h0026; // 0.14794
		// offset = 16'h0090; // 0.56125
		#10;
		$display("Test Case 2 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

		// Test case 3: 
		x = 16'h0200;     // 2
	//  gradient = 16'h0012; // 0.07177
	//  offset = 16'h00BD; // 0.73725
		#10;
		$display("Test Case 3 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

		// Test case 4: 
		x = 16'h0300;     // 3
	//  gradient = 16'h0008; // 0.029439
	//  offset = 16'h00DD; // 0.864253
		#10;
		$display("Test Case 4 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

		// Test case 5: 
		x = 16'h0400;     // 4
	//  gradient = 16'h0003; // 0.011293
		// offset = 16'h00F0; // 0.936841
		#10;
		$display("Test Case 5 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

	// Test case 6: 
		x = 16'h0500;     // 5
	//  gradient = 16'h0001; // 0.00422
	//  offset = 16'h00F9; // 0.973307
		#10;
		$display("Test Case 6 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);
		
	// Test case 7: 
		x = 16'hFF00;     // -1
	//   gradient = 16'h0026; // 0.14794
	//  offset = 16'h0090; // 0.56125
		#10;
		$display("Test Case 7 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

	// Test case 8: 
		x = 16'hFE00;     // -2
	//  gradient = 16'h0012; // 0.07177
	//   offset = 16'h00BD; // 0.73725
		#10;
		$display("Test Case 8 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

	// Test case 9: 
		x = 16'hFD00;     // -3
	//  gradient = 16'h0008; // 0.029439
	//   offset = 16'h00DD; // 0.864253
		#10;
		$display("Test Case 9 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

	// Test case 10: 
		x = 16'hFC00;     // -4
	//  gradient = 16'h0003; // 0.011293
	//  offset = 16'h00F0; // 0.936841
		#10;
		$display("Test Case 10 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

	// Test case 11: 
		x = 16'hFB00;     // -5
	//  gradient = 16'h0001; // 0.00422
	//  offset = 16'h00F9; // 0.973307
		#10;
		$display("Test Case 11 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

		
	// Finish simulation
		$finish;
    end

	// Optional: Waveform dump for ModelSim/QuestaSim
	initial begin
		$dumpfile("softplus_squared_tb.vcd");
		$dumpvars(0, tb_softplus_squared);
	end
endmodule
