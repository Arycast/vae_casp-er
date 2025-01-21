`timescale 1ns / 1ps

module tb_top_treeadder;

    // Parameters
    parameter WIDTH = 16;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg en;
    reg clr;
    reg [WIDTH-1:0] in0, in1, in2, in3, in4, in5, in6, in7;
    wire [WIDTH-1:0] out;

    // Instantiate the DUT (Device Under Test)
    top_treeadder #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .in5(in5),
        .in6(in6),
        .in7(in7),
        .out(out)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns clock period (100 MHz)

    // Test stimulus
    initial begin
        $dumpfile("tb_top_treeadder.vcd");
        $dumpvars(0, tb_top_treeadder);
        // Initialize inputs
        rst_n = 0;
        en = 0;
        clr = 0;
        in0 = 0; in1 = 0; in2 = 0; in3 = 0;
        in4 = 0; in5 = 0; in6 = 0; in7 = 0;

        // Reset the DUT
        #10 rst_n = 1; en = 1;

        // Test Case 1: Simple summation
        #10 in0 = 16'sh0100;  // 1.00
            in1 = 16'sh0200;  // 2.00
            in2 = 16'sh0300;  // 3.00
            in3 = 16'sh0400;  // 4.00
            in4 = 16'sh0500;  // 5.00
            in5 = 16'sh0600;  // 6.00
            in6 = 16'sh0700;  // 7.00
            in7 = 16'sh0800;  // 8.00

        // Test Case 2: Negative numbers
        /*
        #20 clr = 1;  // Clear pipeline
        #10 clr = 0;
            in0 = 16'shFF00;  // -1.00
            in1 = 16'shFE00;  // -2.00
            in2 = 16'shFD00;  // -3.00
            in3 = 16'shFC00;  // -4.00
            in4 = 16'shFB00;  // -5.00
            in5 = 16'shFA00;  // -6.00
            in6 = 16'shF900;  // -7.00
            in7 = 16'shF800;  // -8.00 */

        // End simulation
        #100 $stop;
    end

    // Monitor output
    initial begin
        $monitor($time, " in0=%h in1=%h in2=%h in3=%h | out=%h",
                 in0, in1, in2, in3, out);
    end

endmodule
