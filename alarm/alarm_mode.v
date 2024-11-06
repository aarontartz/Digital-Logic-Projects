`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 01:12:31 PM
// Design Name: 
// Module Name: alarm_mode
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


module alarm_mode(
    input clk_1Hz,
    input rst,
    input alarm_active,
    input count_active,  // LED lights if both alarm and count modes are on
    input increase_min,
    input increase_hour,
    output reg hourten,
    output reg [3:0] hour,
    output reg [2:0] minten,
    output reg [3:0] min,
    output reg led
);

    // Flag to ensure the initial time is set only once
    reg initial_time_set;

    // Registers to store the saved time
    reg [3:0] saved_min;
    reg [2:0] saved_minten;
    reg [3:0] saved_hour;
    reg saved_hourten;

    // Counter to keep the LED on for 5 seconds
    reg [2:0] led_countdown;
    
    // Control Logic for min, minten, hour, and hourten
    always @(posedge clk_1Hz or posedge rst) begin
        if (rst) begin
            min <= 5;
            minten <= 5;
            hour <= 2;
            hourten <= 1;
            initial_time_set <= 0;  // Reset the flag on reset
            led <= 0;               // Turn off LED on reset
        end 
        else if (!alarm_active) begin
            // Normal minute increment logic when alarm_active is off
            if (min == 9) begin
                min <= 0;
                if (minten == 5) begin
                    minten <= 0;
                end else begin
                    minten <= minten + 1;
                end
            end else begin
                min <= min + 1;
            end

            // Hour increment logic based on minutes
            if (minten == 5 && min == 9) begin
                if (hour == 9 && hourten == 0) begin
                    hour <= 0;
                    hourten <= 1;
                end else if (hour == 2 && hourten == 1) begin
                    hour <= 1;
                    hourten <= 0;
                end else begin
                    hour <= hour + 1;
                end
            end
        end
        else if (alarm_active && count_active && !initial_time_set) begin
            // Set initial time only once when alarm_active and count_active are both active
            min <= 5;
            minten <= 5;
            hour <= 2;
            hourten <= 1;
            initial_time_set <= 1;  // Mark that the initial time has been set
        end 
        else if (alarm_active && count_active && initial_time_set) begin
            // Continue clock increment when both buttons are active
            if (min == 9) begin
                min <= 0;
                if (minten == 5) begin
                    minten <= 0;
                end else begin
                    minten <= minten + 1;
                end
            end else begin
                min <= min + 1;
            end

            // Hour increment logic based on minutes
            if (minten == 5 && min == 9) begin
                if (hour == 9 && hourten == 0) begin
                    hour <= 0;
                    hourten <= 1;
                end else if (hour == 2 && hourten == 1) begin
                    hour <= 1;
                    hourten <= 0;
                end else begin
                    hour <= hour + 1;
                end
            end
            
            // Turn on the LED if min == 4 and keep it on for 5 seconds
            if ((min == saved_min) && (minten == saved_minten) && (hour == saved_hour) && (hourten == saved_hourten)) begin
                led <= 1;  // Turn on LED (U16)
                led_countdown <= 5;  // Start 5-second countdown
            end else if (led_countdown > 0) begin
                led <= 1;  // Keep LED on during countdown
                led_countdown <= led_countdown - 1;  // Decrement countdown
            end else begin
                led <= 0;  // Turn off LED if min is not 4 and countdown is 0
            end

        end 
        else begin
            // Reset the initial time set flag if the buttons are no longer both active
            if (!(alarm_active && count_active)) begin
                initial_time_set <= 0;  // Reset flag to allow for reactivation
            end

            // Alarm Mode Logic for Incrementing Minutes and Hours
            if (alarm_active) begin
                if (increase_min) begin
                    if (min == 9) begin
                        min <= 0;
                        if (minten == 5) begin
                            minten <= 0;
                        end else begin
                            minten <= minten + 1;
                        end
                    end else begin
                        min <= min + 1;
                    end
                    // Save the current time when both buttons are pressed
                    saved_min <= min;
                    saved_minten <= minten;
                    saved_hour <= hour;
                    saved_hourten <= hourten;
                end

                else if (increase_hour) begin
                    if (hour == 9) begin
                        hour <= 0;
                        if (hourten == 2) begin
                            hourten <= 0;
                        end else begin
                            hourten <= hourten + 1;
                        end
                    end else begin
                        hour <= hour + 1;
                    end
                    // Save the current time when both buttons are pressed
                    saved_min <= min;
                    saved_minten <= minten;
                    saved_hour <= hour;
                    saved_hourten <= hourten;
                end
            end
        end
    end

endmodule
