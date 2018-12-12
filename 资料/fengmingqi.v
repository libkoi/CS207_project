`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 22:37:43
// Design Name: 
// Module Name: fengmingqi
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


module fengmingqi(input clk,rst,t,output f);
reg f1;
wire clk_bps,f;
counter2 u_c(clk,rst,clk_bps);
always @(posedge clk_bps && t==1'b1)
begin
    if(f1==1'b0)
        f1=1'b1;
    else if(f1==1'b1)
        f1=1'b0;
    else
        f1=1'b1;
end
assign f=f1;
endmodule

module counter2(input clk, rst,output clk_bps);
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
        else if(cnt_second==14'd10)
            cnt_second<=14'd0;
        else if(cnt_first==14'd10000)
            cnt_second<=cnt_second+1'b1;
    assign clk_bps= cnt_second == 14'd10 ? 1'b1:1'b0;
endmodule