`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/21 19:22:34
// Design Name: 
// Module Name: ALU_tb
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

module ALU_TB();

  reg [31:0] op1, op2;
  reg [3:0] ALUOpCode;
  reg reset;
  wire [31:0] ALUResult;
  wire zeroFlag;

  ALU alu(
    .op1(op1),
    .op2(op2),
    .ALUOpCode(ALUOpCode),
    .reset(reset),
    .ALUResult(ALUResult),
    .zeroFlag(zeroFlag)
  );

  integer i;
  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, ALU_TB);

    // Perform 10 random operations
    for (i = 0; i < 10; i = i + 1) begin
      op1 = $random;
      op2 = $random;
      ALUOpCode = $random % 8;
      reset = 0;

      #10;

      $display("Operation %0d:", i);
      $display("  op1: %h", op1);
      $display("  op2: %h", op2);
      $display("  ALUOpCode: %h", ALUOpCode);
      $display("  reset: %h", reset);
      $display("  ALUResult: %h", ALUResult);
      $display("  zeroFlag: %h", zeroFlag);
    end
    $finish;
  end

endmodule

