`timescale 1ns/1ps

module counter(
    input clk,
    input reset,
    output reg [3:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'b0000;
        else
            count <= count + 1;
    end
endmodule

module counter_tb;
    reg clk;
    reg reset;
    wire [3:0] count;

    // Instantiate the Unit Under Test (UUT)
    counter uut (
        .clk(clk), 
        .reset(reset), 
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize Inputs
        reset = 1;

        // Wait 100 ns for global reset to finish
        #10;
        reset = 0;

        // Wait for a few clock cycles
        #10;

        // Finish the simulation
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time = %0t, Reset = %b, Count = %b", $time, reset, count);
    end

    // Optional: Generate VCD file for waveform viewing
    initial begin
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, counter_tb);
    end
endmodule