//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Top Level Tree Adder
// Module Name : top_treeadder
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

`include "register.v"

module top_treeadder #(
    parameter WIDTH = 16
)
(
    input wire clk,
    input wire rst_n,
    input wire en,
    input wire clr,
    input wire [WIDTH-1:0] in0, in1, in2, in3, in4, in5, in6, in7,
    output wire [WIDTH-1:0] out
);
    // Internal signals for intermediate results
    wire [WIDTH-1:0] s11, s12, s13, s14; // Layer 1
    wire [WIDTH-1:0] s21, s22; // Layer 2
    wire [WIDTH-1:0] s31; // Layer 3
    // Registers for each stage
    wire [WIDTH-1:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7; // First layer
    wire [WIDTH-1:0] reg11, reg12, reg13, reg14; // Layer 1
    wire [WIDTH-1:0] reg21, reg22; // Layer 2

    // Registers before the first summation (Layer 1)
    register layer0_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in0), .q(reg0));
    register layer0_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in1), .q(reg1));
    register layer0_2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in2), .q(reg2));
    register layer0_3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in3), .q(reg3));
    register layer0_4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in4), .q(reg4));
    register layer0_5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in5), .q(reg5));
    register layer0_6 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in6), .q(reg6));
    register layer0_7 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in7), .q(reg7));

    // LAYER 1
    assign s11 = reg0 + reg1;
    assign s12 = reg2 + reg3;
    assign s13 = reg4 + reg5;
    assign s14 = reg6 + reg7;

    register layer1_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s11), .q(reg11));
    register layer1_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s12), .q(reg12));
    register layer1_2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s13), .q(reg13));
    register layer1_3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s14), .q(reg14));

    // LAYER 2
    assign s21 = reg11 + reg12;
    assign s22 = reg13 + reg14;

    register layer2_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s21), .q(reg21));
    register layer2_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s22), .q(reg22));

    // LAYER 3
    assign s31 = reg21 + reg22;

    register layer3_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s31), .q(out));

endmodule
