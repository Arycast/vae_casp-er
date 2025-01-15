`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : stream memory to dma
// Module Name : buffer_out
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////


module buffer_out #(
    parameter   MEM_DEPTH = 3,
    parameter   ADDR_WIDTH = 4) 
    (
	input clk, rst_n, en_out,
	input [ADDR_WIDTH-1:0] out_addr,
	input [63:0] in1,in2,in3,
    output reg [63:0] dout
);

	// Declare memory array (depth 4, each entry 64-bits wide)
    reg [63:0] mem_array [MEM_DEPTH-1:0];
    // reg [ADDR_WIDTH-1:0] write_count;  // Counter for number of writes done (4 writes = full buffer)
    reg [63:0] reg_dout;
    // assign dout = reg_dout;

    // Sequential logic
    always @(posedge clk) begin
        if (~rst_n) begin
            // Reset the module
            reg_dout <= 0;
            dout <= 0;
            // Reset memory array to some default value (e.g., 0)
            mem_array[0] <= 0;
            mem_array[1] <= 0;
            mem_array[2] <= 0;
        end else begin
            // Load new input data into memory
            mem_array[0] <= in1;
            mem_array[1] <= in2;
            mem_array[2] <= in3;
        end

        if (en_out) dout <= mem_array[out_addr];
    end

    // // Output data is read from memory on each clock cycle
    // always @(posedge clk) begin
    //     if (en_out) dout <= mem_array[out_addr];  // Example of reading memory at index 0 (you can change to other indices as needed)
    // end
endmodule
