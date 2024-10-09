`timescale 1ns / 1ps

module pwm_driver_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [7:0] duty_cycle;

    // Outputs
    wire pwm_out;

    // Instantiate the Unit Under Test (UUT)
    pwm_driver uut (
        .clk(clk), 
        .rst(rst), 
        .duty_cycle(duty_cycle), 
        .pwm_out(pwm_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        rst = 1;
        duty_cycle = 0;

        // Wait 100 ns for global reset to finish
        #100;
        rst = 0;

        // Test different duty cycles
        duty_cycle = 8'd0;   // 0%
        #10000;
        duty_cycle = 8'd64;  // 25%
        #200
        duty_cycle = 8'd128; // 50%
        #10000;
        duty_cycle = 8'd192; // 75%
        #10000;
        duty_cycle = 8'd255; // 100%
        #10000;

        // End simulation
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t rst=%b duty_cycle=%d pwm_out=%b", 
                 $time, rst, duty_cycle, pwm_out);
        $dumpfile("pwm_driver_tb.vcd");
        $dumpvars(0, pwm_driver_tb);
    end

endmodule