# RGB Color Mixer with Digital Control

## Project Overview
Design and implement a digitally controlled RGB color mixer using Verilog. The system will use digital rotary encoders for input, generate PWM signals to control RGB LED brightness, and provide a UART interface for monitoring and control.

## Key Components

### 1. Digital Rotary Encoder Interface
- Implement debouncing logic for clean signal reading
- Design a quadrature decoder to determine rotation direction and speed
- Create a counter that updates based on encoder rotation

### 2. PWM Driver
- Develop a configurable PWM module with adjustable frequency and duty cycle
- Implement at least 8-bit resolution for smooth color transitions
- Create three instances, one for each color channel (Red, Green, Blue)

### 3. UART Interface
- Design a UART transmitter and receiver with configurable baud rate
- Implement a simple protocol for sending color values and receiving commands
- Include status reporting functionality

### 4. RGB Mixer Control Logic
- Develop logic to map encoder positions to color intensities
- Implement color blending algorithms
- Create a state machine to manage overall system operation

### 5. Top-Level Integration
- Combine all modules into a cohesive system
- Manage clock domains and synchronization between modules
- Implement register interfaces for configuration and status monitoring

## Detailed Module Specifications

### Digital Rotary Encoder Interface
- Input: 2 signals (A and B) from each encoder (3 encoders total)
- Output: 8-bit value for each encoder, representing position
- Features:
  * Configurable debounce period
  * Quadrature decoding for direction sensing
  * Acceleration detection for faster value changes on rapid rotation

### PWM Driver
- Input: 8-bit color intensity value
- Output: PWM signal
- Features:
  * Configurable PWM frequency (e.g., 1 kHz to 20 kHz)
  * 8-bit resolution (256 levels) per channel
  * Optional: Gamma correction for perceptually linear brightness

### UART Interface
- Configurable baud rate (e.g., 9600, 115200)
- 8-bit data, 1 stop bit, no parity
- Transmit features:
  * Send current RGB values
  * Report encoder positions
  * Transmit status messages
- Receive features:
  * Set RGB values directly
  * Adjust PWM frequencies
  * Switch between manual (encoder) and UART control modes

### RGB Mixer Control Logic
- State machine for operation modes:
  * Manual mode (encoder control)
  * UART control mode
  * Demo mode (automatic color cycling)
- Color blending logic:
  * Linear mixing
  * Optional: HSV to RGB conversion for more intuitive control

## Implementation Steps
1. Develop and test individual modules (encoder interface, PWM driver, UART)
2. Implement the RGB mixer control logic
3. Integrate all modules in the top-level design
4. Develop a comprehensive testbench for system verification
5. Synthesize the design and test on an FPGA board
6. Optimize for potential ASIC implementation
