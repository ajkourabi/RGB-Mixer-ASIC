I am learning verilog. My goals is to explore the entire chip desing process, from writing the verilog code to doing the layout. Here are my projects so far:

# **Systolic Array for Matrix Multiplication**. 

A systolic array is a form of architecture in which nodes are tightly couples and networked in a way that allows for streamlined parallel computing. It is used in AI Chips like Google's TPU for matrix multiplication. 

Because these cells are tightly coordinated and pipelines flow rhytmically, the array is called systolic (referring to the way the heart beats)

My code works for any arbitrary 3x3 matric multiplication. The result is outputted row by row for the user. It is done completely in verilog, from scratch. The test bench, which verifies and tests these results, is also in verilog. 

You can see all the code for the poject [here](https://github.com/ajkourabi/learning_verilog/tree/main/systolic_array). There is one, `block.v`, which describes the basic behaviour of a single processing element, and the other code describes putting together the array. 

# Other projetcs

## Traffic State Machine 
Simple program to learn state machines in Verilog! 

## ALU and a Counter 
Other basic projects to understand Verilog and computer architecture better 