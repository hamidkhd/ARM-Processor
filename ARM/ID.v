`timescale 1ns/1ns

module ID(
    input clk, rst, flush, freeze,
    // From IF
    input[31:0] Instruction, PCin,
    // From WB
    input writeBackEn,
    input [3:0] Dest_wb,
    input [31:0] Result_WB,
    // From hazard
    input hazard,
    // From Status Register
    input [3:0] SR,
    output [3:0] src1, src2, src1_reg, src2_reg,
    output Two_src,
    output WB_EN, MEM_R_EN, MEM_W_EN, B, S, hasSrc1,
    output [3:0] EXE_CMD,
    output [31:0] PC,
    output [31:0] Val_Rn, Val_Rm,
    output imm,
    output [11:0] Shift_operand,
    output [23:0] Signed_imm_24,
    output [3:0] Dest
);

    wire WB_EN_temp, MEM_R_EN_temp, MEM_W_EN_temp, B_temp, S_temp, imm_temp, hasSrc1_temp;
    wire [3:0] EXE_CMD_temp, Dest_temp;
    wire [31:0] Val_Rn_temp, Val_Rm_temp, PC_temp;
    wire [11:0] Shift_operand_temp;
    wire [23:0] Signed_imm_24_temp;
    
    ID_Stage instruction_decode(
        clk, rst,
        Instruction, PCin,
        Result_WB,
        writeBackEn,
        Dest_wb,
        hazard,
        SR,
        WB_EN_temp, MEM_R_EN_temp, MEM_W_EN_temp, B_temp, S_temp, hasSrc1_temp,
        EXE_CMD_temp,
        Val_Rn_temp, Val_Rm_temp, PC_temp,
        imm_temp,
        Shift_operand_temp,
        Signed_imm_24_temp,
        Dest_temp,
        src1, src2,
        Two_src
    );

    ID_Stage_Reg instruction_decode_registers(
        clk, rst, flush, freeze,
        WB_EN_temp, MEM_R_EN_temp, MEM_W_EN_temp,
        B_temp, S_temp, hasSrc1_temp,
        EXE_CMD_temp, src1, src2,
        PC_temp, Val_Rn_temp, Val_Rm_temp,
        imm_temp,
        Shift_operand_temp,
        Signed_imm_24_temp,
        Dest_temp,
        WB_EN, MEM_R_EN, MEM_W_EN, B, S, hasSrc1,
        EXE_CMD, src1_reg, src2_reg,
        PC,
        Val_Rn, Val_Rm,
        imm,
        Shift_operand,
        Signed_imm_24,
        Dest
    );

endmodule

