# Goal 

My goal was to design a chip from scratch. To achieve that, I had to learn about the process from the start, beginning with learning Verilog. After some sample projects, I designed an **RGB Mixer** in Verilog. Using OpenLane, I turned that into a chip. 

I also completed several other smaller projects to get to creating this larger more involved project. 

## Final Product 

The final product is an **RGB LED Mixer ASIC**. I described the base functionality in Verilog, and using OpenLane's RTL to ASIC workflow, took the design through the chip desing process. The mixer is made of three parts: 

1. PWM Driver, built from scratch 
2. Digital Rotary Encoder, built from scratch 
3. LED-Driver that combines these modules to power 3 LEDs. 

> The flow of taking the Verilog code into an ASIC is completely outlined and annotated in a Jupyer Notebook I made. I describe and go through each step. You can find it [here](ooo).

The final chip looks like this! 

<p align="center">
  <img src="RGB_Mixer/image.png" alt="GDS File">
</p>


Overall, I learned an incredible amount about chip design. 

## Past Projects 
 
### **Systolic Array for Matrix Multiplication**. 

A systolic array is a form of architecture in which nodes are tightly couples and networked in a way that allows for streamlined parallel computing. It is used in AI Chips like Google's TPU for matrix multiplication. 

Because these cells are tightly coordinated and pipelines flow rhytmically, the array is called systolic (referring to the way the heart beats)

I wanted to better understand parallel architectures, and decided to implement a systolic array -- from scratch, in verilog. It was a robust learning expereince in which I was able to better understand parallel computing. It also enabled me to better understand the details between how TPUs and GPUs are different. 

There is one file, `block.v`, which describes the basic behaviour of a single processing element, and the other code describes putting together the array. 

### Traffic State Machine 
Simple program to learn state machines. 

### ALU and a Counter 
Other basic projects to understand Verilog and computer architecture better 