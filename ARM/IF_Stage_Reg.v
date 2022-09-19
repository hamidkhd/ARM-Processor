`timescale 1ns/1ns

module IF_Stage_Reg (
    input clk, rst, freeze, flush,
    input [31:0] PC_in, Instruction_in,
    output [31:0] PC, Instruction
);

    IFStageRegister R1(clk, rst, flush, ~freeze, PC_in, PC);
    IFStageRegister R2(clk, rst, flush, ~freeze, Instruction_in, Instruction);

endmodule
