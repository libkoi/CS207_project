`timescale 1ns / 1ps

module StateMachine(
    input clk,
    input rst,

    input sound_on,
    input [5:0] alhour,
    input [5:0] alminute,

    input h,    // hour increase buttom
    input min,  // hour increase buttom

    output reg sound_on_led,
    
    // binary output for hour/minute/second
    output reg[5:0] hour,
    output reg[5:0] minute,
    output reg[5:0] second,
    // end binary output
    
    output [7:0] seg_out,
    output [7:0] seg_en,
    output speak
);

wire [5:0] wire_hour_clock;
wire [5:0] wire_minute_clock;
wire [5:0] wire_second_clock;

clock c(clk, rst, h, min, wire_hour_clock, wire_minute_clock, wire_second_clock);
display d(rst, clk, wire_hour_clock, wire_minute_clock, wire_second_clock, seg_out, seg_en);
sound sd(sound_on, clk, wire_hour_clock, wire_minute_clock, wire_second_clock, alhour, alminute, speak);


//////////////////////////////////////////////////////////
// Use led to show current sound/alarm switch status
always @(posedge clk)
    sound_on_led = sound_on;
//////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////
// Transit variable information update
always @(posedge clk)
    begin
        hour <= wire_hour_clock;
        minute <= wire_minute_clock;
        second <= wire_second_clock;
    end
//////////////////////////////////////////////////////////

endmodule
