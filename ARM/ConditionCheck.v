`timescale 1ns/1ns

module ContidionCheck (
    input[3:0] condition, SR,
    output reg out
);

    parameter [3:0] EQ = 4'b0000; 
    parameter [3:0] NE = 4'b0001; 
    parameter [3:0] CS_HS = 4'b0010; 
    parameter [3:0] CC_LO = 4'b0011; 
    parameter [3:0] MI = 4'b0100; 
    parameter [3:0] PL = 4'b0101; 
    parameter [3:0] VS = 4'b0110; 
    parameter [3:0] VC = 4'b0111; 
    parameter [3:0] HI = 4'b1000; 
    parameter [3:0] LS = 4'b1001; 
    parameter [3:0] GE = 4'b1010; 
    parameter [3:0] LT = 4'b1011; 
    parameter [3:0] GT = 4'b1100; 
    parameter [3:0] LE = 4'b1101; 
    parameter [3:0] AL = 4'b1110; 

    wire Z, C, N, V;
    assign {Z, C, N, V} = SR;

    always @(condition, SR) begin
        out = 1'b0;

        case(condition)
            EQ: out = Z;
            NE: out = ~Z;
            CS_HS: out = C;
            CC_LO: out = ~C;
            MI: out = N;
            PL: out = ~N;
            VS: out = V;
            VC: out = ~V;
            HI: out = C & ~Z;
            LS: out = ~C & Z;
            GE: out = (N & V) | (~N & ~V);
            LT: out = (N & ~V) | (~N & V);
            GT: out = ~Z & ((N & V) | (~N & ~V));
            LE: out = Z & ((N & ~V) | (~N & V));
            AL: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule