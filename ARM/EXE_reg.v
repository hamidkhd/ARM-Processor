`timescale 1ns/1ns

module EXE_reg(
    input clk, rst, freeze,
    input WB_en_in, MEM_R_EN_in, MEM_W_EN_in,
    input [3:0] dst_in,
    input [31:0] ALU_result_in, ST_Val_in, 
    output WB_en_out, MEM_R_EN_out, MEM_W_EN_out,
    output [3:0] dst_out,
    output [31:0] ALU_result_out, ST_Val_out
);

    Reg_1bit WB_en_reg(clk, rst, freeze, WB_en_in, WB_en_out);
    Reg_1bit MEM_R_EN_reg(clk, rst, freeze, MEM_R_EN_in, MEM_R_EN_out);
    Reg_1bit MEM_W_EN_reg(clk, rst, freeze, MEM_W_EN_in, MEM_W_EN_out);
    Reg_4bit dst_reg(clk, rst, freeze, dst_in, dst_out);
    Reg_32bit ALU_result_reg(clk, rst, freeze, ALU_result_in, ALU_result_out);
    Reg_32bit ST_Val_reg(clk, rst, freeze, ST_Val_in, ST_Val_out);

endmodule
