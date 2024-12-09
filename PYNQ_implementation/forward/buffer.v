`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : dma dump memory
// Module Name : buffer
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////


module buffer #(
    parameter   MEM_DEPTH = 5,
    parameter   ADDR_WIDTH = 3) (
	input clk, rst_n, start, en_out,
	input [ADDR_WIDTH-1:0] in_addr, out_addr,
	input [63:0] din,
	output reg finish,
	output reg [63:0] dout
);

	// Declare memory array (depth 4, each entry 64-bits wide)
    reg [63:0] mem_array [MEM_DEPTH-1:0];
    reg [ADDR_WIDTH-1:0] write_count;  // Counter for number of writes done (4 writes = full buffer)
    reg [1:0] read_count;   // Counter for reads
	// wire [2:0] temp_addr;

	// assign temp_addr = {in_addr[2],in_addr[0],in_addr[1]};

    // Sequential logic
    always @(posedge clk) begin
        if (~rst_n) begin
            // Reset the module
            finish <= 0;
            dout <= 0;
            write_count <= 0;
            read_count <= 0;
            // mem_array[4] <= 0;
        end else if (start) begin
            // Write data to memory when start is high
			mem_array[in_addr] <= din;
            // mem_array[temp_addr] <= din;

            if (write_count < (MEM_DEPTH-1)) begin
            //     mem_array[write_count] <= din;
                write_count <= write_count + 1;
            end

            mem_array[MEM_DEPTH-1] <= 0;
        end

        if (en_out) begin
			dout <= mem_array[out_addr];
        end


		if (write_count == (MEM_DEPTH-1)) finish <= 1; // Buffer is full and read is complete

    end
endmodule
