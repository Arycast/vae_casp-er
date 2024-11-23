
module gradient_offset (
    
   input [15:0] input_grad,
   output reg [15:0] out_grad,
   output reg [15:0] out_offset

);

wire [3:0] select;
wire [3:0] pre_overflow;
wire overflow;

wire [10:0] not_in;
wire [10:0] temp_2s;

// Handling overflow
assign pre_overflow = {4{input_grad[15]}} ^ input_grad[14:11]; // Sign handling
assign overflow = pre_overflow[3] | pre_overflow[2] | pre_overflow[1] | pre_overflow[0];

// assign overflow = input_grad[15]^(input_grad[14]|input_grad[13]|input_grad[12]|input_grad[11]); //handling overflow

assign not_in = input_grad[15]? ~input_grad[10:0]:input_grad[10:0]; //handling 
assign temp_2s = not_in + input_grad[15];

assign select[3] = overflow;
assign select[2:0] = temp_2s[10:8];

always @(*) begin //gradient 
case (select)
    4'b0000  : out_grad = 16'h003B;
    4'b0001  : out_grad = 16'h0026;
    4'b0010  : out_grad = 16'h0012;
    4'b0011  : out_grad = 16'h0008;
    4'b0100  : out_grad = 16'h0003;
    4'b0101  : out_grad = 16'h0001;    
    default : out_grad = 16'h0000;

endcase
end

//offset handling
reg [15:0] temp_offset_2;
reg [15:0] temp_offset;


always @(*) begin //offset
case (select)
    4'b0000  : temp_offset = 16'h0080;
    4'b0001  : temp_offset = 16'h0090;
    4'b0010  : temp_offset = 16'h00BD;
    4'b0011  : temp_offset = 16'h00DD;
    4'b0100  : temp_offset = 16'h00F0;
    4'b0101  : temp_offset = 16'h00F9;    
    default : temp_offset = 16'h0100;

endcase

temp_offset_2 = input_grad[15]? ~temp_offset:temp_offset; //handling 
out_offset =  temp_offset_2 + {{7'b0000000,input_grad[15]},{7'b0000000,input_grad[15]}}; 

end

endmodule