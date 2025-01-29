module mac_array_tb_2 ();

reg clk;
reg rst;


reg [63:0]DMA_channel_0; // input stream DMA channel 0
reg [63:0]DMA_channel_1; // input stream DMA channel 1
reg [63:0]DMA_channel_2; // input stream DMA channel 2
reg [63:0]DMA_channel_3; // input stream DMA [511:0] secondary_channel_0,
reg rst_n;
reg en;
reg clr;
reg [15:0] bias_1;
reg [15:0] bias_2;
wire [15:0]dot_product_1;
wire [15:0]dot_product_2; 

reg read_en;

initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
end


initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(0, mac_array_tb_2);
		#1600 //$stop;   // Stop simulation after 100ns
		$finish;
    end

//stimulus
 MAC_array MAC_0(

.DMA_channel_0(DMA_channel_0), // input stream DMA channel 0
.DMA_channel_1(DMA_channel_1), // input stream DMA channel 1
.DMA_channel_2(DMA_channel_2), // input stream DMA channel 2
.DMA_channel_3(DMA_channel_3), // input stream DMA [511:0] secondary_channel_0, 
.rst_n(rst_n),
.clk(clk),
.en(en),
.clr(clr),
.bias(bias_1),
.dot_product(dot_product_1),
.read_en(read_en)

);

 MAC_array_var MAC_1(

.DMA_channel_0(DMA_channel_0), // input stream DMA channel 0
.DMA_channel_1(DMA_channel_1), // input stream DMA channel 1
.DMA_channel_2(DMA_channel_2), // input stream DMA channel 2
.DMA_channel_3(DMA_channel_3), // input stream DMA [511:0] secondary_channel_0, 
.rst_n(rst_n),
.clk(clk),
.en(en),
.clr(clr),
.bias(bias_2),
.dot_product(dot_product_2),
.read_en(read_en)

);



initial begin
rst_n <= 0;
read_en <= 0;
en <= 0;
clr <= 1;
#5 rst_n <=1;
en <= 1;
read_en <= 1;
clr <= 0;
bias_1 <= 16'h0000;
bias_2 <= 16'h0000;
// DMA_channel_0 = 64'b1010101010101010101010101010101010101010101010101010101010101010;
DMA_channel_0 = 64'b0000000000000000000000000000000000000000000000000000000000000001;
DMA_channel_1 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
DMA_channel_2 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
DMA_channel_3 = 64'b0000000000000000000000000000000000000000000000000000000000000000;

end


endmodule