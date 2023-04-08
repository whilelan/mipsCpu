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
    input        clkb,       //时钟
    input [31:0] addrb,      //输入指令地址
    input        enb,        //使能信号
    output [31:0] doutb      //输出指令
);

    parameter I_SIZE = 4096;         // iCache大小
    parameter LINE_SIZE = 16;        // iCache缓存行大小
    parameter LINE_COUNT = I_SIZE/LINE_SIZE; //缓存行数量

    reg [31:0] icache [0:LINE_COUNT-1][0:LINE_SIZE/4-1]; //缓存数组
    reg [9:0]  tag;                 //标记
    reg [3:0]  index;               //索引
    reg [3:0]  offset;              //偏移量

    always @(posedge clkb) begin
        if(enb) begin
            tag    = addrb[31:20];
            index  = addrb[19:16];
            offset = addrb[15:0];

            doutb <= icache[index][offset/4];
        end
    end

endmodule

