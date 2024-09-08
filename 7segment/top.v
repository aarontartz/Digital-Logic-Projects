`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2024 02:04:25 PM
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
    input wire clk,
    /*
    input wire en,
    input wire load,
    input wire up,
    input wire clr,
    */
    output wire ck_io1,
    output wire ck_io2,
    output wire ck_io4,
    output wire ck_io5,
    output wire ck_io6,
    output wire ck_io7,
    output wire ck_io9,
    output wire ck_io10
    );
    
    /*
    wire [4:0] num_data = 4'b0011;  //prints 3
    wire [7:0] data_out;
    wire co;
    
    bcd bcd_instance(
        .d(num_data),
        .clk(clk),
        .en(en),
        .load(load),
        .up(up),
        .clr(clr),
        .q(data_out),
        .co(co)
    );
    
    seg7disp disp_instance (
        .clk(clk),
        .data_in(num_data),
        .data_out(data_out)
    );
    */
    
    assign {ck_io1, ck_io2, ck_io4, ck_io5, ck_io6, ck_io7, ck_io9, ck_io10} = 8'b11111001;  //prints 3
    //assign {ck_io1, ck_io2, ck_io4, ck_io5, ck_io6, ck_io7, ck_io9, ck_io10} = data_out;
    
endmodule
