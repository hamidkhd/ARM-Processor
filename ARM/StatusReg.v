module Status_Reg(
    input clk, rst, S,
    input [3:0] SR_in,
    output reg [3:0] SR_out
);

    always @(negedge clk, posedge rst) begin
        if (rst) begin
            SR_out <= 4'b0;
        end
        else if (S == 1'b1) begin
            SR_out <= SR_in;
        end
    end

endmodule