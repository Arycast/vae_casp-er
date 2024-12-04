module mux (
    input [15:0] in_a,
    input [15:0] in_b,
    input selector,
    input [15:0]out
);
    assign out = selector? in_a : in_b;
endmodule