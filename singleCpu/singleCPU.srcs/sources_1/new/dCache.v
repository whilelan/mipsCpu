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
  input        clka,        //时钟信号
  input [31:0] dina,        //写入的数据
  input [9:0]  addra,       //输入数据的地址
  input        ena,         //写入数据的使能信号
  input        clkb,        //时钟信号
  input [9:0]  addrb,       //输出数据的地址
  output reg [31:0]  doutb,      //输出的数据
  input        enb          //输出数据的使能信号
);

  reg [31:0] memory [0:1023];  //dCache存储器，大小为1KB
  integer index;                //dCache存储器的下标

  always @(posedge clka) begin
    if (ena) begin
      index = addra[9:2];       //取输入数据地址的高10位作为dCache存储器的下标
      memory[index] = dina;
    end
  end

  always @(posedge clkb) begin
    if (enb) begin
      index = addrb[9:2];       //取输出数据地址的高10位作为dCache存储器的下标
      doutb <= memory[index];
    end
  end

endmodule

