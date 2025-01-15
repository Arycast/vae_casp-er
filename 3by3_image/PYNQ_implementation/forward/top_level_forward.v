
// `include "grad_softplus_squared.v"
// `include "gradient_offset.v"
// `include "maclyr1.v"
// `include "maclyr2.v"
// `include "minus_offset.v"
// `include "mult.v"
// `include "off_softplus_squared.v"
// `include "sigmoid.v"
// `include "softplus_squared.v"
// `include "top_level_forward.v"
// `include "XORShift_RNG.v"


module top_level_forward (
    input clk,rst,
    input [15:0] x1,x2,x3,x4,x5,x6,x7,x8,x9, //dari 1 ya increment input nya
    input [15:0] wc11,wc12,wc13,wc14,wc15,wc16,wc17,wc18,wc19,
    input [15:0] wd11,wd12,wd13,wd14,wd15,wd16,wd17,wd18,wd19,
    input [15:0] wc21,wc22,wc23,wc24,wc25,wc26,wc27,wc28,wc29,
    input [15:0] wd21,wd22,wd23,wd24,wd25,wd26,wd27,wd28,wd29,
    input [15:0] w11,w12,
    input [15:0] w21,w22,
    input [15:0] w31,w32,
    input [15:0] w41,w42,
    input [15:0] w51,w52,
    input [15:0] w61,w62,
    input [15:0] w71,w72,
    input [15:0] w81,w82,
    input [15:0] w91,w92,
    input [15:0] b21,b22,b23,b24,
    input [15:0] b31,b32,b33,b34,b35,b36,b37,b38,b39,
    output [15:0] out1,out2,out3,out4,out5,out6,out7,out8,out9
);  
//wire layer 2
    wire [15:0] c1;
    wire [15:0] c2;
    wire [15:0] d1;
    wire [15:0] d2;
    wire [15:0] sp1_out;
    wire [15:0] sp2_out;
    wire [15:0] res_mult_sp_e1;
    wire [15:0] res_mult_sp_e2;
    wire [7:0] rand1_out;
    wire [7:0] rand2_out;

    wire [15:0] a21;
    wire [15:0] a22;

    wire [15:0] macout1;
    wire [15:0] macout2;
    wire [15:0] macout3;
    wire [15:0] macout4;
    wire [15:0] macout5;
    wire [15:0] macout6;
    wire [15:0] macout7;
    wire [15:0] macout8;
    wire [15:0] macout9;

    // Pipelined
    wire [15:0] temp_x1,temp_x2,temp_x3,temp_x4,temp_x5,temp_x6,temp_x7,temp_x8,temp_x9;
    wire [15:0] temp_c1,temp_c2;
    wire [15:0] temp_d1,temp_d2;
    wire [15:0] temp_sp1_out, temp_sp2_out;
    wire [7:0] temp1_rand1_out, temp2_rand1_out;
    wire [7:0] temp1_rand2_out, temp2_rand2_out;
    wire [15:0] temp_res_mult_sp_e1, temp_res_mult_sp_e2;
    wire [15:0] temp_a21,temp_a22;
    wire [15:0] temp_macout1;
    wire [15:0] temp_macout2;
    wire [15:0] temp_macout3;
    wire [15:0] temp_macout4;
    wire [15:0] temp_macout5;
    wire [15:0] temp_macout6;
    wire [15:0] temp_macout7;
    wire [15:0] temp_macout8;
    wire [15:0] temp_macout9;

    register #(16) reg_in1(clk, ~rst, 1'b1, 1'b0, x1, temp_x1);
    register #(16) reg_in2(clk, ~rst, 1'b1, 1'b0, x2, temp_x2);
    register #(16) reg_in3(clk, ~rst, 1'b1, 1'b0, x3, temp_x3);
    register #(16) reg_in4(clk, ~rst, 1'b1, 1'b0, x4, temp_x4);
    register #(16) reg_in5(clk, ~rst, 1'b1, 1'b0, x5, temp_x5);
    register #(16) reg_in6(clk, ~rst, 1'b1, 1'b0, x6, temp_x6);
    register #(16) reg_in7(clk, ~rst, 1'b1, 1'b0, x7, temp_x7);
    register #(16) reg_in8(clk, ~rst, 1'b1, 1'b0, x8, temp_x8);
    register #(16) reg_in9(clk, ~rst, 1'b1, 1'b0, x9, temp_x9);

    maclyr1 macc1
    (
        .clk(clk),.rst(rst),
        .d1(temp_x1),.d2(temp_x2),.d3(temp_x3),.d4(temp_x4),.d5(temp_x5),.d6(temp_x6),.d7(temp_x7),.d8(temp_x8),.d9(temp_x9),
        .w1(wc11),.w2(wc12),.w3(wc13),.w4(wc14),.w5(wc15),.w6(wc16),.w7(wc17),.w8(wc18),.w9(wc19),
        .b(b21),
        .res(temp_c1)
    );
    register #(16) reg_macc1(clk, ~rst, 1'b1, 1'b0, temp_c1, c1);

    maclyr1 macd1
    (
        .clk(clk),.rst(rst),
        .d1(temp_x1),.d2(temp_x2),.d3(temp_x3),.d4(temp_x4),.d5(temp_x5),.d6(temp_x6),.d7(temp_x7),.d8(temp_x8),.d9(temp_x9),
        .w1(wd11),.w2(wd12),.w3(wd13),.w4(wd14),.w5(wd15),.w6(wd16),.w7(wd17),.w8(wd18),.w9(wd19),
        .b(b22),
        .res(temp_d1)
    );
    register #(16) reg_macd1(clk, ~rst, 1'b1, 1'b0, temp_d1, d1);

    maclyr1 macc2
    (
        .clk(clk),.rst(rst),
        .d1(temp_x1),.d2(temp_x2),.d3(temp_x3),.d4(temp_x4),.d5(temp_x5),.d6(temp_x6),.d7(temp_x7),.d8(temp_x8),.d9(temp_x9),
        .w1(wc21),.w2(wc22),.w3(wc23),.w4(wc24),.w5(wc25),.w6(wc26),.w7(wc27),.w8(wc28),.w9(wc29),
        .b(b23),
        .res(temp_c2)
    );
    register #(16) reg_macc2(clk, ~rst, 1'b1, 1'b0, temp_c2, c2);

    maclyr1 macd2
    (
        .clk(clk),.rst(rst),
        .d1(temp_x1),.d2(temp_x2),.d3(temp_x3),.d4(temp_x4),.d5(temp_x5),.d6(temp_x6),.d7(temp_x7),.d8(temp_x8),.d9(temp_x9),
        .w1(wd21),.w2(wd22),.w3(wd23),.w4(wd24),.w5(wd25),.w6(wd26),.w7(wd27),.w8(wd28),.w9(wc29),
        .b(b24),
        .res(temp_d2)
    );
    register #(16) reg_macd2(clk, ~rst, 1'b1, 1'b0, temp_d2, d2);


    softplus_squared sp1
    (
        .operand(d1),.out(temp_sp1_out)
    );
    register #(16) reg_sp1(clk, ~rst, 1'b1, 1'b0, temp_sp1_out, sp1_out);

    softplus_squared sp2
    (
        .operand(d2),.out(temp_sp2_out)
    );
    register #(16) reg_sp2(clk, ~rst, 1'b1, 1'b0, temp_sp2_out, sp2_out);


    XOR_RNG random1
    (
        .clk(clk),.rst(rst),.rand(temp1_rand1_out)
    );
    register #(8) reg1_random1(clk, ~rst, 1'b1, 1'b0, temp1_rand1_out, temp2_rand1_out);
    register #(8) reg2_random1(clk, ~rst, 1'b1, 1'b0, temp2_rand1_out, rand1_out);

    XOR_RNG random2
    (
        .clk(clk),.rst(rst),.rand(temp1_rand2_out)
    );
    register #(8) reg1_random2(clk, ~rst, 1'b1, 1'b0, temp1_rand2_out, temp2_rand2_out);
    register #(8) reg2_random2(clk, ~rst, 1'b1, 1'b0, temp2_rand2_out, rand2_out);

    mult mult_sp_e1
    (
        .Operand_1(sp1_out),
        .Operand_2({8'h00,rand1_out}),
		.result(temp_res_mult_sp_e1)
    );
    register #(16) reg_mult_sp_e1(clk, ~rst, 1'b1, 1'b0, temp_res_mult_sp_e1, res_mult_sp_e1);

    mult mult_sp_e2
    (
        .Operand_1(sp2_out),
        .Operand_2({8'h00,rand2_out}),
		.result(temp_res_mult_sp_e2)
    );
    register #(16) reg_mult_sp_e2(clk, ~rst, 1'b1, 1'b0, temp_res_mult_sp_e2, res_mult_sp_e2);


    assign temp_a21 = res_mult_sp_e1+c1;
    assign temp_a22 = res_mult_sp_e2+c2;
    
    register #(16) reg_a21(clk, ~rst, 1'b1, 1'b0, temp_a21, a21);
    register #(16) reg_a22(clk, ~rst, 1'b1, 1'b0, temp_a22, a22);
// =========== end of layer 2 ==========

    maclyr2 macoutput1
    (
        .clk(clk),.rst(rst),
        .d1(a21),.d2(a22),
        .w1(w11),.w2(w12),
        .b(b31),
        .res(temp_macout1)
    );
    maclyr2 macoutput2
    (
        .clk(clk),.rst(rst),
        .d1(a21),.d2(a22),
        .w1(w21),.w2(w22),
        .b(b32),
        .res(temp_macout2)
    );
    maclyr2 macoutput3
    (
        .clk(clk),.rst(rst),
        .d1(a21),.d2(a22),
        .w1(w31),.w2(w32),
        .b(b33),
        .res(temp_macout3)
    );
    maclyr2 macoutput4
    (
        .clk(clk),.rst(rst),
        .d1(a21),.d2(a22),
        .w1(w41),.w2(w42),
        .b(b34),
        .res(temp_macout4)
    );
    maclyr2 macoutput5
    (
        .clk(clk),.rst(rst),
        .d1(a21),.d2(a22),
        .w1(w51),.w2(w52),
        .b(b35),
        .res(temp_macout5)
    );
    maclyr2 macoutput6
    (
        .clk(clk),.rst(rst),
        .d1(a21),.d2(a22),
        .w1(w61),.w2(w62),
        .b(b36),
        .res(temp_macout6)
    );
    maclyr2 macoutput7
    (
        .clk(clk),.rst(rst),
        .d1(a21),.d2(a22),
        .w1(w71),.w2(w72),
        .b(b37),
        .res(temp_macout7)
    );
    maclyr2 macoutput8
    (
        .clk(clk),.rst(rst),
        .d1(a21),.d2(a22),
        .w1(w81),.w2(w82),
        .b(b38),
        .res(temp_macout8)
    );
    maclyr2 macoutput9
    (
        .clk(clk),.rst(rst),
        .d1(a21),.d2(a22),
        .w1(w91),.w2(w92),
        .b(b39),
        .res(temp_macout9)
    );
    register #(16) reg_macoutput1(clk, ~rst, 1'b1, 1'b0, temp_macout1, macout1);
    register #(16) reg_macoutput2(clk, ~rst, 1'b1, 1'b0, temp_macout2, macout2);
    register #(16) reg_macoutput3(clk, ~rst, 1'b1, 1'b0, temp_macout3, macout3);
    register #(16) reg_macoutput4(clk, ~rst, 1'b1, 1'b0, temp_macout4, macout4);
    register #(16) reg_macoutput5(clk, ~rst, 1'b1, 1'b0, temp_macout5, macout5);
    register #(16) reg_macoutput6(clk, ~rst, 1'b1, 1'b0, temp_macout6, macout6);
    register #(16) reg_macoutput7(clk, ~rst, 1'b1, 1'b0, temp_macout7, macout7);
    register #(16) reg_macoutput8(clk, ~rst, 1'b1, 1'b0, temp_macout8, macout8);
    register #(16) reg_macoutput9(clk, ~rst, 1'b1, 1'b0, temp_macout9, macout9);

    sigmoid sigmoidout1
    (
        .x(macout1), .alfa(out1)
    );

    sigmoid sigmoidout2
    (
        .x(macout2), .alfa(out2)
    );

    sigmoid sigmoidout3
    (
        .x(macout3), .alfa(out3)
    );

    sigmoid sigmoidout4
    (
        .x(macout4), .alfa(out4)
    );

    sigmoid sigmoidout5
    (
        .x(macout5), .alfa(out5)
    );

    sigmoid sigmoidout6
    (
        .x(macout6), .alfa(out6)
    );

    sigmoid sigmoidout7
    (
        .x(macout7), .alfa(out7)
    );

    sigmoid sigmoidout8
    (
        .x(macout8), .alfa(out8)
    );

    sigmoid sigmoidout9
    (
        .x(macout9), .alfa(out9)
    );

// =========== end of layer 3 ==========    
endmodule