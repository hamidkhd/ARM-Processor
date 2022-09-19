`timescale 1ns/1ns

module Memory(
    input clk, MEMread, MEMwrite,
    input [31:0] address, data,
    output [31:0] MEM_result
);

    reg [31:0] MemByte [0:63];

    wire [31:0] adr = address - 32'd1024;

	assign MEM_result = MEMread ? MemByte[{2'b0, adr[31:2]}] : 32'bz;
	
    always @(posedge clk) begin
	    if (MEMwrite)
	        MemByte[{2'b0, adr[31:2]}] <= data;
	end    

endmodule
