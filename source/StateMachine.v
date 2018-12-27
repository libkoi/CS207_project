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
    input clk,//100MHz晶震时钟信号
    input rst,//重置信号，测试用
    input on,//声音功能开关
    input h,//调整小时的按钮
    input min,//调整分钟的按钮
    output reg sound_on,//声音功能开关提示灯
    output reg[5:0] hour,//二进制时钟小时输出
    output reg[5:0] minute,//二进制时钟分钟输出
    output reg[5:0] second,//二进制时钟秒输出
    output [7:0] seg_out,
    output [7:0] seg_en,//显示器输出
    output speak//蜂鸣器输出
    );
    
    wire [5:0] reg_hour;
    wire [5:0] reg_minute;
    wire [5:0] reg_second;//中间变量
    
    clock c(clk,rst,h,min,reg_hour,reg_minute,reg_second);//时钟模块
    display d(rst,clk,reg_hour,reg_minute,reg_second,seg_out,seg_en);//显示模块
    sound sd(on,clk,reg_hour,reg_minute,reg_second,speak);//声音模块
    
    always @(posedge clk)
    sound_on=on;
    //控制声音开关
    
    always @(posedge clk)
    begin
        hour=reg_hour;
        minute=reg_minute;
        second=reg_second;
    end
    //设置时间
endmodule
