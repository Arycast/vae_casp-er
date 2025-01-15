module register #(
) (
    input rst,
    input [15:0] data_in,
    output reg [15:0] data_out
);
    if (rst) data_out <= {16'h0000};
    else data_out <= data_in;
endmodule