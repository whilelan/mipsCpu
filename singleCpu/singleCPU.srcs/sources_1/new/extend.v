`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 13:00:09
// Design Name: 
// Module Name: extend
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


module extend(      //l立即数符号扩展模块
    input [15:0] imm,
    output reg [31:0] ext_imm
    );
always @(*) begin
    if (imm[15] == 1) // 如果符号位为1，表示负数，需要进行符号扩展
        ext_imm = {16'b1111111111111111, imm}; // 在高位填充1，得到32位有符号数
    else // 如果符号位为0，表示正数，不需要进行符号扩展
        ext_imm = {16'b0000000000000000, imm}; // 在高位填充0，得到32位有符号数
end
endmodule
