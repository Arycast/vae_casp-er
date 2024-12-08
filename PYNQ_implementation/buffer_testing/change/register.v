`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer    : casp-er
// Design Name : Variable width register
// Module Name : register
// Project Name: Variational Autoencoder
//////////////////////////////////////////////////////////////////////////////////

module register #(parameter WIDTH = 16) (
        input wire                    clk,
        input wire                    rst_n,
        input wire                    en,
        input wire                    clr,
        input wire signed [WIDTH-1:0] d,
        output reg signed [WIDTH-1:0] q
    );
    
    always @(posedge clk)
    begin
        if (!rst_n || clr)
        begin
            q <= 0;
        end
        else if (en)
        begin
            q <= d;
        end
    end
    
endmodule
