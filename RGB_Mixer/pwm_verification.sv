`timescale 1ns/1ps
`include "pwm_driver.sv" 
module pwm_driver_tb;
    reg clk;
    reg rst;
    reg [7:0] duty_cycle;
    wire pwm_out;

    // Instantiate the PWM driver
    pwm_driver uut (
        .clk(clk),
        .rst(rst),
        .duty_cycle(duty_cycle),
        .pwm_out(pwm_out)
    );

    // Clock generation
    always #10 clk = ~clk;  // 50MHz clock

    // Test variables
    integer errors = 0;
    integer i;

    initial begin
        $dumpfile("pwm_driver_tb.vcd");
        $dumpvars(0, pwm_driver_tb);

        clk = 0;
        rst = 1;
        duty_cycle = 8'd0;

        // Reset test
        #20 rst = 0;
        if (pwm_out !== 1'b0) begin
            $display("Error: PWM output not reset properly");
            errors = errors + 1;
        end

        // Test different duty cycles
        for (i = 0; i <= 255; i = i + 30) begin
            duty_cycle = i;
            #2000;  // Wait for 1us (50 clock cycles)
            check_duty_cycle(i);
        end

        // Report results
        if (errors == 0)
            $display("All tests passed successfully!");
        else
            $display("Tests completed with %d errors.", errors);

        $finish;
    end

    // Task to check duty cycle
    task check_duty_cycle;
        input [7:0] expected_duty;
        integer high_time, total_time;
        begin
            high_time = 0;
            total_time = 0;
            repeat (100) begin  // Check over 100 cycles
                @(posedge clk);
                if (pwm_out) high_time = high_time + 1;
                total_time = total_time + 1;
            end
            if (high_time != expected_duty / 2) begin
                $display("Error: Incorrect duty cycle. Expected %d%%, got %d%%", 
                         (expected_duty * 100) / 255, (high_time * 100) / total_time);
                errors = errors + 1;
            end
        end
    endtask

endmodule