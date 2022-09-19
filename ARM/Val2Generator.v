`timescale 1ns/1ns

module Val2Generator(
    input imm, is_MEM_command,
    input [11:0] Shifte_operand,
    input [31:0] Val_Rm,
    output reg [31:0] Val2_result
);

    parameter [1:0] LSL = 2'b00; 
    parameter [1:0] LSR = 2'b01; 
    parameter [1:0] ASR = 2'b10; 
    parameter [1:0] ROR = 2'b11; 
    
    integer i;

    always @(*) begin
        if (is_MEM_command == 1'b1)
            Val2_result <= {20'b0, Shifte_operand};

        else if (imm == 1'b1) begin
                Val2_result = {24'b0, Shifte_operand[7:0]};
                for (i = 0; i < {1'b0, Shifte_operand[11:8]}; i = i + 1) begin
                    Val2_result = {Val2_result[1], Val2_result[0], Val2_result[31:2]}; 
                end
        end
        else begin
            case (Shifte_operand[6:5])
                LSL: Val2_result = Val_Rm << {1'b0, Shifte_operand[11:7]};
                LSR: Val2_result = Val_Rm >> {1'b0, Shifte_operand[11:7]};
                ASR: Val2_result = Val_Rm >>> {1'b0, Shifte_operand[11:7]};
                ROR: begin
                    Val2_result <= Val_Rm;
                    for (i = 0; i < {1'b0, Shifte_operand[11:7]}; i = i + 1) begin
                        Val2_result = {Val2_result[0], Val2_result[31:1]};
                    end
                end 
                default: Val2_result = Val_Rm;
            endcase
        end
    end

endmodule