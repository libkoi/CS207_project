`timescale 1ns / 1ps

module StateMachine(
    input clk,
    input rst,
    // input change,

    input next, //next digit switch
    input sound_on,
    input alarm_on,
    //input [5:0] alhour; \
    //input [5:0] alminute; \

    input h,    // hour increase buttom
    input min,  // hour increase buttom

    output reg sound_on_led,
    output reg alarm_on_led,
    // input [3:0] row, 
    // output [3:0] col,
    // binary output for hour/minute/second
    output reg[5:0] hour,
    output reg[5:0] minute,
    output reg[5:0] second,
    // end binary output
    output [7:0] seg_out,
    output [7:0] seg_en,
    output speak
    //output reg[2:0] twink
);

// reg state;
reg set_time;
// Variable for transit purpose, regardless of misleading naming(
wire [5:0] reg_hour;
wire [5:0] reg_minute;
wire [5:0] reg_second;
// wire [5:0] key_hour;
// wire [5:0] key_minute;
// wire [2:0] twinkle;

// End of transit variable

// reg start;

clock c(clk, rst, h, min, set_time, key_hour, key_minute, reg_hour, reg_minute, reg_second);
display d(rst, clk, reg_hour, reg_minute, reg_second, seg_out, seg_en);

  //  naoning nao(on,clk,reg_hour,reg_minute,reg_second,speak);

sound sd(sound_on, clk, reg_hour, reg_minute, reg_second, speak);
//alarm al(alarm_on, clk, alhour, almin, speak);\

// SetTime st(clk, rst, start, next, row, col, key_hour, key_minute, twinkle);

//////////////////////////////////////////////////////////
// Use led to show current sound/alarm switch status
always @(posedge clk)
    begin
        sound_on_led = sound_on;
        alarm_on_led = alarm_on;
    end

//////////////////////////////////////////////////////////


// SetTime st(clk,rst,start,next,row,col,key_hour,key_minute,twinkle); 
//    always @(posedge rst or posedge change)
//    begin
//        if(rst)
//            state=0;
//        else if(change)
//            state=~state;
//    end
    
//    always @(posedge clk)
//    begin
//        if(state)
//        begin
//            start=1;
//            #100
//            start=0;
//        end
//    end
//    always @(posedge state)
//    begin
//        start=1'b1;      
//    end
//    always @(state)
//    begin
//        if(twinkle==3'b100)
//        begin
//            set_time=1'b1;
//            #100
//            set_time=1'b0;
//        end
//    end

//////////////////////////////////////////////////////////
// So what's this block's purpose? ((
always @(posedge clk)
    begin
        hour = reg_hour;
        minute = reg_minute;
        second = reg_second;
    end
//////////////////////////////////////////////////////////

endmodule
