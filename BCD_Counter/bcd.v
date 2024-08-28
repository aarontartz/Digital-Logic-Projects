`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2024 12:30:45 PM
// Design Name: 
// Module Name: bcd
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


module bcd(
    input wire [3:0] d,
    input wire clk,
    input wire en,
    input wire load,
    input wire up,
    input wire clr,
    output wire [3:0] q,
    output reg co
    );
    
    reg [3:0] count;
    assign q = count;
    
    always @(posedge clk or negedge clr) begin
        if (clr == 0) begin
            count <= 4'd0;
            co <= 1'b0;
        end
        else if (en == 1) begin
            if (load == 1) begin
                count <= d;
                co <= 0; // good practice
            end
            else if (load == 0) begin
                if (up == 1) begin
                    if (count == 9) begin
                        count <= 4'd0;
                        co <= 1;
                    end
                    else begin
                        count <= count + 1;
                        co <= 0; // remember to set to 0
                    end
                end
                else if (up == 0) begin
                    if (count == 0) begin
                        count <= 4'd9;
                        co <= 1;
                    end
                    else begin
                        count <= count - 1;
                        co <= 0; // remember to set to 0
                    end
                end
            end
        end
    end
endmodule
