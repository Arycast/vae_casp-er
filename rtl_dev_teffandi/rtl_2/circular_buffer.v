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

    reg [15:0] buffer [7:0][7:0];

    //declare temporay memory
    reg [15:0] temp [1023:0];

    // Read index
    reg [2:0] read_ptr;

    integer i;
    integer j;
    integer offset = address1;
    
    // Initialize the buffer from the external file
    initial begin

        $readmemh("mu.txt",temp,0,1023);
        read_ptr = 0;
    end

    initial begin 

     for (i = 0; i < 8; i = i + 1) begin
         for (j = 0; j <8; j = j + 1) begin
            buffer[i][j] = temp[offset+8*i+j];
         end
     end
    end
    

    
    // Read data from the buffer
    assign read_data_1 = buffer[0][read_ptr];
    assign read_data_2 = buffer[1][read_ptr];
    assign read_data_3 = buffer[2][read_ptr];
    assign read_data_4 = buffer[3][read_ptr];
    assign read_data_5 = buffer[4][read_ptr];
    assign read_data_6 = buffer[5][read_ptr];
    assign read_data_7 = buffer[6][read_ptr];
    assign read_data_8 = buffer[7][read_ptr];

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

    always @(posedge clk) begin
        

        
    end

    endmodule