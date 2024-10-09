`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 10/08/2024 11:51:21 PM
// Module Name: top_tb
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb;
    reg clk;
    reg tx_en;
    reg rx_en;
    reg [7:0] data_in;
    wire fsm_clk;   // for sending multiple letters, but not needed for one (refer to tx_tb for example)
    wire [7:0] rx_out;

    wire [7:0] lastname [0:4];
    assign lastname[0] = "T";
    //assign lastname[1] = "a";
    //assign lastname[2] = "r";
    //assign lastname[3] = "t";
    //assign lastname[4] = "z";
    
    reg [4:0] index = 0;
    
    top top00 (
        .clk(clk),
        .tx_en(tx_en),
        .rx_en(rx_en),
        .data_in(data_in),
        .fsm_clk(fsm_clk),
        .rx_out(rx_out)
    );                       
    
    always #10 clk = ~clk;
    
    initial begin
        clk <= 0;
        tx_en <= 0;
        rx_en <= 0;
        //data <= lastname[index];
        @(posedge clk);
        @(posedge clk);
        tx_en <= 1;
        rx_en <= 1;
    end
    
    always @(*) data_in <= lastname[index];
    
endmodule
