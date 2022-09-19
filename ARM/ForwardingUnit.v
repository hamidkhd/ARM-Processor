`timescale 1ns/1ns

module ForwardingUnit(
    input MEM_wb_en, WB_wb_en, Forward_en,
    input [3:0] src1, src2, MEM_dst, WB_dst,
    output reg [1:0] Sel_src1, Sel_src2
);

    always @(*) begin
        {Sel_src1, Sel_src2} = 4'b0;
    
        if (Forward_en == 1'b1) begin 
            if ((MEM_wb_en == 1'b1) && (src1 == MEM_dst)) 
                Sel_src1 = 2'b01;
            else if ((WB_wb_en == 1'b1) && (src1 == WB_dst))
                Sel_src1 = 2'b10;

            if ((MEM_wb_en == 1'b1) && (src2 == MEM_dst)) 
                Sel_src2 = 2'b01;
            else if ((WB_wb_en == 1'b1) && (src2 == WB_dst))
                Sel_src2 = 2'b10;
        end      
    end

endmodule