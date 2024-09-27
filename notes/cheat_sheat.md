# Verilog Cheat Sheet

## Module Definition
```verilog
module module_name(
    input wire in1, in2,
    output reg out1,
    output wire out2
);
    // Module contents
endmodule
```

## Data Types
- `wire`: Represents a physical wire (combinational logic)
- `reg`: Represents a storage element (sequential logic)
- `integer`: 32-bit signed integer
- `real`: Double-precision floating point
- `time`: 64-bit unsigned integer

## Vector Declaration
```verilog
wire [7:0] bus;     // 8-bit vector
reg [3:0] nibble;   // 4-bit register
```

## Parameter Definition
```verilog
parameter WIDTH = 8;
localparam DEPTH = 16;
```

## Operators
- Arithmetic: `+`, `-`, `*`, `/`, `%`
- Bitwise: `&`, `|`, `^`, `~`
- Logical: `&&`, `||`, `!`
- Comparison: `==`, `!=`, `<`, `>`, `<=`, `>=`
- Shift: `<<`, `>>`
- Concatenation: `{}`
- Replication: `{n{x}}`

## Procedural Blocks

### Always Block (Sequential)
```verilog
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 0;
    else
        q <= d;
end
```
Explanation:
- This block describes a positive-edge triggered flip-flop with asynchronous reset.
- `@(posedge clk or negedge rst_n)`: The block is sensitive to the rising edge of `clk` and falling edge of `rst_n`.
- `if (!rst_n)`: If reset is active (low in this case), `q` is set to 0.
- `else`: On the rising edge of the clock (when not in reset), `q` takes the value of `d`.
- `<=` is a non-blocking assignment, typically used in sequential logic to prevent race conditions.

### Always Block (Combinational)
```verilog
always @(*) begin
    y = a & b | c;
end
```
Explanation:
- This block describes combinational logic.
- `@(*)`: The sensitivity list includes all signals on the right-hand side of assignments within the block.
- It's equivalent to `@(a, b, c)` in this case.
- `=` is a blocking assignment, typically used in combinational logic.
- The logic performs `(a AND b) OR c`.

## Continuous Assignment
```verilog
assign sum = a + b;
```

## Conditional Statements
```verilog
if (condition) begin
    // statements
end else if (condition2) begin
    // statements
end else begin
    // statements
end

case (select)
    2'b00: out = a;
    2'b01: out = b;
    2'b10: out = c;
    default: out = 0;
endcase
```

### Ternary Operator
```verilog
out = condition ? value1 : value2;
```
Explanation:
- This is a shorthand for a simple if-else statement.
- If `condition` is true, `out` is assigned `value1`.
- If `condition` is false, `out` is assigned `value2`.
- It's often used for simple conditional assignments in both combinational and sequential logic.
- Example: `max = (a > b) ? a : b;` assigns the larger of `a` or `b` to `max`.

## Loops
```verilog
for (i = 0; i < 10; i = i + 1) begin
    // statements
end

while (condition) begin
    // statements
end

repeat (n) begin
    // statements
end

forever begin
    // statements
end
```

## Tasks and Functions
```verilog
task my_task;
    input [7:0] in;
    output [7:0] out;
    begin
        // task body
    end
endtask

function [7:0] my_function;
    input [7:0] in;
    begin
        // function body
        my_function = result;
    end
endfunction
```

## Generate Statements
```verilog
generate
    genvar i;
    for (i = 0; i < 8; i = i + 1) begin : gen_loop
        // generate block
    end
endgenerate
```

## System Tasks
- `$display("text %d", var);`  // Print to console
- `$monitor("var = %b", var);` // Continuously monitor
- `$time`                      // Current simulation time
- `$finish;`                   // End simulation
- `$readmemh("file.mem", memory);` // Read hex file into memory

## Testbench Constructs
```verilog
initial begin
    // Initial block for testbench
end

// Clock generation
always #5 clk = ~clk;

// Delay
#10 signal = 1;  // Wait for 10 time units
```

## Useful Syntax
- Bit selection: `bus[3]`
- Range selection: `bus[7:4]`
- Concatenation: `{4'b1010, 4'b0101}`
- Replication: `{4{2'b10}}`  // Results in 8'b10101010