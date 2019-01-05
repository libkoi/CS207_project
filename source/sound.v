`timescale 1ns / 1ps

module sound(
    input on,clk,
    input [5:0] hour,[5:0] min,[5:0] sec,
    input [5:0] alhour, [5:0] almin,
    output speak
);

reg [19:0] sound;
reg  ringing = 1;    

ring  a(on, clk, sound, speak);

//////////////////////////////////////////////////////////
// alarm like this: 
// 3--1--2--5(-)----|5(-)--2--3--1----|5(-)----5(-)----5(-)----
// time is defined by input "alhour" and "almin"

always@ (posedge clk)
begin
    if(alhour == hour && almin == min)
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
    else if(ringing == 1)
        sound <= 20'd20000;
    else
       sound <= 0;
end
//////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////
// Single "di" ring, relevent to current hour
// also, use enum because loop is too haed for me(

// i.e. for 04:00, it will heard like: 
    // 04:00:00 "di"
    // 04:00:01 null
    // 04:00:02 "di"
    // 04:00:03 null
    // 04:00:04 "di"
    // 04:00:05 null
    // 04:00:06 "di"

always@ (posedge clk)
    begin
        if(min == 6'd0)
        begin
            if(hour == 0||hour == 12)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        4: ringing <= 1;
                        6: ringing <= 1;
                        8: ringing <= 1;
                        10: ringing <= 1;
                        12: ringing <= 1;
                        14: ringing <= 1;
                        16: ringing <= 1;
                        18: ringing <= 1;
                        20: ringing <= 1;
                        22: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 1||hour == 13)
                begin
                    case (sec)
                        0: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 2||hour == 14)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 3||hour == 15)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        4: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 4||hour == 16)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        4: ringing <= 1;
                        6: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 5||hour == 17)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        4: ringing <= 1;
                        6: ringing <= 1;
                        8: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 6||hour == 18)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        4: ringing <= 1;
                        6: ringing <= 1;
                        8: ringing <= 1;
                        10: ringing <= 1;
                        default ringing <= 0;
                    endcase
                 end
            if(hour == 7||hour == 19)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        4: ringing <= 1;
                        6: ringing <= 1;
                        8: ringing <= 1;
                        10: ringing <= 1;
                        12: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 8||hour == 20)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        4: ringing <= 1;
                        6: ringing <= 1;
                        8: ringing <= 1;
                        10: ringing <= 1;
                        12: ringing <= 1;
                        14: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 9||hour == 21)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        4: ringing <= 1;
                        6: ringing <= 1;
                        8: ringing <= 1;
                        10: ringing <= 1;
                        12: ringing <= 1;
                        14: ringing <= 1;
                        16: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 10||hour == 22)
                begin
                    case (sec)
                        0: ringing <= 1;
                        2: ringing <= 1;
                        4: ringing <= 1;
                        6: ringing <= 1;
                        8: ringing <= 1;
                        10: ringing <= 1;
                        12: ringing <= 1;
                        14: ringing <= 1;
                        16: ringing <= 1;
                        18: ringing <= 1;
                        default ringing <= 0;
                    endcase
                end
            if(hour == 11||hour == 23)
                begin
                    case (sec)
                    0: ringing <= 1;
                    2: ringing <= 1;
                    4: ringing <= 1;
                    6: ringing <= 1;
                    8: ringing <= 1;
                    10: ringing <= 1;
                    12: ringing <= 1;
                    14: ringing <= 1;
                    16: ringing <= 1;
                    18: ringing <= 1;
                    20: ringing <= 1;
                    default ringing <= 0;
                    endcase
                end
        end
        else ringing <= 0;
    end
//////////////////////////////////////////////////////////

endmodule


module ring(
    input on, clk, [19:0] sound,
    output reg speak // connected to buzzer
);

reg [19:0] counter;

//////////////////////////////////////////////////////////
//ring control module
always @(posedge clk)
    begin
    if(on)
        begin
            if(counter >= sound) 
            begin
                counter <= 0; 
                if(speak == 1)
                    speak <= 0;
                else speak <= 1;
            end
            else counter <= counter + 1;
        end
    else speak <= 0;
    end
//////////////////////////////////////////////////////////

endmodule