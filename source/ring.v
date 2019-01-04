`timescale 1ns / 1ps
module ring(
    input on,clk,[19:0]sound,
    output reg speak
);

reg [19:0] counter;
    
always @(posedge clk)
    begin
    if(on)
        begin
            if(counter>=sound) 
            begin
                counter<=0; 
                if(speak==1)
                    speak<=0;
                else speak<=1;
            end
            else counter <= counter+1;
        end
    else speak<=0;
    end
endmodule
