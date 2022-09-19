`timescale 1ns/1ns

module MEM_Stage(
	input clk, rst,
	input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
	input [31:0] ALU_RES_IN, Val_Rm,
	input [3:0] Dest_IN,
	output WB_EN, MEM_R_EN,
	output [31:0] MEM_OUT, ALU_RES,
	output [3:0] Dest,
	output ready,
	inout[63:0] SRAM_DQ,
	output[16:0] SRAM_ADDR,
	output SRAM_WE_N
);

	wire[31:0] sram_address, sram_wdata;
	wire[63:0] rdata;
	wire[63:0] sram_rdata;
	wire sram_ready, sram_read_en, sram_write_en;

	CacheController cc(
    	clk,
    	rst,

		ALU_RES_IN,
		Val_Rm,
    	MEM_R_EN_IN,
    	MEM_W_EN_IN,
    	MEM_OUT,
    	ready,

		rdata,
		sram_ready,
    	sram_address,
    	sram_wdata,
		sram_read_en,
		sram_write_en
	);

	wire SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N;
	SRAM_Controller mc(clk, rst, sram_write_en, sram_read_en,
		sram_address, sram_wdata, rdata, 
    	sram_ready,
    	SRAM_DQ,
    	SRAM_ADDR,
    	SRAM_UB_N,
    	SRAM_LB_N,
    	SRAM_WE_N,
    	SRAM_CE_N,
    	SRAM_OE_N
	);
    assign WB_EN = WB_EN_IN;
    assign ALU_RES = ALU_RES_IN;
    assign Dest = Dest_IN;
    assign MEM_R_EN = MEM_R_EN_IN;
	//assign MEM_OUT = rdata;
endmodule