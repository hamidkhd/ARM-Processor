module Hazard_Detection_Unit(
    input EXE_WB_EN, MEM_WB_EN, Two_src, Forward_en, EXE_MEM_R_EN, hasSrc1,
    input [3:0] Src1, Src2, EXE_dst, MEM_dst,
    output reg Hazard
);

    always @(*) begin
        Hazard = 1'b0;
        if (Forward_en == 1'b0) begin
            if ((EXE_WB_EN == 1'b1) && (Src1 == EXE_dst) && (hasSrc1 == 1'b1)) 
                Hazard = 1'b1;
            else if ((EXE_WB_EN == 1'b1) && (Src2 == EXE_dst) && (Two_src == 1'b1)) 
                Hazard = 1'b1;
            else if ((MEM_WB_EN == 1'b1) && (Src1 == MEM_dst) && (hasSrc1 == 1'b1)) 
                Hazard = 1'b1;
            else if ((MEM_WB_EN == 1'b1) && (Src2 == MEM_dst) && (Two_src == 1'b1)) 
                Hazard = 1'b1;
        end
        else begin 
            if ((EXE_MEM_R_EN == 1'b1) && (EXE_WB_EN == 1'b1) && (Src1 == EXE_dst) && (hasSrc1 == 1'b1)) 
                Hazard = 1'b1;
            else if ((EXE_MEM_R_EN == 1'b1) && (EXE_WB_EN == 1'b1) && (Src2 == EXE_dst) && (Two_src == 1'b1)) 
                Hazard = 1'b1;
        end
    end

endmodule