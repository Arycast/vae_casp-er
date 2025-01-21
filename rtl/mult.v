//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Multiplier Fixed Point
// Module Name : mult
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module mult #(
    parameter WIDTH = 16,
    parameter FRAC_WIDTH = 8
)(
    
   input [WIDTH-1:0] Operand_1, 
   input [WIDTH-1:0] Operand_2,
   output [WIDTH-1:0] result
);

wire [2*WIDTH-1:0] temp_op1, temp_op2;
wire [4*WIDTH-1:0]temp;

assign temp_op1 = {{WIDTH{Operand_1[WIDTH-1]}}, Operand_1}; 
assign temp_op2 = {{WIDTH{Operand_2[WIDTH-1]}}, Operand_2};

assign temp = temp_op1 * temp_op2;
assign result[WIDTH-1:0] = temp[WIDTH+FRAC_WIDTH:FRAC_WIDTH];
endmodule