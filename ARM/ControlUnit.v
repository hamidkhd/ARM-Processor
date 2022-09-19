`timescale 1ns/1ns

module ControlUnit (
    input SIn,
    input [3:0] opcode,
    input [1:0] mode,
    output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S, hasSrc1,
    output reg [3:0] EXE_CMD
);

    parameter STR = 1'b0; 
    parameter LDR = 1'b1; 

    parameter [1:0] ARTHMETIC_LOGIC = 2'b00; 
    parameter [1:0] STR_LDR = 2'b01; 
    parameter [1:0] BRANCH = 2'b10; 

    parameter [3:0] AND = 4'b0000; 
    parameter [3:0] EOR = 4'b0001; 
    parameter [3:0] SUB = 4'b0010;
    parameter [3:0] ADD = 4'b0100;  
    parameter [3:0] ADC = 4'b0101; 
    parameter [3:0] SBC = 4'b0110; 
    parameter [3:0] TST = 4'b1000; 
    parameter [3:0] CMP = 4'b1010; 
    parameter [3:0] ORR = 4'b1100; 
    parameter [3:0] MOV = 4'b1101; 
    parameter [3:0] MVN = 4'b1111; 

    always @(SIn, opcode, mode) begin
        {WB_EN, MEM_R_EN, MEM_W_EN, B, S, EXE_CMD, hasSrc1} = 10'b0;

        case (mode)
            ARTHMETIC_LOGIC: begin
                case (opcode)
                    MOV: begin 
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b0001;
                        S = SIn;
                    end
                    MVN: begin 
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b1001;
                        S = SIn;
                    end
                    ADD: begin 
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b0010;
                        S = SIn;
                        hasSrc1 = 1'b1;
                    end
                    ADC: begin 
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b0011;
                        S = SIn;
                        hasSrc1 = 1'b1;
                    end
                    SUB: begin 
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b0100;
                        S = SIn;
                        hasSrc1 = 1'b1;
                    end
                    SBC: begin 
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b0101;
                        S = SIn;
                        hasSrc1 = 1'b1;
                    end
                    AND: begin 
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b0110;
                        S = SIn;
                        hasSrc1 = 1'b1;
                    end
                    ORR: begin 
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b0111;
                        S = SIn;
                        hasSrc1 = 1'b1;
                    end
                    EOR: begin 
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b1000;
                        S = SIn;
                        hasSrc1 = 1'b1;
                    end
                    CMP: begin 
                        EXE_CMD = 4'b0100;
                        S = 1'b1;
                        hasSrc1 = 1'b1;
                    end
                    TST: begin 
                        EXE_CMD = 4'b0110;
                        S = 1'b1;
                        hasSrc1 = 1'b1;
                    end
                endcase
            end 

            STR_LDR: begin
                case (SIn)
                    STR: begin 
                        MEM_W_EN = 1'b1;
                        EXE_CMD = 4'b0010;
                        S = 1'b0;
                        hasSrc1 = 1'b1;
                    end 
                    LDR: begin
                        MEM_R_EN = 1'b1;
                        WB_EN = 1'b1;
                        EXE_CMD = 4'b0010;
                        S = 1'b1;
                        hasSrc1 = 1'b1;
                    end
                endcase
            end

            BRANCH: begin 
                B = 1'b1;
            end
             
        endcase
    end

endmodule
