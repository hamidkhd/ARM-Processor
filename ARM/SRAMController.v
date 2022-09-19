`timescale 1ns/1ns

module SRAM_Controller(
    input clk,
    input rst,

    input write_en,
    input read_en,
    input[31:0] address,
    input[31:0] writeData,

    output[63:0] readData,
    output ready,
    
    inout[63:0] SRAM_DQ,
    output[16:0] SRAM_ADDR,
    output SRAM_UB_N,
    output SRAM_LB_N,
    output SRAM_WE_N,
    output SRAM_CE_N,
    output SRAM_OE_N
);
    parameter [1:0] IDLE = 2'b00; 
    parameter [1:0] READING = 2'b01; 
    parameter [1:0] WRITING = 2'b11;

    wire[1:0] ns, ps;
    wire[2:0] counter, counter_out;
    wire[63:0] dq;

    assign SRAM_UB_N = 1'b0;
    assign SRAM_LB_N = 1'b0;
    assign SRAM_CE_N = 1'b0;
    assign SRAM_OE_N = 1'b0;

    Reg_2bit state_register(clk, rst, ns, ps);
    Reg_3bit counter_register(clk, rst, counter, counter_out);
    Reg_64bit dq_reg(clk, rst, 1'b1, SRAM_DQ, dq);

    wire [31:0] adr = address - 32'd1024;
    assign SRAM_ADDR = adr[18:2];
    
    assign SRAM_DQ = (ns == WRITING && counter < 3'b101) ? writeData : 64'bz;
    assign SRAM_WE_N = (ns == WRITING && counter < 3'b101) ? 1'b0 : 1'b1; 
    assign readData = read_en ? dq : 32'bz;
    assign ready = (ns == READING && counter < 3'b101) ? 1'b0 :
                   (ns == WRITING && counter < 3'b101) ? 1'b0 : 1'b1;


    assign counter = rst ? 3'b0 :
        (ps == READING && counter_out != 3'b101) ? (counter_out + 1'b1) :
        (ps == WRITING && counter_out != 3'b101) ? (counter_out + 1'b1) : 3'b0
    ;

    assign ns = rst ? IDLE :
    (
        (ps == IDLE && read_en) ? READING :
        (ps == IDLE && write_en) ? WRITING :
        (ps == READING && counter != 3'b101) ? READING :
        (ps == WRITING && counter != 3'b101) ? WRITING : 2'b00
    );
endmodule