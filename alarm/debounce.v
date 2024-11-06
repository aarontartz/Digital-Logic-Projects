`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 12:32:48 PM
// Design Name: 
// Module Name: debounce
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

module debounce(
    input wire CLK100HZ,
    input wire btn_in,
    output wire btn_out
    );
    
    reg t0;
    reg t1;
    reg t2;
    
    always @(posedge CLK100HZ) begin
        t0 <= btn_in;
        t1 <= t0;
        t2 <= t1;
    end
    
    assign btn_out = t2;
    
endmodule
