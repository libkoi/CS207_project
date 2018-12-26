`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/23 14:51:31
// Design Name: 
// Module Name: StateMachine
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


module StateMachine(
    input clk,
    input rst,
    input change,
   input next,//切换设置数位
   input on,
   input h,
   input min,
    output reg sound_on,
    input [3:0] row, 
    output [3:0] col,
    output reg[5:0] hour,//二进制输出
    output reg[5:0] minute,//二进制输出
    output reg[5:0] second,//二进制输出
    output [7:0] seg_out,
    output [7:0] seg_en,
    output speak
    //output reg[2:0] twink
    );
    reg state;
    reg set_time;
    wire [5:0] reg_hour;
    wire [5:0] reg_minute;
    wire [5:0] reg_second;
    wire [5:0] key_hour;
    wire [5:0] key_minute;
    wire [2:0] twinkle;
    reg start;
    clock c(clk,rst,h,min,set_time,key_hour,key_minute,reg_hour,reg_minute,reg_second);
    display d(rst,clk,reg_hour,reg_minute,reg_second,seg_out,seg_en);
  //  naoning nao(on,clk,reg_hour,reg_minute,reg_second,speak);
    sound sd(on,clk,reg_hour,reg_minute,reg_second,speak);
    SetTime st(clk,rst,start,next,row,col,key_hour,key_minute,twinkle);
    always @(posedge clk)
    sound_on=on;
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


    always @(posedge clk)
    begin
        hour=reg_hour;
        minute=reg_minute;
        second=reg_second;
    end
endmodule
