module alu (
    input [7:0] a,
    input [7:0] b,
    input [2:0] op,
    output reg [7:0] result,
    output zero,
    output overflow
);

//Operations code

parameter ADD = 3'b000; 
parameter SUB = 3'b001; 
parameter AND = 3'b010; 
parameter OR  = 3'b011;  
parameter XOR = 3'b100;  
parameter SHL = 3'b101;  
parameter SHR = 3'b110;  

reg [8:0] temp;

always @(*) begin
    temp = 9'b0;
    case(op)
        ADD : begin
        temp[7:0] = a + b;
        result = temp; 
        end 

        SUB : begin
        temp[7:0] = a - b; 
        result = temp; 
        end 
        AND : result = a & b;
        OR : result = a | b; 
        XOR : result = a ^ b;
        SHL : result = a << 1; 
        SHR: result = a >> 1; 
    endcase 
end 

// Zero flag
assign zero = (result == 8'b0);

// Overflow flag (only for addition and subtraction)
assign overflow = (op == ADD && temp[8] != temp[7]) ||
                  (op == SUB && temp[8] != temp[7]);

endmodule
`timescale 1ns / 1ps

