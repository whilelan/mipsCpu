`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/27 20:37:08
// Design Name: 
// Module Name: IR
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
module IR(  //解码器模块，以R-type指令进行解码，因为R-typr粒度最大
    input [31:0] iCacheData,
    output [5:0] opcode,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] imm
    );
    
    assign opcode = iCacheData[31:26];
    assign rs = iCacheData[25:21];
    assign rt = iCacheData[20:16];
    assign rd = iCacheData[15:11];
    assign imm = iCacheData[15:0];
    
endmodule