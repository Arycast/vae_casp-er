// circular buffer for single PE
module circular_buffer #(parameter address1=0) (
    input clk,
    input rst,
    input read_en,
    output [15:0] read_data_1,
    output [15:0] read_data_2,
    output [15:0] read_data_3,
    output [15:0] read_data_4,
    output [15:0] read_data_5,
    output [15:0] read_data_6,
    output [15:0] read_data_7,
    output [15:0] read_data_8

);
    // Define the size of the buffer
    parameter SIZE = 8;
    
    // Declare the buffer memory
    reg [15:0] buffer_1 [0:SIZE-1];
    reg [15:0] buffer_2 [0:SIZE-1];
    reg [15:0] buffer_3 [0:SIZE-1];
    reg [15:0] buffer_4 [0:SIZE-1];
    reg [15:0] buffer_5 [0:SIZE-1];
    reg [15:0] buffer_6 [0:SIZE-1];
    reg [15:0] buffer_7 [0:SIZE-1];
    reg [15:0] buffer_8 [0:SIZE-1];

    // Read index
    reg [2:0] read_ptr;
    
    // Initialize the buffer from the external file
    initial begin
        $readmemb("preprocessed_mu.txt", buffer_1, address1, address1+7);
        $readmemb("preprocessed_mu.txt", buffer_2, address1+8, address1+8+7);
        $readmemb("preprocessed_mu.txt", buffer_3, address1+8*2, address1+7+8*2);
        $readmemb("preprocessed_mu.txt", buffer_4, address1+8*3, address1+7+8*3);
        $readmemb("preprocessed_mu.txt", buffer_5, address1+8*4, address1+7+8*4);
        $readmemb("preprocessed_mu.txt", buffer_6, address1+8*5, address1+7+8*5);
        $readmemb("preprocessed_mu.txt", buffer_7, address1+8*6, address1+7+8*6);
        $readmemb("preprocessed_mu.txt", buffer_8, address1+8*7, address1+7+8*7);
        read_ptr = 0;
    end
    
    // Read data from the buffer
    assign read_data_1 = buffer_1[read_ptr];
    assign read_data_2 = buffer_2[read_ptr];
    assign read_data_3 = buffer_3[read_ptr];
    assign read_data_4 = buffer_4[read_ptr];
    assign read_data_5 = buffer_5[read_ptr];
    assign read_data_6 = buffer_6[read_ptr];
    assign read_data_7 = buffer_7[read_ptr];
    assign read_data_8 = buffer_8[read_ptr];

    // Update read pointer on clock edge
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            read_ptr <= 0;
        end else begin
            if (read_en) begin
                read_ptr <= (read_ptr + 1) % SIZE;
                
            end
        end
    end

    endmodule