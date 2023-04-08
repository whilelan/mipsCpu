`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/08 09:24:14
// Design Name: 
// Module Name: dCache
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


module dCache(
  input        clka,        //ʱ���ź�
  input [31:0] dina,        //д�������
  input [9:0]  addra,       //�������ݵĵ�ַ
  input        ena,         //д�����ݵ�ʹ���ź�
  input        clkb,        //ʱ���ź�
  input [9:0]  addrb,       //������ݵĵ�ַ
  output reg [31:0]  doutb,      //���������
  input        enb          //������ݵ�ʹ���ź�
);

  reg [31:0] memory [0:1023];  //dCache�洢������СΪ1KB
  integer index;                //dCache�洢�����±�

  always @(posedge clka) begin
    if (ena) begin
      index = addra[9:2];       //ȡ�������ݵ�ַ�ĸ�10λ��ΪdCache�洢�����±�
      memory[index] = dina;
    end
  end

  always @(posedge clkb) begin
    if (enb) begin
      index = addrb[9:2];       //ȡ������ݵ�ַ�ĸ�10λ��ΪdCache�洢�����±�
      doutb <= memory[index];
    end
  end

endmodule

