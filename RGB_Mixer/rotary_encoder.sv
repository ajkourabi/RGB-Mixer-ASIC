module rotary_encoder(

    input clk, rst,
    input A, B,
    output reg [7:0] count

);
    reg Aprev, Bprev;

    always @( posedge clk or posedge rst ) begin : encoder
    
    if (rst) begin 
        Aprev <= 1'b0;
        Bprev <= 1'b0;
        count <= 8'b0;
    end else begin 
        Aprev <= A;
        Bprev <= B;
        if (A && !Aprev) begin
            if (!B) begin 
                count <= count + 1; //clockwise
            end 
            else 
                count <= count -1; //anti clockwise
        end 
        if (B && !Bprev) begin 
            if (A) begin 
                count <= count + 1; //clockwise
            end
            else 
                count  <= count - 1; //anti clockwise
        end
    end 
    end    
endmodule