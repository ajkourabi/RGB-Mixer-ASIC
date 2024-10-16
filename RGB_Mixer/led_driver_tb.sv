`timescale 1ns / 1ps

module led_driver_tb;

    reg clk;
    reg rst;

    reg blue_A; 
    reg blue_B; 

    reg red_A; 
    reg red_B;

    reg green_A; 
    reg green_B;

    wire pwm_red;
    wire pwm_green;
    wire pwm_blue;

    rgb_led_driver uut(
        .clk(clk),
        .rst(rst),
        .red_A(red_A),
        .red_B(red_B),
        .green_A(green_A),
        .green_B(green_B),
        .blue_A(blue_A),
        .blue_B(blue_B),
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
    {red_A, red_B, green_A, green_B, blue_A, blue_B} = 6'b000000;

    // Reset
    #20 rst = 1'b0;

    // Test red at 25%, green at 50%, blue at 75%
    repeat(25) begin
        #10 red_A = 1'b1;
        #10 red_B = 1'b1;
        #10 red_A = 1'b0;
        #10 red_B = 1'b0;
    end

    repeat(64) begin
        #10 green_A = 1'b1;
        #10 green_B = 1'b1;
        #10 green_A = 1'b0;
        #10 green_B = 1'b0;
    end

    repeat(80) begin
        #10 blue_A = 1'b1;
        #10 blue_B = 1'b1;
        #10 blue_A = 1'b0;
        #10 blue_B = 1'b0;
    end

    #2000;

    // turning things down
    repeat(20) begin
        #10 red_B = 1'b1;
        #10 red_A = 1'b1;
        #10 red_B = 1'b0;
        #10 red_A = 1'b0;
    end

    repeat(30) begin
        #10 green_B = 1'b1;
        #10 green_A = 1'b1;
        #10 green_B = 1'b0;
        #10 green_A = 1'b0;
    end

    repeat(10) begin
        #10 blue_B = 1'b1;
        #10 blue_A = 1'b1;
        #10 blue_B = 1'b0;
        #10 blue_A = 1'b0;
    end

    #1000;

    #20 rst = 1'b1;
    #20 rst = 1'b0;

    #1000;
    // End simulation
    #100 $finish;
  end

  // VCD file generation
  initial begin
      $dumpfile("led_driver.vcd");
      $dumpvars(0, led_driver_tb);
  end


endmodule


