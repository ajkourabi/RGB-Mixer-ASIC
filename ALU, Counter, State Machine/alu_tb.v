`timescale 1ns / 1ps

module alu_tb();

  // Inputs
  reg [7:0] a, b;
  reg [2:0] op;

  // Outputs
  wire [7:0] result;
  wire zero, overflow;

  // Instantiate the Unit Under Test (UUT)
  alu uut (
    .a(a),
    .b(b),
    .op(op),
    .result(result),
    .zero(zero),
    .overflow(overflow)
  );

  // Test case counter
  integer test_case;

  // Helper task to display test results
  task display_test_case;
    input [64*8-1:0] operation;
    begin
      $display("Test Case %0d: %s", test_case, operation);
      $display("a = %8b, b = %8b, op = %3b", a, b, op);
      $display("result = %8b, zero = %0d, overflow = %0d", result, zero, overflow);
      $display("----------------------------------------");
      test_case = test_case + 1;
    end
  endtask

  // Testbench stimulus
  initial begin
    test_case = 0;

    // Test case 1: Addition (no overflow)
    a = 8'b00100101; b = 8'b00011010; op = 3'b000; #10;
    display_test_case("Addition (no overflow)");

    // Test case 2: Addition (with overflow)
    a = 8'b11100101; b = 8'b00011010; op = 3'b000; #10;
    display_test_case("Addition (with overflow)");

    // Test case 3: Subtraction (no overflow)
    a = 8'b00100101; b = 8'b00011010; op = 3'b001; #10;
    display_test_case("Subtraction (no overflow)");

    // Test case 4: Subtraction (with overflow)
    a = 8'b10000000; b = 8'b00000001; op = 3'b001; #10;
    display_test_case("Subtraction (with overflow)");

    // Test case 5: Bitwise AND
    a = 8'b10101010; b = 8'b11001100; op = 3'b010; #10;
    display_test_case("Bitwise AND");

    // Test case 6: Bitwise OR
    a = 8'b10101010; b = 8'b11001100; op = 3'b011; #10;
    display_test_case("Bitwise OR");

    // Test case 7: Bitwise XOR
    a = 8'b10101010; b = 8'b11001100; op = 3'b100; #10;
    display_test_case("Bitwise XOR");

    // Test case 8: Shift Left
    a = 8'b10101010; b = 8'b00000000; op = 3'b101; #10;
    display_test_case("Shift Left");

    // Test case 9: Shift Right
    a = 8'b10101010; b = 8'b00000000; op = 3'b110; #10;
    display_test_case("Shift Right");

    // Test case 10: Zero result
    a = 8'b00000000; b = 8'b00000000; op = 3'b000; #10;
    display_test_case("Zero result");

    // Test case 11: Edge case - all 1's addition
    a = 8'b11111111; b = 8'b00000001; op = 3'b000; #10;
    display_test_case("Edge case - all 1's addition");

    // Test case 12: Edge case - subtracting larger from smaller
    a = 8'b00000001; b = 8'b11111111; op = 3'b001; #10;
    display_test_case("Edge case - subtracting larger from smaller");

    $finish;
  end

endmodule