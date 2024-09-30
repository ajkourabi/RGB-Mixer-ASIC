module clock_select(
    input wire clk_in,    // Input clock
    input wire sel,       // Selection signal
    output wire clk_out   // Output clock
);

    wire clk_inv;         // Inverted clock signal

    // Generate inverted clock
    assign clk_inv = ~clk_in;

    // 2-to-1 MUX to select between normal and inverted clock
    mux2to1 clock_mux (
        .a(clk_in),       // Normal clock connected to input A
        .b(clk_inv),      // Inverted clock connected to input B
        .sel(sel),        // Selection signal
        .out(clk_out)     // Output clock
    );

endmodule

// 2-to-1 Multiplexer (reused from previous example)
module mux2to1(
    input wire a,      // Input A
    input wire b,      // Input B
    input wire sel,    // Selection signal
    output wire out    // Output
);

    assign out = sel ? b : a;

endmodule

// Testbench
module tb_clock_select();
    reg clk_in;
    reg sel;
    wire clk_out;

    // Instantiate the clock_select module
    clock_select uut (
        .clk_in(clk_in),
        .sel(sel),
        .clk_out(clk_out)
    );

    // Clock generation
    initial begin
        clk_in = 0;
        forever #5 clk_in = ~clk_in;  // Generate a clock with 10 time units period
    end

    // Test scenario
    initial begin
        $dumpfile("clock_select.vcd");
        $dumpvars(0, tb_clock_select);

        sel = 0;  // Select normal clock
        #20;
        sel = 1;  // Select inverted clock
        #20;
        sel = 0;  // Back to normal clock
        #20;
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t: clk_in=%b, sel=%b, clk_out=%b", $time, clk_in, sel, clk_out);
    end

endmodule