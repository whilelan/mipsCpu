`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/21 09:19:05
// Design Name: 
// Module Name: SUB
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
module SUB(     //减法模块，采用两级流水线减法
  input [31:0] a, b,
  input enable,
  output reg [31:0] result,
  output reg zero
);

  reg [31:0] neg_b;
  reg [31:0] temp;
  reg [15:0] a_15_0, b_15_0;
  reg [15:0] a_31_16, b_31_16;

  always @(posedge enable) begin
    // 将a和b分为16位和高16位两部分
    a_15_0 <= a[15:0];
    b_15_0 <= b[15:0];
    a_31_16 <= a[31:16];
    b_31_16 <= b[31:16];
    // 计算b的补码
    neg_b <= ~b + 1;
  end

  always @(posedge enable) begin
    // 第一级流水线，计算低16位结果
    temp[15:0] <= a_15_0 + neg_b[15:0];
  end

  always @(posedge enable) begin
    // 第二级流水线，计算高16位结果
    temp[31:16] <= a_31_16 + neg_b[31:16] + (temp[15] == 1);
    result <= temp; // 输出结果
    zero <= (temp == 0); // 判断结果是否为0
  end

endmodule




