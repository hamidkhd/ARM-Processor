`timescale 1ns/1ns

module MEM(
    input clk, rst, freeze,
    input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
    input [31:0] ALU_RES_IN, Val_Rm,
    input [3:0] Dest_IN,
    output WB_en, MEM_R_en,
    output [3:0] Dest,
    output [31:0] ALU_result, Mem_read_value,
    output sram_ready,
	inout[63:0] SRAM_DQ,
	output[16:0] SRAM_ADDR,
	output SRAM_WE_N
);

    wire[31:0] mem_out_temp, alu_res_temp;
    wire[3:0] dest_temp;
    wire WB_EN_temp, MEM_R_EN_temp;

    MEM_Stage memory_access(
	    clk, rst,
	    WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
	    ALU_RES_IN, Val_Rm,
	    Dest_IN,
	    WB_EN_temp, MEM_R_EN_temp,
	    mem_out_temp, alu_res_temp,
	    dest_temp,
        sram_ready,
        SRAM_DQ,
        SRAM_ADDR,
        SRAM_WE_N
    );

    MEM_Reg memory_access_registers(
        clk, rst, freeze,
        WB_EN_temp, MEM_R_EN_temp,
        alu_res_temp, mem_out_temp,
        dest_temp,
        WB_en, MEM_R_en,
        ALU_result, Mem_read_value,
        Dest
    );

endmodule