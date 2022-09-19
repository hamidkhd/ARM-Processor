`timescale 1ns/1ns

module MEM_Reg (
    input clk, rst, freeze,
    input WB_en_in, MEM_R_en_in,
    input [31:0] ALU_result_in, Mem_read_value_in,
    input [3:0] Dest_in,
    output WB_en, MEM_R_en,
    output [31:0] ALU_result, Mem_read_value,
    output [3:0] Dest
);

    MemRegister1bit R1(clk, rst, freeze, WB_en_in, WB_en);
    MemRegister1bit R2(clk, rst, freeze, MEM_R_en_in, MEM_R_en);
    MemRegister32bit R3(clk, rst, freeze, ALU_result_in, ALU_result);
    MemRegister32bit R4(clk, rst, freeze, Mem_read_value_in, Mem_read_value);
    MemRegister4bit R5(clk, rst, freeze, Dest_in, Dest);
    
endmodule
