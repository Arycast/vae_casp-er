`timescale 1ns / 1ps

module axis_buffer_tb();
    localparam T = 10;
    
    reg aclk;
    reg aresetn;
    
    wire s_axis_tready;
    reg [63:0] s_axis_tdata;
    reg s_axis_tvalid;
    reg s_axis_tlast;
    
    reg m_axis_tready;
    wire [63:0] m_axis_tdata;
    wire m_axis_tvalid;
    wire m_axis_tlast;

    integer i;
    
    axis_forward dut
    (
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axis_tready(s_axis_tready),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tlast(s_axis_tlast),
        .m_axis_tready(m_axis_tready),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tlast(m_axis_tlast)
    );
    
    always
    begin
        aclk = 0;
        #(T/2);
        aclk = 1;
        #(T/2);
    end

    initial
    begin
        s_axis_tdata = 0;
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
        m_axis_tready = 1;
        
        aresetn = 0;
        #(T*5);
        aresetn = 1;
        #(T*5);

        s_axis_tvalid = 1;
        s_axis_tdata = 64'h0000000000000001;
        for (i = 2; i < 20; i=i+1) begin
            #T;
            s_axis_tdata = i;
        end
        // #T;
        // s_axis_tdata = 64'hfa000011c0000005;
        // #T;
        // s_axis_tdata = 64'h8000000260000007;
        // #T; 
        // s_axis_tdata = 64'h9000000840000003;
        s_axis_tlast = 1;
        #T;
        s_axis_tvalid = 0;
        s_axis_tdata = 0; 
        s_axis_tlast = 0;
    end
        
endmodule