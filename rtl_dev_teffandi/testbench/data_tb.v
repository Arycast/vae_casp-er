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

//  Temporary for testing
reg [63:0] temp1 [15:0]; 
reg [63:0] temp2 [15:0]; 
reg [63:0] temp3 [15:0]; 
reg [63:0] temp4 [15:0]; 

// Result hold
reg [15:0] resmu;
reg [15:0] resvar;

// Dot Product
wire [15:0] pre_activation;
reg [15:0] mu_preactivation;
reg [15:0] var_preactivation;

// Result
integer file,file_pre_activation;

initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
end


initial begin 
		$dumpfile("wave.vcd");
		$dumpvars(0, toplevel_tb);
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
.result(result),
.pre_activation(pre_activation)

);

initial begin
	$readmemb("input_bad1.txt",temp1, 0, 15);
	$readmemb("input_bad2.txt",temp2, 0, 15);
	$readmemb("input_bad3.txt",temp3, 0, 15);
	$readmemb("input_bad4.txt",temp4, 0, 15);
end


integer i;
integer j;


initial begin
file = $fopen("..\\python\\data_tb\\result.txt", "w");
file_pre_activation = $fopen("..\\python\\data_tb\\pre-activation_result.txt", "w");
#5;
rst_n <= 0;
read_en <= 0;
en <= 0;
clr <= 1;
#10; 
	for (j = 0; j < 2; j = j + 1) begin
		rst_n <= 0;
		read_en <= 0;
		en <= 0;
		clr <= 1;
		#10 rst_n <=1;
		en <= 1;
		op_mode <= 0;
		read_en <= 1;
		clr <= 0;
		bias <= 16'hf580;
		#10;
			for (i = 0; i < 8; i = i + 1) begin
			DMA_channel_0 = temp1[i+(j*8)];
			DMA_channel_1 = temp2[i+(j*8)];
			DMA_channel_2 = temp3[i+(j*8)];
			DMA_channel_3 = temp4[i+(j*8)];
			#10;
			end
		
		wait (done);
		wait (!done);
		#5;
		resmu = result;
		mu_preactivation = pre_activation;
		// $display("%h", resmu);
		#5;
		rst_n <= 0;
		read_en <= 0;
		en <= 0;
		clr <= 1;
		#10 rst_n <=1;
		en <= 1;
		op_mode <= 1;
		read_en <= 1;
		clr <= 0;
		bias <= 16'hffee;
		#10
			for (i = 0; i < 8; i = i + 1) begin
			DMA_channel_0 = temp1[i+(j*8)];
			DMA_channel_1 = temp2[i+(j*8)];
			DMA_channel_2 = temp3[i+(j*8)];
			DMA_channel_3 = temp4[i+(j*8)];
			#10;
			end

		wait (done);
		wait (!done);
		#5;
		resvar = result;
		var_preactivation = pre_activation;
		// $display("%h", resvar);
		$display("%h", resmu+resvar);
		$fwrite(file, "%h\n", resmu+resvar);
		$fwrite(file_pre_activation, "%h\n%h\n", mu_preactivation, var_preactivation);
		#5;
		
	end
	$fclose(file);
	$fclose(file_pre_activation);
	$finish;
end

endmodule