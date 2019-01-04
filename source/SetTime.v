`timescale 1ns / 1ps

module SetTime(
    input clk,
    input rst,
    input start,
    input next,
    input [3:0] row, 
    output [3:0] col,
    output[5:0] hour, 
    minute,  
    output [2:0] twinkle  // twinkle digit (current setting digit)
        //0_00 --> hour(large), 0_01 --> hour(small)
        //0_10 --> minute(large), 0_11 --> minute(small)
);

wire[3:0] val;
reg[5:0] hour,minute;
reg[2:0] twinkle;
get_key u(clk,rst,row,col,val);

always @(posedge next or posedge start)
begin
    if(start)
    twinkle=3'b000;
    else
    begin
    case(twinkle)
        3'b000:hour=val*10;
        3'b001:hour=hour+val;
        3'b010:minute=val*10;
        3'b011:minute=minute+val;
    endcase
    twinkle=twinkle+3'b001;
    end
end
endmodule
