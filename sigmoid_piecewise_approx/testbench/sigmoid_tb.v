`timescale 1ns/1ps

module sigmoid_tb ();

    /****************************************************************************
    * Parameter
    ***************************************************************************/
	parameter WIDTH = 16;
	integer fd;	// For opening files
	integer i;

   /****************************************************************************
    * Signals
    ***************************************************************************/

   // reg clock, rst;

   reg signed [WIDTH-1:0] x;
   wire signed[WIDTH-1:0] alfa;

   /****************************************************************************
    * Generate Clock Signals
    ***************************************************************************/

	// 250 MHz clock
   // initial clock = 1'b1;
   // always #2 clock = ~clock;

   /****************************************************************************
    * Instantiate Modules
    ***************************************************************************/

	sigmoid #(.BITS(WIDTH)) uut (
      .x(x),
      .alfa(alfa)
    );

   /****************************************************************************
    * Apply Stimulus
    ***************************************************************************/

   initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0,sigmoid_tb);

		// x = 16'h0000;
		// fd = $fopen("softplus_result.txt","w");
		// #2 $fwriteb(fd, x); $fwriteb(fd," "); $fwriteb(fd,alfa); $fwriteb(fd," "); $fdisplayh(fd,alfa);

		// x = 16'h0100;
		// #2 $fwriteb(fd, x); $fwriteb(fd," "); $fwriteb(fd,alfa); $fwriteb(fd," "); $fdisplayh(fd,alfa);

		fd = $fopen("result_sigmoid.txt","w");
		for (i=16'hf900; i <= 16'hffff; i=i+1) begin
			x = i;
			#2 $fwriteb(fd, x); $fwriteb(fd," "); $fwriteb(fd,alfa); $fwriteb(fd," "); $fdisplayh(fd,alfa);
		end

		for (i=16'h0000; i <= 16'h0700; i=i+1) begin
			x = i;
			#2 $fwriteb(fd, x); $fwriteb(fd," "); $fwriteb(fd,alfa); $fwriteb(fd," "); $fdisplayh(fd,alfa);
		end

		#2 $fclose(fd);	
      $finish;

   end


endmodule
