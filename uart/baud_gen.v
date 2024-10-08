`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/24/2024 10:44:00 AM
// Module Name: baud_gen
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
