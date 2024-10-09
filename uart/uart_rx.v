`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/24/2024 07:23:04 PM 
// Module Name: uart_rx
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_rx(
    input wire rx_pulse,
    input wire rx_en,
    input wire rx_in,
    output reg [7:0] data_out
    );
    
    localparam [1:0] START = 2'b00,
                     DATA  = 2'b01,         
                     STOP  = 2'b10,
                     IDLE  = 2'b11;
                     
    reg [1:0] state = IDLE;    // state register
    
    reg rx_in_reg;
    reg [7:0] data = 0;
    reg [3:0] index = 0;
    
    always @(posedge rx_pulse) begin
        rx_in_reg <= rx_in;
        case (state)
            START: begin
                state <= DATA;
            end
            DATA: begin
                if (index == 7 && rx_in == 1)
                    state <= STOP;
                else
                    index <= index + 1;
            end
            STOP: begin
                index <= 0;
                if (rx_en == 1)
                    state <= START;
                else
                    state <= IDLE;
            end
            IDLE: begin
                if (rx_en == 1 && rx_in == 0)
                    state <= START;
            end
        endcase
    end

    always @(*) begin
        case (state)
            DATA: begin
                data[index] = rx_in_reg;
            end
            STOP: begin
                data_out = data;
            end
        endcase
    end
endmodule
