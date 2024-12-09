`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : dforward vae + dum memory + control
// Module Name : forward_vae
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module forward_vae #(
    parameter WIDTH = 16,
    parameter MEM_DEPTH_IN = 21,
    parameter MEM_DEPTH_OUT = 4,
    parameter ADDR_WIDTH_IN = 5,
    parameter ADDR_WIDTH_OUT = 4
) (
    input clk, rst_n, start, en_out,
	input [ADDR_WIDTH_IN-1:0] in_addr, 
    input [ADDR_WIDTH_OUT-1:0] out_addr,
	input [63:0] din,
    input rd_en,
    // output rd_finish,
	output reg finish,
	output reg [63:0] dout
);
    // Buffer in
    // wire rd_en;     // To output data stored in buffer in
    wire rd_finish;  // Read stream data finish
    reg [63:0] rd_data [MEM_DEPTH_IN-1:0];
    reg [ADDR_WIDTH_IN-1:0] write_count;

    // Forward VAE
    wire [15:0] x1, x2, x3, x4, x5, x6, x7, x8, x9;
	wire [15:0] wc11, wc12, wc13, wc14, wc15, wc16, wc17, wc18, wc19;
	wire [15:0] wd11, wd12, wd13, wd14, wd15, wd16, wd17, wd18, wd19;
	wire [15:0] wc21, wc22, wc23, wc24, wc25, wc26, wc27, wc28, wc29;
	wire [15:0] wd21, wd22, wd23, wd24, wd25, wd26, wd27, wd28, wd29;
	wire [15:0] w11, w12;
	wire [15:0] w21, w22;
	wire [15:0] w31, w32;
	wire [15:0] w41, w42;
	wire [15:0] w51, w52;
	wire [15:0] w61, w62;
	wire [15:0] w71, w72;
	wire [15:0] w81, w82;
	wire [15:0] w91, w92;
	wire [15:0] b21, b22, b23, b24;
	wire [15:0] b31, b32, b33, b34, b35, b36, b37, b38, b39;
    wire [15:0] out1,out2,out3,out4,out5,out6,out7,out8,out9;

    // Buffer out
    reg [63:0] out_data [2:0];

    // Control

    always @(posedge clk) begin
        if (~rst_n) begin
            // Reset the module
            finish <= 0;
            dout <= 0;
            write_count <= 0;
        end else if (start) begin
            // Write data to memory when start is high
			rd_data[in_addr] <= din;

            if (write_count < (MEM_DEPTH_IN-1)) begin
                write_count <= write_count + 1;
            end

            rd_data[MEM_DEPTH_IN-1] <= 0;
        end

        out_data[0][15:0]  <= out1; out_data[1][15:0]  <= out5;
        out_data[0][31:16] <= out2; out_data[1][31:16] <= out6;
        out_data[0][47:32] <= out3; out_data[1][47:32] <= out7;
        out_data[0][63:48] <= out4; out_data[1][63:48] <= out8; 

        out_data[2][15:0]  <= out9;
        out_data[2][31:16] <= 16'h000;
        out_data[2][47:32] <= 16'h000;
        out_data[2][63:48] <= 16'h000;

        if (en_out) begin
			dout <= out_data[out_addr];
        end


		if (write_count == (MEM_DEPTH_IN-1)) finish <= 1; // Buffer is full and read is complete

    end

    // always @(posedge clk) begin
    //     out_data[0][15:0]  <= out1; out_data[1][15:0]  <= out5;
    //     out_data[0][31:16] <= out2; out_data[1][31:16] <= out6;
    //     out_data[0][47:32] <= out3; out_data[1][47:32] <= out7;
    //     out_data[0][63:48] <= out4; out_data[1][63:48] <= out8; 

    //     out_data[2][15:0]  <= out9;
    //     out_data[2][31:16] <= 16'h000;
    //     out_data[2][47:32] <= 16'h000;
    //     out_data[2][63:48] <= 16'h000;
    // end

    top_level_forward core_forward (
        .clk(clk),.rst(~rst_n),
		.x1(x1),.x2(x2),.x3(x3),.x4(x4),. x5(x5),.x6(x6),.x7(x7),.x8(x8),.x9(x9),
		.wc11(wc11),.wc12(wc12),.wc13(wc13),.wc14(wc14),.wc15(wc15),.wc16(wc16),.wc17(wc17),.wc18(wc18),.wc19(wc19),
		.wd11(wd11),.wd12(wd12),.wd13(wd13),.wd14(wd14),.wd15(wd15),.wd16(wd16),.wd17(wd17),.wd18(wd18),.wd19(wd19),
		.wc21(wc21),.wc22(wc22),.wc23(wc23),.wc24(wc24),.wc25(wc25),.wc26(wc26),.wc27(wc27),.wc28(wc28),.wc29(wc29),
		.wd21(wd21),.wd22(wd22),.wd23(wd23),.wd24(wd24),.wd25(wd25),.wd26(wd26),.wd27(wd27),.wd28(wd28),.wd29(wd29),
		.w11(w11),.w12(w12),
		.w21(w21),.w22(w22),
		.w31(w31),.w32(w32),
		.w41(w41),.w42(w42),
		.w51(w51),.w52(w52),
		.w61(w61),.w62(w62),
		.w71(w71),.w72(w72),
		.w81(w81),.w82(w82),
		.w91(w91),.w92(w92),
		.b21(b21),.b22(b22),.b23(b23),.b24(b24),
		.b31(b31),.b32(b32),.b33(b33),.b34(b34),.b35(b35),.b36(b36),.b37(b37),.b38(b38),.b39(b39),
		.out1(out1),.out2(out2),.out3(out3),.out4(out4),.out5(out5),.out6(out6),.out7(out7),.out8(out8),.out9(out9)
    );

    assign x1 = rd_data[0][15:0]; assign x2 = rd_data[0][31:16]; assign x3 = rd_data[0][47:32]; assign x4 = rd_data[0][63:48];
    assign x5 = rd_data[1][15:0]; assign x6 = rd_data[1][31:16]; assign x7 = rd_data[1][47:32]; assign x8 = rd_data[1][63:48];
    assign x9 = rd_data[2][15:0]; 

    assign wc11 = rd_data[2][31:16]; assign wc12 = rd_data[2][47:32]; assign wc13 = rd_data[2][63:48]; assign wc14 = rd_data[3][15:0]; 
    assign wc15 = rd_data[3][31:16]; assign wc16 = rd_data[3][47:32]; assign wc17 = rd_data[3][63:48]; assign wc18 = rd_data[4][15:0]; 
    assign wc19 = rd_data[4][31:16]; 

    assign wd11 = rd_data[4][47:32]; assign wd12 = rd_data[4][63:48]; assign wd13 = rd_data[5][15:0]; assign wd14 = rd_data[5][31:16];
    assign wd15 = rd_data[5][47:32]; assign wd16 = rd_data[5][63:48]; assign wd17 = rd_data[6][15:0]; assign wd18 = rd_data[6][31:16]; 
    assign wd19 = rd_data[6][47:32];

    assign wc21 = rd_data[6][63:48]; assign wc22 = rd_data[7][15:0]; assign wc23 = rd_data[7][31:16]; assign wc24 = rd_data[7][47:32];
    assign wc25 = rd_data[7][63:48]; assign wc26 = rd_data[8][15:0]; assign wc27 = rd_data[8][31:16]; assign wc28 = rd_data[8][47:32];
    assign wc29 = rd_data[8][63:48];

    assign wd21 = rd_data[9][15:0]; assign wd22 = rd_data[9][31:16]; assign wd23 = rd_data[9][47:32]; assign wd24 = rd_data[9][63:48];
    assign wd25 = rd_data[10][15:0]; assign wd26 = rd_data[10][31:16]; assign wd27 = rd_data[10][47:32]; assign wd28 = rd_data[10][63:48];
    assign wd29 = rd_data[11][15:0]; 

    assign b21 = rd_data[11][31:16]; assign b22 = rd_data[11][47:32]; assign b23 = rd_data[11][63:48]; assign b24 = rd_data[12][15:0];

    assign w11 = rd_data[12][31:16]; assign w12 = rd_data[12][47:32];
    assign w21 = rd_data[12][63:48]; assign w22 = rd_data[13][15:0];
    assign w31 = rd_data[13][31:16]; assign w32 = rd_data[13][47:32];
    assign w41 = rd_data[13][63:48]; assign w42 = rd_data[14][15:0];
    assign w51 = rd_data[14][31:16]; assign w52 = rd_data[14][47:32];
    assign w61 = rd_data[14][63:48]; assign w62 = rd_data[15][15:0];
    assign w71 = rd_data[15][31:16]; assign w72 = rd_data[15][47:32];
    assign w81 = rd_data[15][63:48]; assign w82 = rd_data[16][15:0];
    assign w91 = rd_data[16][31:16]; assign w92 = rd_data[16][47:32];

    assign b31 = rd_data[16][63:48]; assign b32 = rd_data[17][15:0]; assign b33 = rd_data[17][31:16]; assign b34 = rd_data[17][47:32];
    assign b35 = rd_data[17][63:48]; assign b36 = rd_data[18][15:0]; assign b37 = rd_data[18][31:16]; assign b38 = rd_data[18][47:32];
    assign b39 = rd_data[18][63:48];

endmodule