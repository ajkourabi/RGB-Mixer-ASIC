`timescale 1ns / 1ps

module systolic_array_tb();
    
    reg clk;
    reg rst;
    reg [4:0][15:0] west_0;
    reg [4:0][15:0] west_1;
    reg [4:0][15:0] west_2;
    reg [4:0][15:0] north_0;
    reg [4:0][15:0] north_1;
    reg [4:0][15:0] north_2;
    wire [8:0][31:0] out;
    wire done;

systolic_array uut(

    .clk(clk),
    .rst(rst),

    .west_0(west_0),
    .west_1(west_1),
    .west_2(west_2),

    .north_0(north_0),
    .north_1(north_1),
    .north_2(north_2),

    .out(out),
    .done(done)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // Generate a 100MHz clock
end

initial begin 
    $display("Simulation started");
    rst = 1;  // Start with reset high
    #10 rst = 0;  // De-assert reset after 10 time units
    west_0 = {16'd0, 16'd0, 16'd4, 16'd3, 16'd1};
    west_1 = {16'd0, 16'd9, 16'd8, 16'd5, 16'd0};
    west_2 = {16'd5, 16'd4, 16'd7, 16'd0, 16'd0};

    north_0 = {16'd0, 16'd0, 16'd4, 16'd3, 16'd7};
    north_1 = {16'd0, 16'd7, 16'd6, 16'd8, 16'd0};
    north_2 = {16'd3, 16'd7, 16'd2, 16'd0, 16'd0};
    #1000;
    wait(done);

    $display("Systolic Array Output:");
    for (integer i = 0; i < 9; i = i + 1) begin
        $display("out[%0d] = %0d", i, out[i]);
    end

    #100 $finish;  // End simulation

end 

// VCD file generation
initial begin
    $dumpfile("systolic_sim.vcd");
    $dumpvars(0, systolic_array_tb);
end

endmodule