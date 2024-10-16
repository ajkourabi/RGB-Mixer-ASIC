`timescale 1ns / 1ps

module rotary_encoder_tb();

  // Testbench signals
  reg clk;
  reg rst;
  reg A;
  reg B;
  wire [7:0] count;

  // Instantiate the Unit Under Test (UUT)
  rotary_encoder uut (
    .clk(clk),
    .rst(rst),
    .A(A),
    .B(B),
    .count(count)
  );

  // Clock generation
  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  // Test stimulus
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
    repeat(30) begin
      A = 1'b1;
      B = 1'b1;
      A = 1'b0;
      B = 1'b0;
    end

    repeat(1) begin
      B = 1'b1;
      A = 1'b1;
      B = 1'b0;
      A = 1'b0;
    end

    // End simulation
    #100 $finish;
  end

  // VCD file generation
  initial begin
      $dumpfile("rotary.vcd");
      $dumpvars(0, rotary_encoder_tb);
  end
  
  // Monitor
  initial begin
    $monitor("Time=%0t rst=%b A=%b B=%b count=%d", $time, rst, A, B, count);
  end

endmodule