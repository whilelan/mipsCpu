`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/25 09:53:41
// Design Name: 
// Module Name: ControlUnit
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
module ControlUnit(     //CUÄ£¿é£¬¿ØÖÆÄ£¿é
    input [5:0] opcode,
    input [5:0] Func,
    output reg [3:0] ALUOp,
    output reg ALUSrc,
    output reg RegDst,
    output reg RegWrite,
    output reg Branch,
    output reg MemRead,
    output reg MemWrite,
    output reg MemtoReg,
    output reg [1:0] JumpOp
);

    always @(*) begin
        case (opcode)
            6'b000000: begin // R-format
                ALUSrc = 1'b0;
                RegDst = 1'b1;
                RegWrite = 1'b1;
                Branch = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 1'b0;
                JumpOp = 2'b00;
                case (Func)
                    6'b100000, 6'b100010, 6'b100100, 6'b100101, 6'b101010: ALUOp = 4'b0010; // add, sub, and, or, slt
                    6'b000000: ALUOp = 4'b0110; // sll
                    6'b000010: ALUOp = 4'b1000; // srl
                    6'b001000: ALUOp = 4'b0111; // jr
                    default: ALUOp = 4'b0000;
                endcase
            end
            6'b001000, 6'b001001, 6'b001100, 6'b001101, 6'b001110, 6'b001111, 6'b100011, 6'b101011, 6'b000100, 6'b000101, 6'b001010, 6'b001011: begin // I-format
            //addi, addiu, andi, ori, xori, lui, lw, sw, beq, bne, slti, sltiu
                ALUSrc = 1'b1;
                RegDst = 1'b0;
                RegWrite = 1'b1;
                Branch = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 1'b0;
                JumpOp = 2'b00;
                case (opcode)
                    6'b000100, 6'b000101: ALUOp = 4'b0100; // beq, bne
                    6'b001000: ALUOp = 4'b0000; // addi
                    6'b001001: ALUOp = 4'b0001; // addiu
                    6'b001100: ALUOp = 4'b0110; // andi
                    6'b001101: ALUOp = 4'b0010; // ori
                    6'b001111: ALUOp = 4'b0101; // lui
                    6'b100011: begin // lw
                        ALUOp = 4'b0010;
                        MemRead = 1'b1;
                        MemtoReg = 1'b1;
                    end
                    default: ALUOp = 4'b0000;
                endcase
            end
            6'b000010: begin // J-type
                ALUSrc = 1'b0;
                RegDst = 1'b0;
                RegWrite = 1'b0;
                Branch = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 1'b0;
                JumpOp = 2'b10;
                ALUOp = 4'b0000;
            end
            6'b000011: begin // jal
                ALUSrc = 1'b0;
                RegDst = 1'b0;
                RegWrite = 1'b1;
                Branch = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 1'b0;
                JumpOp = 2'b11;
                ALUOp = 4'b0000;
            end
            default: begin // Unknown opcode
                ALUSrc = 1'b0;
                RegDst = 1'b0;
                RegWrite = 1'b0;
                Branch = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 1'b0;
                JumpOp = 2'b00;
                ALUOp = 4'b0000;
            end
        endcase
    end

endmodule




