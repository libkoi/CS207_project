`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SUSTech
// Engineer: Chen Yuheng
// 
// Create Date: 2018/12/12 15:38:53
// Design Name: 
// Module Name: Clock
// Project Name: Alarm Clock
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
module clock(
    input clk, 
    rst,
    h,
    min, 
    output reg[5:0] hour, 
    output reg[5:0] minute, 
    output reg[5:0] second
    );
    
    wire clk_fbps;//每秒跳动四次的时钟信号
    reg[5:0] reg_hour,reg_minute,reg_second;
    counter ct(clk,rst,clk_bps);//每秒一次的时钟信号的分频模块
    counter_tube u_t(clk,rst,clk_fbps);//每秒四次的时钟信号的分频模块
   
    always @(posedge clk)
    begin
        hour=reg_hour;
        minute=reg_minute;
        second=reg_second;
        if(rst)
        begin
            reg_hour<=6'b000_000;
            reg_minute<=6'b000_000;
            reg_second<=6'b000_000;
        end
    end//赋值与归零
    
    always @(posedge clk_bps or posedge rst)
    begin
        if(rst)
            reg_second<=6'b000000;
        else if(reg_second==6'd59)
            reg_second<=6'd0;
        else
            reg_second<=reg_second+1'b1;
    end//秒钟跳动
    
    reg[1:0] c1;
    always @(posedge clk_fbps or posedge rst)
    begin
        c1=c1+1;
        if(c1==2'b00 && ~min)//当不处于调整时间模式时
        begin
            if(rst)
                reg_minute<=6'b000000;   
            else if(reg_minute==6'd59 )
            begin
                if(reg_second==6'd59)
                reg_minute<=6'd0;
            end
            else if(reg_second==6'd59)
                reg_minute<=reg_minute+1'b1;
        end
        else if(min)//当处于调整时间模式时
        begin
            if(rst)
                reg_minute<=6'b000000;
            else if(reg_minute==6'd59)
                reg_minute<=6'd0;
            else
                reg_minute<=reg_minute+1;
        end
    end//分钟跳动
    
    reg [1:0] c2;
    always @(posedge clk_fbps , posedge rst)
    begin
        c2=c2+1;
        if(~h&&c2==2'b00)//当不处于调整时间模式时
        begin
            if(rst)
                reg_hour<=6'b000000;
            else if(reg_hour==6'd23 )
            begin
                if(reg_minute==6'd59)
                begin
                    if(reg_second==6'd59)
                        reg_hour<=6'd0;
                end
            end
            else if(reg_minute==6'd59)
            begin
                if(reg_second==6'd59)
                    reg_hour<=reg_hour+1'b1;
            end   
        end
        else if(h)//当处于调整时间模式时
        begin
            if(rst)
                reg_hour<=6'b000000;
            else if(reg_hour==6'd23)
                reg_hour<=6'd0;
            else
                reg_hour<=reg_hour+1;
        end     
    end//时种跳动
endmodule

module counter(input clk, rst,output clk_bps);//每秒一次分频模块
    reg [13:0] cnt_first, cnt_second;
    always @(posedge clk or posedge rst)
        if(rst)
            cnt_first<=14'd0;
        else if(cnt_first==14'd10000)
            cnt_first<=14'd0;
        else
            cnt_first<=cnt_first+1'b1;
    always @(posedge clk or posedge rst)
        if(rst)
            cnt_second<=14'd0;
        else if(cnt_second==14'd10000)
            cnt_second<=14'd0;
        else if(cnt_first==14'd10000)
            cnt_second<=cnt_second+1'b1;
    assign clk_bps= cnt_second == 14'd10000 ? 1'b1:1'b0;
endmodule

module counter_tube(input clk, rst,output clk_bps_tube);//每秒4次分频模块
    reg [13:0] cnt_first, cnt_second;
    always @(posedge clk or posedge rst)
        if(rst)
            cnt_first<=14'd0;
        else if(cnt_first==14'd10000)
            cnt_first<=14'd0;
        else
            cnt_first<=cnt_first+1'b1;
    always @(posedge clk or posedge rst)
        if(rst)
            cnt_second<=14'd0;
        else if(cnt_second==14'd2500)
            cnt_second<=14'd0;
        else if(cnt_first==14'd10000)
            cnt_second<=cnt_second+1'b1;
    assign clk_bps_tube= cnt_second == 14'd2500 ? 1'b1:1'b0;
endmodule