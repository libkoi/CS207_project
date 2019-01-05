`timescale 1ns / 1ps

module alarm(
    input on, clk,
    input [5:0] alhour, [5:0] almin,
    output speak
);

reg[19:0] sound;

ring  a(on, clk, sound, speak);

//////////////////////////////////////////////////////////
// alarm like this: 
// 3--1--2--5(-)----|5(-)--2--3--1----|5(-)----5(-)----5(-)----
// time is defined by input "alhour" and "almin"

always@ (posedge clk)
    begin
    if(min == 6'd0)
        begin
        case(sec)
            6'd0: sound = 20'd113636;
            6'd1: sound = 20'd170300;
            6'd2: sound = 20'd151700;
            6'd3: sound = 20'd191131;
            6'd4: sound = 20'd191131;
            6'd5: sound = 20'd0;
            6'd6: sound = 20'd191131;
            6'd7: sound = 20'd143184;
            6'd8: sound = 20'd113636;
            6'd9: sound = 20'd170300;
            6'd10: sound = 20'd0;
            6'd11: sound = 20'd191131;
            6'd12: sound = 20'd191131;
            6'd13: sound = 20'd0;
            6'd14: sound = 20'd191131;
            6'd15: sound = 20'd191131;
            6'd16: sound = 20'd0;
            6'd17: sound = 20'd191131;
            6'd18: sound = 20'd191131;
            default sound = 20'd0;
        endcase
        end
    else sound = 17'd0;
    end
//////////////////////////////////////////////////////////

endmodule
