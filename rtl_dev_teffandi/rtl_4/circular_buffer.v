// circular buffer for single PE
module circular_buffer #(parameter address1=0) (
    input clk,
    input rst,
    input read_en,
    input op_mode, //  0 for mu and 1 for var
    output reg [15:0] read_data_1,
    output reg [15:0] read_data_2,
    output reg [15:0] read_data_3,
    output reg [15:0] read_data_4,
    output reg [15:0] read_data_5,
    output reg [15:0] read_data_6,
    output reg [15:0] read_data_7,
    output reg [15:0] read_data_8

);
    // Define the size of the buffer
    parameter SIZE = 8;
    
    // Declare the buffer memory
    reg [15:0] buffer [7:0][7:0];
    reg [15:0] buffer_2 [7:0][7:0];

    //declare temporay memory
    reg [15:0] temp [1023:0];
    reg [15:0] temp_2 [1023:0];

    // Read index
    reg [2:0] read_ptr;

    integer i;
    integer j;
    integer offset = address1;
    
    // Initialize the buffer from the external file
    initial begin

        $readmemh("mu.txt",temp,0,1023);
        $readmemh("var.txt",temp_2,0,1023);

        read_ptr = 0;
    
  end
    // Read data from the buffer


    // Update read pointer on clock edge
    always @(posedge clk) begin
        if (rst) begin
            read_ptr <= 0;

            read_data_1 <= 0;
            read_data_2 <= 0;
            read_data_3 <= 0;
            read_data_4 <= 0;
            read_data_5 <= 0;
            read_data_6 <= 0;
            read_data_7 <= 0;
            read_data_8 <= 0;

        end else begin
            if (read_en) begin
                read_ptr <= (read_ptr + 1) % SIZE;
            end
            if (!op_mode ) begin

                    read_data_1 <= temp[offset+read_ptr];
                    read_data_2 <= temp[offset+8+read_ptr];
                    read_data_3 <= temp[offset+16+read_ptr];
                    read_data_4 <= temp[offset+24+read_ptr];
                    read_data_5 <= temp[offset+32+read_ptr];
                    read_data_6 <= temp[offset+40+read_ptr];
                    read_data_7 <= temp[offset+48+read_ptr];
                    read_data_8 <= temp[offset+56+read_ptr];

                end

                else begin
                    read_data_1 <= temp_2[offset+read_ptr];
                    read_data_2 <= temp_2[offset+8+read_ptr];
                    read_data_3 <= temp_2[offset+16+read_ptr];
                    read_data_4 <= temp_2[offset+24+read_ptr];
                    read_data_5 <= temp_2[offset+32+read_ptr];
                    read_data_6 <= temp_2[offset+40+read_ptr];
                    read_data_7 <= temp_2[offset+48+read_ptr];
                    read_data_8 <= temp_2[offset+56+read_ptr];
                
                end
        end
    end


    endmodule