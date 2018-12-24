`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/23 14:07:14
// Design Name: 
// Module Name: SetTime
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


module SetTime(
input clk,
input rst,
input next,
input [3:0] row, 
output [3:0] col,
output[5:0] hour, 
minute,  
output [2:0] twinkle);//闪烁数位，也就是当前设置数位，0_00时针十位，0_01时针个位，0_10分针十位，0_11分针个位
wire[3:0] val;
reg[5:0] hour,minute;
reg[2:0] twinkle;
get_key u(clk,rst,row,col,val);

always @(posedge next)
begin
    case(twinkle)
        3'b000:hour=val*10;
        3'b001:hour=hour+val;
        3'b010:minute=val*10;
        3'b011:minute=minute+val;
    endcase
    twinkle=twinkle+2'b01;
end

endmodule
