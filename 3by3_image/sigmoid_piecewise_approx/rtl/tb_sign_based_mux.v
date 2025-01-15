//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Sign-Based Multiplexer Testbench
// Module Name : tb_sign_based_mux
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module tb_sign_based_mux;
    parameter BITS = 16;
    
    // Inputs
    reg [BITS-1:0] sign_bit;
    reg [BITS-1:0] minus_offset;
    reg [BITS-1:0] plus_offset;
    
    // Output
    wire [BITS-1:0] out;
    
    // Instantiate the Unit Under Test (UUT)
    sign_based_mux #(.BITS(BITS)) uut (
        .sign_bit(sign_bit),
        .plus_offset(plus_offset),
        .minus_offset(minus_offset),
        .out(out)
    );
    
    // Stimulus
    initial begin
		$dumpfile("tb_sign_based_mux.vcd");
        $dumpvars(0, tb_sign_based_mux);
  
        // Test case 1: Positive input
        sign_bit = 16'b0000000100000000;          // Positive value
        plus_offset = 16'b0000000010000000; // Positive input
        minus_offset = 16'b1111111110000000; // Negative input
        #10;
        $display("Test 1 - sign_bit: %b, Selected: %b", sign_bit, out);
        
        // Test case 2: Negative input
        sign_bit = 16'b1111111100000000;          // Negative value
        plus_offset = 16'b0000000010000000; // Positive input
        minus_offset = 16'b1111111110000000; // Negative input
        #10;
        $display("Test 2 - sign_bit: %b, Selected: %b", sign_bit, out);
        
        // Test case 3: Zero input
        sign_bit = 16'b0000000000000000;          // Zero value
        plus_offset = 16'b0000000010000000; // Positive input
        minus_offset = 16'b1111111110000000; // Negative input
        #10;
        $display("Test 3 - sign_bit: %b, Selected: %b", sign_bit, out);
        
        $finish;
    end      
endmodule