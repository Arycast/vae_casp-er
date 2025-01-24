//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Multiplier Fixed Point
// Module Name : buffer
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////
module buffer(

input wire [15:0] data_in,
input wire clk,
input wire rst,

output reg done,
output reg [15:0] data_out

);

reg [15:0] temp;
reg [7:0] counter;


always @(posedge clk)
begin
if (!rst) begin
    temp <= temp + data_in;
end

else begin
    temp <= 0;
end

end

always @(posedge clk)
begin
if (!rst)
begin
    if (counter !== 132)
    begin 
        counter <= counter+1;
    end
    else begin
        data_out <= temp;
        done <= 0;
        counter <= 0;
    end

end

else begin
    counter <= 0;
    done <= 0;
end

end





endmodule