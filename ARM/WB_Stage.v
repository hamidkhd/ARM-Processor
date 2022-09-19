`timescale 1ns/1ns

module WB(
    input clk, rst,
    input [31:0] ALU_result, MEM_result,
    input [3:0] Dest_in,
    input MEM_R_en, WB_EN_in,
    output [31:0] out,
    output [3:0] Dest,
    output WB_EN
);

    assign WB_EN = WB_EN_in;
    assign Dest = Dest_in;
    MUX2_32 mux(MEM_result, ALU_result, MEM_R_en, out);

endmodule

