`timescale 1ns / 1ps

module tb_sigmoid;
    // Parameters
    parameter BITS = 16;

    // Inputs
    reg [BITS-1:0] x;
    reg [BITS-1:0] gradient;
    reg [BITS-1:0] offset;

    // Output
    wire [BITS-1:0] alfa;

    // Instantiate the Unit Under Test (UUT)
    sigmoid #(.BITS(BITS)) uut (
        .x(x),
        .gradient(gradient),
        .offset(offset),
        .alfa(alfa)
    );

    // Stimulus process
    initial begin
        // Initialize inputs
        x = 0;
        gradient = 0;
        offset = 0;

        // Test case 1: Positive input close to zero
        x = 16'h0001;     // 1/256, which is a small positive number
        gradient = 16'h0002; // 2/256, also a small positive number
        offset = 16'h0000; // 0
        #10; // Wait for 10 time units
        $display("Test Case 1 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

        // Test case 2: Moderate positive inputs
        x = 16'h000C;     // 12/256 = 0.046875
        gradient = 16'h0004; // 4/256 = 0.015625
        offset = 16'h0001; // 1/256
        #10;
        $display("Test Case 2 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

        // Test case 3: Zero input
        x = 16'h0000;     // 0
        gradient = 16'h0000; // 0
        offset = 16'h0000; // 0
        #10;
        $display("Test Case 3 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

        // Test case 4: Large positive values
        x = 16'h007F;     // 127/256 ~ 0.49609375 (close to 0.5)
        gradient = 16'h0002; // 2/256
        offset = 16'h0001; // 1/256
        #10;
        $display("Test Case 4 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

        // Test case 5: Large negative values
        x = 16'hFF80;     // -128/256 = -0.5
        gradient = 16'hFFFE; // -2/256
        offset = 16'hFFFF; // -1/256
        #10;
        $display("Test Case 5 - x: %h, gradient: %h, offset: %h, alfa: %h", x, gradient, offset, alfa);

        // Finish simulation
        $finish;
    end

    // Optional: Waveform dump for ModelSim/QuestaSim
    initial begin
        $dumpfile("sigmoid_tb.vcd");
        $dumpvars(0, tb_sigmoid);
    end
endmodule