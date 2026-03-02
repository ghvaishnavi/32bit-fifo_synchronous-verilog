//////////////////////////////////////////////
//// Vaishnavi G H
//// Testbench for fifo_simple_8x32
//////////////////////////////////////////////

`timescale 1ns/1ps
module fifo_simple_8x32_tb;

    reg clk;
    reg rst;
    reg write_enable;
    reg read_enable;
    reg [31:0] data_in;        // Changed to 32-bit
    wire [31:0] data_out;      // Changed to 32-bit
    wire full;
    wire empty;

    // Instantiate DUT
    fifo_simple_8x32 dut (
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("fifo_simple_8x32_tb.vcd");
        $dumpvars(1, fifo_simple_8x32_tb);

        clk = 0;
        rst = 1;
        write_enable = 0;
        read_enable = 0;
        data_in = 0;

        // Reset system
        #10;
        rst = 0;
        $display("\n--- Reset Deasserted ---");
        $display("Initial: full=%b, empty=%b (Expect full=0, empty=1)\n", full, empty);

        // -----------------------------------
        // WRITE PHASE (Fill FIFO)
        // -----------------------------------
        $display("--- Writing 32-bit Data into FIFO ---");
        for (i = 0; i < 8; i = i + 1) begin
            @(posedge clk);
            if (!full) begin
                write_enable = 1;
                data_in = 32'hA0000000 + i;   // Example 32-bit pattern
                $display("Time=%0t | Writing Data=0x%h | wr_ptr=%0d | full=%b | empty=%b",
                          $time, data_in, dut.wr_ptr, full, empty);
            end else begin
                $display("Time=%0t | Write Ignored: FIFO FULL", $time);
            end
        end
        @(posedge clk);
        write_enable = 0;

        // -----------------------------------
        // READ PHASE (Empty FIFO)
        // -----------------------------------
        $display("\n--- Reading 32-bit Data from FIFO ---");
        for (i = 0; i < 8; i = i + 1) begin
            @(posedge clk);
            if (!empty) begin
                read_enable = 1;
                $display("Time=%0t | Reading Data=0x%h | rd_ptr=%0d | full=%b | empty=%b",
                          $time, data_out, dut.rd_ptr, full, empty);
            end else begin
                $display("Time=%0t | Read Ignored: FIFO EMPTY", $time);
            end
        end
        @(posedge clk);
        read_enable = 0;

        // -----------------------------------
        // CHECK EMPTY CONDITION
        // -----------------------------------
        @(posedge clk);
        $display("\nAfter Reading All Data: full=%b, empty=%b (Expect full=0, empty=1)", full, empty);

        // -----------------------------------
        // WRAP-AROUND TEST
        // -----------------------------------
        $display("\n--- Wrap-Around Test ---");
        for (i = 0; i < 4; i = i + 1) begin
            @(posedge clk);
            write_enable = 1;
            data_in = 32'hB0000000 + i;
            $display("Time=%0t | Writing Data=0x%h", $time, data_in);
        end
        @(posedge clk);
        write_enable = 0;

        for (i = 0; i < 4; i = i + 1) begin
            @(posedge clk);
            read_enable = 1;
            $display("Time=%0t | Reading Data=0x%h", $time, data_out);
        end
        @(posedge clk);
        read_enable = 0;

        #20;
        $display("\n--- Simulation Complete ---");
        $finish;
    end
endmodule