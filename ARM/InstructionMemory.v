`timescale 1ns/1ns

module InstructionMemory(
    input [31:0] address,
    output [31:0] instruction
);
    reg [31:0] MemByte[0:255];
    
    initial begin
		$readmemb("Program.data", MemByte);
	end

    assign instruction = MemByte[{2'b0, address[31:2]}];

endmodule