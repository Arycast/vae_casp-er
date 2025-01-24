module mac_array_tb ();

reg clk;
reg rst;


reg [511:0]DMA_channel_0; // input stream DMA channel 0
reg [511:0]DMA_channel_1; // input stream DMA channel 1
reg [511:0]DMA_channel_2; // input stream DMA channel 2
reg [511:0]DMA_channel_3; // input stream DMA [511:0] secondary_channel_0,
reg [511:0]secondary_channel_0; // input BRAM channel 0
reg [511:0]secondary_channel_1; // input BRAM channel 1
reg [511:0]secondary_channel_2; // input BRAM channel 2
reg [511:0]secondary_channel_3; // input BRAM [15:0] bias, // input bias fclk,
reg rst_n;
reg en;
reg clr;
reg [15:0] bias;
wire [15:0]dot_product; 


initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
end


initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(0, mac_array_tb);
		#1600 //$stop;   // Stop simulation after 100ns
		$finish;
    end

//stimulus
 MAC_array MAC_0(

.DMA_channel_0(DMA_channel_0), // input stream DMA channel 0
.DMA_channel_1(DMA_channel_1), // input stream DMA channel 1
.DMA_channel_2(DMA_channel_2), // input stream DMA channel 2
.DMA_channel_3(DMA_channel_3), // input stream DMA [511:0] secondary_channel_0, 
.secondary_channel_0(secondary_channel_0), // input BRAM channel 0
.secondary_channel_1(secondary_channel_1), // input BRAM channel 1
.secondary_channel_2(secondary_channel_2), // input BRAM channel 2
.secondary_channel_3(secondary_channel_3), // input BRAM [15:0] bias, // input bias fclk,
.rst_n(rst_n),
.clk(clk),
.en(en),
.clr(clr),
.bias(bias),
.dot_product(dot_product)

);


initial begin
rst_n <= 0;
en <= 0;
clr <= 1;
#5 rst_n <=1;
en <= 1;
clr <= 0;
bias <= 16'h0010;
DMA_channel_0 = 512'h01000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100;
DMA_channel_1 = 512'h01000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100;
DMA_channel_2 = 512'h01000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100;
DMA_channel_3 = 512'h01000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100;
secondary_channel_0 = 512'h00010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001;
secondary_channel_1 = 512'h00010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001;
secondary_channel_2 = 512'h00010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001;
secondary_channel_3 = 512'h00010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001;

end


endmodule