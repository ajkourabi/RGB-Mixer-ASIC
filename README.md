I am learning verilog. My goals is to explore the entire chip desing process, from writing the verilog code to doing the layout. Here are my projects so far:

# **Systolic Array for Matrix Multiplication**. 

A systolic array is a form of architecture in which nodes are tightly couples and networked in a way that allows for streamlined parallel computing. It is used in AI Chips like Google's TPU for matrix multiplication. 

Because these cells are tightly coordinated and pipelines flow rhytmically, the array is called systolic (referring to the way the heart beats)

I wanted to better understand parallel architectures, and decided to implement a systolic array -- from scratch, in verilog. It was a robust learning expereince in which I was able to better understand parallel computing. It also enabled me to better understand the details between how TPUs and GPUs are different. 

There is one file, `block.v`, which describes the basic behaviour of a single processing element, and the other code describes putting together the array. 

# Other projetcs

## Traffic State Machine 
Simple program to learn state machines in Verilog! 

## ALU and a Counter 
Other basic projects to understand Verilog and computer architecture better 