`timescale 1ns / 1ps

module clock(
    input on, clk,
    input [5:0] min, [5:0]sec, [5:0] hour,
    output speak
);

reg[19:0] sound = 0;
reg  ringing = 1;

ring  a(on, clk, sound, speak);

//////////////////////////////////////////////////////////
// Ring "on the clock", ring time depends on current hour
// As an loop expression is too difficult, just provide a enum way(
always@ (posedge clk)
    begin
    if(min == 6'd0)
        begin

// Ring count on each hour 
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
// End of Ring count
    else ringing <= 0;
    end

//////////////////////////////////////////////////////////
    

//////////////////////////////////////////////////////////
// Sound setting
always@(posedge clk)
    begin
    if(ringing == 1)
        begin 
            sound <= 20'd20000;
        end
    else
        sound <= 0;
    end
//////////////////////////////////////////////////////////

endmodule
