`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module derate (
    input CLK100MHZ,
    input rst, 
    output reg CLK1HZ,
    output reg CLK100HZ
    );

    // clk1freq / 2*DIVISOR = clk2freq
    localparam DIVISOR_1HZ = 50_000_000;
    localparam DIVISOR_100HZ = 500_000;

    reg [26:0] counter_1hz = 0;
    reg [26:0] counter_100hz = 0;

    always @(posedge CLK100MHZ or posedge rst) begin
        if (rst) begin
            counter_1hz <= 0;
            CLK1HZ <= 0;
            CLK100HZ <= 0;
        end else begin
            if (counter_1hz == (DIVISOR_1HZ - 1)) begin
                counter_1hz <= 0;
                CLK1HZ <= ~CLK1HZ;
            end 
            else begin
                counter_100hz <= counter_100hz + 1;
            end
            if (counter_100hz == (DIVISOR_1HZ - 1)) begin
                counter_100hz <= 0;
                CLK100HZ <= ~CLK100HZ;
            end 
            else begin
                counter_100hz <= counter_100hz + 1;
            end
        end
    end

endmodule
