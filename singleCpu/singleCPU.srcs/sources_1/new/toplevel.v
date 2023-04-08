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
    wire [31:0] inst;   //ָ��  
    wire inst_en;       //ָ��ʹ���ź�
    // ������Ҫ���ӵ�ControlUnitģ����ź�
    //���룬ָ�����ͺ͹�����
    wire [5:0] Op;  
    wire [5:0] Func;
    //����������źţ�·����Ϣ
    wire AlUSrc;
    wire RegDst;
    wire RegWrite;
    wire Branch;
    wire MemRead;
    wire MemWrite;
    wire MemtoReg;
    wire [3:0] ALUOp;
    wire [1:0] JumpOp;
    // ������Ҫ���ӵ�RegFileģ����ź�
    wire [4:0] rs;//��һ��Դ�Ĵ����ĵ�ַ��
    wire [4:0] rt;//��ʱ�Ĵ����ĵ�ַ�룬������Դ����Ŀ�ģ�ĩ���Ĵ���
    wire [4:0] rd;//��Ž����Ŀ�ģ�ĩ���Ĵ����ĵ�ַ��
    wire [31:0] SrcA;//��regfile��������1
    wire [31:0] SrcB;//��regfile��������2
    wire [4:0] RegFile_w;//
    //����IR��Ҫ�ź�
    wire [15:0] imm;
    //����extend��Ҫ���ź�
    wire [31:0] ext_imm;//signimm
    //����mux_2_SrcB��Ҫ���ź�
    
    //����alu��Ҫ���ź�
    //alu���
    wire [31:0] ALUResult;
    wire Equal;
    //����and_pcsrcСģ����Ҫ���ź�
    wire PCSrc;
    //����mux_2_PC����Ҫ���ź�
    wire mux2_PC;
    //����<<2����Ҫ���ź�
    wire ext_imm_ls2;
    //����pc+4����Ҫ���ź�
    wire [31:0] pc_add_4;
    //����pc����Ҫ���ź�
    wire [31:0] pc;
    //ʵ����ext_imm_ls2+pc_add_4����Ҫ���ź�
    wire [31:0] PCBranch;
    //ʵ����mux2_WriteBackData����Ҫ���ź�
    wire [31:0] ReadData;
    wire [31:0] WriteBackData;
    //ʵ����dCache����Ҫ���ź�
    wire [31:0] WriteData;
    
    // ʵ����ControlUnitģ��
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
    // ʵ����RegFileģ��
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
    //ʵ����������ģ��
    IR IR_inst(
    .iCacheData(inst),
    .opcode(Op),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .imm(imm)
    );
    //ʵ����extend
    extend extend_inst(
    .imm(imm),
    .ext_imm(ext_imm)
    );
    //ʵ����srcb��������ѡ����
    mux2 mux2_SrcB(
    .sel(AlUSrc),
    .data0(WriteData),
    .data1(ext_imm),//signimm
    .out(SrcB)
    );
    //ʵ����alu
    ALU ALU_inst(
    .op1(SrcA),//srca
    .op2(SrcB),//srcb
    .ALUOpCode(ALUOp),//aluopcode
    .reset(reset),//reset
    .ALUResult(ALUResult),//ALUResult
    .equal(Equal),
    .zeroFlag()
    );
    //ʵ����anСģ��
    and_2 and_PCSrc(
    .op1(Branch),
    .op2(Equal),
    .out(PCSrc)
    );
    //ʵ����mux2_PCСģ��
    mux2 mux_PC(
    .data0(pc_add_4),//pc+4
    .data1(PCBranch),//BranchAddress
    .sel(PCSrc),
    .out(mux2_PC)//pc
    );
    //ʵ����mux2_WСģ��
    mux2_6 mux_w(
    .sel(RegDst),
    .data0(rt),
    .data1(rd),
    .out(RegFile_w)
    );
    //ʵ����leftShift_2Сģ��
    leftShift_2 leftShift_2_inst(
    .op(ext_imm),
    .out(ext_imm_ls2)
    );
    //ʵ����pc+4Сģ��
   pcadd_4  pc_4_inst(
    .pc(pc),
    .pc_plus_4(pc_add_4)
    );
    //ʵ����add_32ģ��
    add_32 add_32_inst(
    .op1(ext_imm_ls2),
    .op2(pc_add_4),
    .result(PCBranch)
    );
    //ʵ����pc
    PC PC_inst(
    .reset(reset),
    .clk(clk),
    .NextPC(mux2_PC),
    .PCOut(pc),
    .inst_en(inst_en)
    );
    //ʵ��mux2_WriteBackData
    mux2 mux2_WriteBackData_inst(
    .data0(ALUResult),
    .data1(ReadData),
    .sel(MemtoReg),
    .out(WriteBackData)
    );
    //ʵ����icache
    iCache iCache_inst(
    .clkb(clk),
    .addrb(pc),
    .enb(inst_en),
    .doutb(inst)
    );
    //ʵ����dCache
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
