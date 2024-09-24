`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 11:41:19 AM
// Design Name: 
// Module Name: tx_tb
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


module tx_tb;
    reg clk;
    reg data_en;
    reg [7:0] data_en;
    wire o_bit;
    wire baud_clk_wire;
    
    baud_gen baud_gen00 (
        .clk(clk),
        .baud_clk(baud_clk_wire)
    );
    
    uart_tx uart_tx00 (
        .baud_clk(baud_clk_wire),
        .data_en(data_en),
        .data_in(data),
        .o_bit(o_bit)
    );
    
endmodule
