`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/25 10:11:17
// Design Name: 
// Module Name: toplevel
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


module toplevel(
    input clk,
    input reset,
    //instruction
     input [31:0] inst_1,//instruction
     input inst_en_1//instruction enable
//    input [31:0] inst_addr//instruction address
    //data
//    input data_in,//data input
//    input data_out_en,//data enable
//    input [31:0] data_addr,//data address
//    output reg [31:0] data_out//data output
    );
    wire [31:0] inst;   //指令  
    wire inst_en;       //指令使能信号
    // 定义需要连接到ControlUnit模块的信号
    //输入，指令类型和功能码
    wire [5:0] Op;  
    wire [5:0] Func;
    //输出，控制信号，路由信息
    wire AlUSrc;
    wire RegDst;
    wire RegWrite;
    wire Branch;
    wire MemRead;
    wire MemWrite;
    wire MemtoReg;
    wire [3:0] ALUOp;
    wire [1:0] JumpOp;
    // 定义需要连接到RegFile模块的信号
    wire [4:0] rs;//第一个源寄存器的地址码
    wire [4:0] rt;//临时寄存器的地址码，可用于源或者目的（末）寄存器
    wire [4:0] rd;//存放结果的目的（末）寄存器的地址码
    wire [31:0] SrcA;//自regfile来的数据1
    wire [31:0] SrcB;//自regfile来的数据2
    wire [4:0] RegFile_w;//
    //定义IR需要信号
    wire [15:0] imm;
    //定义extend需要的信号
    wire [31:0] ext_imm;//signimm
    //定义mux_2_SrcB需要的信号
    
    //定义alu需要的信号
    //alu输出
    wire [31:0] ALUResult;
    wire Equal;
    //定义and_pcsrc小模块需要的信号
    wire PCSrc;
    //定义mux_2_PC所需要的信号
    wire mux2_PC;
    //定义<<2所需要的信号
    wire ext_imm_ls2;
    //定义pc+4所需要的信号
    wire [31:0] pc_add_4;
    //定义pc所需要的信号
    wire [31:0] pc;
    //实例化ext_imm_ls2+pc_add_4所需要的信号
    wire [31:0] PCBranch;
    //实例化mux2_WriteBackData所需要的信号
    wire [31:0] ReadData;
    wire [31:0] WriteBackData;
    //实例化dCache所需要的信号
    wire [31:0] WriteData;
    
    // 实例化ControlUnit模块
    ControlUnit ControlUnit_inst(
        .opcode(Op),
        .Func(Func),
        .ALUOp(ALUOp),
        .ALUSrc(AlUSrc),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .JumpOp(JumpOp)
    );
    // 实例化RegFile模块
    RegFile RegFile_inst(
        .clk(clk),
        .rs(rs),
        .rt(rt),
        .rd(RegFile_w),
        .writeData(WriteBackData),//wd
        .RegWriteEn(RegWrite),//we
        .rsData(SrcA),//r1
        .rtData(WriteData)//r2
    );
    //实例化解码器模块
    IR IR_inst(
    .iCacheData(inst),
    .opcode(Op),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .imm(imm)
    );
    //实例化extend
    extend extend_inst(
    .imm(imm),
    .ext_imm(ext_imm)
    );
    //实例化srcb处的数据选择器
    mux2 mux2_SrcB(
    .sel(AlUSrc),
    .data0(WriteData),
    .data1(ext_imm),//signimm
    .out(SrcB)
    );
    //实例化alu
    ALU ALU_inst(
    .op1(SrcA),//srca
    .op2(SrcB),//srcb
    .ALUOpCode(ALUOp),//aluopcode
    .reset(reset),//reset
    .ALUResult(ALUResult),//ALUResult
    .equal(Equal),
    .zeroFlag()
    );
    //实例化an小模块
    and_2 and_PCSrc(
    .op1(Branch),
    .op2(Equal),
    .out(PCSrc)
    );
    //实例化mux2_PC小模块
    mux2 mux_PC(
    .data0(pc_add_4),//pc+4
    .data1(PCBranch),//BranchAddress
    .sel(PCSrc),
    .out(mux2_PC)//pc
    );
    //实例化mux2_W小模块
    mux2_6 mux_w(
    .sel(RegDst),
    .data0(rt),
    .data1(rd),
    .out(RegFile_w)
    );
    //实例化leftShift_2小模块
    leftShift_2 leftShift_2_inst(
    .op(ext_imm),
    .out(ext_imm_ls2)
    );
    //实例化pc+4小模块
   pcadd_4  pc_4_inst(
    .pc(pc),
    .pc_plus_4(pc_add_4)
    );
    //实例化add_32模块
    add_32 add_32_inst(
    .op1(ext_imm_ls2),
    .op2(pc_add_4),
    .result(PCBranch)
    );
    //实例化pc
    PC PC_inst(
    .reset(reset),
    .clk(clk),
    .NextPC(mux2_PC),
    .PCOut(pc),
    .inst_en(inst_en)
    );
    //实例mux2_WriteBackData
    mux2 mux2_WriteBackData_inst(
    .data0(ALUResult),
    .data1(ReadData),
    .sel(MemtoReg),
    .out(WriteBackData)
    );
    //实例化icache
    iCache iCache_inst(
    .clkb(clk),
    .addrb(pc),
    .enb(inst_en),
    .doutb(inst)
    );
    //实例化dCache
    dCache dCache_inst(
    .clka(clk),
    .dina(WriteData),
    .addra(ALUResult[9:0]),//input data address [9:0]
    .ena(MemWrite),//input enable signal
    .clkb(clk),
    .addrb(ALUResult[9:0]),//output data address [9:0]
    .doutb(ReadData),//output data
    .enb(MemtoReg)//data out enable
    );
endmodule
