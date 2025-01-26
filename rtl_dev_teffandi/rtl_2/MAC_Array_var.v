//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Multiplier Fixed Point
// Module Name : MAC_array
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module MAC_array_var(

input wire [63:0] DMA_channel_0, // input stream DMA channel 0
input wire [63:0] DMA_channel_1, // input stream DMA channel 1
input wire [63:0] DMA_channel_2, // input stream DMA channel 2
input wire [63:0] DMA_channel_3, // input stream DMA channel 3

input wire [15:0] bias, // input bias from cache

input wire clk,
input wire rst_n,
input wire en,
input wire clr,
input wire read_en,

output reg [15:0] dot_product

);

wire rst;
assign rst = !rst_n;

// PE output
wire [15:0] channel_0_PE_out[3:0];
wire [15:0] channel_1_PE_out[3:0];
wire [15:0] channel_2_PE_out[3:0];
wire [15:0] channel_3_PE_out[3:0];


// channel 0

wire [15:0] secondary_channel_PE_0_0 [7:0];
wire [15:0] secondary_channel_PE_0_1 [7:0];
wire [15:0] secondary_channel_PE_0_2 [7:0];
wire [15:0] secondary_channel_PE_0_3 [7:0];



PE   Channel_0_PE_0
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_0_0[0]), 
    .weight1(secondary_channel_PE_0_0[1]), 
    .weight2(secondary_channel_PE_0_0[2]), 
    .weight3(secondary_channel_PE_0_0[3]), 
    .weight4(secondary_channel_PE_0_0[4]), 
    .weight5(secondary_channel_PE_0_0[5]), 
    .weight6(secondary_channel_PE_0_0[6]), 
    .weight7(secondary_channel_PE_0_0[7]),
    .in0(DMA_channel_0[1:0]), 
    .in1(DMA_channel_0[3:2]), 
    .in2(DMA_channel_0[5:4]), 
    .in3(DMA_channel_0[7:6]), 
    .in4(DMA_channel_0[9:8]), 
    .in5(DMA_channel_0[11:10]), 
    .in6(DMA_channel_0[13:12]), 
    .in7(DMA_channel_0[15:14]),
    .out(channel_0_PE_out[0])
);

PE   Channel_0_PE_1
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_0_1[0]), 
    .weight1(secondary_channel_PE_0_1[1]), 
    .weight2(secondary_channel_PE_0_1[2]), 
    .weight3(secondary_channel_PE_0_1[3]), 
    .weight4(secondary_channel_PE_0_1[4]), 
    .weight5(secondary_channel_PE_0_1[5]), 
    .weight6(secondary_channel_PE_0_1[6]), 
    .weight7(secondary_channel_PE_0_1[7]),
    .in0(DMA_channel_0[17:16]), 
    .in1(DMA_channel_0[19:18]), 
    .in2(DMA_channel_0[21:20]), 
    .in3(DMA_channel_0[23:22]), 
    .in4(DMA_channel_0[25:24]), 
    .in5(DMA_channel_0[27:26]), 
    .in6(DMA_channel_0[29:28]), 
    .in7(DMA_channel_0[31:30]),
    .out(channel_0_PE_out[1])
);

PE   Channel_0_PE_2
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_0_2[0]), 
    .weight1(secondary_channel_PE_0_2[1]), 
    .weight2(secondary_channel_PE_0_2[2]), 
    .weight3(secondary_channel_PE_0_2[3]), 
    .weight4(secondary_channel_PE_0_2[4]), 
    .weight5(secondary_channel_PE_0_2[5]), 
    .weight6(secondary_channel_PE_0_2[6]), 
    .weight7(secondary_channel_PE_0_2[7]),
    .in0(DMA_channel_0[33:32]), 
    .in1(DMA_channel_0[35:34]), 
    .in2(DMA_channel_0[37:36]), 
    .in3(DMA_channel_0[39:38]), 
    .in4(DMA_channel_0[41:40]), 
    .in5(DMA_channel_0[43:42]), 
    .in6(DMA_channel_0[45:44]), 
    .in7(DMA_channel_0[47:46]),
    .out(channel_0_PE_out[2])
);

PE   Channel_0_PE_3
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_0_3[0]), 
    .weight1(secondary_channel_PE_0_3[1]), 
    .weight2(secondary_channel_PE_0_3[2]), 
    .weight3(secondary_channel_PE_0_3[3]), 
    .weight4(secondary_channel_PE_0_3[4]), 
    .weight5(secondary_channel_PE_0_3[5]), 
    .weight6(secondary_channel_PE_0_3[6]), 
    .weight7(secondary_channel_PE_0_3[7]),
    .in0(DMA_channel_0[49:48]), 
    .in1(DMA_channel_0[51:50]), 
    .in2(DMA_channel_0[53:52]), 
    .in3(DMA_channel_0[55:54]), 
    .in4(DMA_channel_0[57:56]), 
    .in5(DMA_channel_0[59:58]), 
    .in6(DMA_channel_0[61:60]), 
    .in7(DMA_channel_0[63:62]),
    .out(channel_0_PE_out[3])
);

circular_buffer_var #(0) PE_buffer_0_0  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_0_0[0]),
    .read_data_2(secondary_channel_PE_0_0[1]),
    .read_data_3(secondary_channel_PE_0_0[2]),
    .read_data_4(secondary_channel_PE_0_0[3]),
    .read_data_5(secondary_channel_PE_0_0[4]),
    .read_data_6(secondary_channel_PE_0_0[5]),
    .read_data_7(secondary_channel_PE_0_0[6]),
    .read_data_8(secondary_channel_PE_0_0[7])
);

circular_buffer_var #(64) PE_buffer_0_1  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_0_1[0]),
    .read_data_2(secondary_channel_PE_0_1[1]),
    .read_data_3(secondary_channel_PE_0_1[2]),
    .read_data_4(secondary_channel_PE_0_1[3]),
    .read_data_5(secondary_channel_PE_0_1[4]),
    .read_data_6(secondary_channel_PE_0_1[5]),
    .read_data_7(secondary_channel_PE_0_1[6]),
    .read_data_8(secondary_channel_PE_0_1[7])
);

circular_buffer_var #(128) PE_buffer_0_2  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_0_2[0]),
    .read_data_2(secondary_channel_PE_0_2[1]),
    .read_data_3(secondary_channel_PE_0_2[2]),
    .read_data_4(secondary_channel_PE_0_2[3]),
    .read_data_5(secondary_channel_PE_0_2[4]),
    .read_data_6(secondary_channel_PE_0_2[5]),
    .read_data_7(secondary_channel_PE_0_2[6]),
    .read_data_8(secondary_channel_PE_0_2[7])
);

circular_buffer_var #(192) PE_buffer_0_3  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_0_3[0]),
    .read_data_2(secondary_channel_PE_0_3[1]),
    .read_data_3(secondary_channel_PE_0_3[2]),
    .read_data_4(secondary_channel_PE_0_3[3]),
    .read_data_5(secondary_channel_PE_0_3[4]),
    .read_data_6(secondary_channel_PE_0_3[5]),
    .read_data_7(secondary_channel_PE_0_3[6]),
    .read_data_8(secondary_channel_PE_0_3[7])
);


// channel 1

wire [15:0] secondary_channel_PE_1_0 [7:0];
wire [15:0] secondary_channel_PE_1_1 [7:0];
wire [15:0] secondary_channel_PE_1_2 [7:0];
wire [15:0] secondary_channel_PE_1_3 [7:0];



PE   Channel_1_PE_0
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_1_0[0]), 
    .weight1(secondary_channel_PE_1_0[1]), 
    .weight2(secondary_channel_PE_1_0[2]), 
    .weight3(secondary_channel_PE_1_0[3]), 
    .weight4(secondary_channel_PE_1_0[4]), 
    .weight5(secondary_channel_PE_1_0[5]), 
    .weight6(secondary_channel_PE_1_0[6]), 
    .weight7(secondary_channel_PE_1_0[7]),
    .in0(DMA_channel_1[1:0]), 
    .in1(DMA_channel_1[3:2]), 
    .in2(DMA_channel_1[5:4]), 
    .in3(DMA_channel_1[7:6]), 
    .in4(DMA_channel_1[9:8]), 
    .in5(DMA_channel_1[11:10]), 
    .in6(DMA_channel_1[13:12]), 
    .in7(DMA_channel_1[15:14]),
    .out(channel_1_PE_out[0])
);

PE   Channel_1_PE_1
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_1_1[0]), 
    .weight1(secondary_channel_PE_1_1[1]), 
    .weight2(secondary_channel_PE_1_1[2]), 
    .weight3(secondary_channel_PE_1_1[3]), 
    .weight4(secondary_channel_PE_1_1[4]), 
    .weight5(secondary_channel_PE_1_1[5]), 
    .weight6(secondary_channel_PE_1_1[6]), 
    .weight7(secondary_channel_PE_1_1[7]),
    .in0(DMA_channel_1[17:16]), 
    .in1(DMA_channel_1[19:18]), 
    .in2(DMA_channel_1[21:20]), 
    .in3(DMA_channel_1[23:22]), 
    .in4(DMA_channel_1[25:24]), 
    .in5(DMA_channel_1[27:26]), 
    .in6(DMA_channel_1[29:28]), 
    .in7(DMA_channel_1[31:30]),
    .out(channel_1_PE_out[1])
);

PE   Channel_1_PE_2
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_1_2[0]), 
    .weight1(secondary_channel_PE_1_2[1]), 
    .weight2(secondary_channel_PE_1_2[2]), 
    .weight3(secondary_channel_PE_1_2[3]), 
    .weight4(secondary_channel_PE_1_2[4]), 
    .weight5(secondary_channel_PE_1_2[5]), 
    .weight6(secondary_channel_PE_1_2[6]), 
    .weight7(secondary_channel_PE_1_2[7]),
    .in0(DMA_channel_1[33:32]), 
    .in1(DMA_channel_1[35:34]), 
    .in2(DMA_channel_1[37:36]), 
    .in3(DMA_channel_1[39:38]), 
    .in4(DMA_channel_1[41:40]), 
    .in5(DMA_channel_1[43:42]), 
    .in6(DMA_channel_1[45:44]), 
    .in7(DMA_channel_1[47:46]),
    .out(channel_1_PE_out[2])
);

PE   Channel_1_PE_3
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_1_3[0]), 
    .weight1(secondary_channel_PE_1_3[1]), 
    .weight2(secondary_channel_PE_1_3[2]), 
    .weight3(secondary_channel_PE_1_3[3]), 
    .weight4(secondary_channel_PE_1_3[4]), 
    .weight5(secondary_channel_PE_1_3[5]), 
    .weight6(secondary_channel_PE_1_3[6]), 
    .weight7(secondary_channel_PE_1_3[7]),
    .in0(DMA_channel_1[49:48]), 
    .in1(DMA_channel_1[51:50]), 
    .in2(DMA_channel_1[53:52]), 
    .in3(DMA_channel_1[55:54]), 
    .in4(DMA_channel_1[57:56]), 
    .in5(DMA_channel_1[59:58]), 
    .in6(DMA_channel_1[61:60]), 
    .in7(DMA_channel_1[63:62]),
    .out(channel_1_PE_out[3])
);


circular_buffer_var #(256) PE_buffer_1_0  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_1_0[0]),
    .read_data_2(secondary_channel_PE_1_0[1]),
    .read_data_3(secondary_channel_PE_1_0[2]),
    .read_data_4(secondary_channel_PE_1_0[3]),
    .read_data_5(secondary_channel_PE_1_0[4]),
    .read_data_6(secondary_channel_PE_1_0[5]),
    .read_data_7(secondary_channel_PE_1_0[6]),
    .read_data_8(secondary_channel_PE_1_0[7])
);

circular_buffer_var #(320) PE_buffer_1_1  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_1_1[0]),
    .read_data_2(secondary_channel_PE_1_1[1]),
    .read_data_3(secondary_channel_PE_1_1[2]),
    .read_data_4(secondary_channel_PE_1_1[3]),
    .read_data_5(secondary_channel_PE_1_1[4]),
    .read_data_6(secondary_channel_PE_1_1[5]),
    .read_data_7(secondary_channel_PE_1_1[6]),
    .read_data_8(secondary_channel_PE_1_1[7])
);

circular_buffer_var #(384) PE_buffer_1_2  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_1_2[0]),
    .read_data_2(secondary_channel_PE_1_2[1]),
    .read_data_3(secondary_channel_PE_1_2[2]),
    .read_data_4(secondary_channel_PE_1_2[3]),
    .read_data_5(secondary_channel_PE_1_2[4]),
    .read_data_6(secondary_channel_PE_1_2[5]),
    .read_data_7(secondary_channel_PE_1_2[6]),
    .read_data_8(secondary_channel_PE_1_2[7])
);

circular_buffer_var #(448) PE_buffer_1_3  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_1_3[0]),
    .read_data_2(secondary_channel_PE_1_3[1]),
    .read_data_3(secondary_channel_PE_1_3[2]),
    .read_data_4(secondary_channel_PE_1_3[3]),
    .read_data_5(secondary_channel_PE_1_3[4]),
    .read_data_6(secondary_channel_PE_1_3[5]),
    .read_data_7(secondary_channel_PE_1_3[6]),
    .read_data_8(secondary_channel_PE_1_3[7])
);


// channel 2

wire [15:0] secondary_channel_PE_2_0 [7:0];
wire [15:0] secondary_channel_PE_2_1 [7:0];
wire [15:0] secondary_channel_PE_2_2 [7:0];
wire [15:0] secondary_channel_PE_2_3 [7:0];


PE   Channel_2_PE_0
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_2_0[0]), 
    .weight1(secondary_channel_PE_2_0[1]), 
    .weight2(secondary_channel_PE_2_0[2]), 
    .weight3(secondary_channel_PE_2_0[3]), 
    .weight4(secondary_channel_PE_2_0[4]), 
    .weight5(secondary_channel_PE_2_0[5]), 
    .weight6(secondary_channel_PE_2_0[6]), 
    .weight7(secondary_channel_PE_2_0[7]),
    .in0(DMA_channel_2[1:0]), 
    .in1(DMA_channel_2[3:2]), 
    .in2(DMA_channel_2[5:4]), 
    .in3(DMA_channel_2[7:6]), 
    .in4(DMA_channel_2[9:8]), 
    .in5(DMA_channel_2[11:10]), 
    .in6(DMA_channel_2[13:12]), 
    .in7(DMA_channel_2[15:14]),
    .out(channel_2_PE_out[0])
);

PE   Channel_2_PE_1
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_2_1[0]), 
    .weight1(secondary_channel_PE_2_1[1]), 
    .weight2(secondary_channel_PE_2_1[2]), 
    .weight3(secondary_channel_PE_2_1[3]), 
    .weight4(secondary_channel_PE_2_1[4]), 
    .weight5(secondary_channel_PE_2_1[5]), 
    .weight6(secondary_channel_PE_2_1[6]), 
    .weight7(secondary_channel_PE_2_1[7]),
    .in0(DMA_channel_1[17:16]), 
    .in1(DMA_channel_1[19:18]), 
    .in2(DMA_channel_1[21:20]), 
    .in3(DMA_channel_1[23:22]), 
    .in4(DMA_channel_1[25:24]), 
    .in5(DMA_channel_1[27:26]), 
    .in6(DMA_channel_1[29:28]), 
    .in7(DMA_channel_1[31:30]),
    .out(channel_2_PE_out[1])
);

PE   Channel_2_PE_2
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_2_2[0]), 
    .weight1(secondary_channel_PE_2_2[1]), 
    .weight2(secondary_channel_PE_2_2[2]), 
    .weight3(secondary_channel_PE_2_2[3]), 
    .weight4(secondary_channel_PE_2_2[4]), 
    .weight5(secondary_channel_PE_2_2[5]), 
    .weight6(secondary_channel_PE_2_2[6]), 
    .weight7(secondary_channel_PE_2_2[7]),
    .in0(DMA_channel_2[33:32]), 
    .in1(DMA_channel_2[35:34]), 
    .in2(DMA_channel_2[37:36]), 
    .in3(DMA_channel_2[39:38]), 
    .in4(DMA_channel_2[41:40]), 
    .in5(DMA_channel_2[43:42]), 
    .in6(DMA_channel_2[45:44]), 
    .in7(DMA_channel_2[47:46]),
    .out(channel_2_PE_out[2])
);

PE   Channel_2_PE_3
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_2_3[0]), 
    .weight1(secondary_channel_PE_2_3[1]), 
    .weight2(secondary_channel_PE_2_3[2]), 
    .weight3(secondary_channel_PE_2_3[3]), 
    .weight4(secondary_channel_PE_2_3[4]), 
    .weight5(secondary_channel_PE_2_3[5]), 
    .weight6(secondary_channel_PE_2_3[6]), 
    .weight7(secondary_channel_PE_2_3[7]),
    .in0(DMA_channel_2[49:48]), 
    .in1(DMA_channel_2[51:50]), 
    .in2(DMA_channel_2[53:52]), 
    .in3(DMA_channel_2[55:54]), 
    .in4(DMA_channel_2[57:56]), 
    .in5(DMA_channel_2[59:58]), 
    .in6(DMA_channel_2[61:60]), 
    .in7(DMA_channel_2[63:62]),
    .out(channel_2_PE_out[3])
);


circular_buffer_var #(512) PE_buffer_2_0  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_2_0[0]),
    .read_data_2(secondary_channel_PE_2_0[1]),
    .read_data_3(secondary_channel_PE_2_0[2]),
    .read_data_4(secondary_channel_PE_2_0[3]),
    .read_data_5(secondary_channel_PE_2_0[4]),
    .read_data_6(secondary_channel_PE_2_0[5]),
    .read_data_7(secondary_channel_PE_2_0[6]),
    .read_data_8(secondary_channel_PE_2_0[7])
);

circular_buffer_var #(576) PE_buffer_2_1  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_2_1[0]),
    .read_data_2(secondary_channel_PE_2_1[1]),
    .read_data_3(secondary_channel_PE_2_1[2]),
    .read_data_4(secondary_channel_PE_2_1[3]),
    .read_data_5(secondary_channel_PE_2_1[4]),
    .read_data_6(secondary_channel_PE_2_1[5]),
    .read_data_7(secondary_channel_PE_2_1[6]),
    .read_data_8(secondary_channel_PE_2_1[7])
);

circular_buffer_var #(640) PE_buffer_2_2  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_2_2[0]),
    .read_data_2(secondary_channel_PE_2_2[1]),
    .read_data_3(secondary_channel_PE_2_2[2]),
    .read_data_4(secondary_channel_PE_2_2[3]),
    .read_data_5(secondary_channel_PE_2_2[4]),
    .read_data_6(secondary_channel_PE_2_2[5]),
    .read_data_7(secondary_channel_PE_2_2[6]),
    .read_data_8(secondary_channel_PE_2_2[7])
);

circular_buffer_var #(704) PE_buffer_2_3  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_2_3[0]),
    .read_data_2(secondary_channel_PE_2_3[1]),
    .read_data_3(secondary_channel_PE_2_3[2]),
    .read_data_4(secondary_channel_PE_2_3[3]),
    .read_data_5(secondary_channel_PE_2_3[4]),
    .read_data_6(secondary_channel_PE_2_3[5]),
    .read_data_7(secondary_channel_PE_2_3[6]),
    .read_data_8(secondary_channel_PE_2_3[7])
);




// channel 3

wire [15:0] secondary_channel_PE_3_0 [7:0];
wire [15:0] secondary_channel_PE_3_1 [7:0];
wire [15:0] secondary_channel_PE_3_2 [7:0];
wire [15:0] secondary_channel_PE_3_3 [7:0];


PE  Channel_3_PE_0
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_3_0[0]), 
    .weight1(secondary_channel_PE_3_0[1]), 
    .weight2(secondary_channel_PE_3_0[2]), 
    .weight3(secondary_channel_PE_3_0[3]), 
    .weight4(secondary_channel_PE_3_0[4]), 
    .weight5(secondary_channel_PE_3_0[5]), 
    .weight6(secondary_channel_PE_3_0[6]), 
    .weight7(secondary_channel_PE_3_0[7]),
    .in0(DMA_channel_3[1:0]), 
    .in1(DMA_channel_3[3:2]), 
    .in2(DMA_channel_3[5:4]), 
    .in3(DMA_channel_3[7:6]), 
    .in4(DMA_channel_3[9:8]), 
    .in5(DMA_channel_3[11:10]), 
    .in6(DMA_channel_3[13:12]), 
    .in7(DMA_channel_3[15:14]),
    .out(channel_3_PE_out[0])
);

PE   Channel_3_PE_1
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_3_1[0]), 
    .weight1(secondary_channel_PE_3_1[1]), 
    .weight2(secondary_channel_PE_3_1[2]), 
    .weight3(secondary_channel_PE_3_1[3]), 
    .weight4(secondary_channel_PE_3_1[4]), 
    .weight5(secondary_channel_PE_3_1[5]), 
    .weight6(secondary_channel_PE_3_1[6]), 
    .weight7(secondary_channel_PE_3_1[7]),
    .in0(DMA_channel_3[17:16]), 
    .in1(DMA_channel_3[19:18]), 
    .in2(DMA_channel_3[21:20]), 
    .in3(DMA_channel_3[23:22]), 
    .in4(DMA_channel_3[25:24]), 
    .in5(DMA_channel_3[27:26]), 
    .in6(DMA_channel_3[29:28]), 
    .in7(DMA_channel_3[31:30]),
    .out(channel_3_PE_out[1])
);

PE   Channel_3_PE_2
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_3_2[0]), 
    .weight1(secondary_channel_PE_3_2[1]), 
    .weight2(secondary_channel_PE_3_2[2]), 
    .weight3(secondary_channel_PE_3_2[3]), 
    .weight4(secondary_channel_PE_3_2[4]), 
    .weight5(secondary_channel_PE_3_2[5]), 
    .weight6(secondary_channel_PE_3_2[6]), 
    .weight7(secondary_channel_PE_3_2[7]),
    .in0(DMA_channel_3[33:32]), 
    .in1(DMA_channel_3[35:34]), 
    .in2(DMA_channel_3[37:36]), 
    .in3(DMA_channel_3[39:38]), 
    .in4(DMA_channel_3[41:40]), 
    .in5(DMA_channel_3[43:42]), 
    .in6(DMA_channel_3[45:44]), 
    .in7(DMA_channel_3[47:46]),
    .out(channel_3_PE_out[2])
);

PE   Channel_3_PE_3
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .weight0(secondary_channel_PE_3_3[0]), 
    .weight1(secondary_channel_PE_3_3[1]), 
    .weight2(secondary_channel_PE_3_3[2]), 
    .weight3(secondary_channel_PE_3_3[3]), 
    .weight4(secondary_channel_PE_3_3[4]), 
    .weight5(secondary_channel_PE_3_3[5]), 
    .weight6(secondary_channel_PE_3_3[6]), 
    .weight7(secondary_channel_PE_3_3[7]),
    .in0(DMA_channel_3[49:48]), 
    .in1(DMA_channel_3[51:50]), 
    .in2(DMA_channel_3[53:52]), 
    .in3(DMA_channel_3[55:54]), 
    .in4(DMA_channel_3[57:56]), 
    .in5(DMA_channel_3[59:58]), 
    .in6(DMA_channel_3[61:60]), 
    .in7(DMA_channel_3[63:62]),
    .out(channel_3_PE_out[3])
);


circular_buffer_var #(768) PE_buffer_3_0  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_3_0[0]),
    .read_data_2(secondary_channel_PE_3_0[1]),
    .read_data_3(secondary_channel_PE_3_0[2]),
    .read_data_4(secondary_channel_PE_3_0[3]),
    .read_data_5(secondary_channel_PE_3_0[4]),
    .read_data_6(secondary_channel_PE_3_0[5]),
    .read_data_7(secondary_channel_PE_3_0[6]),
    .read_data_8(secondary_channel_PE_3_0[7])
);

circular_buffer_var #(832) PE_buffer_3_1  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_3_1[0]),
    .read_data_2(secondary_channel_PE_3_1[1]),
    .read_data_3(secondary_channel_PE_3_1[2]),
    .read_data_4(secondary_channel_PE_3_1[3]),
    .read_data_5(secondary_channel_PE_3_1[4]),
    .read_data_6(secondary_channel_PE_3_1[5]),
    .read_data_7(secondary_channel_PE_3_1[6]),
    .read_data_8(secondary_channel_PE_3_1[7])
);

circular_buffer_var #(896) PE_buffer_3_2  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_3_2[0]),
    .read_data_2(secondary_channel_PE_3_2[1]),
    .read_data_3(secondary_channel_PE_3_2[2]),
    .read_data_4(secondary_channel_PE_3_2[3]),
    .read_data_5(secondary_channel_PE_3_2[4]),
    .read_data_6(secondary_channel_PE_3_2[5]),
    .read_data_7(secondary_channel_PE_3_2[6]),
    .read_data_8(secondary_channel_PE_3_2[7])
);

circular_buffer_var #(960) PE_buffer_3_3  (
    .clk(clk),
    .rst(rst),
    .read_en(read_en),
    .read_data_1(secondary_channel_PE_3_3[0]),
    .read_data_2(secondary_channel_PE_3_3[1]),
    .read_data_3(secondary_channel_PE_3_3[2]),
    .read_data_4(secondary_channel_PE_3_3[3]),
    .read_data_5(secondary_channel_PE_3_3[4]),
    .read_data_6(secondary_channel_PE_3_3[5]),
    .read_data_7(secondary_channel_PE_3_3[6]),
    .read_data_8(secondary_channel_PE_3_3[7])
);




// converging the result from each PE

// channel 0 partial result
wire [15:0]channel_0_PE_0_1_out;
wire [15:0]channel_0_PE_2_3_out;
wire [15:0]channel_0_PE_0_1_out_reg;
wire [15:0]channel_0_PE_2_3_out_reg;
wire [15:0]channel_0_out;
wire [15:0]channel_0_out_reg;


assign channel_0_PE_0_1_out = channel_0_PE_out[0]+channel_0_PE_out[1];
assign channel_0_PE_2_3_out = channel_0_PE_out[2]+channel_0_PE_out[3];

register ch_0_reg_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_0_PE_0_1_out), .q(channel_0_PE_0_1_out_reg));
register ch_0_reg_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_0_PE_2_3_out), .q(channel_0_PE_2_3_out_reg));

assign channel_0_out = channel_0_PE_0_1_out_reg + channel_0_PE_2_3_out_reg;
register ch_0_reg_out (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_0_out), .q(channel_0_out_reg));

// channel 1 partial result
wire [15:0]channel_1_PE_0_1_out;
wire [15:0]channel_1_PE_2_3_out;
wire [15:0]channel_1_PE_0_1_out_reg;
wire [15:0]channel_1_PE_2_3_out_reg;
wire [15:0]channel_1_out;
wire [15:0]channel_1_out_reg;


assign channel_1_PE_0_1_out = channel_1_PE_out[0]+channel_1_PE_out[1];
assign channel_1_PE_2_3_out = channel_1_PE_out[2]+channel_1_PE_out[3];

register ch_1_reg_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_1_PE_0_1_out), .q(channel_1_PE_0_1_out_reg));
register ch_1_reg_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_1_PE_2_3_out), .q(channel_1_PE_2_3_out_reg));

assign channel_1_out = channel_1_PE_0_1_out_reg + channel_1_PE_2_3_out_reg;
register ch_1_reg_out (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_1_out), .q(channel_1_out_reg));


// channel 2 partial result
wire [15:0]channel_2_PE_0_1_out;
wire [15:0]channel_2_PE_2_3_out;
wire [15:0]channel_2_PE_0_1_out_reg;
wire [15:0]channel_2_PE_2_3_out_reg;
wire [15:0]channel_2_out;
wire [15:0]channel_2_out_reg;


assign channel_2_PE_0_1_out = channel_2_PE_out[0]+channel_2_PE_out[1];
assign channel_2_PE_2_3_out = channel_2_PE_out[2]+channel_2_PE_out[3];

register ch_2_reg_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_2_PE_0_1_out), .q(channel_2_PE_0_1_out_reg));
register ch_2_reg_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_2_PE_2_3_out), .q(channel_2_PE_2_3_out_reg));

assign channel_2_out = channel_2_PE_0_1_out_reg + channel_2_PE_2_3_out_reg;
register ch_2_reg_out (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_2_out), .q(channel_2_out_reg));



// channel 3 partial result
wire [15:0]channel_3_PE_0_1_out;
wire [15:0]channel_3_PE_2_3_out;
wire [15:0]channel_3_PE_0_1_out_reg;
wire [15:0]channel_3_PE_2_3_out_reg;
wire [15:0]channel_3_out;
wire [15:0]channel_3_out_reg;


assign channel_3_PE_0_1_out = channel_3_PE_out[0]+channel_3_PE_out[1];
assign channel_3_PE_2_3_out = channel_3_PE_out[2]+channel_3_PE_out[3];

register ch_3_reg_0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_3_PE_0_1_out), .q(channel_3_PE_0_1_out_reg));
register ch_3_reg_1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_3_PE_2_3_out), .q(channel_3_PE_2_3_out_reg));

assign channel_3_out = channel_3_PE_0_1_out_reg + channel_3_PE_2_3_out_reg;
register ch_3_reg_out (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_3_out), .q(channel_3_out_reg));

// adding each channel partial result together
wire [15:0] channel_0_1_out;
wire [15:0] channel_2_3_out;
wire [15:0] channel_0_1_out_reg;
wire [15:0] channel_2_3_out_reg;

assign channel_0_1_out = channel_0_out_reg + channel_1_out_reg;
assign channel_2_3_out = channel_2_out_reg + channel_3_out_reg;

register ch_0_1_reg_out (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_0_1_out), .q(channel_0_1_out_reg));
register ch_2_3_reg_out (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(channel_2_3_out), .q(channel_2_3_out_reg));

//last stage of partial result
wire [15:0] channel_0_1_2_3_out;

assign channel_0_1_2_3_out = channel_0_1_out_reg + channel_2_3_out_reg;

//entering recursive adding stage

wire done; //unconnected
wire [15:0] data_out;

buffer buffer_0(
.data_in(channel_0_1_2_3_out),
.clk(clk),
.rst_n(rst_n),
.done(done),
.data_out(data_out)
);

// adding bias
always @(posedge clk) begin

if (done) begin
 dot_product <= data_out + bias;
end

else begin
 dot_product <= 0;
end

end

endmodule

