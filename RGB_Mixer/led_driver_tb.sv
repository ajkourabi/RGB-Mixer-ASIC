`timescale 1ns / 1ps

module led_driver_tb;

    reg clk;
    reg rst;
    reg A;
    reg B;

    wire pwm_red;
    wire pwm_green;
    wire pwm_blue;

    rgb_led_driver uut(
        .clk(clk),
        .rst(rst),
        .encoder_A(A),
        .encoder_B(B),
        .pwm_red(pwm_red),
        .pwm_blue(pwm_blue),
        .pwm_green(pwm_green)
    );

  // Clock generation
  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

initial begin
    // Initialize inputs
    rst = 1'b1;
    A = 1'b0;
    B = 1'b0;

    // Reset
    #20 rst = 1'b0;

    // Test clockwise rotation
    #20 A = 1'b1;
    #10 B = 1'b1;
    #10 A = 1'b0;
    #10 B = 1'b0;

    // Test counter-clockwise rotation
    #20 B = 1'b1;
    #10 A = 1'b1;
    #10 B = 1'b0;
    #10 A = 1'b0;

    // Test multiple rotations
    repeat(10) begin
    #10 A = 1'b1;
    #10 B = 1'b1;
    #10 A = 1'b0;
    #10 B = 1'b0;
    
    end
    #1000

    repeat(60) begin
    #10 A = 1'b1;
    #10 B = 1'b1;
    #10 A = 1'b0;
    #10 B = 1'b0;
    
    end
    #1000

    // End simulation
    #100 $finish;
  end


 // VCD file generation
  initial begin
      $dumpfile("led_driver.vcd");
      $dumpvars(0, led_driver_tb);
  end

initial begin
    $monitor("Time=%0t rst=%b A=%b B=%b", $time, rst, A, B );
  end
endmodule