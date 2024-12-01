module testbench;
    reg clk;
    reg rst;
    wire [7:0] rand;

    // Instantiate the xorshift RNG module
    XOR_RNG random_0 (
        .clk(clk),
        .rst(rst),
        .rand(rand)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Test sequence
    initial begin
        rst = 1;
        #10 rst = 0;  // Release reset after 10ns
        #800 $stop;   // Stop simulation after 100ns
    end

    // Monitor output
    initial begin
        $monitor("Time: %t | Random: %h", $time, rand);
    end


        // Optional: Waveform dump for ModelSim/QuestaSim
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench);
    end


endmodule