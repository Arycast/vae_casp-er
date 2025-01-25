//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Multiplier Fixed Point
// Module Name : MAC_array
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module MAC_array(

input wire [511:0] DMA_channel_0, // input stream DMA channel 0
input wire [511:0] DMA_channel_1, // input stream DMA channel 1
input wire [511:0] DMA_channel_2, // input stream DMA channel 2
input wire [511:0] DMA_channel_3, // input stream DMA channel 3

input wire [511:0] secondary_channel_0, // input BRAM channel 0
input wire [511:0] secondary_channel_1, // input BRAM channel 1
input wire [511:0] secondary_channel_2, // input BRAM channel 2
input wire [511:0] secondary_channel_3, // input BRAM channel 3

input wire [15:0] bias, // input bias from cache

input wire clk,
input wire rst_n,
input wire en,
input wire clr,

output reg [15:0] dot_product

);

// PE output
wire [15:0] channel_0_PE_out[3:0];
wire [15:0] channel_1_PE_out[3:0];
wire [15:0] channel_2_PE_out[3:0];
wire [15:0] channel_3_PE_out[3:0];


// channel 0
PE  #(16) Channel_0_PE_0
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_0[15:0]), 
    .in1(secondary_channel_0[15+16:16]), 
    .in2(secondary_channel_0[15+16*2:16*2]), 
    .in3(secondary_channel_0[15+16*3:16*3]), 
    .in4(secondary_channel_0[15+16*4:16*4]), 
    .in5(secondary_channel_0[15+16*5:16*5]), 
    .in6(secondary_channel_0[15+16*6:16*6]), 
    .in7(secondary_channel_0[15+16*7:16*7]),
    .weight0(DMA_channel_0[15:0]), 
    .weight1(DMA_channel_0[15+16:16]), 
    .weight2(DMA_channel_0[15+16*2:16*2]), 
    .weight3(DMA_channel_0[15+16*3:16*3]), 
    .weight4(DMA_channel_0[15+16*4:16*4]), 
    .weight5(DMA_channel_0[15+16*5:16*5]), 
    .weight6(DMA_channel_0[15+16*6:16*6]), 
    .weight7(DMA_channel_0[15+16*7:16*7]),
    .out(channel_0_PE_out[0])
);

PE  #(16) Channel_0_PE_1
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_0[143:128]), 
    .in1(secondary_channel_0[143+16:128+16]), 
    .in2(secondary_channel_0[143+16*2:128+16*2]), 
    .in3(secondary_channel_0[143+16*3:128+16*3]), 
    .in4(secondary_channel_0[143+16*4:128+16*4]), 
    .in5(secondary_channel_0[143+16*5:128+16*5]), 
    .in6(secondary_channel_0[143+16*6:128+16*6]), 
    .in7(secondary_channel_0[143+16*7:128+16*7]),
    .weight0(DMA_channel_0[143:128]), 
    .weight1(DMA_channel_0[143+16:128+16]), 
    .weight2(DMA_channel_0[143+16*2:128+16*2]), 
    .weight3(DMA_channel_0[143+16*3:128+16*3]), 
    .weight4(DMA_channel_0[143+16*4:128+16*4]), 
    .weight5(DMA_channel_0[143+16*5:128+16*5]), 
    .weight6(DMA_channel_0[143+16*6:128+16*6]), 
    .weight7(DMA_channel_0[143+16*7:128+16*7]),
    .out(channel_0_PE_out[1])
);

PE  #(16) Channel_0_PE_2
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_0[271:256]), 
    .in1(secondary_channel_0[271+16:256+16]), 
    .in2(secondary_channel_0[271+16*2:256+16*2]), 
    .in3(secondary_channel_0[271+16*3:256+16*3]), 
    .in4(secondary_channel_0[271+16*4:256+16*4]), 
    .in5(secondary_channel_0[271+16*5:256+16*5]), 
    .in6(secondary_channel_0[271+16*6:256+16*6]), 
    .in7(secondary_channel_0[271+16*7:256+16*7]),
    .weight0(DMA_channel_0[271:256]), 
    .weight1(DMA_channel_0[271+16:256+16]), 
    .weight2(DMA_channel_0[271+16*2:256+16*2]), 
    .weight3(DMA_channel_0[271+16*3:256+16*3]), 
    .weight4(DMA_channel_0[271+16*4:256+16*4]), 
    .weight5(DMA_channel_0[271+16*5:256+16*5]), 
    .weight6(DMA_channel_0[271+16*6:256+16*6]), 
    .weight7(DMA_channel_0[271+16*7:256+16*7]),
    .out(channel_0_PE_out[2])
);

PE  #(16) Channel_0_PE_3
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_0[399:384]), 
    .in1(secondary_channel_0[399+16:384+16]), 
    .in2(secondary_channel_0[399+16*2:384+16*2]), 
    .in3(secondary_channel_0[399+16*3:384+16*3]), 
    .in4(secondary_channel_0[399+16*4:384+16*4]), 
    .in5(secondary_channel_0[399+16*5:384+16*5]), 
    .in6(secondary_channel_0[399+16*6:384+16*6]), 
    .in7(secondary_channel_0[399+16*7:384+16*7]),
    .weight0(DMA_channel_0[399:384]), 
    .weight1(DMA_channel_0[399+16:384+16]), 
    .weight2(DMA_channel_0[399+16*2:384+16*2]), 
    .weight3(DMA_channel_0[399+16*3:384+16*3]), 
    .weight4(DMA_channel_0[399+16*4:384+16*4]), 
    .weight5(DMA_channel_0[399+16*5:384+16*5]), 
    .weight6(DMA_channel_0[399+16*6:384+16*6]), 
    .weight7(DMA_channel_0[399+16*7:384+16*7]),
    .out(channel_0_PE_out[3])
);

// channel 1
PE  #(16) Channel_1_PE_0
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_1[15:0]), 
    .in1(secondary_channel_1[15+16:16]), 
    .in2(secondary_channel_1[15+16*2:16*2]), 
    .in3(secondary_channel_1[15+16*3:16*3]), 
    .in4(secondary_channel_1[15+16*4:16*4]), 
    .in5(secondary_channel_1[15+16*5:16*5]), 
    .in6(secondary_channel_1[15+16*6:16*6]), 
    .in7(secondary_channel_1[15+16*7:16*7]),
    .weight0(DMA_channel_1[15:0]), 
    .weight1(DMA_channel_1[15+16:16]), 
    .weight2(DMA_channel_1[15+16*2:16*2]), 
    .weight3(DMA_channel_1[15+16*3:16*3]), 
    .weight4(DMA_channel_1[15+16*4:16*4]), 
    .weight5(DMA_channel_1[15+16*5:16*5]), 
    .weight6(DMA_channel_1[15+16*6:16*6]), 
    .weight7(DMA_channel_1[15+16*7:16*7]),
    .out(channel_1_PE_out[0])
);

PE  #(16) Channel_1_PE_1
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_1[143:128]), 
    .in1(secondary_channel_1[143+16:128+16]), 
    .in2(secondary_channel_1[143+16*2:128+16*2]), 
    .in3(secondary_channel_1[143+16*3:128+16*3]), 
    .in4(secondary_channel_1[143+16*4:128+16*4]), 
    .in5(secondary_channel_1[143+16*5:128+16*5]), 
    .in6(secondary_channel_1[143+16*6:128+16*6]), 
    .in7(secondary_channel_1[143+16*7:128+16*7]),
    .weight0(DMA_channel_1[143:128]), 
    .weight1(DMA_channel_1[143+16:128+16]), 
    .weight2(DMA_channel_1[143+16*2:128+16*2]), 
    .weight3(DMA_channel_1[143+16*3:128+16*3]), 
    .weight4(DMA_channel_1[143+16*4:128+16*4]), 
    .weight5(DMA_channel_1[143+16*5:128+16*5]), 
    .weight6(DMA_channel_1[143+16*6:128+16*6]), 
    .weight7(DMA_channel_1[143+16*7:128+16*7]),
    .out(channel_1_PE_out[1])
);

PE  #(16) Channel_1_PE_2
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_1[271:256]), 
    .in1(secondary_channel_1[271+16:256+16]), 
    .in2(secondary_channel_1[271+16*2:256+16*2]), 
    .in3(secondary_channel_1[271+16*3:256+16*3]), 
    .in4(secondary_channel_1[271+16*4:256+16*4]), 
    .in5(secondary_channel_1[271+16*5:256+16*5]), 
    .in6(secondary_channel_1[271+16*6:256+16*6]), 
    .in7(secondary_channel_1[271+16*7:256+16*7]),
    .weight0(DMA_channel_1[271:256]), 
    .weight1(DMA_channel_1[271+16:256+16]), 
    .weight2(DMA_channel_1[271+16*2:256+16*2]), 
    .weight3(DMA_channel_1[271+16*3:256+16*3]), 
    .weight4(DMA_channel_1[271+16*4:256+16*4]), 
    .weight5(DMA_channel_1[271+16*5:256+16*5]), 
    .weight6(DMA_channel_1[271+16*6:256+16*6]), 
    .weight7(DMA_channel_1[271+16*7:256+16*7]),
    .out(channel_1_PE_out[2])
);

PE  #(16) Channel_1_PE_3
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_1[399:384]), 
    .in1(secondary_channel_1[399+16:384+16]), 
    .in2(secondary_channel_1[399+16*2:384+16*2]), 
    .in3(secondary_channel_1[399+16*3:384+16*3]), 
    .in4(secondary_channel_1[399+16*4:384+16*4]), 
    .in5(secondary_channel_1[399+16*5:384+16*5]), 
    .in6(secondary_channel_1[399+16*6:384+16*6]), 
    .in7(secondary_channel_1[399+16*7:384+16*7]),
    .weight0(DMA_channel_1[399:384]), 
    .weight1(DMA_channel_1[399+16:384+16]), 
    .weight2(DMA_channel_1[399+16*2:384+16*2]), 
    .weight3(DMA_channel_1[399+16*3:384+16*3]), 
    .weight4(DMA_channel_1[399+16*4:384+16*4]), 
    .weight5(DMA_channel_1[399+16*5:384+16*5]), 
    .weight6(DMA_channel_1[399+16*6:384+16*6]), 
    .weight7(DMA_channel_1[399+16*7:384+16*7]),
    .out(channel_1_PE_out[3])
);


// channel 2
PE  #(16) Channel_2_PE_0
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_2[15:0]), 
    .in1(secondary_channel_2[15+16:16]), 
    .in2(secondary_channel_2[15+16*2:16*2]), 
    .in3(secondary_channel_2[15+16*3:16*3]), 
    .in4(secondary_channel_2[15+16*4:16*4]), 
    .in5(secondary_channel_2[15+16*5:16*5]), 
    .in6(secondary_channel_2[15+16*6:16*6]), 
    .in7(secondary_channel_2[15+16*7:16*7]),
    .weight0(DMA_channel_2[15:0]), 
    .weight1(DMA_channel_2[15+16:16]), 
    .weight2(DMA_channel_2[15+16*2:16*2]), 
    .weight3(DMA_channel_2[15+16*3:16*3]), 
    .weight4(DMA_channel_2[15+16*4:16*4]), 
    .weight5(DMA_channel_2[15+16*5:16*5]), 
    .weight6(DMA_channel_2[15+16*6:16*6]), 
    .weight7(DMA_channel_2[15+16*7:16*7]),
    .out(channel_2_PE_out[0])
);

PE  #(16) Channel_2_PE_1
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_2[143:128]), 
    .in1(secondary_channel_2[143+16:128+16]), 
    .in2(secondary_channel_2[143+16*2:128+16*2]), 
    .in3(secondary_channel_2[143+16*3:128+16*3]), 
    .in4(secondary_channel_2[143+16*4:128+16*4]), 
    .in5(secondary_channel_2[143+16*5:128+16*5]), 
    .in6(secondary_channel_2[143+16*6:128+16*6]), 
    .in7(secondary_channel_2[143+16*7:128+16*7]),
    .weight0(DMA_channel_2[143:128]), 
    .weight1(DMA_channel_2[143+16:128+16]), 
    .weight2(DMA_channel_2[143+16*2:128+16*2]), 
    .weight3(DMA_channel_2[143+16*3:128+16*3]), 
    .weight4(DMA_channel_2[143+16*4:128+16*4]), 
    .weight5(DMA_channel_2[143+16*5:128+16*5]), 
    .weight6(DMA_channel_2[143+16*6:128+16*6]), 
    .weight7(DMA_channel_2[143+16*7:128+16*7]),
    .out(channel_2_PE_out[1])
);

PE  #(16) Channel_2_PE_2
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_2[271:256]), 
    .in1(secondary_channel_2[271+16:256+16]), 
    .in2(secondary_channel_2[271+16*2:256+16*2]), 
    .in3(secondary_channel_2[271+16*3:256+16*3]), 
    .in4(secondary_channel_2[271+16*4:256+16*4]), 
    .in5(secondary_channel_2[271+16*5:256+16*5]), 
    .in6(secondary_channel_2[271+16*6:256+16*6]), 
    .in7(secondary_channel_2[271+16*7:256+16*7]),
    .weight0(DMA_channel_2[271:256]), 
    .weight1(DMA_channel_2[271+16:256+16]), 
    .weight2(DMA_channel_2[271+16*2:256+16*2]), 
    .weight3(DMA_channel_2[271+16*3:256+16*3]), 
    .weight4(DMA_channel_2[271+16*4:256+16*4]), 
    .weight5(DMA_channel_2[271+16*5:256+16*5]), 
    .weight6(DMA_channel_2[271+16*6:256+16*6]), 
    .weight7(DMA_channel_2[271+16*7:256+16*7]),
    .out(channel_2_PE_out[2])
);

PE  #(16) Channel_2_PE_3
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_2[399:384]), 
    .in1(secondary_channel_2[399+16:384+16]), 
    .in2(secondary_channel_2[399+16*2:384+16*2]), 
    .in3(secondary_channel_2[399+16*3:384+16*3]), 
    .in4(secondary_channel_2[399+16*4:384+16*4]), 
    .in5(secondary_channel_2[399+16*5:384+16*5]), 
    .in6(secondary_channel_2[399+16*6:384+16*6]), 
    .in7(secondary_channel_2[399+16*7:384+16*7]),
    .weight0(DMA_channel_2[399:384]), 
    .weight1(DMA_channel_2[399+16:384+16]), 
    .weight2(DMA_channel_2[399+16*2:384+16*2]), 
    .weight3(DMA_channel_2[399+16*3:384+16*3]), 
    .weight4(DMA_channel_2[399+16*4:384+16*4]), 
    .weight5(DMA_channel_2[399+16*5:384+16*5]), 
    .weight6(DMA_channel_2[399+16*6:384+16*6]), 
    .weight7(DMA_channel_2[399+16*7:384+16*7]),
    .out(channel_2_PE_out[3])
);



// channel 3
PE  #(16) Channel_3_PE_0
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_3[15:0]), 
    .in1(secondary_channel_3[15+16:16]), 
    .in2(secondary_channel_3[15+16*2:16*2]), 
    .in3(secondary_channel_3[15+16*3:16*3]), 
    .in4(secondary_channel_3[15+16*4:16*4]), 
    .in5(secondary_channel_3[15+16*5:16*5]), 
    .in6(secondary_channel_3[15+16*6:16*6]), 
    .in7(secondary_channel_3[15+16*7:16*7]),
    .weight0(DMA_channel_3[15:0]), 
    .weight1(DMA_channel_3[15+16:16]), 
    .weight2(DMA_channel_3[15+16*2:16*2]), 
    .weight3(DMA_channel_3[15+16*3:16*3]), 
    .weight4(DMA_channel_3[15+16*4:16*4]), 
    .weight5(DMA_channel_3[15+16*5:16*5]), 
    .weight6(DMA_channel_3[15+16*6:16*6]), 
    .weight7(DMA_channel_3[15+16*7:16*7]),
    .out(channel_3_PE_out[0])
);

PE  #(16) Channel_3_PE_1
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_3[143:128]), 
    .in1(secondary_channel_3[143+16:128+16]), 
    .in2(secondary_channel_3[143+16*2:128+16*2]), 
    .in3(secondary_channel_3[143+16*3:128+16*3]), 
    .in4(secondary_channel_3[143+16*4:128+16*4]), 
    .in5(secondary_channel_3[143+16*5:128+16*5]), 
    .in6(secondary_channel_3[143+16*6:128+16*6]), 
    .in7(secondary_channel_3[143+16*7:128+16*7]),
    .weight0(DMA_channel_3[143:128]), 
    .weight1(DMA_channel_3[143+16:128+16]), 
    .weight2(DMA_channel_3[143+16*2:128+16*2]), 
    .weight3(DMA_channel_3[143+16*3:128+16*3]), 
    .weight4(DMA_channel_3[143+16*4:128+16*4]), 
    .weight5(DMA_channel_3[143+16*5:128+16*5]), 
    .weight6(DMA_channel_3[143+16*6:128+16*6]), 
    .weight7(DMA_channel_3[143+16*7:128+16*7]),
    .out(channel_3_PE_out[1])
);

PE  #(16) Channel_3_PE_2
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_3[271:256]), 
    .in1(secondary_channel_3[271+16:256+16]), 
    .in2(secondary_channel_3[271+16*2:256+16*2]), 
    .in3(secondary_channel_3[271+16*3:256+16*3]), 
    .in4(secondary_channel_3[271+16*4:256+16*4]), 
    .in5(secondary_channel_3[271+16*5:256+16*5]), 
    .in6(secondary_channel_3[271+16*6:256+16*6]), 
    .in7(secondary_channel_3[271+16*7:256+16*7]),
    .weight0(DMA_channel_3[271:256]), 
    .weight1(DMA_channel_3[271+16:256+16]), 
    .weight2(DMA_channel_3[271+16*2:256+16*2]), 
    .weight3(DMA_channel_3[271+16*3:256+16*3]), 
    .weight4(DMA_channel_3[271+16*4:256+16*4]), 
    .weight5(DMA_channel_3[271+16*5:256+16*5]), 
    .weight6(DMA_channel_3[271+16*6:256+16*6]), 
    .weight7(DMA_channel_3[271+16*7:256+16*7]),
    .out(channel_3_PE_out[2])
);

PE  #(16) Channel_3_PE_3
(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .in0(secondary_channel_3[399:384]), 
    .in1(secondary_channel_3[399+16:384+16]), 
    .in2(secondary_channel_3[399+16*2:384+16*2]), 
    .in3(secondary_channel_3[399+16*3:384+16*3]), 
    .in4(secondary_channel_3[399+16*4:384+16*4]), 
    .in5(secondary_channel_3[399+16*5:384+16*5]), 
    .in6(secondary_channel_3[399+16*6:384+16*6]), 
    .in7(secondary_channel_3[399+16*7:384+16*7]),
    .weight0(DMA_channel_3[399:384]), 
    .weight1(DMA_channel_3[399+16:384+16]), 
    .weight2(DMA_channel_3[399+16*2:384+16*2]), 
    .weight3(DMA_channel_3[399+16*3:384+16*3]), 
    .weight4(DMA_channel_3[399+16*4:384+16*4]), 
    .weight5(DMA_channel_3[399+16*5:384+16*5]), 
    .weight6(DMA_channel_3[399+16*6:384+16*6]), 
    .weight7(DMA_channel_3[399+16*7:384+16*7]),
    .out(channel_3_PE_out[3])
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

