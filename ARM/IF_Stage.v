`timescale 1ns/1ns

module IF_Stage (
    input clk, rst, freeze, Branch_taken,
    input [31:0] BranchAddr,
    output [31:0] PC, Instruction
);

    wire[31:0] pcIn, pcOut;

    MUX2_32 mux(BranchAddr, PC, Branch_taken, pcIn);
    PCRegister PCReg(clk, rst, ~freeze, pcIn, pcOut);
    Adder_32bit adder(pcOut, 32'd4, PC);
    InstructionMemory inst_mem(pcOut, Instruction);

endmodule
