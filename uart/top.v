`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 
// 
// Create Date: 10/08/2024 11:41:38 PM
// Module Name: top
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input wire clk,
    input wire tx_en,
    input wire rx_en,
    input wire [7:0] data_in,
    output wire fsm_clk,    // for testbench simulation
    output wire [7:0] rx_out
    );
    
    wire baud_clk;
    wire rx_pulse;
    wire tx_out;
    
     baud_gen baud_gen00 (
        .clk(clk),
        .baud_clk(baud_clk),
        .rx_pulse(rx_pulse)
    );
    
    uart_tx uart_tx00 (
        .baud_clk(baud_clk),
        .tx_en(tx_en),
        .data_in(data_in),
        .tx_out(tx_out),
        .fsm_clk(fsm_clk)
    );
    
    uart_rx uart_rx00 (
        .rx_pulse(rx_pulse),
        .rx_in(tx_out),
        .rx_en(rx_en),
        .data_out(rx_out)
    );
    
endmodule
