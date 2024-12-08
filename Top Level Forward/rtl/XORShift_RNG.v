// this is a module for random number generator based on XORShift algorithm

module XOR_RNG (
    input wire clk,          // Clock input
    input wire rst,          // Reset input (synchronous)
    output reg [7:0] rand    // 8-bit random output
);

    // Internal state register
    reg [7:0] state;

    always @(posedge clk) begin
        if (rst) begin
            // Initialize with a non-zero seed
            state = 8'h4D;  // Example seed value (must be non-zero)
        end else begin
            // Xorshift operations
        //    state <= update_state;
            state <= state ^ (state << 3);  // Shift left by 3 and XOR
            state <= state ^ (state >> 5);  // Shift right by 5 and XOR
            state <= state ^ (state << 2);  // Shift left by 2 and XOR
            state <= state  + 8'h11; // Add a constant for feedback

        end
    end

    // Assign the state to the random output
    always @(posedge clk) begin
        rand <= state;

    end

endmodule