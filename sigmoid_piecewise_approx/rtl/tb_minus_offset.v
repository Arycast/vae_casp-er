//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Testbench for Min value from the offset + 2
// Module Name : tb_minus_offset
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module tb_minus_offset;
    // Inputs and outputs
    reg [15:0] offset;
    wire [15:0] sum;

    // Instantiate the Unit Under Test (UUT)
    minus_offset uut (
        .offset(offset),
        .sum(sum)
    );

    // Stimulus
    initial begin
        // Test case 1: Positive number
        offset = 16'b0000_0000_0000_0101;  // 5
        #10;
        $display("Offset: %d, Sum: %d", $signed(offset), $signed(sum));

        // Test case 2: Negative number
        offset = 16'b1111_1111_1111_1011;  // -5
        #10;
        $display("Offset: %d, Sum: %d", $signed(offset), $signed(sum));

        // Test case 3: Zero
        offset = 16'b0000_0000_0000_0000;  // 0
        #10;
        $display("Offset: %d, Sum: %d", $signed(offset), $signed(sum));

        // Test case 4: Large positive number
        offset = 16'b0111_1111_1111_1111;  // Max positive
        #10;
        $display("Offset: %d, Sum: %d", $signed(offset), $signed(sum));

        // Test case 5: Large negative number
        offset = 16'b1000_0000_0000_0000;  // Min negative
        #10;
        $display("Offset: %d, Sum: %d", $signed(offset), $signed(sum));

        // Finish simulation
        $finish;
    end

    // Optional: Waveform dump for ModelSim/QuestaSim
    initial begin
        $dumpfile("minus_offset_tb.vcd");
        $dumpvars(0, tb_minus_offset);
    end
endmodule