module rotary_encoder(

    input clk, rst,
    input A, B,
    output reg [7:0] count

);
    reg Aprev, Bprev;

    always_ff @( posedge clk or posedge rst ) begin : encoder
    
    if (rst) begin 
        Aprev <= 1'b0;
        Bprev <= 1'b0;
        count <= 0;
    end else begin 
        Aprev <= A;
        Bprev <= B;
        if (A && !Aprev) begin 
            count <= count + 1;
        end 
        if (B && !Bprev) begin 

            count  <= count - 1;
        end
    end 
    end    
endmodule