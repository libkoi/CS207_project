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
 set,
[3:0]hour1,
[3:0]hour0,
[3:0]minute1,
[3:0]minute0, 
output[5:0] hour, 
minute, 
second);
//四个输入设置时间的输入分别代表小时的十位、个位、分钟的十位、个位。输入为A代表不用设置
//这个模块不想处理输入时间的异常，希望传入模块已做好异常处理
//三个输出直接用六位二进制数表示时分秒
    wire[0:0] clk_bps;
    
    reg[5:0] reg_hour,reg_minute,reg_second;
    counter u_c(clk,rst,clk_bps);
    always @(posedge clk or posedge rst)
        if(rst)
        begin
            reg_hour<=6'd0;
            reg_minute<=6'd0;
            reg_second<=6'd0;
        end
    always @(posedge clk_bps)
    begin
        if(reg_second==6'd59)
            reg_second<=6'd0;
        else
            reg_second<=reg_second+1'b1;
    end
    always @(posedge clk_bps)
        begin
            if(reg_minute==6'd59 )
            begin
                if(reg_second==6'd59)
                reg_minute<=6'd0;
            end
            else if(reg_second==6'd59)
                reg_minute<=reg_minute+1'b1;
        end
    always @(posedge clk_bps)
    begin
        if(reg_hour==6'd23 )
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
    
    //设置时间代码开始
    //这段代码可能有错，也可能会与时钟的跳动产生冲突，待测试
    always @(posedge set)
    begin
            reg_hour=hour0;
            reg_hour=reg_hour+hour1*10;
            reg_hour=reg_hour%24;

            reg_minute=reg_minute+minute0;
            reg_minute=reg_minute+minute1*10;
            reg_minute=reg_minute%60;
    end
    //设置时间代码结束
    
    assign hour=reg_hour;
    assign minute=reg_minute;
    assign second=reg_second;
endmodule

module counter(input clk, rst,output clk_bps);
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
