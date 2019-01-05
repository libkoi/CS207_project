`timescale 1ns / 1ps


module clock(
    input clk, 
    rst,
    h,
    min,
    output reg[5:0] hour, 
    output reg[5:0] minute, 
    output reg[5:0] second
);


// Four timeset input represent hour(high/low digit), minute(high/low digit)
// A stands for "not need for set"
// NO illegal input time detect, they will be fixed before input
// Binary output for hour/minute/second

wire clk_bps;
wire clk_fbps;
reg [5:0] reg_hour, reg_minute, reg_second;
    
counter u_c(clk,rst,clk_bps);
counter_tube u_t(clk,rst,clk_fbps);

//////////////////////////////////////////////////////////
// Update
always @(posedge clk)
    begin
        hour = reg_hour;
        minute = reg_minute;
        second = reg_second;
    end

// Tested but not work... sad

// always @(posedge clk or posedge rst)
//     begin
//         if(rst) begin
//             reg_hour <=6'b0;
//             reg_minute <=6'b0;
//             reg_second <=6'b0;
//             hour <=6'b0;
//             minute <=6'b0;
//             second <=6'b0;
//         end
//         else begin
//             hour = reg_hour;
//             minute = reg_minute;
//             second = reg_second;
//         end
//     end
//////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////
// second change counter
always @(posedge clk_bps or posedge rst)
    begin
        if(rst)
            reg_second <= 6'b000000;
        else if(reg_second == 6'd59)
            reg_second <= 6'd0;
        else
            reg_second <= reg_second + 1'b1;
    end
//////////////////////////////////////////////////////////


reg [2:0] mm;
reg [2:0] mh;
reg cm;
reg ch;
reg [1:0] c1;
reg [1:0] c2;


//////////////////////////////////////////////////////////
// "min" buttom. press to increase minute

always @(posedge clk_fbps or posedge rst)
begin
    c1 = c1 + 1;
    if(c1 == 2'b00 && ~min)
        begin
            if(rst)
                reg_minute <= 6'b000000;
            else if(reg_minute == 6'd59 )
            begin
                if(reg_second == 6'd59)
                reg_minute <= 6'd0;
            end
            else if(reg_second == 6'd59)
                reg_minute <= reg_minute + 1'b1;
        end
        else if(min)
        begin
            if(rst)
                reg_minute <= 6'b000000;
            else if(reg_minute == 6'd59)
                reg_minute <= 6'd0;
            else
                reg_minute <= reg_minute+1;
        end
end
//////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////
// "h" buttom. press to increase hour

always @(posedge clk_fbps , posedge rst)
begin
    c2=c2+1;
    if(~h && c2 == 2'b00)
    begin
        if(rst)
            reg_hour <= 6'b000000;
        else if(reg_hour == 6'd23 )
        begin
            if(reg_minute == 6'd59)
            begin
                if(reg_second == 6'd59)
                    reg_hour <= 6'd0;
            end
        end
        else if(reg_minute == 6'd59)
        begin
            if(reg_second == 6'd59)
                reg_hour <= reg_hour + 1'b1;
        end   
    end
    else if(h)
    begin
        if(rst)
            reg_hour <= 6'b000000;
        else if(reg_hour == 6'd23)
            reg_hour <= 6'd0;
        else
            reg_hour <= reg_hour + 1;
    end     
end
//////////////////////////////////////////////////////////

endmodule



// Two frequency divider module below

//////////////////////////////////////////////////////////
// clk has posedge every second
module counter(input clk, rst, output clk_bps);
    reg [13:0] cnt_first, cnt_second;
    always @(posedge clk or posedge rst)
        if(rst)
            cnt_first <= 14'd0;
        else if(cnt_first == 14'd10000)
            cnt_first <= 14'd0;
        else
            cnt_first <= cnt_first +1'b1;
    always @(posedge clk or posedge rst)
        if(rst)
            cnt_second <= 14'd0;
        else if(cnt_second == 14'd10000)
            cnt_second <= 14'd0;
        else if(cnt_first == 14'd10000)
            cnt_second <= cnt_second+1'b1;
    assign clk_bps = cnt_second == 14'd10000 ? 1'b1:1'b0;
endmodule
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// 0.05 s per posedge
module counter_tube(input clk, rst, output clk_bps_tube);
    reg [13:0] cnt_first, cnt_second;
    always @(posedge clk or posedge rst)
        if(rst)
            cnt_first <= 14'd0;
        else if(cnt_first == 14'd10000)
            cnt_first <= 14'd0;
        else
            cnt_first <= cnt_first+1'b1;
    always @(posedge clk or posedge rst)
        if(rst)
            cnt_second <= 14'd0;
        else if(cnt_second == 14'd2500)
            cnt_second <= 14'd0;
        else if(cnt_first == 14'd10000)
            cnt_second <= cnt_second+1'b1;
    assign clk_bps_tube = cnt_second == 14'd2500 ? 1'b1:1'b0;
endmodule
//////////////////////////////////////////////////////////
