`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2024 02:29:33 PM
// Design Name: 
// Module Name: seg7disp
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


module seg7disp(
    input wire clk,
    input wire [4:0] data_in,
    output reg [7:0] data_out
    );

    wire [7:0] data_in;
    
    always @(posedge clk) begin       // sequential logic
        case (data_in)
            4'b0000: 
                data_out <= 8'b00000000;  //zero
            4'b0001:
                data_out <= 8'b00100001;  //one
            4'b0010:
                data_out <= 8'b11001011;  //two
            4'b0011:
                data_out <= 8'b01101011;  //three
            4'b0100:
                data_out <= 8'b00101101;  //four
            4'b0101:
                data_out<= 8'b01101110;  //five
            4'b0110:
                data_out <= 8'b11101110;  //six
            4'b0111:
                data_out <= 8'b00100011;  //seven
            4'b1000:
                data_out <= 8'b11101111;  //eight
            4'b1001:
                data_out <= 8'b01101111;  //nine
            default:
                data_out <= 8'b00001000;  //-
        endcase
    end
endmodule
