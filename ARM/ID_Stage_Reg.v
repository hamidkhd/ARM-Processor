`timescale 1ns/1ns

module ID_Stage_Reg (
    input clk, rst, flush, freeze,
    input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
    input B_IN, S_IN, hasSrc1_IN,
    input [3:0] EXE_CMD_IN, src1_IN, src2_IN,
    input [31:0] PC_IN,
    input [31:0] Val_Rn_IN, Val_Rm_IN,
    input imm_IN,
    input [11:0] Shift_operand_IN,
    input [23:0] Signed_imm_24_IN,
    input [3:0] Dest_IN,
    output WB_EN, MEM_R_EN, MEM_W_EN, B, S, hasSrc1,
    output [3:0] EXE_CMD, src1, src2,
    output [31:0] PC,
    output [31:0] Val_Rn, Val_Rm,
    output imm,
    output [11:0] Shift_operand,
    output [23:0] Signed_imm_24,
    output [3:0] Dest
);


    IDStageRegister32bit R1(clk, rst, flush, freeze, PC_IN, PC);
    IDStageRegister32bit R2(clk, rst, flush, freeze, Val_Rm_IN, Val_Rm);
    IDStageRegister32bit R3(clk, rst, flush, freeze, Val_Rn_IN, Val_Rn);
    IDStageRegister1bit R4(clk, rst, flush, freeze, WB_EN_IN, WB_EN);
    IDStageRegister1bit R5(clk, rst, flush, freeze, MEM_R_EN_IN, MEM_R_EN);
    IDStageRegister1bit R6(clk, rst, flush, freeze, MEM_W_EN_IN, MEM_W_EN);
    IDStageRegister1bit R7(clk, rst, flush, freeze, B_IN, B);
    IDStageRegister1bit R8(clk, rst, flush, freeze, S_IN, S);
    IDStageRegister1bit R16(clk, rst, flush, freeze, hasSrc1_IN, hasSrc1);
    IDStageRegister4bit R9(clk, rst, flush, freeze, EXE_CMD_IN, EXE_CMD);
    IDStageRegister1bit R10(clk, rst, flush, freeze, imm_IN, imm);
    IDStageRegister12bit R11(clk, rst, flush, freeze, Shift_operand_IN, Shift_operand);
    IDStageRegister24bit R12(clk, rst, flush, freeze, Signed_imm_24_IN, Signed_imm_24);
    IDStageRegister4bit R13(clk, rst, flush, freeze, Dest_IN, Dest);
    IDStageRegister4bit R14(clk, rst, flush, freeze, src1_IN, src1);
    IDStageRegister4bit R15(clk, rst, flush, freeze, src2_IN, src2);

endmodule
