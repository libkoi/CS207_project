`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2018 00:20:03
// Design Name: 
// Module Name: display
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


module display(
    input rst,
    input clk,
    input [5:0] hour,
    input [5:0] minute,
    input [5:0] second,
    output [7:0] seg_out,
    output [7:0] seg_en
);

reg [2:0] scan_cnt;         // scan count, 0 --> 7
reg [31:0] cnt;
parameter period = 200000; // 500Hz for stable

reg [6:0] Y_r;              // for selection
reg [7:0] DIG_r;            // for one digit
assign seg_en = {1'b1, (~Y_r[6:0])};   // dot never light
assign seg_out = ~DIG_r;


reg [3:0] hh;
reg [3:0] hl;
reg [3:0] mh;
reg [3:0] ml;
reg [3:0] sh;
reg [3:0] sl;

reg [7:0] hh_r;
reg [7:0] hl_r;
reg [7:0] mh_r;
reg [7:0] ml_r;
reg [7:0] sh_r;
reg [7:0] sl_r;


//////////////////////////////////////////////////////////
// display convert toolkit
// [5:0] time --> [3:0] digit
always @(posedge clk or negedge rst)
begin
    if(!rst) begin
        hh <= 0;
        hl <= 0;
        mh <= 0;
        ml <= 0;
        sh <= 0;
        sl <= 0;
    end
    else begin
        hh <= hour   / 10;
        hl <= hour   % 10;
        mh <= minute / 60;
        ml <= minute % 60;
        sh <= second / 60;
        sl <= second % 60;
    end
end


//////////////////////////////////////////////////////////
 // display convert toolkit 2
 // [3:0] digit --> [7:0] tube signal
 always @(posedge clk or negedge rst)
 
 begin
    if(!rst) begin
        hh_r <= 0;
        hl_r <= 0;
        mh_r <= 0;
        ml_r <= 0;
        sh_r <= 0;
        sl_r <= 0;
    end
    else begin
        case (hh)
            0: hh_r <= 7'b0111111;
            1: hh_r <= 7'b0000110;
            2: hh_r <= 7'b1011011;
            3: hh_r <= 7'b1001111;
            4: hh_r <= 7'b1100110;
            5: hh_r <= 7'b1101101;
            6: hh_r <= 7'b1111101;
            7: hh_r <= 7'b0100111;
            8: hh_r <= 7'b1111111;
            9: hh_r <= 7'b1100111;
            default : hh_r <= 7'b0000000;
        endcase
      
        case (hl)
            0: hl_r <= 7'b0111111;
            1: hl_r <= 7'b0000110;
            2: hl_r <= 7'b1011011;
            3: hl_r <= 7'b1001111;
            4: hl_r <= 7'b1100110;
            5: hl_r <= 7'b1101101;
            6: hl_r <= 7'b1111101;
            7: hl_r <= 7'b0100111;
            8: hl_r <= 7'b1111111;
            9: hl_r <= 7'b1100111;
            default : hl_r <= 7'b0000000;
        endcase
    
        case (mh)
            0: mh_r <= 7'b0111111;
            1: mh_r <= 7'b0000110;
            2: mh_r <= 7'b1011011;
            3: mh_r <= 7'b1001111;
            4: mh_r <= 7'b1100110;
            5: mh_r <= 7'b1101101;
            6: mh_r <= 7'b1111101;
            7: mh_r <= 7'b0100111;
            8: mh_r <= 7'b1111111;
            9: mh_r <= 7'b1100111;
            default : mh_r <= 7'b0000000;
        endcase
    
        case (ml)
            0: ml_r <= 7'b0111111;
            1: ml_r <= 7'b0000110;
            2: ml_r <= 7'b1011011;
            3: ml_r <= 7'b1001111;
            4: ml_r <= 7'b1100110;
            5: ml_r <= 7'b1101101;
            6: ml_r <= 7'b1111101;
            7: ml_r <= 7'b0100111;
            8: ml_r <= 7'b1111111;
            9: ml_r <= 7'b1100111;
            default : ml_r <= 7'b0000000;
        endcase
    
        case (sh)
            0: sh_r <= 7'b0111111;
            1: sh_r <= 7'b0000110;
            2: sh_r <= 7'b1011011;
            3: sh_r <= 7'b1001111;
            4: sh_r <= 7'b1100110;
            5: sh_r <= 7'b1101101;
            6: sh_r <= 7'b1111101;
            7: sh_r <= 7'b0100111;
            8: sh_r <= 7'b1111111;
            9: sh_r <= 7'b1100111;
            default : sh_r <= 7'b0000000;
        endcase
    
        case (sl)
            0: sl_r <= 7'b0111111;
            1: sl_r <= 7'b0000110;
            2: sl_r <= 7'b1011011;
            3: sl_r <= 7'b1001111;
            4: sl_r <= 7'b1100110;
            5: sl_r <= 7'b1101101;
            6: sl_r <= 7'b1111101;
            7: sl_r <= 7'b0100111;
            8: sl_r <= 7'b1111111;
            9: sl_r <= 7'b1100111;
            default : sl_r <= 7'b0000000;
        endcase
    end    
 end
//////////////////////////////////////////////////////////

reg clkout;
//////////////////////////////////////////////////////////
// frequency division 
// clk --> clkout
always @(posedge clk or negedge rst) 
begin
    if(!rst) begin
        cnt <= 0;
        clkout <= 0;
    end
    else begin
        if(cnt == (period >> 1) - 1) begin
            clkout <= ~clkout;
            cnt <= 0;
        end
        else
            cnt <= cnt + 1;    
    end
end
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
 // scan clock generate
 // clkout --> scan_cnt 
 // scan_cnt repeat 0 -> 7
always @(posedge clkout or negedge rst)
begin
    if(!rst)
        scan_cnt <= 0;
    else
        begin
            scan_cnt <= scan_cnt + 1;
            if(scan_cnt == 3'd7) scan_cnt <= 0;
        end
end
//////////////////////////////////////////////////////////
 
//////////////////////////////////////////////////////////
// tube selection
always @(scan_cnt) // tube select
begin
    case (scan_cnt)
        3'b000 : DIG_r = 8'b0000_0001;
        3'b001 : DIG_r = 8'b0000_0010;
        3'b010 : DIG_r = 8'b0000_0100;
        3'b011 : DIG_r = 8'b0000_1000;
        3'b100 : DIG_r = 8'b0001_0000;
        3'b101 : DIG_r = 8'b0010_0000;
        3'b110 : DIG_r = 8'b0000_0000; // 8'b0100_0000;
        3'b111 : DIG_r = 8'b0000_0000; // 8'b1000_0000;
        default: DIG_r = 8'b0000_0000;
    endcase
end
//////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////
// display on one tube digit
always @(scan_cnt)
begin
    case (scan_cnt)
        0: Y_r = sl;
        1: Y_r = sh;
        2: Y_r = ml;
        3: Y_r = mh;
        4: Y_r = hl;
        5: Y_r = hh;
        6: Y_r = 7'b0000000;
        7: Y_r = 7'b0000000;
        default Y_r = 7'b0000000;  
    endcase
    
end
//////////////////////////////////////////////////////////

endmodule
