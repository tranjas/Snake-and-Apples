## Snakes and Apples Game Implementation in SystemVerilog

# Overview
This document provides an overview of how to implement a basic Snakes and Apples game in SystemVerilog. The game will be implemented on an FPGA board, such as the DE1-SoC board, using a VGA display for graphics output and input devices (buttons, switches, etc.) for user interaction.

# Game Logic
The Snakes and Apples game involves the following basic logic:

Snake Movement: The snake moves across the game board in different directions - up, down, left, and right. It consists of a sequence of segments that grow as it eats apples.

Apple Generation: Apples randomly appear on the game board at specific positions. The apple positions should be generated using a random number generator.

User Input: The player can control the direction of the snake's movement using input devices like buttons or switches on the FPGA board.

Collision Detection: The game should detect collisions between the snake and apples, as well as collisions with the game board boundaries and the snake's own body.

Scoring: The player's score increases each time the snake eats an apple.

# SystemVerilog Modules
VGA Display Module: This module controls the VGA output to display the game graphics on the connected monitor or display.

Apple RNG (Random Number Generator) Module: The Apple RNG module generates random coordinates for placing apples on the game board.

Snake Control Module: This module handles the logic for snake movement, growth, and collision detection. It processes user input to change the snake's direction.

Game Logic Module: The Game Logic module coordinates all the game elements, including the VGA display, apple generation, and snake control.

Top-Level Module: The Top-Level module integrates all the above modules and connects them to the FPGA board's input/output ports.

# Hardware Implementation
Connect a VGA monitor or display to the FPGA board for visual output.

Use input devices (buttons, switches) on the FPGA board to control the snake's movement direction.

Instantiate the VGA Display, Apple RNG, Snake Control, and Game Logic modules in the Top-Level module.

Connect the modules and their respective input/output ports in the Top-Level module.

# Development Flow
Design and implement each SystemVerilog module according to the specified logic.

Simulate each module using a SystemVerilog simulator (e.g., ModelSim) to verify their correctness.

Create a testbench for the Top-Level module to verify the interaction between the modules and their functionality as a complete game.

Synthesize the design to obtain a bitstream suitable for the target FPGA device (DE1-SoC board).

Upload the bitstream to the FPGA board and test the game on a VGA monitor.

# Additional Features
To enhance the game, you can consider adding the following features:

Level progression: Increase the difficulty of the game as the player progresses.
Sound effects: Add sound effects for various game events (e.g., eating apples, collisions).
High-score tracking: Store and display the highest scores achieved by different players.
