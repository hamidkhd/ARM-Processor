`timescale 1ns/1ns

module Reg_1bit(
	input clk, rst, load, in,
	output reg out
);
	always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= 1'b0;
        end
        else begin
            if (load) out <= in;
        end
    end
endmodule

module Reg_4bit(
	input clk, rst, load,
	input [3:0] in,
	output reg [3:0] out
);
	always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= 4'b0;
        end
        else begin
            if (load) out <= in;
        end
    end
endmodule

module Reg_2bit(
	input clk, rst, 
	input [1:0] in,
	output reg [1:0] out
);
	always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= 2'b0;
        end
        else begin
            out <= in;
        end
    end
endmodule

module Reg_3bit(
	input clk, rst, 
	input [2:0] in,
	output reg [2:0] out
);
	always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= 3'b0;
        end
        else begin
            out <= in;
        end
    end
endmodule



module Reg_32bit(
	input clk, rst, load,
	input [31:0] in,
	output reg [31:0] out
);
	always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= 32'b0;
        end
        else begin
			if (load) out <= in;
        end
    end
	
endmodule

module Reg_64bit(
	input clk, rst, load,
	input [63:0] in,
	output reg [63:0] out
);
	always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= 32'b0;
        end
        else begin
			if (load) out <= in;
        end
    end
	
endmodule


module MemRegister32bit(
    input clk, rst, load,
    input [31:0] in,
    output reg [31:0] out
);

	always @(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else if (load) out <= in;
	end
	
endmodule

module MemRegister1bit(
    input clk, rst, load,
    input in,
    output reg out
);

	always@(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else if (load) out <= in;
	end
	
endmodule

module MemRegister4bit(
    input clk, rst, load,
    input [3:0] in,
    output reg [3:0] out
);

	always@(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else if (load) out <= in;
	end
	
endmodule

module IFStageRegister(
    input clk, rst, flush, load,
    input [31:0] in,
    output reg [31:0] out
);

	always @(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else if (load && flush) out <= 0;
		else if (load) out <= in;
	end
	
endmodule


module IDStageRegister32bit(
    input clk, rst, flush, load,
    input [31:0] in,
    output reg [31:0] out
);

	always@(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else if (load && flush) out <= 0;
		else if (load) out <= in;
	end
	
endmodule

module PCRegister(
    input clk, rst, load,
    input [31:0] in,
    output reg [31:0] out
);

	always @(posedge clk, posedge rst) 
	begin
		if (rst) out <= 0;
		else if (load) out <= in;
	end
	
endmodule

module IDStageRegister1bit(
    input clk, rst, flush, load,
    input in,
    output reg out
);

	always@(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else if (load && flush) out <= 0;
		else if (load) out <= in;
	end
	
endmodule

module IDStageRegister4bit(
    input clk, rst, flush, load,
    input [3:0] in,
    output reg [3:0] out
);

	always @(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else if (load && flush) out <= 0;
		else if (load) out <= in;
	end
	
endmodule

module IDStageRegister12bit(
    input clk, rst, flush, load,
    input [11:0] in,
    output reg [11:0] out
);

	always @(posedge clk, posedge rst) 
	begin
		if (rst) out <= 0;
		else if (load && flush) out <= 0;
		else if (load) out <= in;
	end
	
endmodule

module IDStageRegister24bit(
    input clk, rst, flush, load,
    input [23:0] in,
    output reg [23:0] out
);

	always @(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else if (load && flush) out <= 0;
		else if (load) out <= in;
	end
	
endmodule