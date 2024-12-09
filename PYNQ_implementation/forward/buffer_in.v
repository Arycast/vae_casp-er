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
    output reg [63:0] out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,
    output reg [63:0] out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,
    output reg [63:0] out20
);

	// Declare memory array (depth 4, each entry 64-bits wide)
    reg [63:0] mem_array [MEM_DEPTH-1:0];
    reg [ADDR_WIDTH-1:0] write_count;  // Counter for number of writes done (4 writes = full buffer)
    integer i;

    // reg [63:0] reg_out0,reg_out1,reg_out2,reg_out3,reg_out4,reg_out5,reg_out6,reg_out7,reg_out8,reg_out9;
    // reg [63:0] reg_out10,reg_out11,reg_out12,reg_out13,reg_out14,reg_out15,reg_out16,reg_out17,reg_out18,reg_out19;
    // reg [63:0] reg_out20;

    // assign out0 = reg_out0; assign out1 = reg_out1; assign out2 = reg_out2; assign out3 = reg_out3;
    // assign out4 = reg_out4; assign out5 = reg_out5; assign out6 = reg_out6; assign out7 = reg_out7;
    // assign out8 = reg_out8; assign out9 = reg_out9; assign out10 = reg_out10; assign out11 = reg_out11;
    // assign out12 = reg_out12; assign out13 = reg_out13; assign out14 = reg_out14; assign out15 = reg_out15;
    // assign out16 = reg_out16; assign out17 = reg_out17; assign out18 = reg_out18; assign out19 = reg_out19;
    // assign out20 = reg_out20;

    // Sequential logic
    always @(posedge clk) begin
        if (~rst_n) begin
            // Reset the module
            finish <= 0;
            write_count <= 0;

            // reg_out0 <= 0;      reg_out1 <= 0;
            // reg_out2 <= 0;      reg_out3 <= 0;
            // reg_out4 <= 0;      reg_out5 <= 0;
            // reg_out6 <= 0;      reg_out7 <= 0;
            // reg_out8 <= 0;      reg_out9 <= 0;
            // reg_out10 <= 0;     reg_out11 <= 0;
            // reg_out12 <= 0;     reg_out13 <= 0;
            // reg_out14 <= 0;     reg_out15 <= 0;
            // reg_out16 <= 0;     reg_out17 <= 0;
            // reg_out18 <= 0;     reg_out19 <= 0;
            // reg_out20 <= 0;

            // out0 <= 0;      out1 <= 0;
            // out2 <= 0;      out3 <= 0;
            // out4 <= 0;      out5 <= 0;
            // out6 <= 0;      out7 <= 0;
            // out8 <= 0;      out9 <= 0;
            // out10 <= 0;     out11 <= 0;
            // out12 <= 0;     out13 <= 0;
            // out14 <= 0;     out15 <= 0;
            // out16 <= 0;     out17 <= 0;
            // out18 <= 0;     out19 <= 0;
            // out20 <= 0;

            for (i = 0; i < 21; i = i + 1) begin
                mem_array[i] <= 64'b0;
            end
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

        // if (en_out) begin
		// 	// reg_out0 <= mem_array[0];      reg_out1 <= mem_array[1];
        //     // reg_out2 <= mem_array[2];      reg_out3 <= mem_array[3];
        //     // reg_out4 <= mem_array[4];      reg_out5 <= mem_array[5];
        //     // reg_out6 <= mem_array[6];      reg_out7 <= mem_array[7];
        //     // reg_out8 <= mem_array[8];      reg_out9 <= mem_array[9];
        //     // reg_out10 <= mem_array[10];    reg_out11 <= mem_array[11];
        //     // reg_out12 <= mem_array[12];    reg_out13 <= mem_array[13];
        //     // reg_out14 <= mem_array[14];    reg_out15 <= mem_array[15];
        //     // reg_out16 <= mem_array[16];    reg_out17 <= mem_array[17];
        //     // reg_out18 <= mem_array[18];    reg_out19 <= mem_array[19];
        //     // reg_out20 <= mem_array[20];

        //     out0 <= mem_array[0];      out1 <= mem_array[1];
        //     out2 <= mem_array[2];      out3 <= mem_array[3];
        //     out4 <= mem_array[4];      out5 <= mem_array[5];
        //     out6 <= mem_array[6];      out7 <= mem_array[7];
        //     out8 <= mem_array[8];      out9 <= mem_array[9];
        //     out10 <= mem_array[10];    out11 <= mem_array[11];
        //     out12 <= mem_array[12];    out13 <= mem_array[13];
        //     out14 <= mem_array[14];    out15 <= mem_array[15];
        //     out16 <= mem_array[16];    out17 <= mem_array[17];
        //     out18 <= mem_array[18];    out19 <= mem_array[19];
        //     out20 <= mem_array[20];
        // end


		

    end

    always @(posedge clk) begin
        if (write_count == (MEM_DEPTH-1)) finish <= 1; // Buffer is full and read is complete
        else finish <= 0;

        if (en_out) begin
            out0 <= mem_array[0];      out1 <= mem_array[1];
            out2 <= mem_array[2];      out3 <= mem_array[3];
            out4 <= mem_array[4];      out5 <= mem_array[5];
            out6 <= mem_array[6];      out7 <= mem_array[7];
            out8 <= mem_array[8];      out9 <= mem_array[9];
            out10 <= mem_array[10];    out11 <= mem_array[11];
            out12 <= mem_array[12];    out13 <= mem_array[13];
            out14 <= mem_array[14];    out15 <= mem_array[15];
            out16 <= mem_array[16];    out17 <= mem_array[17];
            out18 <= mem_array[18];    out19 <= mem_array[19];
            out20 <= mem_array[20];
        end

    end
endmodule
