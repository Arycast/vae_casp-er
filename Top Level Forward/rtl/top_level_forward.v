
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


    maclyr1 macc1
    (
        .d1(x1),.d2(x2),.d3(x3),.d4(x4),.d5(x5),.d6(x6),.d7(x7),.d8(x8),.d9(x9),
        .w1(wc11),.w2(wc12),.w3(wc13),.w4(wc14),.w5(wc15),.w6(wc16),.w7(wc17),.w8(wc18),.w9(wc19),
        .b(b21),
        .res(c1)
    );
    maclyr1 macd1
    (
        .d1(x1),.d2(x2),.d3(x3),.d4(x4),.d5(x5),.d6(x6),.d7(x7),.d8(x8),.d9(x9),
        .w1(wd11),.w2(wd12),.w3(wd13),.w4(wd14),.w5(wd15),.w6(wd16),.w7(wd17),.w8(wd18),.w9(wd19),
        .b(b22),
        .res(d1)
    );
    maclyr1 macc2
    (
        .d1(x1),.d2(x2),.d3(x3),.d4(x4),.d5(x5),.d6(x6),.d7(x7),.d8(x8),.d9(x9),
        .w1(wc21),.w2(wc22),.w3(wc23),.w4(wc24),.w5(wc25),.w6(wc26),.w7(wc27),.w8(wc28),.w9(wc29),
        .b(b23),
        .res(c2)
    );
    maclyr1 macd2
    (
        .d1(x1),.d2(x2),.d3(x3),.d4(x4),.d5(x5),.d6(x6),.d7(x7),.d8(x8),.d9(x9),
        .w1(wd21),.w2(wd22),.w3(wd23),.w4(wd24),.w5(wd25),.w6(wd26),.w7(wd27),.w8(wd28),.w9(wc29),
        .b(b24),
        .res(d2)
    );

    softplus_squared sp1
    (
        .operand(d1),.out(sp1_out)
    );
    softplus_squared sp2
    (
        .operand(d2),.out(sp2_out)
    );

    XOR_RNG random1
    (
        .clk(clk),.rst(rst),.rand(rand1_out)
    );
    XOR_RNG random2
    (
        .clk(clk),.rst(rst),.rand(rand2_out)
    );

    mult mult_sp_e1
    (
        .Operand_1(sp1_out),
        .Operand_2({8'h00,rand1_out}),
		.result(res_mult_sp_e1)
    );
    mult mult_sp_e2
    (
        .Operand_1(sp2_out),
        .Operand_2({8'h00,rand2_out}),
		.result(res_mult_sp_e2)
    );

    assign a21 = res_mult_sp_e1+c1;
    assign a22 = res_mult_sp_e2+c2;
// =========== end of layer 2 ==========

    maclyr2 macoutput1
    (
        .d1(a21),.d2(a22),
        .w1(w11),.w2(w12),
        .b(b31),
        .res(macout1)
    );
    maclyr2 macoutput2
    (
        .d1(a21),.d2(a22),
        .w1(w21),.w2(w22),
        .b(b32),
        .res(macout2)
    );
    maclyr2 macoutput3
    (
        .d1(a21),.d2(a22),
        .w1(w31),.w2(w32),
        .b(b33),
        .res(macout3)
    );
    maclyr2 macoutput4
    (
        .d1(a21),.d2(a22),
        .w1(w41),.w2(w42),
        .b(b34),
        .res(macout4)
    );
    maclyr2 macoutput5
    (
        .d1(a21),.d2(a22),
        .w1(w51),.w2(w52),
        .b(b35),
        .res(macout5)
    );
    maclyr2 macoutput6
    (
        .d1(a21),.d2(a22),
        .w1(w61),.w2(w62),
        .b(b36),
        .res(macout6)
    );
    maclyr2 macoutput7
    (
        .d1(a21),.d2(a22),
        .w1(w71),.w2(w72),
        .b(b37),
        .res(macout7)
    );
    maclyr2 macoutput8
    (
        .d1(a21),.d2(a22),
        .w1(w81),.w2(w82),
        .b(b38),
        .res(macout8)
    );
    maclyr2 macoutput9
    (
        .d1(a21),.d2(a22),
        .w1(w91),.w2(w92),
        .b(b39),
        .res(macout9)
    );

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