module traffic_light_controller (
    input wire clk,              // System clock
    input wire reset,            // Reset signal
    input wire [7:0] timer_adj,  // 8-bit input for timer adjustment
    
    output reg [2:0] main_lights,  // Red, Yellow, Green for Main Street
    output reg [2:0] side_lights   // Red, Yellow, Green for Side Street
);

    // Parameters for default timer values (in clock cycles)
    parameter MAIN_GREEN_TIME  = 8'd100;  // 100 clock cycles
    parameter YELLOW_TIME      = 8'd30;   // 30 clock cycles
    parameter SIDE_GREEN_TIME  = 8'd60;   // 60 clock cycles

    // State definition
    localparam [1:0]
        MAIN_GREEN_SIDE_RED  = 2'b00,
        MAIN_YELLOW_SIDE_RED = 2'b01,
        MAIN_RED_SIDE_GREEN  = 2'b10,
        MAIN_RED_SIDE_YELLOW = 2'b11;

    // State register
    reg [1:0] current_state, next_state;

    // Timer
    reg [7:0] timer;

    // State machine logic (to be implemented)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= MAIN_GREEN_SIDE_RED;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic (to be implemented)
    always @(*) begin
        // Set main_lights and side_lights based on current_state
        case(current_state)
            MAIN_GREEN_SIDE_RED : begin
                main_lights = 3'b001;
                side_lights = 3'b100;
            end
            MAIN_YELLOW_SIDE_RED : begin
                main_lights = 3'b010;
                side_lights = 3'b100;
            end 
            MAIN_RED_SIDE_GREEN : begin 
                main_lights = 3'b100;
                side_lights = 3'b001;
            end 
            MAIN_RED_SIDE_YELLOW : begin
                main_lights = 3'b100;
                side_lights = 3'b010;
            end
            default: begin
                main_lights = 3'b100;
                side_lights = 3'b100;
            end  

        endcase 
    end

    always @(*) begin
        case (current_state)
            MAIN_GREEN_SIDE_RED: begin 
                if (timer == 0)
                    next_state = MAIN_YELLOW_SIDE_RED;
                else
                    next_state = MAIN_GREEN_SIDE_RED;
            end
            MAIN_YELLOW_SIDE_RED: begin 
                if (timer == 0)
                    next_state = MAIN_RED_SIDE_GREEN;
                else
                    next_state = MAIN_YELLOW_SIDE_RED;
            end 
            MAIN_RED_SIDE_GREEN: begin 
                if (timer == 0)
                    next_state = MAIN_RED_SIDE_YELLOW;
                else
                    next_state = MAIN_RED_SIDE_GREEN;
            end 
            MAIN_RED_SIDE_YELLOW: begin 
                if (timer == 0)
                    next_state = MAIN_GREEN_SIDE_RED;
                else
                    next_state = MAIN_RED_SIDE_YELLOW;
            end
            default: next_state = MAIN_GREEN_SIDE_RED;
        endcase 
    end
    
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin 
            timer <= MAIN_GREEN_TIME;
        end 
        else begin 
            if (timer == 0) begin
                case (next_state)  
                    MAIN_GREEN_SIDE_RED:  timer <= MAIN_GREEN_TIME;
                    MAIN_YELLOW_SIDE_RED: timer <= YELLOW_TIME;
                    MAIN_RED_SIDE_GREEN:  timer <= SIDE_GREEN_TIME;
                    MAIN_RED_SIDE_YELLOW: timer <= YELLOW_TIME;
                    default:              timer <= MAIN_GREEN_TIME;
                endcase 
            end 
            else begin 
                timer <= timer - 1;
            end 
        end 
    end

endmodule

