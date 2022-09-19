`timescale 1ns/1ns

module TB();

	wire[63:0] SRAM_DQ;
	wire[16:0] SRAM_ADDR;
	wire SRAM_WE_N;
	reg clk, rst, Forward_en, long_clk;
	ARM arm(clk, rst, Forward_en, SRAM_DQ, SRAM_ADDR, SRAM_WE_N);
	SRAM ram(long_clk, rst, SRAM_WE_N, SRAM_ADDR, SRAM_DQ);

	initial begin
		long_clk = 1'b0;
		repeat (500) begin
			#20 long_clk = ~long_clk;
		end
	end

	initial begin
		clk = 1'b0;
		rst = 1'b0;
		Forward_en = 1'b1;

		#10 clk = 1'b1;
		#10 rst = 1'b1;
		#10 clk = 1'b0;
		#10 rst = 1'b0;
		#10 clk = 1'b1;

		repeat (1000) begin
			#10 clk = ~clk;
		end
	end

endmodule