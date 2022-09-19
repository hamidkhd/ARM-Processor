`timescale 1ns/1ns

module Adder_32bit(
    input [31:0] in1, in2,
    output [31:0] result
);

    assign result = in1 + in2;

endmodule