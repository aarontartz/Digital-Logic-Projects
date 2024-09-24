`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 10:44:00 AM
// Design Name: 
// Module Name: baud_gen
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


module baud_gen(
    input wire clk,
    output reg baud_clk
    );
    
    // 9600 = 100MHz / (8 * x)
    // x = 1302
    
    reg [11:0] count = 0;
    
    always @(posedge clk) begin
        if (count == 12'd1302) begin
            baud_clk <= ~baud_clk;
            count <= 0;
        end
        else
            count <= count + 1;
    end
endmodule
