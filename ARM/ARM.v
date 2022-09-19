`timescale 1ns/1ns

module ARM(
    input clk, rst, Forward_en,
	inout[63:0] SRAM_DQ,
	output[16:0] SRAM_ADDR,
	output SRAM_WE_N
);

    wire freeze, Branch_taken, flush, hazard, sram_ready;
    wire [31:0] Branch_Address, PC_if, Instruction;
    
    or fr(freeze, ~sram_ready, hazard);
    IF instruction_fetch(
        clk, rst, freeze, Branch_taken, Branch_taken,
        Branch_Address,
        PC_if, Instruction
    );

    wire Two_src_id, WB_EN_id, MEM_R_EN_id, MEM_W_EN_id, B_id, S_id, imm_id, hasSrc1_id;
    wire [3:0] SR, src1_id, src2_id, src1_id_reg, src2_id_reg, exe_cmd_id, dest_id;
    wire [31:0] PCid, Val_Rm_id, Val_Rn_id;
    wire [11:0] Shift_operand_id;
    wire [23:0] Signed_imm_24_id;

    wire [31:0] wb_out;
    wire [3:0] wb_dest;
    wire WB_EN;

    ID instruction_decode(
        clk, rst, Branch_taken, sram_ready,
        // From IF
        Instruction, PC_if,
        // From WB
        WB_EN,
        wb_dest,
        wb_out,
        // From hazard
        hazard,
        // From Status Register
        SR,
        src1_id, src2_id, src1_id_reg, src2_id_reg,
        Two_src_id,
        WB_EN_id, MEM_R_EN_id, MEM_W_EN_id, Branch_taken, S_id, hasSrc1_id,
        exe_cmd_id,
        PCid,
        Val_Rn_id, Val_Rm_id,
        imm_id,
        Shift_operand_id,
        Signed_imm_24_id,
        dest_id
    );

    wire MEM_R_EN_exe, MEM_W_EN_exe, WB_EN_exe;
    wire [1:0] Sel_src1, Sel_src2;
    wire [3:0] Dest_exe, SR_exe;
    wire [31:0] ALU_result_exe, Val_rm_exe;

    EXE execute(
        clk, rst, sram_ready,
        imm_id, MEM_R_EN_id, MEM_W_EN_id, WB_EN_id,
        Sel_src1, Sel_src2,
        exe_cmd_id, dest_id, SR,
        Shift_operand_id,
        Signed_imm_24_id,
        PCid, Val_Rn_id, Val_Rm_id, ALU_result_exe, wb_out, 
        MEM_R_EN_exe, MEM_W_EN_exe, WB_EN_exe,
        Dest_exe, SR_exe,
        ALU_result_exe, Branch_Address, Val_rm_exe
    );

    wire WB_EN_mem, MEM_R_EN_mem;
    wire [3:0] Dest_mem;
    wire [31:0] ALU_result_mem, Mem_read_value_mem;

    MEM mem(
        clk, rst, sram_ready,
        WB_EN_exe, MEM_R_EN_exe, MEM_W_EN_exe,
        ALU_result_exe, Val_rm_exe,
        Dest_exe,
        WB_EN_mem, MEM_R_EN_mem,
        Dest_mem,
        ALU_result_mem, Mem_read_value_mem,
        sram_ready,
        SRAM_DQ,
        SRAM_ADDR,
        SRAM_WE_N
    );

    Hazard_Detection_Unit hazard_decetion(
        WB_EN_id, WB_EN_exe, Two_src_id, Forward_en, MEM_R_EN_id, hasSrc1_id,
        src1_id, src2_id, dest_id, Dest_exe,
        hazard
    );

    Status_Reg status_register(
        clk, rst, S_id,
        SR_exe,
        SR
    );

    WB write_back(
        clk, rst,
        ALU_result_mem, Mem_read_value_mem,
        Dest_mem,
        MEM_R_EN_mem, WB_EN_mem,
        wb_out,
        wb_dest,
        WB_EN
    );

    ForwardingUnit forwarding(
        WB_EN_exe, WB_EN_mem, Forward_en,
        src1_id_reg, src2_id_reg, Dest_exe, wb_dest,
        Sel_src1, Sel_src2
);

endmodule