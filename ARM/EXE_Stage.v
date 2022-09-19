`timescale 1ns/1ns

module EXE_Stage(
    input clk, rst, imm, MEM_R_EN, MEM_W_EN,
    input [1:0] Sel_src1, Sel_src2,
    input [3:0] EXE_CMD, dst_in, SR_in,
    input [11:0] Shifte_operand,
    input [23:0] Signed_imm_24,
    input [31:0] PC_in, Val_Rn, Val_Rm, ALU_MEM_val, WB_Val,
    output [3:0] SR_out, dst_out,
    output [31:0] ALU_result, Branch_Address, Val_Rm_out
);

    wire [31:0] Val2, Signed_imm_32, mux3_32_1_out, mux3_32_2_out;
    wire is_memory_command, C;

    assign dst_out = dst_in;
    assign C = SR_in[2];
    assign Signed_imm_32 = {{6{Signed_imm_24[23]}}, Signed_imm_24, 2'b0};

    MUX3_32 mux3_32_1(Val_Rn, ALU_MEM_val, WB_Val, Sel_src1, mux3_32_1_out);
    MUX3_32 mux3_32_2(Val_Rm, ALU_MEM_val, WB_Val, Sel_src2, mux3_32_2_out);

    or is_memory(is_memory_command, MEM_R_EN, MEM_W_EN);
    Val2Generator val2_generator(imm, is_memory_command, Shifte_operand, mux3_32_2_out, Val2);
    ALU alu(mux3_32_1_out, Val2, C, EXE_CMD, SR_out, ALU_result);
    Adder_32bit pc_adder(PC_in, Signed_imm_32, Branch_Address);

    assign Val_Rm_out = mux3_32_2_out;

endmodule