`timescale 1ns/1ns

module Cache(
    input clk, rst,
    input read_en, write_en, is_store,
    input [16:0] address,
    input [63:0] SRAM_data,
    output reg [31:0] read_data,
    output hit
);

    reg [31:0] datas_left [0:1][0:63];
    reg [31:0] datas_right [0:1][0:63];

    reg [9:0] tags_left [0:63];
    reg [9:0] tags_right [0:63];

    reg valids_left [0:63];
    reg valids_right [0:63];

    reg used [0:63];

    wire [9:0] tag = address[16:7];
    wire [5:0] index = address[6:1];
    wire offset = address[0];

    integer i;
    initial begin
        for (i = 0; i <= 63; i = i + 1) begin
            used[i] = 1'b0;
            tags_left[i] = 10'b0;
            tags_right[i] = 10'b0;
            valids_left[i] = 1'b0;
            valids_right[i] = 1'b0;
        end
    end

    wire hit1, hit2;
    assign hit1 = (tags_left[index] == tag) && valids_left[index];
    assign hit2 = (tags_right[index] == tag) && valids_right[index];
    assign hit = hit1 || hit2;

    always @(*) begin
        if (rst) begin

            for (i = 0; i <= 63; i = i + 1) begin
                used[i] = 1'b0;
                tags_left[i] = 10'b0;
                tags_right[i] = 10'b0;
                valids_left[i] = 1'b0;
                valids_right[i] = 1'b0;
            end
            
        end

        else begin

            if (read_en) begin

                if (hit) begin
                    if (hit1) begin
                        read_data = datas_left[offset][index];
                        used[index] = 1'b1;
                    end
                    else if (hit2) begin
                        read_data = datas_right[offset][index];
                        used[index] = 1'b0;
                    end
                end
            end

            if (is_store && hit) begin
                if (hit1) begin
                    valids_left[index] = 1'b0;
                    used[index] = 1'b0;
                end
                else if(hit2) begin
                    valids_right[index] = 1'b0;
                    used[index] = 1'b1;
                end
		    end

            if (write_en) begin

                if (used[index] == 1'b1) begin
                    valids_right[index] = 1'b1;
                    used[index] = 1'b0;

                    datas_right[0][index] = SRAM_data[31:0];
                    datas_right[1][index] = SRAM_data[63:32];

                    tags_right[index] = tag;
                end

                else if (used[index] == 1'b0) begin
                    valids_left[index] = 1'b1;
                    used[index] = 1'b1;

                    datas_left[0][index] = SRAM_data[31:0];
                    datas_left[1][index] = SRAM_data[63:32];

                    tags_left[index] = tag;
                end

            end
        end
    end

endmodule