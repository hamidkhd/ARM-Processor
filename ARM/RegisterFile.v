`timescale 1ns/1ns

module RegisterFile (
    input clk, rst,
    input [3:0] src1, src2, Dest_wb,
    input [31:0] Result_WB,
    input writeBackEn,
    output [31:0] reg1, reg2
);

    reg [31:0] R[0:14];

    integer i;
    initial begin
        for (i = 0; i < 15; i = i + 1)
			R[i] = i;
    end

	assign reg1 = R[src1];
	assign reg2 = R[src2];

	always @(negedge clk, posedge rst) begin
        if (rst) begin
            for (i = 0; i < 15; i = i + 1)
			R[i] = i;
        end
	    if (writeBackEn)
	        R[Dest_wb] <= Result_WB;
	end

endmodule