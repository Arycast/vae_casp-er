`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 
// 
// Create Date: 12/06/2024 
// Design Name: 
// Module Name: axis_buffer
// Project Name: 
// Target Devices: 

//////////////////////////////////////////////////////////////////////////////////


module axis_forward (
	input aclk,
	input aresetn,
	// *** AXIS slave port ***
	output wire        s_axis_tready,
	input wire [63:0]  s_axis_tdata,
	input wire         s_axis_tvalid,
	input wire         s_axis_tlast,
	// *** AXIS master port ***
	input wire         m_axis_tready,
	output wire [63:0] m_axis_tdata,
	output wire        m_axis_tvalid,
	output wire        m_axis_tlast
);

	// State machine
	reg [2:0] state_reg, state_next;
	reg [5:0] cnt_word_reg, cnt_word_next;
	reg [7:0] cnt_stream_data_reg, cnt_stream_data_next;

	// MM2S FIFO    
	wire [8:0] mm2s_data_count;
	wire start_from_mm2s;
	reg mm2s_ready_reg, mm2s_ready_next;
	wire [63:0] mm2s_data;

	// forward_vae
	parameter MEM_DEPTH_FROM_DMA = 21;	// Depth of memory dump from DMA
	parameter MEM_DEPTH_TO_DMA 	 = 11;	// Depth of memory dump from DMA
	parameter ADDR_WIDTH		 = 5;
	parameter ADDR_WIDTH_OUT	 = 4;
	wire start, finish;
	wire rd_finish, rd_en;
	wire [ADDR_WIDTH-1:0] in_addr, out_addr;
	wire [63:0] din, dout;

	// S2MM FIFO
	wire s2mm_ready;
	wire [63:0] s2mm_data;
	wire s2mm_valid, s2mm_valid_reg;
	wire s2mm_last, s2mm_last_reg;

	// *** MM2S FIFO ************************************************************
	// xpm_fifo_axis: AXI Stream FIFO
	// Xilinx Parameterized Macro, version 2018.3
	xpm_fifo_axis
	#(
		.CDC_SYNC_STAGES(2),                 // DECIMAL
		.CLOCKING_MODE("common_clock"),      // String
		.ECC_MODE("no_ecc"),                 // String
		.FIFO_DEPTH(256),                    // DECIMAL, depth 256 elemen 
		.FIFO_MEMORY_TYPE("auto"),           // String
		.PACKET_FIFO("false"),               // String
		.PROG_EMPTY_THRESH(10),              // DECIMAL
		.PROG_FULL_THRESH(10),               // DECIMAL
		.RD_DATA_COUNT_WIDTH(1),             // DECIMAL
		.RELATED_CLOCKS(0),                  // DECIMAL
		.SIM_ASSERT_CHK(0),                  // DECIMAL
		.TDATA_WIDTH(64),                    // DECIMAL, data width 64 bit
		.TDEST_WIDTH(1),                     // DECIMAL
		.TID_WIDTH(1),                       // DECIMAL
		.TUSER_WIDTH(1),                     // DECIMAL
		.USE_ADV_FEATURES("0004"),           // String, write data count
		.WR_DATA_COUNT_WIDTH(9)              // DECIMAL, width log2(256)+1=9 
	)
	xpm_fifo_axis_0
	(
		.almost_empty_axis(), 
		.almost_full_axis(), 
		.dbiterr_axis(), 
		.prog_empty_axis(), 
		.prog_full_axis(), 
		.rd_data_count_axis(), 
		.sbiterr_axis(), 
		.injectdbiterr_axis(1'b0), 
		.injectsbiterr_axis(1'b0), 

		.s_aclk(aclk), // aclk
		.m_aclk(aclk), // aclk
		.s_aresetn(aresetn), // aresetn
		
		.s_axis_tready(s_axis_tready), // ready    
		.s_axis_tdata(s_axis_tdata), // data
		.s_axis_tvalid(s_axis_tvalid), // valid
		.s_axis_tdest(1'b0), 
		.s_axis_tid(1'b0), 
		.s_axis_tkeep(8'hff), 
		.s_axis_tlast(s_axis_tlast),
		.s_axis_tstrb(8'hff), 
		.s_axis_tuser(1'b0), 
		
		.m_axis_tready(mm2s_ready_reg), // ready  
		.m_axis_tdata(mm2s_data), // data
		.m_axis_tvalid(), // valid
		.m_axis_tdest(), 
		.m_axis_tid(), 
		.m_axis_tkeep(), 
		.m_axis_tlast(), 
		.m_axis_tstrb(), 
		.m_axis_tuser(),  
		
		.wr_data_count_axis(mm2s_data_count) // data count
	);

	// *** Main control *********************************************************
    // Start signal from DMA MM2S
    assign start_from_mm2s = (mm2s_data_count >= (MEM_DEPTH_FROM_DMA-1)); // Weight = 5 word, input = 2 word, total = 7 word
    
    // State machine for AXI-Stream protocol
    always @(posedge aclk)
    begin
        if (!aresetn)
        begin
            state_reg <= 0;
            mm2s_ready_reg <= 0;
            cnt_word_reg <= 0;
			cnt_stream_data_reg <= 0;
        end
        else
        begin
            state_reg <= state_next;
            mm2s_ready_reg <= mm2s_ready_next;
            cnt_word_reg <= cnt_word_next;
			cnt_stream_data_reg <= cnt_stream_data_next;
        end
    end
    
	always @(*)
	begin
		state_next = state_reg;
		mm2s_ready_next = mm2s_ready_reg;
		cnt_word_next = cnt_word_reg;
		cnt_stream_data_next = cnt_stream_data_reg;
		case (state_reg)
			0: // Wait until data from MM2S is ready
			begin
					// if (start_from_mm2s)
					// begin
					// 	state_next = 1;
					// 	mm2s_ready_next = 1; // Tell the MM2S FIFO that it is ready to accept data
					// end
					if (s_axis_tvalid == 1'b1) state_next = 1;
			end
			1: begin
				if (s_axis_tvalid == 1'b0) begin
					state_next = 2;
					mm2s_ready_next = 1; // Tell the MM2S FIFO that it is ready to accept data
				end
				cnt_stream_data_next = cnt_stream_data_reg + 1;
			end
			2: // Write data to input forward vae
			begin
				if (cnt_word_reg == cnt_stream_data_reg) begin
					state_next = 3;
					cnt_word_next = 0;
					cnt_stream_data_next = 0;
				end

				else cnt_word_next = cnt_word_reg + 1;
			end
			3: // Start the forward VAE
			begin
				// if (cnt_word_reg == (9)) begin
				// 	state_next = 3;
				// 	cnt_word_next = 0;
				// end
				// else cnt_word_next = cnt_word_reg + 1;
				state_next = 4;
			end
			4: // Wait until VAE computation done and S2MM FIFO is ready to accept data
			begin
				if (finish && s2mm_ready)
				begin
					state_next = 5;
				end
			end
			5: // Read data output from memory of the VAE
			begin
				if (cnt_word_reg == (MEM_DEPTH_TO_DMA-1))
				begin
					state_next = 0;
					cnt_word_next = 0;
					// state_next = 5;
				end
				else
				begin
					cnt_word_next = cnt_word_reg + 1;
				end
			end
			// 5:
			// begin
				
			// end
			default: state_next = 0;
		endcase
	end

	// Control data input port buffer
	assign in_addr = cnt_word_reg;
	assign din = mm2s_data;
	
	// Start reading input
	assign start = (state_reg == 2) ? 1'b1 : 1'b0;

	// Start forward VAE calculation
	assign rd_en = (state_reg == 4) ? 1'b1 : 1'b0;
	
	// Control data output port buffer
	assign en_out = (state_reg == 5) ? 1'b1 : 1'b0;
	assign out_addr = cnt_word_reg;           

	// Control S2MM FIFO
	assign s2mm_data = dout;
	assign s2mm_valid = en_out;
	register #(1) reg_s2mm_valid(aclk, aresetn, 1'b1, 1'b0, s2mm_valid, s2mm_valid_reg); 
	assign s2mm_last = ((state_reg == 5) && (out_addr == (MEM_DEPTH_TO_DMA-1))) ? 1 : 0;
	register #(1) reg_s2mm_last(aclk, aresetn, 1'b1, 1'b0, s2mm_last, s2mm_last_reg);

	forward_vae #(
		.WIDTH (16),
		.MEM_DEPTH_IN(MEM_DEPTH_FROM_DMA),
		.MEM_DEPTH_OUT(MEM_DEPTH_TO_DMA),
		.ADDR_WIDTH_IN(ADDR_WIDTH),
		.ADDR_WIDTH_OUT(ADDR_WIDTH_OUT)
	) forwward_top (
		.clk(aclk),
		.rst_n(aresetn),
		.start(start),
		.finish(finish),
		.en_out(en_out),
		.in_addr(in_addr),
		.out_addr(out_addr),
		.din(din),
		.dout(dout),
		.rd_en(rd_en)
		// .rd_finish(rd_finish)
	);

	// buffer #(
	// 	.MEM_DEPTH(MEM_DEPTH_FROM_DMA),
	// 	.ADDR_WIDTH(ADDR_WIDTH)
	// ) buff (
	// 	.clk(aclk),
	// 	.rst_n(aresetn),
	// 	.start(start),
	// 	.finish(finish),
	// 	.en_out(en_out),
	// 	.in_addr(in_addr),
	// 	.out_addr(out_addr),
	// 	.din(din),
	// 	.dout(dout)
	// );

	// *** S2MM FIFO ************************************************************
	// xpm_fifo_axis: AXI Stream FIFO
	// Xilinx Parameterized Macro, version 2018.3
	xpm_fifo_axis
	#(
		.CDC_SYNC_STAGES(2),                 // DECIMAL
		.CLOCKING_MODE("common_clock"),      // String
		.ECC_MODE("no_ecc"),                 // String
		.FIFO_DEPTH(256),                    // DECIMAL, depth 256 elemen 
		.FIFO_MEMORY_TYPE("auto"),           // String
		.PACKET_FIFO("false"),               // String
		.PROG_EMPTY_THRESH(10),              // DECIMAL
		.PROG_FULL_THRESH(10),               // DECIMAL
		.RD_DATA_COUNT_WIDTH(1),             // DECIMAL
		.RELATED_CLOCKS(0),                  // DECIMAL
		.SIM_ASSERT_CHK(0),                  // DECIMAL
		.TDATA_WIDTH(64),                    // DECIMAL, data width 64 bit
		.TDEST_WIDTH(1),                     // DECIMAL
		.TID_WIDTH(1),                       // DECIMAL
		.TUSER_WIDTH(1),                     // DECIMAL
		.USE_ADV_FEATURES("0004"),           // String, write data count
		.WR_DATA_COUNT_WIDTH(9)              // DECIMAL, width log2(256)+1=9 
	)
	xpm_fifo_axis_1
	(
		.almost_empty_axis(), 
		.almost_full_axis(), 
		.dbiterr_axis(), 
		.prog_empty_axis(), 
		.prog_full_axis(), 
		.rd_data_count_axis(), 
		.sbiterr_axis(), 
		.injectdbiterr_axis(1'b0), 
		.injectsbiterr_axis(1'b0), 

		.s_aclk(aclk), // aclk
		.m_aclk(aclk), // aclk
		.s_aresetn(aresetn), // aresetn
		
		.s_axis_tready(s2mm_ready), // ready    
		.s_axis_tdata(s2mm_data), // data
		.s_axis_tvalid(s2mm_valid_reg), // valid
		.s_axis_tdest(1'b0), 
		.s_axis_tid(1'b0), 
		.s_axis_tkeep(8'hff), 
		.s_axis_tlast(s2mm_last_reg),
		.s_axis_tstrb(8'hff), 
		.s_axis_tuser(1'b0), 
		
		.m_axis_tready(m_axis_tready), // ready  
		.m_axis_tdata(m_axis_tdata), // data
		.m_axis_tvalid(m_axis_tvalid), // valid
		.m_axis_tdest(), 
		.m_axis_tid(), 
		.m_axis_tkeep(), 
		.m_axis_tlast(m_axis_tlast), 
		.m_axis_tstrb(), 
		.m_axis_tuser(),  
		
		.wr_data_count_axis() // data count
	);

endmodule
