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


module extend(      //l������������չģ��
    input [15:0] imm,
    output reg [31:0] ext_imm
    );
always @(*) begin
    if (imm[15] == 1) // �������λΪ1����ʾ��������Ҫ���з�����չ
        ext_imm = {16'b1111111111111111, imm}; // �ڸ�λ���1���õ�32λ�з�����
    else // �������λΪ0����ʾ����������Ҫ���з�����չ
        ext_imm = {16'b0000000000000000, imm}; // �ڸ�λ���0���õ�32λ�з�����
end
endmodule
