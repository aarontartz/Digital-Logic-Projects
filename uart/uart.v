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
    output wire o_bit
    );
    
    localparam [3:0] START = 2'b00,
                     DATA  = 2'b01,         
                     END   = 2'b10,
                     IDLE  = 2'b11;
                     
    reg [1:0] state = START;    // state register
    
    
    
endmodule
