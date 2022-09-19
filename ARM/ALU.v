`timescale 1ns/1ns

module ALU(
	input signed [31:0] ALU_in1, ALU_in2, 
	input C_in,
	input [3:0] ALU_command,
	output wire [3:0] SR,
	output reg [31:0] ALU_result
);
	
    parameter [3:0] MOV = 4'b0001; 
    parameter [3:0] MVN = 4'b1001; 
    parameter [3:0] ADD = 4'b0010; 
    parameter [3:0] ADC = 4'b0011; 
	parameter [3:0] SUB = 4'b0100; 
	parameter [3:0] SBC = 4'b0101; 
	parameter [3:0] AND = 4'b0110; 
	parameter [3:0] ORR = 4'b0111; 
	parameter [3:0] EOR = 4'b1000; 
	parameter [3:0] CMP = 4'b0100; 
	parameter [3:0] TST = 4'b0110; 
	parameter [3:0] LDR = 4'b0010; 
	parameter [3:0] STR = 4'b0010; 

	wire Z, N;
	reg C_out, V;

	assign SR = {Z, C_out, N, V};

	assign Z = (ALU_result == 32'b0) ? 1'b1 : 1'b0;
	assign N = ALU_result[31];

	  
	always @(ALU_command, ALU_in1, ALU_in2) begin
		    
		{ALU_result, C_out, V} = 34'b0; 

		case (ALU_command) 
			MOV: ALU_result = ALU_in2;
			MVN: ALU_result = ~ALU_in2;
			ADD: begin 	
				{C_out, ALU_result} = ALU_in1 + ALU_in2;
				V = (ALU_in1[31] == ALU_in2[31]) & (ALU_in1[31] != ALU_result[31]);
			end
			ADC: begin 	
				{C_out, ALU_result} = ALU_in1 + ALU_in2 + {32'b0, C_in};
				V = (ALU_in1[31] == ALU_in2[31]) & (ALU_in1[31] != ALU_result[31]);
			end
			SUB: begin 	
				{C_out, ALU_result} = {ALU_in1[31], ALU_in1} - {ALU_in2[31], ALU_in2};
				V = (ALU_in1[31] == ~ALU_in2[31]) & (ALU_in1[31] != ALU_result[31]);
			end
			SBC: begin 	
				{C_out, ALU_result} = {ALU_in1[31], ALU_in1} - {ALU_in2[31], ALU_in2} -  {32'b0, ~C_in};
				V = (ALU_in1[31] == ~ALU_in2[31]) & (ALU_in1[31] != ALU_result[31]);
			end
			AND: ALU_result = ALU_in1 & ALU_in2;
	    	ORR: ALU_result = ALU_in1 | ALU_in2;
	    	EOR: ALU_result = ALU_in1 ^ ALU_in2;
			CMP: begin 	
				{C_out, ALU_result} = {ALU_in1[31], ALU_in1} - {ALU_in2[31], ALU_in2};
				V = (ALU_in1[31] == ~ALU_in2[31]) & (ALU_in1[31] != ALU_result[31]);
			end			
			TST: ALU_result = ALU_in1 & ALU_in2;
			LDR: begin 	
				{C_out, ALU_result} = ALU_in1 + ALU_in2;
				V = (ALU_in1[31] == ALU_in2[31]) & (ALU_in1[31] != ALU_result[31]);
			end
			STR: begin
				{C_out, ALU_result} = ALU_in1 + ALU_in2;
				V = (ALU_in1[31] == ALU_in2[31]) & (ALU_in1[31] != ALU_result[31]);
			end
	  	endcase
	end
	
endmodule