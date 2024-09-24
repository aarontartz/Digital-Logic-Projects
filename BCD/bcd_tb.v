// Company: 
// Engineer: 
// 
// Create Date: 08/28/2024 12:37:20 PM
// Design Name: 
// Module Name: bcd_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
//////////////////////////////////////////////////////////////////////////////////


module bcd_tb;
    reg [3:0] d;
    reg clk;
    reg en;
    reg load;
    reg up;
    reg clr;
    wire [3:0] q;
    wire co;

    bcd bcd00 (
        .d(d),
        .clk(clk),
        .en(en),
        .load(load),
        .up(up),
        .clr(clr),
        .q(q),
        .co(co)
    );

    initial begin
        d <= 4'd3;
        clk = 1;
        en = 0;
        load = 0;
        up = 0;
        clr = 0;
    end

    always #10 clk = ~clk;
    
    initial begin
        @(posedge clk);
        clr <= 1;
        load <= 1;
        en <= 1;
        @(posedge clk);
        load <= 0;
        up <= 1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        up <= 0;
        @(posedge clk);
        @(posedge clk);
        clr <= 0;
    end
endmodule
