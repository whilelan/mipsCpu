`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/28 15:49:35
// Design Name: 
// Module Name: add_32
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


module add_32(          //普通32位加法
    input [31:0] op1,
    input [31:0] op2,
    output reg [31:0] result
    );
    always @(*)
    begin
    result <= op1+op2;
    end
endmodule
