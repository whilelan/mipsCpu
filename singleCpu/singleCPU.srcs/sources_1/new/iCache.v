`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/08 09:23:57
// Design Name: 
// Module Name: iCache
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


module iCache (
    input        clkb,       //ʱ��
    input [31:0] addrb,      //����ָ���ַ
    input        enb,        //ʹ���ź�
    output [31:0] doutb      //���ָ��
);

    parameter I_SIZE = 4096;         // iCache��С
    parameter LINE_SIZE = 16;        // iCache�����д�С
    parameter LINE_COUNT = I_SIZE/LINE_SIZE; //����������

    reg [31:0] icache [0:LINE_COUNT-1][0:LINE_SIZE/4-1]; //��������
    reg [9:0]  tag;                 //���
    reg [3:0]  index;               //����
    reg [3:0]  offset;              //ƫ����

    always @(posedge clkb) begin
        if(enb) begin
            tag    = addrb[31:20];
            index  = addrb[19:16];
            offset = addrb[15:0];

            doutb <= icache[index][offset/4];
        end
    end

endmodule

