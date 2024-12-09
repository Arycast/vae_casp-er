`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : dump memory from dma
// Module Name : buffer_in
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////


module buffer_in #(
    parameter   MEM_DEPTH = 21,
    parameter   ADDR_WIDTH = 5) 
    (
	input clk, rst_n, start, en_out,
	input [ADDR_WIDTH-1:0] in_addr,
	input [63:0] din,
	output reg finish,
    output wire [63:0] out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,
    output wire [63:0] out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,
    output wire [63:0] out20
    // output reg [15:0] w1_std1,w1_std2,w1_std3,w1_std4,w1_std5,w1_std6,w1_std7,w1_std8,w1_std9,
    // output reg [15:0] w2_mean1,w2_mean2,w2_mean3,w2_mean4,w2_mean5,w2_mean6,w2_mean7,w2_mean8,w2_mean9,
    // output reg [15:0] w2_std1,w2_std2,w2_std3,w2_std4,w2_std5,w2_std6,w2_std7,w2_std8,w2_std9,
	// output reg [15:0] w1_mean1,w1_mean2,w1_mean3,w1_mean4,w1_mean5,w1_mean6,w1_mean7,w1_mean8,w1_mean9,
    // output reg [15:0] w11,w12,
    // output reg [15:0] w21,w22,
    // output reg [15:0] w31,w32,
    // output reg [15:0] w41,w42,
    // output reg [15:0] w51,w52,
    // output reg [15:0] w61,w62,
    // output reg [15:0] w71,w72,
    // output reg [15:0] w81,w82,
    // output reg [15:0] w91,w92,
    // output reg [15:0] b21,b22,b23,b24,
    // output reg [15:0] b31,b32,b33,b34,b35,b36,b37,b38,b39
);

	// Declare memory array (depth 4, each entry 64-bits wide)
    reg [63:0] mem_array [MEM_DEPTH-1:0];
    reg [ADDR_WIDTH-1:0] write_count;  // Counter for number of writes done (4 writes = full buffer)

    reg [63:0] reg_out0,reg_out1,reg_out2,reg_out3,reg_out4,reg_out5,reg_out6,reg_out7,reg_out8,reg_out9;
    reg [63:0] reg_out10,reg_out11,reg_out12,reg_out13,reg_out14,reg_out15,reg_out16,reg_out17,reg_out18,reg_out19;
    reg [63:0] reg_out20;

    assign out0 = reg_out0; assign out1 = reg_out1; assign out2 = reg_out2; assign out3 = reg_out3;
    assign out4 = reg_out4; assign out5 = reg_out5; assign out6 = reg_out6; assign out7 = reg_out7;
    assign out8 = reg_out8; assign out9 = reg_out9; assign out10 = reg_out10; assign out11 = reg_out11;
    assign out12 = reg_out12; assign out13 = reg_out13; assign out14 = reg_out14; assign out15 = reg_out15;
    assign out16 = reg_out16; assign out17 = reg_out17; assign out18 = reg_out18; assign out19 = reg_out19;
    assign out20 = reg_out20;

    // Sequential logic
    always @(posedge clk) begin
        if (~rst_n) begin
            // Reset the module
            finish <= 0;
            write_count <= 0;

            reg_out0 <= 0;      reg_out1 <= 0;
            reg_out2 <= 0;      reg_out3 <= 0;
            reg_out4 <= 0;      reg_out5 <= 0;
            reg_out6 <= 0;      reg_out7 <= 0;
            reg_out8 <= 0;      reg_out9 <= 0;
            reg_out10 <= 0;     reg_out11 <= 0;
            reg_out12 <= 0;     reg_out13 <= 0;
            reg_out14 <= 0;     reg_out15 <= 0;
            reg_out16 <= 0;     reg_out17 <= 0;
            reg_out18 <= 0;     reg_out19 <= 0;
            reg_out20 <= 0;
        end else if (start) begin
            // Write data to memory when start is high
			mem_array[in_addr] <= din;
            // mem_array[temp_addr] <= din;

            if (write_count < (MEM_DEPTH-1)) begin
            //     mem_array[write_count] <= din;
                write_count <= write_count + 1;
            end

            // mem_array[MEM_DEPTH-1] <= 0;
        end

        if (en_out) begin
			reg_out0 <= mem_array[0];      reg_out1 <= mem_array[1];
            reg_out2 <= mem_array[2];      reg_out3 <= mem_array[3];
            reg_out4 <= mem_array[4];      reg_out5 <= mem_array[5];
            reg_out6 <= mem_array[6];      reg_out7 <= mem_array[7];
            reg_out8 <= mem_array[8];      reg_out9 <= mem_array[9];
            reg_out10 <= mem_array[10];    reg_out11 <= mem_array[11];
            reg_out12 <= mem_array[12];    reg_out13 <= mem_array[13];
            reg_out14 <= mem_array[14];    reg_out15 <= mem_array[15];
            reg_out16 <= mem_array[16];    reg_out17 <= mem_array[17];
            reg_out18 <= mem_array[18];    reg_out19 <= mem_array[19];
            reg_out20 <= mem_array[20];
        end


		if (write_count == (MEM_DEPTH-1)) finish <= 1; // Buffer is full and read is complete

    end
endmodule
