`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/27 20:30:26
// Design Name: 
// Module Name: CU_tb
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
module tb_ControlUnit;

// ControlUnit Parameters
parameter PERIOD  = 10;


// ControlUnit Inputs
reg   [5:0]  opcode                        = 0 ;
reg   [5:0]  Func                          = 0 ;

// ControlUnit Outputs
wire  [3:0]  ALUOp                         ;    
wire  ALUSrc                               ;    
wire  RegDst                               ;
wire  RegWrite                             ;
wire  Branch                               ;
wire  MemRead                              ;
wire  MemWrite                             ;
wire  [1:0]  JumpOp                        ;
wire  MemtoReg                             ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

ControlUnit  u_ControlUnit (
    .opcode                  ( opcode    [5:0] ),
    .Func                    ( Func      [5:0] ),

    .ALUOp                   ( ALUOp     [3:0] ),
    .ALUSrc                  ( ALUSrc          ),
    .RegDst                  ( RegDst          ),
    .RegWrite                ( RegWrite        ),
    .Branch                  ( Branch          ),
    .MemRead                 ( MemRead         ),
    .MemWrite                ( MemWrite        ),
    .JumpOp                  ( JumpOp    [1:0] ),
    .MemtoReg                ( MemtoReg        )
);

initial
begin

    $finish;
end

endmodule
