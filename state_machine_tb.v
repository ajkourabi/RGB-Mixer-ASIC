`timescale 1ns / 1ps

module traffic_light_controller_tb();

    // Inputs
    reg clk;
    reg reset;
    reg [7:0] timer_adj;

    // Outputs
    wire [2:0] main_lights;
    wire [2:0] side_lights;

    // Instantiate the Unit Under Test (UUT)
    traffic_light_controller uut (
        .clk(clk), 
        .reset(reset), 
        .timer_adj(timer_adj), 
        .main_lights(main_lights), 
        .side_lights(side_lights)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // VCD file generation
    initial begin
        $dumpfile("traffic_light_sim.vcd");
        $dumpvars(0, traffic_light_controller_tb);
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        timer_adj = 0;

        // Wait 100 ns for global reset to finish
        #100;
        reset = 0;

        // Wait for a full cycle
        #((100 + 30 + 60 + 30) * 10);

        // Apply timer adjustment
        timer_adj = 8'd50;
        #100;
        timer_adj = 8'd0;

        // Wait for another full cycle
        #((100 + 30 + 60 + 30) * 10);

        // Test reset during operation
        reset = 1;
        #20;
        reset = 0;

        // Wait for another full cycle
        #((100 + 30 + 60 + 30) * 10);

        // Finish the simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time=%0t, State=%b, Main=%b, Side=%b", 
                 $time, uut.current_state, main_lights, side_lights);
    end

endmodule