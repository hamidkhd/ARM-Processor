`timescale 1ns/1ns

module EXE(
    input clk, rst, freeze,
    input imm, MEM_R_EN_in, MEM_W_EN_in, WB_EN_in,
    input [1:0] Sel_src1, Sel_src2,
    input [3:0] EXE_CMD, dst_in, SRin,
    input [11:0] Shift_operand,
    input [23:0] Signed_imm_24,
    input [31:0] PC_in, Val_Rn, Val_Rm, ALU_MEM_val, WB_Val,
    output MEM_R_EN, MEM_W_EN, WB_EN,
    output [3:0] Dest, SR,
    output [31:0] ALU_result, Branch_Address, Val_Rm_out
);

    wire [31:0] ALU_result_temp, Val_Rm_temp;
    wire [3:0] dest_temp;

    EXE_Stage execute(
        clk, rst, imm, MEM_R_EN_in, MEM_W_EN_in,
        Sel_src1, Sel_src2,
        EXE_CMD, dst_in, SRin,
        Shift_operand,
        Signed_imm_24,
        PC_in, Val_Rn, Val_Rm, ALU_MEM_val, WB_Val,
        SR, dest_temp,
        ALU_result_temp, Branch_Address, Val_Rm_temp
    );

    EXE_reg execute_registers(
        clk, rst, freeze,
        WB_EN_in, MEM_R_EN_in, MEM_W_EN_in,
        dest_temp,
        ALU_result_temp, Val_Rm_temp, 
        WB_EN, MEM_R_EN, MEM_W_EN,
        Dest,
        ALU_result, Val_Rm_out
    );

endmodule