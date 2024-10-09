module rgb_led_driver(
    input clk, rst,
    input encoder_A, encoder_B,
    output pwm_red, pwm_green, pwm_blue
);

    
    wire [7:0] red_counter;
    wire [7:0] green_counter;
    wire [7:0] blue_counter;
    
    rotary_encoder encoder_red (
        .clk(clk),
        .rst(rst),
        .A(encoder_A),
        .B(encoder_B),
        .count(red_counter)
    );

    pwm_driver driver_red (
        .clk(clk),
        .rst(rst),
        .duty_cycle(red_counter),
        .pwm_out(pwm_red)
    );

    rotary_encoder encoder_green (
        .clk(clk),
        .rst(rst),
        .A(encoder_A),
        .B(encoder_B),
        .count(green_counter)
    );

    pwm_driver driver_green (
        .clk(clk),
        .rst(rst),
        .duty_cycle(red_counter),
        .pwm_out(pwm_green)
    );

    rotary_encoder encoder_blue (
        .clk(clk),
        .rst(rst),
        .A(encoder_A),
        .B(encoder_B),
        .count(blue_counter)
    );

    pwm_driver driver_blue (
        .clk(clk),
        .rst(rst),
        .duty_cycle(red_counter),
        .pwm_out(pwm_blue)
    );
    
    always @(posedge clk) begin
        $display("Red: %d, Green: %d, Blue: %d", red_counter, green_counter, blue_counter);
    end
endmodule 