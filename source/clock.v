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
//????????????????????????¡ì????????????????????????????????????A??????????
//?????????????????????????????????????????????
//????????????????????????????????
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
    
    //???????????
    //???????????¡ì?????????????????????????????????
    always @(posedge set)
    begin
            reg_hour=hour0;
            reg_hour=reg_hour+hour1*10;
            reg_hour=reg_hour%24;

            reg_minute=reg_minute+minute0;
            reg_minute=reg_minute+minute1*10;
            reg_minute=reg_minute%60;
    end
    //?????????????
    
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
