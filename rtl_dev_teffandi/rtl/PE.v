//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Top Level Tree Adder
// Module Name : PE
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////


module PE #(
    parameter WIDTH = 16
)
(
    input wire clk,
    input wire rst_n,
    input wire en,
    input wire clr,
    input wire [WIDTH-1:0] in0, in1, in2, in3, in4, in5, in6, in7,
    input wire [WIDTH-1:0] weight0, weight1, weight2, weight3, weight4, weight5, weight6, weight7,
    output wire [WIDTH-1:0] out
);
    // Internal signals for intermediate results
    wire [WIDTH-1:0] s01, s02, s03, s04, s05, s06, s07, s08; // wight and input product
    wire [WIDTH-1:0] s11, s12, s13, s14; // Layer 1
    wire [WIDTH-1:0] s21, s22; // Layer 2
    wire [WIDTH-1:0] s31; // Layer 3
    // Registers for each stage
    wire [WIDTH-1:0] in_reg0, in_reg1, in_reg2, in_reg3, in_reg4, in_reg5, in_reg6, in_reg7; // product layer
    wire [WIDTH-1:0] weight_reg0, weight_reg1, weight_reg2, weight_reg3,weight_reg4,weight_reg5,weight_reg6,weight_reg7; // product layer
    wire [WIDTH-1:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7; // First layer
    wire [WIDTH-1:0] reg11, reg12, reg13, reg14; // Layer 1
    wire [WIDTH-1:0] reg21, reg22; // Layer 2

    //input and weight product

    register layer_input_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in0), .q(in_reg0));
    register layer_input_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in1), .q(in_reg1));
    register layer_input_2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in2), .q(in_reg2));
    register layer_input_3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in3), .q(in_reg3));
    register layer_input_4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in4), .q(in_reg4));
    register layer_input_5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in5), .q(in_reg5));
    register layer_input_6 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in6), .q(in_reg6));
    register layer_input_7 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(in7), .q(in_reg7));

    register layer_weight_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(weight0), .q(weight_reg0));
    register layer_weight_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(weight1), .q(weight_reg1));
    register layer_weight_2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(weight2), .q(weight_reg2));
    register layer_weight_3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(weight3), .q(weight_reg3));
    register layer_weight_4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(weight4), .q(weight_reg4));
    register layer_weight_5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(weight5), .q(weight_reg5));
    register layer_weight_6 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(weight6), .q(weight_reg6));
    register layer_weight_7 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(weight7), .q(weight_reg7));

    mult mult_0(.Operand_1(in_reg0),.Operand_2(weight_reg0),.result(s01));
    mult mult_1(.Operand_1(in_reg1),.Operand_2(weight_reg1),.result(s02));
    mult mult_2(.Operand_1(in_reg2),.Operand_2(weight_reg2),.result(s03));
    mult mult_3(.Operand_1(in_reg3),.Operand_2(weight_reg3),.result(s04));
    mult mult_4(.Operand_1(in_reg4),.Operand_2(weight_reg4),.result(s05));
    mult mult_5(.Operand_1(in_reg5),.Operand_2(weight_reg5),.result(s06));
    mult mult_6(.Operand_1(in_reg6),.Operand_2(weight_reg6),.result(s07));
    mult mult_7(.Operand_1(in_reg7),.Operand_2(weight_reg7),.result(s08));


    // Registers before the first summation (Layer 1)
    register layer0_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s01), .q(reg0));
    register layer0_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s02), .q(reg1));
    register layer0_2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s03), .q(reg2));
    register layer0_3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s04), .q(reg3));
    register layer0_4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s05), .q(reg4));
    register layer0_5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s06), .q(reg5));
    register layer0_6 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s07), .q(reg6));
    register layer0_7 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(s08), .q(reg7));

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
