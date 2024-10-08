`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 09/24/2024 11:41:19 AM
// Module Name: tx_tb
// 
//////////////////////////////////////////////////////////////////////////////////


module tx_tb;
    reg clk;
    reg data_en;
    reg [7:0] data;
    wire tx_out;
    wire fsm_clk;
    wire baud_clk_wire;

    wire [7:0] lastname [0:4];
    assign lastname[0] = "T";
    assign lastname[1] = "a";
    assign lastname[2] = "r";
    assign lastname[3] = "t";
    assign lastname[4] = "z";
    
    reg [4:0] index = 0;
    
    baud_gen baud_gen00 (
        .clk(clk),
        .baud_clk(baud_clk_wire)
    );
    
    uart_tx uart_tx00 (
        .baud_clk(baud_clk_wire),
        .data_en(data_en),
        .data_in(data),
        .tx_out(tx_out),
        .fsm_clk(fsm_clk)
    );                              
    
    always #10 clk = ~clk;
    
    initial begin
        clk <= 0;
        data_en <= 0;
        //data <= lastname[index];
        @(posedge baud_clk_wire);
        @(posedge baud_clk_wire);
        data_en <= 1;
    end
    
    always @(posedge fsm_clk) begin
        if (index == 4)
            data_en <= 0;
        else
            index <= index + 1;
    end
    
    always @(*) data <= lastname[index];
    
endmodule
