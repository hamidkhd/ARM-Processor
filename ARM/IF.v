`timescale 1ns/1ns

module IF(
    input clk, rst, freeze, Branch_taken, flush,
    input [31:0] BranchAddr,
    output [31:0] PC, Instruction
);

    wire[31:0] PC_if, Instruction_if;
    
    IF_Stage instruction_fetch(clk, rst, freeze, Branch_taken, BranchAddr, PC_if, Instruction_if);
    IF_Stage_Reg instruction_fetch_registers(clk, rst, freeze, flush, PC_if, Instruction_if, PC, Instruction);

endmodule
