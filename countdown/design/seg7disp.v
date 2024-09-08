`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//
// Create Date: 09/07/2024 09:00:01 PM
// Design Name: 
// Module Name: disp7seg
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


module disp7seg(
    input wire clk,
    output wire ck_io1,
    output wire ck_io2,
    output wire ck_io4,
    output wire ck_io5,
    output wire ck_io6,
    output wire ck_io7,
    output wire ck_io9,
    output wire ck_io10
    );
    
    localparam [3:0] STATE_F        = 4'b1111,
                     STATE_E        = 4'b1110,         
                     STATE_D        = 4'b1101,
                     STATE_C        = 4'b1100,
                     STATE_B        = 4'b1011,
                     STATE_A        = 4'b1010,
                     STATE_9        = 4'b1001,
                     STATE_8        = 4'b1000,
                     STATE_7        = 4'b0111,
                     STATE_6        = 4'b0110,
                     STATE_5        = 4'b0101,
                     STATE_4        = 4'b0100,
                     STATE_3        = 4'b0011,
                     STATE_2        = 4'b0010,
                     STATE_1        = 4'b0001,
                     STATE_0        = 4'b0000;
                     
    reg [3:0] state = STATE_F;
    reg [31:0] count = 0;
    reg [7:0] disp_num;
    
    assign {ck_io1, ck_io2, ck_io4, ck_io5, ck_io6, ck_io7, ck_io9, ck_io10} = disp_num;
    
    always @(posedge clk) begin
        count <= count + 1;
        case (state)
            STATE_F: begin
                disp_num <= 8'b10000111;
                if (count == 100_000_000)
                    state <= STATE_E;
            end
            STATE_E: begin
                disp_num <= 8'b11000111;
                if (count == 200_000_000)
                    state <= STATE_D;
            end
            STATE_D: begin
                disp_num <= 8'b11101001;
                if (count == 300_000_000)
                    state <= STATE_C;
            end
            STATE_C: begin
                disp_num <= 8'b11000110;
                if (count == 400_000_000)
                    state <= STATE_B;
            end
            STATE_B: begin
                disp_num <= 8'b11100011;
                if (count == 500_000_000)
                    state <= STATE_A;
            end
            STATE_A: begin
                disp_num <= 8'b10101111;
                if (count == 600_000_000)
                    state <= STATE_9;
            end
            STATE_9: begin
                disp_num <= 8'b01101111;
                if (count == 700_000_000)
                    state <= STATE_8;
            end
            STATE_8: begin
                disp_num <= 8'b11101111;
                if (count == 800_000_000)
                    state <= STATE_7;
            end
            STATE_7: begin
                disp_num <= 8'b00101100;
                if (count == 900_000_000)
                    state <= STATE_6;
            end
            STATE_6: begin
                disp_num <= 8'b11100111;
                if (count == 1_000_000_000)
                    state <= STATE_5;
            end
            STATE_5: begin
                disp_num <= 8'b01100111;
                if (count == 1_100_000_000)
                    state <= STATE_4;
            end
            STATE_4: begin
                disp_num <= 8'b00101011;
                if (count == 1_200_000_000)
                    state <= STATE_3;
            end
            STATE_3: begin
                disp_num <= 8'b01101101;
                if (count == 1_300_000_000)
                    state <= STATE_2;
            end
            STATE_2: begin
                disp_num <= 8'b11001101;
                if (count == 1_400_000_000)
                    state <= STATE_1;
            end
            STATE_1: begin
                disp_num <= 8'b00101000;
                if (count == 1_500_000_000)
                    state <= STATE_0;
            end
            STATE_0: begin
                disp_num <= 8'b11101110;
                if (count == 1_600_000_000) begin
                    state <= STATE_F;
                    count <= 1'b0;
                end
            end
        endcase
    end
endmodule
