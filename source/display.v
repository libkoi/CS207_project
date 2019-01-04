`timescale 1ns / 1ps


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
parameter period = 200000;  // 500Hz for stable

reg [7:0] DIG_r;            // for one digit
assign seg_out = Xseg_out;
assign seg_en = ~DIG_r;


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
always @(posedge clk or posedge rst)
begin
    if(rst) begin
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
        mh <= minute / 10;
        ml <= minute % 10;
        sh <= second / 10;
        sl <= second % 10;
    end
end


reg clkout;
//////////////////////////////////////////////////////////
// frequency division 
// clk --> clkout
always @(posedge clk or posedge rst) 
begin
    if(rst) begin
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
always @(posedge clkout or posedge rst)
begin
    if(rst)
        scan_cnt <= 0;
    else
        begin
            scan_cnt <= scan_cnt + 1;
            if(scan_cnt == 3'd5) scan_cnt <= 0;
        end
end
//////////////////////////////////////////////////////////
 
//////////////////////////////////////////////////////////
// tube selection
always @(scan_cnt) // tube select
begin
    case (scan_cnt)
        3'd0 : DIG_r = 8'b0000_0001;
        3'd1 : DIG_r = 8'b0000_0010;
        3'd2 : DIG_r = 8'b0000_0100;
        3'd3 : DIG_r = 8'b0000_1000;
        3'd4 : DIG_r = 8'b0001_0000;
        3'd5 : DIG_r = 8'b0010_0000;
        default: DIG_r = 8'b0000_0000;
    endcase
end
//////////////////////////////////////////////////////////


reg [3:0] Q;

always @(scan_cnt)
begin
    case (scan_cnt)
        3'd0: Q = sl;
        3'd1: Q = sh;
        3'd2: Q = ml;
        3'd3: Q = mh;
        3'd4: Q = hl;
        3'd5: Q = hh;
    endcase
end

reg [7:0] Xseg_out;

always @(Q)
begin
    case (Q[3:0])
        4'd0: Xseg_out<=8'b01000000;
        4'd1: Xseg_out<=8'b01111001;
        4'd2: Xseg_out<=8'b00100100;
        4'd3: Xseg_out<=8'b00110000;
        4'd4: Xseg_out<=8'b00011001;
        4'd5: Xseg_out<=8'b00010010;
        4'd6: Xseg_out<=8'b00000010;
        4'd7: Xseg_out<=8'b01111000;
        4'd8: Xseg_out<=8'b00000000;
        4'd9: Xseg_out<=8'b00010000;
        default:  Xseg_out<=8'b11111111;
    endcase
end

endmodule
