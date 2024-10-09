module pwm_driver(
    input wire clk,
    input wire rst,
    input wire [7:0] duty_cycle,
    output reg pwm_out
);
    reg [7:0] cycle;
    reg [7:0] counter;
    
    // Calculate cycle value
    always @(duty_cycle) begin
        cycle = duty_cycle / 2.55; // Approximation of duty_cycle / 2.55
    end

    always @(posedge clk or posedge rst) begin 
        if (rst) begin 
            pwm_out <= 1'b0;
            counter <= 8'b0;
        end 
        else begin
            if (counter < 8'd100) 
                counter <= counter + 8'd1; 
            else 
                counter <= 8'd0; 

            pwm_out <= (counter < cycle) ? 1'b1 : 1'b0;
        end 
    end 

endmodule