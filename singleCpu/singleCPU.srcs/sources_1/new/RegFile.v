`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/25 09:46:06
// Design Name: 
// Module Name: RegFile
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

 module RegFile(
    input clk,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] writeData,
    input RegWriteEn,
    output [31:0] rsData,
    output [31:0] rtData
    );
    
    reg [31:0] regs [0:31];
    //����R��ָ���rd�Ĵ�����д������
    always @(posedge clk) begin
    if (RegWriteEn) begin
        if (rd != 0) begin
            regs[rd] <= writeData;
        end //����I��ָ���rt�Ĵ�����д������
        else if (rt != 0) begin
            regs[rt] <= writeData;
        end
    end
    end
    //�ڼĴ�����regs��ȡ����
    assign rsData = (rs == 0) ? 32'h0 : regs[rs];
    assign rtData = (rt == 0) ? 32'h0 : regs[rt];
    
    endmodule
