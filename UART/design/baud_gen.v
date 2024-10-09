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
    output wire baud_clk,
    output wire rx_pulse
    );
    
    // 9600 = 100MHz / (10 * x)
    // x = 1302
    
    localparam [7:0] BAUD_SCALE = 8'd100;
    
    reg [31:0] count = 0;
    reg baud_reg = 0;
    reg rx_pulse_reg = 1;
    
    assign baud_clk = baud_reg;
    assign rx_pulse = rx_pulse_reg;
    
    always @(posedge clk) begin
        if ((count == 2 && baud_reg == 0) || (count == 98  && baud_reg == 1 ))
            rx_pulse_reg <= ~rx_pulse_reg;
        if (count == BAUD_SCALE) begin
            baud_reg <= ~baud_reg;
            count <= 0;
        end
        else
            count <= count + 1;
    end
endmodule
