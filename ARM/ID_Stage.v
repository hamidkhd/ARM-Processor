`timescale 1ns/1ns

module ID_Stage (
    input clk, rst,
    input [31:0] Instruction, PCin,
    input [31:0] Result_WB,
    input writeBackEn,
    input [3:0] Dest_wb,
    input hazard,
    input [3:0] SR,
    output WB_EN, MEM_R_EN, MEM_W_EN, B, S, hasSrc1,
    output [3:0] EXE_CMD,
    output [31:0] Val_Rn, Val_Rm, PC,
    output imm,
    output [11:0] Shift_operand,
    output [23:0] Signed_imm_24,
    output [3:0] Dest,
    output [3:0] src1, src2,
    output Two_src
);
    assign PC = PCin;
    assign imm = Instruction[25];
    assign Shift_operand = Instruction[11:0];
    assign Signed_imm_24 = Instruction[23:0];
    assign Dest = Instruction[15:12];

    wire condition_check, control_unit_mux_select;
    wire WB_EN_temp, MEM_R_EN_temp, MEM_W_EN_temp, B_temp, S_temp, hasSrc1_temp;
    wire [3:0] EXE_CMD_temp;

    ControlUnit CU(Instruction[20], Instruction[24:21], Instruction[27:26], WB_EN_temp, MEM_R_EN_temp, MEM_W_EN_temp, B_temp, S_temp, hasSrc1_temp, EXE_CMD_temp);
    or twoSrcGen(Two_src, MEM_W_EN, ~imm);
    ContidionCheck CC(Instruction[31:28], SR, condition_check);

    or mux_select(control_unit_mux_select, ~condition_check, hazard);

    assign WB_EN = control_unit_mux_select ? 0 : WB_EN_temp;
    assign MEM_R_EN = control_unit_mux_select ? 0 : MEM_R_EN_temp;
    assign MEM_W_EN = control_unit_mux_select ? 0 : MEM_W_EN_temp;
    assign B = control_unit_mux_select ? 0 : B_temp;
    assign S = control_unit_mux_select ? 0 : S_temp;
    assign EXE_CMD = control_unit_mux_select ? 0 : EXE_CMD_temp;
    assign hasSrc1 = control_unit_mux_select ? 0 : hasSrc1_temp;

    assign src1 = Instruction[19:16];
    assign src2 = MEM_W_EN ? Instruction[15:12] : Instruction[3:0];
    RegisterFile RF(clk, rst, src1, src2, Dest_wb, Result_WB, writeBackEn, Val_Rn, Val_Rm);

endmodule