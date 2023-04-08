`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/28 15:24:14
// Design Name: 
// Module Name: mux2_6
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

module mux2_6(      //二选一数据选择器（6位地址选择）
    input [5:0] data0,
    input [5:0] data1,
    input sel,
    output reg [5:0] out
);
    always @* begin
        if (sel == 1'b0) begin
            out = data0;
        end else begin
            out = data1;
        end
    end
endmodule
