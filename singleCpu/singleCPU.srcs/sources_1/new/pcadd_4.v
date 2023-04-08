`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/28 17:04:57
// Design Name: 
// Module Name: pcadd_4
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

module pcadd_4 (        //PC£¨Ö¸Áî¼ÆÊýÆ÷£©+4
    input [31:0] pc,
    input clk,
    output reg [31:0] pc_plus_4
);

    always @ (clk) begin
        pc_plus_4 <= pc + 4;
    end

endmodule


