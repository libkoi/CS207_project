`timescale 1ns / 1ps


module clock(
    input clk, 
    rst,
    h,
    min,
    set_time,
    [5:0] key_hour,
    [5:0] key_minute, 
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
reg[5:0] reg_hour,reg_minute,reg_second;
    
counter u_c(clk,rst,clk_bps);
counter_tube u_t(clk,rst,clk_fbps);

always @(posedge clk)
    begin
        hour = reg_hour;
        minute = reg_minute;
        second = reg_second;
//        if(rst)
//        begin
//            reg_hour <= 6'b001_010;
//            reg_minute <= 6'b000_111;
//            reg_second <= 6'b100_111;
//        end
    end
    
//////////////////////////////////////////////////////////
// second change counter
always @(posedge clk_bps or posedge rst)
    begin
        if(rst)
            reg_second <= 6'b000000;
        else if(reg_second == 6'd59)
            reg_second <= 6'd0;
        else
            reg_second <= reg_second+1'b1;
    end
//////////////////////////////////////////////////////////


reg[2:0] mm;
reg[2:0] mh;
reg cm;
reg ch;


//    always @(posedge min or posedge cm)
//    begin
//        mm <= mm+1;
//        if(cm)
//            mm <= 0;
//     end
//    always @(posedge h)
//        mh <= mh+1;

reg[1:0] c1;


always @(posedge clk_fbps or posedge rst or posedge set_time)
begin
    c1 = c1 + 1;
    if(c1 == 2'b00 && ~min)
        begin
            if(rst)
                reg_minute <= 6'b000000;
//            else if(min)
//                reg_minute <= reg_minute+1;
//            else if(min==(01))
//            begin
//                reg_minute <= reg_minute+1'b1;
////                    reg_minute=key_hour;
////                    reg_minute=reg_minute%60;
//            end    
            else if(set_time)
                reg_minute <= key_minute;
            else if(reg_minute == 6'd59 )
            begin
                if(reg_second == 6'd59)
                reg_minute <= 6'd0;
            end
            else if(reg_second == 6'd59)
                reg_minute <= reg_minute + 1'b1;
//            reg_minute <= reg_minute+mm;
//            cm <= 1;
//            #100
//            cm <= 0;
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

reg [1:0] c2;

//////////////////////////////////////////////////////////
always @(posedge clk_fbps , posedge rst , posedge set_time)
begin
    c2=c2+1;
    if(~h&&c2 == 2'b00)
    begin
        if(rst)
            reg_hour <= 6'b000000;

//        else if(h)
//            reg_hour <= reg_hour+1'b1;
//        begin
//            reg_hour=key_hour;
//            reg_hour=reg_hour%24;
//        end
        else if(set_time)
            reg_hour <= key_hour;
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
                reg_hour <= reg_hour+1'b1;
        end   
    end
    else if(h)
    begin
        if(rst)
            reg_hour <= 6'b000000;
        else if(reg_hour == 6'd23)
            reg_hour <= 6'd0;
        else
            reg_hour <= reg_hour+1;
    end     
end
    
    

endmodule

//////////////////////////////////////////////////////////
// Two frequency divider module below


// clk has posedge every second
module counter(input clk, rst, output clk_bps);
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
        else if(cnt_second == 14'd10000)
            cnt_second <= 14'd0;
        else if(cnt_first == 14'd10000)
            cnt_second <= cnt_second+1'b1;
    assign clk_bps = cnt_second == 14'd10000 ? 1'b1:1'b0;
endmodule


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
//////////////////////////////////////////////////////////

endmodule