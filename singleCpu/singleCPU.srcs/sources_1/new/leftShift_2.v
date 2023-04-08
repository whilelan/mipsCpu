`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/28 15:31:15
// Design Name: 
// Module Name: leftShift_2
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


module leftShift_2(     //×óÒÆÁ½Î»
    input [31:0] op,
    output reg [31:0] out 
    );
    always @ (*)
    begin
    out <= op<<2;
    end
endmodule
