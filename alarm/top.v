`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 12:54:12 PM
// Design Name: 
// Module Name: top
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


module top(
    input wire CLK100MHZ,
    input wire [15:0] sw,
    input wire btnD,
    input wire btnL,
    input wire btnR,
    input wire btnC,
    output wire [3:0] an,
    output wire [6:0] seg,
    output wire [15:0] LED
    );
    
    wire btnL_wire;
    wire btnR_wire;
    wire btnC_wire;
    wire btnD_wire;
    wire clk1hz_wire;
    wire clk100hz_wire;
    wire hourten_wire;
    wire [3:0] hour_wire;
    wire [2:0] minten_wire;
    wire [3:0] min_wire;
    
    
    derate derate_inst (
        .CLK100MHZ(CLK100MHZ),
        .rst(btnD_wire),
        .CLK1HZ(clk1hz_wire),
        .CLK100HZ(clk100hz_wire)
    );
    
    debounce btnL_inst (
        .CLK100HZ(clk100hz_wire),
        .btn_in(btnL),
        .btn_out(btnL_wire)
    );
    
    debounce btnR_inst (
        .CLK100HZ(clk100hz_wire),
        .btn_in(btnR),
        .btn_out(btnR_wire)
    );
    
    debounce btnC_inst (
        .CLK100HZ(clk100hz_wire),
        .btn_in(btnC),
        .btn_out(btnC_wire)
    );
    
    debounce btnD_inst (
        .CLK100HZ(clk100hz_wire),
        .btn_in(btnD),
        .btn_out(btnD_wire)
    );
    
    disp disp_inst (
        .CLK100MHZ(CLK100MHZ),
        .rst(btnD_wire),
        .hourten(hourten_wire),
        .hour(hour_wire),
        .minten(minten_wire),
        .min(min_wire),
        .disp_num(seg),
        .digit(an)
    );
    
    alarm_mode alarm_mode_inst (
        .clk_1Hz(clk1hz_wire),
        .rst(btnD_wire),
        .alarm_active(sw[15]),
        .count_active(sw[0]),
        .increase_min(btnR_wire),
        .increase_hour(btnL_wire),
        .hourten(hourten_wire),
        .hour(hour_wire),
        .minten(minten_wire),
        .min(min_wire),
        .led(LED[0])
    );
    
endmodule
