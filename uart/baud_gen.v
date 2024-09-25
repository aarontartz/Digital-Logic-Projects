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
    output wire baud_clk
    );
    
    localparam [15:0] BAUD_SCALE = 16'd100;  // just arbitrary value, can change later for exact baud rate
    
    reg [31:0] count = 0;
    reg baud_clk_reg = 0;
    
    assign baud_clk = baud_clk_reg;
    
    always @(posedge clk) begin
        if (count == BAUD_SCALE) begin
            baud_clk_reg <= ~baud_clk_reg;
            count <= 0;
        end
        else
            count <= count + 1;
    end
endmodule
