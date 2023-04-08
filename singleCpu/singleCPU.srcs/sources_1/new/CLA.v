`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/20 20:59:39
// Design Name: 
// Module Name: CLA
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
module CLA(     //加法模块，采用超前进位加法
input [31:0] A,
input [31:0] B,
input cin,
input enable, // added enable input
output [31:0] S,
output cout
);

genvar i;
wire [3:0] G [31:0];
wire [3:0] P [31:0];
wire [3:0] C [31:0];

generate
for(i = 0; i < 32; i = i + 1) begin : GEN
assign G[i] = A[i] & B[i];
assign P[i] = A[i] ^ B[i];
assign C[i][0] = G[i][0] | (P[i][0] & (i == 0 ? cin : C[i-1][0])); // modified carry calculation with enable
assign C[i][1] = G[i][1] | (P[i][1] & (i == 0 ? C[i][0] : C[i-1][1])); // modified carry calculation with enable
assign C[i][2] = G[i][2] | (P[i][2] & (i == 0 ? C[i][1] : C[i-1][2])); // modified carry calculation with enable
assign C[i][3] = G[i][3] | (P[i][3] & (i == 0 ? C[i][2] : C[i-1][3])); // modified carry calculation with enable
end
endgenerate

assign S = (enable ? A + B + cin : 32'b0); // output 0 when enable is 0
assign cout = (enable ? C[31][3] : 1'b0); // output 0 when enable is 0

endmodule

