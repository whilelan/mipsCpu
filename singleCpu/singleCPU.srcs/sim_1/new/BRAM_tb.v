`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/24 16:31:55
// Design Name: 
// Module Name: BRAM_tb
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


module BRAM_tb(

    );
reg clk;
reg rst;
    
BRAM BRAM_test(.clk(clk),.rst(rst));

initial begin
rst = 1'b1;
clk = 1'b0;
#20 rst = 1'b0;
#50 rst = 1'b1;
end 

always #20 clk =~clk;
 
endmodule
