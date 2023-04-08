`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/28 14:58:45
// Design Name: 
// Module Name: and
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


module and_2(       //一个与门
    input op1,
    input op2,
    output reg out
    );
    always @ (*)
    begin
    out <= op1&op2;
    end
endmodule
