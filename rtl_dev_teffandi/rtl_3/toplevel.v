module toplevel(

input wire [63:0] DMA_channel_0, // input stream DMA channel 0
input wire [63:0] DMA_channel_1, // input stream DMA channel 1
input wire [63:0] DMA_channel_2, // input stream DMA channel 2
input wire [63:0] DMA_channel_3, // input stream DMA channel 3

input wire [15:0] bias, // input bias from cache
output wire [15:0] pre_activation,

input wire clk,
input wire rst_n,
input wire en,
input wire clr,
input wire read_en,
input wire op_mode,

output done,

output [15:0] result


);

wire [15:0] temp_1;

MAC_array MAC_0(
.DMA_channel_0(DMA_channel_0), // input stream DMA channel 0
.DMA_channel_1(DMA_channel_1), // input stream DMA channel 1
.DMA_channel_2(DMA_channel_2), // input stream DMA channel 2
.DMA_channel_3(DMA_channel_3), // input stream DMA channel 3
.bias(bias), // input bias from cache
.clk(clk),
.rst_n(rst_n),
.en(en),
.clr(clr),
.read_en(read_en),
.op_mode(op_mode),
.done(done),
.dot_product(temp_1)
);

mux_2_1 mux_0 (
    
   .input_1(temp_1), 
   .input_2(relu_to_mux),
   .select(op_mode),
   .out(out_mux_0)
);

mux_2_1 mux_1 (
    
   .input_1(out_mux_0), 
   .input_2(mult_to_mux),
   .select(op_mode),
   .out(pre_activation)
); 


 ReLu #(16) ReLu_0 (
   .val(temp_1),
   .result(relu_to_mux)
);

 XOR_RNG RNG_0(
    .clk(clk),          
    .rst(!rst_n),          
    .rand(temp_rand)    
);

mult mult_0 (
    
   .Operand_1({8'b00000000,temp_rand}), 
   .Operand_2(out_mux_0),
   .result(mult_to_mux)
);

//Dot to Relu and mux switches
wire [15:0] relu_to_mux;
wire [15:0] mult_to_mux;
wire [15:0] out_mux_0;
wire [7:0] temp_rand;


endmodule