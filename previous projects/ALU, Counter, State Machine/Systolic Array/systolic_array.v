
`include "block.v"
module systolic_array (
    input wire clk,
    input wire rst,

    input wire [4:0][15:0] west_0,
    input wire [4:0][15:0] west_1,
    input wire [4:0][15:0] west_2,

    input wire [4:0][15:0] north_0,
    input wire [4:0][15:0] north_1,
    input wire [4:0][15:0] north_2,

    output wire [8:0][31:0] out,
    output reg done 
);
    wire [15:0] out_south[8:0], out_east[8:0];
    reg [3:0] counter;
    reg [15:0] west_in[2:0], north_in[2:0];


    // First row
    block b00 (clk, rst, west_in[0], north_in[0], out_south[0], out_east[0], out[0]);
    block b01 (clk, rst, out_east[0], north_in[1], out_south[1], out_east[1], out[1]);
    block b02 (clk, rst, out_east[1], north_in[2], out_south[2], out_east[2], out[2]);

    // Second row
    block b10 (clk, rst, west_in[1], out_south[0], out_south[3], out_east[3], out[3]);
    block b11 (clk, rst, out_east[3], out_south[1], out_south[4], out_east[4], out[4]);
    block b12 (clk, rst, out_east[4], out_south[2], out_south[5], out_east[5], out[5]);

    // Third row
    block b20 (clk, rst, west_in[2], out_south[3], out_south[6], out_east[6], out[6]);
    block b21 (clk, rst, out_east[6], out_south[4], out_south[7], out_east[7], out[7]);
    block b22 (clk, rst, out_east[7], out_south[5], out_south[8], out_east[8], out[8]);

    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            counter <= 0;
            done <= 0;
            west_in[0] <= 0; west_in[1] <= 0; west_in[2] <= 0;
            north_in[0] <= 0; north_in[1] <= 0; north_in[2] <= 0;
        end 
        else if (counter < 5) begin 

            west_in[0] <= west_0[counter];
            west_in[1] <= west_1[counter];
            west_in[2] <= west_2[counter];

            north_in[0] <= north_0[counter];
            north_in[1] <= north_1[counter];
            north_in[2] <= north_2[counter];

            counter <= counter + 1 ;
        end
        else if (counter == 5) begin
            counter <= counter + 1;
        end
        else begin
            done <= 1;
        end
    end

endmodule

