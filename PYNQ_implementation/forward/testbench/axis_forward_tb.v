`timescale 1ns / 1ps

module axis_forward_tb();
    localparam T = 10;
    
    reg aclk;
    reg aresetn;
    
    wire s_axis_tready;
    reg [63:0] s_axis_tdata;
    reg s_axis_tvalid;
    reg s_axis_tlast;
    
    reg m_axis_tready;
    wire [63:0] m_axis_tdata;
    wire m_axis_tvalid;
    wire m_axis_tlast;

    integer i;
    
    axis_forward dut
    (
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axis_tready(s_axis_tready),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tlast(s_axis_tlast),
        .m_axis_tready(m_axis_tready),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tlast(m_axis_tlast)
    );
    
    always
    begin
        aclk = 0;
        #(T/2);
        aclk = 1;
        #(T/2);
    end

    initial
    begin
        s_axis_tdata = 0;
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        m_axis_tready = 1;
        
        aresetn = 0;
        #(T*5);
        aresetn = 1;
        #(T*5);

        s_axis_tvalid = 1;
        s_axis_tdata[15:0]  = 16'h0100;
        s_axis_tdata[31:16] = 16'h0000;
        s_axis_tdata[47:32] = 16'h0100;
        s_axis_tdata[63:48] = 16'h0000;
        #T;
        
        // x1=16'h0100;
		// x2=16'h0000;
		// x3=16'h0100;
		// x4=16'h0000;

        s_axis_tdata[15:0]  = 16'h0100;
        s_axis_tdata[31:16] = 16'h0000;
        s_axis_tdata[47:32] = 16'h0100;
        s_axis_tdata[63:48] = 16'h0000;
        #T;

		// x5=16'h0100;
		// x6=16'h0000;
		// x7=16'h0100;
		// x8=16'h0000;

        s_axis_tdata[15:0]  = 16'h0100;
        s_axis_tdata[31:16] = 16'h0004;
        s_axis_tdata[47:32] = 16'hffff;
        s_axis_tdata[63:48] = 16'hfffb;
        #T;
        
		// x9  = 16'h0100;
        // wc11= 16'h0004;   
	 	// wc12= 16'hffff;   
	  	// wc13= 16'hfffb;

        s_axis_tdata[15:0]  = 16'h0000;
        s_axis_tdata[31:16] = 16'hfffb;
        s_axis_tdata[47:32] = 16'h0003;
        s_axis_tdata[63:48] = 16'hffad;
        #T;

	  	// wc14= 16'h0000;   
	  	// wc15= 16'hfffb;    
	  	// wc16= 16'h0003;   
	  	// wc17= 16'hffad;

        s_axis_tdata[15:0]  = 16'h020d;
        s_axis_tdata[31:16] = 16'h003f;
        s_axis_tdata[47:32] = 16'h000f;
        s_axis_tdata[63:48] = 16'hfffa;
        #T;
            
	  	// wc18= 16'h020d;    
	  	// wc19= 16'h003f;
        // wd11= 16'h000f;     
	 	// wd12= 16'hfffa; 

        s_axis_tdata[15:0]  = 16'hfffa;
        s_axis_tdata[31:16] = 16'h0003;
        s_axis_tdata[47:32] = 16'h0006;
        s_axis_tdata[63:48] = 16'hfffc;
        #T;     
	  	
        // wd13= 16'hfffa;       
	  	// wd14= 16'h0003;       
	  	// wd15= 16'h0006;       
	  	// wd16= 16'hfffc;

        s_axis_tdata[15:0]  = 16'hffe9;
        s_axis_tdata[31:16] = 16'hffee;
        s_axis_tdata[47:32] = 16'hffa8;
        s_axis_tdata[63:48] = 16'hffff;
        #T;      
	  	
        // wd17= 16'hffe9;       
	  	// wd18= 16'hffee;       
	  	// wd19= 16'hffa8;
        // wc21= 16'hffff;

        s_axis_tdata[15:0]  = 16'h0009;
        s_axis_tdata[31:16] = 16'hffff;
        s_axis_tdata[47:32] = 16'h0009;
        s_axis_tdata[63:48] = 16'hfff6;
        #T;
		
        // wc22= 16'h0009;   
		// wc23= 16'hffff;    
		// wc24= 16'h0009;   
		// wc25= 16'hfff6;

        s_axis_tdata[15:0]  = 16'h0009;
        s_axis_tdata[31:16] = 16'h0065;
        s_axis_tdata[47:32] = 16'hffd6;
        s_axis_tdata[63:48] = 16'h008a;
        #T;    
		
        // wc26= 16'h0009;   
		// wc27= 16'h0065;    
		// wc28= 16'hffd6;    
		// wc29= 16'h008a;

        s_axis_tdata[15:0]  = 16'h000b;
        s_axis_tdata[31:16] = 16'hfff6;
        s_axis_tdata[47:32] = 16'h000b;
        s_axis_tdata[63:48] = 16'hfff7;
        #T;
        
        // wd21= 16'h000b;   	
		// wd22= 16'hfff6;    	   
		// wd23= 16'h000b;   	    
		// wd24= 16'hfff7;

        s_axis_tdata[15:0]  = 16'h0015;
        s_axis_tdata[31:16] = 16'hfff4;
        s_axis_tdata[47:32] = 16'h00dd;
        s_axis_tdata[63:48] = 16'h002b;
        #T;    	   
		
        // wd25= 16'h0015;   	    
		// wd26= 16'hfff4;    	   
		// wd27= 16'h00dd;    	    
		// wd28= 16'h002b;

        s_axis_tdata[15:0]  = 16'h0028;
        s_axis_tdata[31:16] = 16'hff23;
        s_axis_tdata[47:32] = 16'hff16;
        s_axis_tdata[63:48] = 16'hff20;
        #T;    	    
		
        // wd29= 16'h0028;
        // b21 = 16'hff23;
		// b22 = 16'hff16;
		// b23 = 16'hff20;

        s_axis_tdata[15:0]  = 16'hff60;
        s_axis_tdata[31:16] = 16'h0024;
        s_axis_tdata[47:32] = 16'h0044;
        s_axis_tdata[63:48] = 16'h04fb;
        #T;
		
        // b24 = 16'hff60;
        // w11 = 16'h0024; 
        // w12 = 16'h0044;
		// w21 = 16'h04fb;

        s_axis_tdata[15:0]  = 16'hffe4;
        s_axis_tdata[31:16] = 16'h0023;
        s_axis_tdata[47:32] = 16'h0043;
        s_axis_tdata[63:48] = 16'h04f9;
        #T; 
        
        // w22 = 16'hffe4;
		// w31 = 16'h0023; 
        // w32 = 16'h0043;
		// w41 = 16'h04f9;

        s_axis_tdata[15:0]  = 16'hffe4;
        s_axis_tdata[31:16] = 16'hfb10;
        s_axis_tdata[47:32] = 16'h001d;
        s_axis_tdata[63:48] = 16'h04fa;
        #T; 
        
        // w42 = 16'hffe4;
		// w51 = 16'hfb10; 
        // w52 = 16'h001d;
		// w61 = 16'h04fa;

        s_axis_tdata[15:0]  = 16'hffe4;
        s_axis_tdata[31:16] = 16'h0025;
        s_axis_tdata[47:32] = 16'h0047;
        s_axis_tdata[63:48] = 16'h04fb;
        #T; 
        
        // w62 = 16'hffe4;
		// w71 = 16'h0025; 
        // w72 = 16'h0047;
		// w81 = 16'h04fb;

        s_axis_tdata[15:0]  = 16'hffe4;
        s_axis_tdata[31:16] = 16'h0022;
        s_axis_tdata[47:32] = 16'h0041;
        s_axis_tdata[63:48] = 16'h04f0;
        #T; 
        
        // w82 = 16'hffe4;
		// w91 = 16'h0022; 
        // w92 = 16'h0041;
        // b31 = 16'h04f0;

        s_axis_tdata[15:0]  = 16'hffcc;
        s_axis_tdata[31:16] = 16'h04ef;
        s_axis_tdata[47:32] = 16'hffcc;
        s_axis_tdata[63:48] = 16'h0032;
        #T;
		
        // b32 = 16'hffcc;
		// b33 = 16'h04ef;
		// b34 = 16'hffcc;
		// b35 = 16'h0032;

        s_axis_tdata[15:0]  = 16'hffcc;
        s_axis_tdata[31:16] = 16'h04f1;
        s_axis_tdata[47:32] = 16'hffcc;
        s_axis_tdata[63:48] = 16'h04ed;
        #T;
		
        // b36 = 16'hffcc;
		// b37 = 16'h04f1;
		// b38 = 16'hffcc;
		// b39 = 16'h04ed;
        
        s_axis_tvalid = 0;
        s_axis_tdata = 0; 
        s_axis_tlast = 0;
    end
        
endmodule