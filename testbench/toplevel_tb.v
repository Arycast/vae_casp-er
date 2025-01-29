module toplevel_tb ();

reg clk;
reg [63:0]DMA_channel_0; // input stream DMA channel 0
reg [63:0]DMA_channel_1; // input stream DMA channel 1
reg [63:0]DMA_channel_2; // input stream DMA channel 2
reg [63:0]DMA_channel_3; // input stream DMA [511:0] secondary_channel_0,
reg rst_n;
reg en;
reg clr;
reg [15:0] bias;
wire [15:0] result;
wire done;
reg read_en;
reg op_mode;

initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
end


initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(0, toplevel_tb);
		#1600 //$stop;   // Stop simulation after 100ns
		$finish;
    end


toplevel top_0(

.DMA_channel_0(DMA_channel_0), // input stream DMA channel 0
.DMA_channel_1(DMA_channel_1), // input stream DMA channel 1
.DMA_channel_2(DMA_channel_2), // input stream DMA channel 2
.DMA_channel_3(DMA_channel_3), // input stream DMA channel 3

.bias(bias), // input bias from cache
.done(done),
.clk(clk),
.rst_n(rst_n),
.en(en),
.clr(clr),
.read_en(read_en),
.op_mode(op_mode),
.result(result)

);



initial begin
rst_n <= 0;
read_en <= 0;
en <= 0;
clr <= 1;
#5 rst_n <=1;
en <= 1;
op_mode <= 1;
read_en <= 1;
clr <= 0;
bias <= 16'h0000;
DMA_channel_0 = 64'b1010101010101010101010101010101010101010101010101010101010101010;
DMA_channel_1 = 64'b1010101010101010101010101010101010101010101010101010101010101010;
DMA_channel_2 = 64'b1010101010101010101010101010101010101010101010101010101010101010;
DMA_channel_3 = 64'b1010101010101010101010101010101010101010101010101010101010101010;

end


endmodule