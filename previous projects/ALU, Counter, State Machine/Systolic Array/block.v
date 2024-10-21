

module block (
    input clk,
    input wire rst,
    input [15:0] west_input, //inputs from the west
    input [15:0] north_input, // inputs from the north
    
    output reg [15:0] out_south, out_east, 
    output reg [31:0] out  
);
    reg [31:0] product; // temp var to hold product


   always @(posedge clk or posedge rst) begin
    if (rst) begin   // reset
        out <= 32'b0;
        product <= 32'b0;
        out_south <= 16'b0;
        out_east <= 16'b0;
    end
    else begin 
        out <= out + (west_input * north_input);
        out_south <= north_input;
        out_east <=  west_input;
    end  
   end 
endmodule
