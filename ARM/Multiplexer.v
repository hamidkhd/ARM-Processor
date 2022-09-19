`timescale 1ns/1ns

module MUX2_32(
    input [31:0] in1, in2, 
    input sel,
    output [31:0] out
);
    
    assign out = sel ? in1 : in2;
    
endmodule

module MUX3_32(
    input [31:0] in1, in2, in3,
    input [1:0] sel, 
    output reg [31:0] out
);

    parameter [1:0] A = 2'b00;
    parameter [1:0] B = 2'b01;
    parameter [1:0] C = 2'b10;

    always @(*) begin
        case (sel)
            A : out = in1;
            B : out = in2;
            C : out = in3;
        endcase
    end

endmodule