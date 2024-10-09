`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/24/2024 09:44:13 AM 
// Module Name: uart_rx
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_rx(
    input wire baud_clk,
    input wire data_en,
    input wire data_in,
  output reg [7:0] data_out,
    output wire fsm_clk
    );
    
    localparam [1:0] START = 2'b00,
                     DATA  = 2'b01,         
                     STOP  = 2'b10,
                     IDLE  = 2'b11;
                     
    reg [1:0] state = IDLE;    // state register
    reg [7:0] data;
    reg [3:0] index = 0;
    
    reg fsm_clk_reg = 0;
    assign fsm_clk = fsm_clk_reg;


    always @(posedge baud_clk) begin
        case (state)
            START: begin
                state <= DATA;
            end
            DATA: begin
                if (index == 7)
                    state <= STOP;
                else
                    index <= index + 1;
            end
            STOP: begin
                index <= 0;
                if (data_en == 1)
                    state <= START;
                else
                    state <= IDLE;
            end
            IDLE: begin
            end
        endcase
    end

    always @(*) begin
        case (state)
            START: begin
                data = 0;
            end
            DATA: begin
                data_out = data;
            end
            STOP: begin
            end
            IDLE: begin
            end
        endcase
    end

    
    
    always @(posedge baud_clk) begin
        case (state)
            START: begin
                fsm_clk_reg <= 1;
                data <= data_in;
                state <= DATA;
            end
            DATA: begin
                if (index == 7)
                    state <= STOP;
                else
                    index <= index + 1;
            end
            STOP: begin
                index <= 0;
                fsm_clk_reg <= 0;
                if (data_en == 1)
                    state <= START;
                else
                    state <= IDLE;
            end
            IDLE: begin
                if (data_en == 1)
                    state <= START;
            end
        endcase
    end
    
    always @(*) begin
        case (state)
            START: begin
                o_bit = 0;
            end
            DATA: begin
                o_bit = data[index];
            end
            STOP: begin
                o_bit = 1;
            end
            IDLE: begin
                o_bit = 1;
            end
        endcase
    end
endmodule