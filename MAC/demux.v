module demux (
    input [15:0] in,
    input selector,
    output [15:0] out1,out2
);
    assign {out1,out2}=selector?{16'h0000,in}:{i,16'h0000};
endmodule