`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 12:32:48 PM
// Design Name: 
// Module Name: disp
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


module disp(
    input wire CLK100MHZ,
    input wire rst,
    input wire hourten,
    input wire [3:0] hour,
    input wire [2:0] minten,
    input wire [3:0] min,
    output reg [6:0] disp_num,
    output reg [3:0] digit
    );
    
    localparam LED0 = 7'b0000001;   // "0"  
    localparam LED1 = 7'b1001111;   // "1" 
    localparam LED2 = 7'b0010010;   // "2" 
    localparam LED3 = 7'b0000110;   // "3" 
    localparam LED4 = 7'b1001100;   // "4" 
    localparam LED5 = 7'b0100100;   // "5" 
    localparam LED6 = 7'b0100000;   // "6" 
    localparam LED7 = 7'b0001111;   // "7" 
    localparam LED8 = 7'b0000000;   // "8"  
    localparam LED9 = 7'b0000100;   // "9" 
    
    reg [1:0] digit_select;  // cycles through turning on and off 4 digits sequentially
    reg [22:0] digit_timer;
    
    always @(posedge CLK100MHZ or posedge rst) begin
        if (rst) begin
            digit_select <= 0;
            digit_timer <= 0; 
        end
        else begin
            if(digit_timer == 500_000 - 1) begin
                digit_timer <= 0;
                digit_select <=  digit_select + 1;
            end
            else begin
                digit_timer <=  digit_timer + 1;
            end
        end
    end
    
    always @(digit_select) begin
        case(digit_select) 
            2'b00 : digit = 4'b1110;
            2'b01 : digit = 4'b1101;
            2'b10 : digit = 4'b1011;
            2'b11 : digit = 4'b0111;
        endcase
    end
    
    always @(*) begin
        case(digit_select)
            2'b00: begin
                case(min)
                    4'b0000 : disp_num = LED0;
                    4'b0001 : disp_num = LED1;
                    4'b0010 : disp_num = LED2;
                    4'b0011 : disp_num = LED3;
                    4'b0100 : disp_num = LED4;
                    4'b0101 : disp_num = LED5;
                    4'b0110 : disp_num = LED6;
                    4'b0111 : disp_num = LED7;
                    4'b1000 : disp_num = LED8;
                    4'b1001 : disp_num = LED9;
                endcase
            end
                    
            2'b01: begin       // minten Digit
                case(minten)
                    4'b0000 : disp_num = LED0;
                    4'b0001 : disp_num = LED1;
                    4'b0010 : disp_num = LED2;
                    4'b0011 : disp_num = LED3;
                    4'b0100 : disp_num = LED4;
                    4'b0101 : disp_num = LED5;
                    endcase
                end
                    
            2'b10: begin
                case(hour)
                    4'b0000 : disp_num = LED0;
                    4'b0001 : disp_num = LED1;
                    4'b0010 : disp_num = LED2;
                    4'b0011 : disp_num = LED3;
                    4'b0100 : disp_num = LED4;
                    4'b0101 : disp_num = LED5;
                    4'b0110 : disp_num = LED6;
                    4'b0111 : disp_num = LED7;
                    4'b1000 : disp_num = LED8;
                    4'b1001 : disp_num = LED9;
                    endcase
                end
                    
            2'b11: begin
                case(hourten)
                    4'b0000 : disp_num = LED0;
                    4'b0001 : disp_num = LED1;
                    endcase
                end
        endcase
    end
endmodule
