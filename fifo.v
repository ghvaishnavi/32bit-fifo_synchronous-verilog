/////////////////////////////////
/// vaishnavi g h///
////////////////////////////////

`timescale 1ns/1ps
module fifo_simple_8x32 (
    input clk,
    input rst,
    input write_enable,
    input read_enable,
    input [31:0] data_in,     
    output reg [31:0] data_out, 
    output full,
    output empty
);

    // 8-word memory (32-bit width)
    reg [31:0] fifo_mem [0:7];

    // 4-bit pointers (3-bit address + 1 wrap bit)
    reg [3:0] wr_ptr;
    reg [3:0] rd_ptr;

    // -----------------------------
    // Status Flags (MSB method)
    // -----------------------------
    assign empty = (wr_ptr == rd_ptr);

    assign full  = (rd_ptr == 
                   {~wr_ptr[3], wr_ptr[2:0]});

    // -----------------------------
    // Sequential Logic
    // -----------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr   <= 4'b0000;
            rd_ptr   <= 4'b0000;
            data_out <= 32'b0;
        end 
        else begin

            // WRITE
            if (write_enable && !full) begin
                fifo_mem[wr_ptr[2:0]] <= data_in;
                wr_ptr <= wr_ptr + 1;
            end

            // READ
            if (read_enable && !empty) begin
                data_out <= fifo_mem[rd_ptr[2:0]];
                rd_ptr <= rd_ptr + 1;
            end
        end
    end

endmodule