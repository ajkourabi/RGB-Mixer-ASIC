
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
    reg [2:0] counter;
    reg [15:0] west_in[2:0], north_in[2:0];


    genvar i;
    generate
        for (i = 0; i < 3; i = i + 1) begin : gen_blocks
            block b0 (clk, rst, west_in[i], north_in[i], out_south[i*3], out_east[i*3], out[i*3]);
            block b1 (clk, rst, out_east[i*3], out_south[i*3], out_south[i*3+1], out_east[i*3+1], out[i*3+1]);
            block b2 (clk, rst, out_east[i*3+1], out_south[i*3+1], out_south[i*3+2], out_east[i*3+2], out[i*3+2]);
        end
    endgenerate

    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            counter <= 0;
            done <= 0;
            west_in[0] <= 0; west_in[1] <= 0; west_in[2] <= 0;
            north_in[0] <= 0; north_in[1] <= 0; north_in[2] <= 0;
        end 
        else if (counter < 5) begin 
            counter <= counter + 1 ;

            west_in[0] <= west_0[counter];
            west_in[1] <= west_1[counter];
            west_in[2] <= west_2[counter];
            north_in[0] <= north_0[counter];
            north_in[1] <= north_1[counter];
            north_in[2] <= north_2[counter];
            
            $display("Counter incremented: %0d", counter);
            
            
            $display("Block 00: west_in=%0d, north_in=%0d, out=%0d, out_south=%0d, out_east=%0d", 
                     west_in[0], north_in[0], out[0], out_south[0], out_east[0]);
            $display("Block 10: west_in=%0d, north_in=%0d, out=%0d, out_south=%0d, out_east=%0d", 
                     west_in[1], out_south[0], out[3], out_south[3], out_east[3]);
            $display("Block 22: west_in=%0d, north_in=%0d, out=%0d, out_south=%0d, out_east=%0d", 
                     out_east[7], out_south[7], out[8], out_south[8], out_east[8]);
        end
        else if (counter == 5) begin
            counter <= counter + 1;
        end
        else begin
            done <= 1;
        end
    end

endmodule

