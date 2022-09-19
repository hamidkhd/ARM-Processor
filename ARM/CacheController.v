`timescale 1ns/1ns

module CacheController(
	input clk,
	input rst,

	// memory stage unit
	input [31:0] address,
	input [31:0] wdata,
	input MEM_R_EN,
	input MEM_W_EN,
	output [31:0] rdata,
	output ready,

	//SRAM controller
	input [63:0] sram_rdata,
	input sram_ready,
	output reg [31:0] sram_address,
	output reg [31:0] sram_wdata,
	output sram_read_en,
	output sram_write_en
);
	wire[31:0] adr, cache_read_data;
	wire[16:0] cache_address;
	wire cache_read_en, cache_write_en, is_store, hit;

	reg[1:0] ns, ps;

	parameter[1:0] IDLE = 2'b00;
	parameter[1:0] WRITE = 2'b10;
	parameter[1:0] READ = 2'b01;

	assign adr = address - 1024;
	assign cache_address = adr[17:2];
	assign cache_read_en = (ps == IDLE);
	assign is_store = (ps == IDLE && ns == WRITE);
	assign cache_write_en = (ps == READ && sram_ready);
	assign ready = (ns == IDLE);
	assign sram_write_en = (ps == WRITE) ? 1'b1 : 1'b0;
	assign sram_read_en = (ps == READ) ? 1'b1 : 1'b0;
	assign rdata = (ps == IDLE && hit) ? cache_read_data : (ps == READ && sram_ready) ? (cache_address[0] ? sram_rdata[63:32] : sram_rdata[31:0]): 32'bz;
	
	always @(posedge clk, posedge rst) begin
		if (rst) ps <= IDLE;
		else ps <= ns;
	end

	always @(ps, MEM_R_EN, hit, MEM_W_EN, sram_ready) begin
		case (ps)
            IDLE: begin
				ns = ps;
				if (MEM_R_EN && ~hit) ns = READ;
				else if (MEM_W_EN) ns = WRITE;
			end

            READ: begin
				if (sram_ready) ns = IDLE;
			end

            WRITE:  begin
				if (sram_ready) ns = IDLE;
			end

            default : ns <= IDLE;
        endcase
	end

	always @(ps) begin
		{sram_address, sram_wdata} = 64'bz;
		if (ps == READ || ps == WRITE) sram_address = address;
		if (ps == WRITE) sram_wdata = wdata;
	end

	Cache c(
		clk, rst,
		cache_read_en, cache_write_en, is_store,
		cache_address,
		sram_rdata,
		cache_read_data,
		hit
	);
	
endmodule