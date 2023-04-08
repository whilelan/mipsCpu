`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 12:44:40
// Design Name: 
// Module Name: pc
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


module PC(          //指令计数器模块
    input [31:0] NextPC, // Address of next instruction
    input reset, // Reset signal
    input clk, // Clock signal
    output reg [31:0] PCOut, // Output PC address
    output reg inst_en
);

    reg inst_en_reg;

    // Update on positive clock edge
    always @(posedge clk) begin
        if (reset) begin
            PCOut <= 32'h0; // Reset PC to 0 when reset signal is high
        end else begin
            PCOut <= NextPC; // Update PC
            inst_en_reg <= 1; // Set inst_en_reg high to enable instruction
        end
    end

    // Assign inst_en non-blocking
    always @(*) begin
        inst_en <= inst_en_reg;
    end

endmodule
