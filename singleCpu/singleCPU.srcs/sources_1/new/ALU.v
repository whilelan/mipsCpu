`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/20 20:45:45
// Design Name: 
// Module Name: ALU
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

module ALU(            //ALUÄ£¿é
  input [31:0] op1,
  input [31:0] op2,
  input [3:0] ALUOpCode,
  input reset,
  output reg [31:0] ALUResult,
  output reg zeroFlag,
  output reg equal
);

  reg cin;
  wire cout;
  wire [31:0] s;
  wire zero;
  reg [31:0] neg_op2;

  SUB sub (
    .a(op1),
    .b(neg_op2),
    .enable(ALUOpCode == 4'b0001),
    .result(s),
    .zero(zero)
  );

  CLA cla_add_32 (
    .A(op1),
    .B(op2),
    .S(s),
    .enable(ALUOpCode == 4'b0000),
    .cin(cin),
    .cout(cout)
  );

  always @(op2) begin
    neg_op2 <= ~op2 + 1;
  end

  always @(posedge reset) begin
    cin <= 1'b0;
    neg_op2<=2'h00;
  end

  always @* begin
    case(ALUOpCode)
      4'b0000:ALUResult=s;
      4'b0001:
      begin
      ALUResult=s;
      zeroFlag=zero;
      end
      4'b0011:ALUResult=op1&op2;
      4'b0100:ALUResult=op1|op2;
      4'b0101:ALUResult=op1^op2;//xor
      4'b0110:ALUResult = op1 << op2[4:0];
      4'b0111:ALUResult = op1 >> op2[4:0];
      4'b1000:equal = (op1 < op2) ? 1 : 0;
      default:
        begin
        zeroFlag =1'b1;
        ALUResult = 32'hxxxxxxxx;
        end
    endcase
  end

endmodule


