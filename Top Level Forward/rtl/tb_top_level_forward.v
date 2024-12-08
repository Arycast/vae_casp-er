module tb_top_level_forward;

	// Inputs
	reg clk;
	reg rst;

	reg [15:0] x1, x2, x3, x4, x5, x6, x7, x8, x9;
	reg [15:0] wc11, wc12, wc13, wc14, wc15, wc16, wc17, wc18, wc19;
	reg [15:0] wd11, wd12, wd13, wd14, wd15, wd16, wd17, wd18, wd19;
	reg [15:0] wc21, wc22, wc23, wc24, wc25, wc26, wc27, wc28, wc29;
	reg [15:0] wd21, wd22, wd23, wd24, wd25, wd26, wd27, wd28, wd29;
	reg [15:0] w11, w12;
	reg [15:0] w21, w22;
	reg [15:0] w31, w32;
	reg [15:0] w41, w42;
	reg [15:0] w51, w52;
	reg [15:0] w61, w62;
	reg [15:0] w71, w72;
	reg [15:0] w81, w82;
	reg [15:0] w91, w92;
	reg [15:0] b21, b22, b23, b24;
	reg [15:0] b31, b32, b33, b34, b35, b36, b37, b38, b39;
	// Output
	wire [15:0] out1;
	wire [15:0] out2;
	wire [15:0] out3;
	wire [15:0] out4;
	wire [15:0] out5;
	wire [15:0] out6;
	wire [15:0] out7;
	wire [15:0] out8;
	wire [15:0] out9;

	// Instantiate the Unit Under Test (UUT)
	top_level_forward #() uut (
		.clk(clk),.rst(rst),
		.x1(x1),.x2(x2),.x3(x3),.x4(x4),. x5(x5),.x6(x6),.x7(x7),.x8(x8),.x9(x9),
		.wc11(wc11),.wc12(wc12),.wc13(wc13),.wc14(wc14),.wc15(wc15),.wc16(wc16),.wc17(wc17),.wc18(wc18),.wc19(wc19),
		.wd11(wd11),.wd12(wd12),.wd13(wd13),.wd14(wd14),.wd15(wd15),.wd16(wd16),.wd17(wd17),.wd18(wd18),.wd19(wd19),
		.wc21(wc21),.wc22(wc22),.wc23(wc23),.wc24(wc24),.wc25(wc25),.wc26(wc26),.wc27(wc27),.wc28(wc28),.wc29(wc29),
		.wd21(wd21),.wd22(wd22),.wd23(wd23),.wd24(wd24),.wd25(wd25),.wd26(wd26),.wd27(wd27),.wd28(wd28),.wd29(wd29),
		.w11(w11),.w12(w12),
		.w21(w21),.w22(w22),
		.w31(w31),.w32(w32),
		.w41(w41),.w42(w42),
		.w51(w51),.w52(w52),
		.w61(w61),.w62(w62),
		.w71(w71),.w72(w72),
		.w81(w81),.w82(w82),
		.w91(w91),.w92(w92),
		.b21(b21),.b22(b22),.b23(b23),.b24(b24),
		.b31(b31),.b32(b32),.b33(b33),.b34(b34),.b35(b35),.b36(b36),.b37(b37),.b38(b38),.b39(b39),
		.out1(out1),.out2(out2),.out3(out3),.out4(out4),.out5(out5),.out6(out6),.out7(out7),.out8(out8),.out9(out9)
	);

	initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

	// Stimulus process
	initial begin
		 rst = 1;
        #10 rst = 0; 
		x1=16'h0100;
		x2=16'h0000;
		x3=16'h0100;
		x4=16'h0000;
		x5=16'h0100;
		x6=16'h0000;
		x7=16'h0100;
		x8=16'h0000;
		x9=16'h0100;

		wc11= 16'h0004;   
	 	wc12= 16'hffff;   
	  	wc13= 16'hfffb;    
	  	wc14= 16'h0000;   
	  	wc15= 16'hfffb;    
	  	wc16= 16'h0003;   
	  	wc17= 16'hffad;    
	  	wc18= 16'h020d;    
	  	wc19= 16'h003f;

		wc21= 16'hffff;
		wc22= 16'h0009;   
		wc23= 16'hffff;    
		wc24= 16'h0009;   
		wc25= 16'hfff6;    
		wc26= 16'h0009;   
		wc27= 16'h0065;    
		wc28= 16'hffd6;    
		wc29= 16'h008a;

		wd11= 16'h000f;     
	 	wd12= 16'hfffa;      
	  	wd13= 16'hfffa;       
	  	wd14= 16'h0003;       
	  	wd15= 16'h0006;       
	  	wd16= 16'hfffc;      
	  	wd17= 16'hffe9;       
	  	wd18= 16'hffee;       
	  	wd19= 16'hffa8;

		wd21= 16'h000b;   	
		wd22= 16'hfff6;    	   
		wd23= 16'h000b;   	    
		wd24= 16'hfff7;    	   
		wd25= 16'h0015;   	    
		wd26= 16'hfff4;    	   
		wd27= 16'h00dd;    	    
		wd28= 16'h002b;    	    
		wd29= 16'h0028;	

		b21 = 16'hff23;
		b22 = 16'hff16;
		b23 = 16'hff20;
		b24 = 16'hff60;

		w11 = 16'h0024; w12 = 16'h0044;
		w21 = 16'h04fb; w22 = 16'hffe4;
		w31 = 16'h0023; w32 = 16'h0043;
		w41 = 16'h04f9; w42 = 16'hffe4;
		w51 = 16'hfb10; w52 = 16'h001d;
		w61 = 16'h04fa; w62 = 16'hffe4;
		w71 = 16'h0025; w72 = 16'h0047;
		w81 = 16'h04fb; w82 = 16'hffe4;
		w91 = 16'h0022; w92 = 16'h0041;

		b31 = 16'h04f0;
		b32 = 16'hffcc;
		b33 = 16'h04ef;
		b34 = 16'hffcc;
		b35 = 16'h0032;
		b36 = 16'hffcc;
		b37 = 16'h04f1;
		b38 = 16'hffcc;
		b39 = 16'h04ed;

		$dumpfile("top_level_tb.vcd");
		$dumpvars(0, tb_top_level_forward);
		#800 $stop;   // Stop simulation after 100ns
		$finish;
    end

endmodule
