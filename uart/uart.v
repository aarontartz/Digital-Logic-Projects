`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 09:44:13 AM
// Design Name: 
// Module Name: uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart(
    input wire baud_clk,
    input wire [7:0] data_in,
    output reg o_bit
    );
    
    localparam [3:0] START = 2'b00,
                     DATA  = 2'b01,         
                     STOP  = 2'b10,
                     IDLE  = 2'b11;
                     
    reg [1:0] state = IDLE;    // state register
    reg [7:0] data;
    reg [3:0] index = 0;
    
    always @(posedge baud_clk) begin
        case (state)
            START: begin
                data <= data_in;
                o_bit <= 0;
            end
            DATA: begin
                o_bit <= data[index];
            end
            STOP: begin
                o_bit <= 1;
                index <= 0;
            end
            IDLE: begin
                o_bit <= 1;
            end
        endcase
    end
    
    always @* begin
        if ((state == DATA) && (index > 0))
            index = index + 1;
    end
    
endmodule
