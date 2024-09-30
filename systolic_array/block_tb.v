
`timescale 1ns / 1ps

module block_tb();

    reg [15:0] north_input, west_input;
    reg rst;
    reg clk;

    wire [15:0] out_south, out_east; 
    wire [31:0] out;

    block uut(
        .north_input(north_input),
        .west_input(west_input),
        .out_east(out_east),
        .out_south(out_south),
        .out(out),
        .rst(rst),
        .clk(clk)
    );
   
    // Clock generation
    always begin
        #5 clk = ~clk; // Generate a 100MHz clock
    end

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        north_input = 0;
        west_input = 0;

        // Dump waveforms
        $dumpfile("block_tb.vcd");
        $dumpvars(0, block_tb);

        // Reset sequence
        #20 rst = 0;

        // Test case 1: Simple multiplication
        #10 north_input = 16'd2; west_input = 16'd4;
        //#10 $display("Test case 1: north_input=%d, west_input=%d, out=%d", north_input, west_input,out);

        // Test case 2: Larger numbers
        #10 north_input = 16'd100; west_input = 16'd200;
        //#10 $display("Test case 2: north_input=%d, west_input=%d, out=%d", north_input, west_input, out);

        // Test case 3: Accumulation
        #10 north_input = 16'd3; west_input = 16'd5;
        //#10 $display("Test case 3: north_input=%d, west_input=%d, out=%d", north_input, west_input, out);

        // Test case 4: Reset during operation
        #10 north_input = 16'd10; west_input = 16'd10;
        #5 rst = 1;
        #5 rst = 0;
        //#10 $display("Test case 4 (after reset): north_input=%d, west_input=%d, out=%d", north_input, west_input, out);

        // End simulation
        #20 $finish;
    end

endmodule
