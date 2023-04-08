`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/28 14:37:00
// Design Name: 
// Module Name: mux2
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
module mux2(        //二选一数据选择器（32位数据选择）
    input [31:0] data0,
    input [31:0] data1,
    input sel,
    output reg [31:0] out
);
    always @* begin
        if (sel == 1'b0) begin
            out = data0;
        end else begin
            out = data1;
        end
    end
endmodule
