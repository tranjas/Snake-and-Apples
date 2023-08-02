// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    input logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 input logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    input logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
    assign HEX0 = '1;
    assign HEX1 = '1;
    assign HEX2 = '1;
    assign HEX3 = '1;
    assign HEX4 = '1;
    assign HEX5 = '1;
	 
	
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal	 
	 

	 logic [15:0][15:0]RedPixels, redoubleLiftED; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels, greenLED; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
	 
	 assign RST = SW[0];
	 

	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .Enablecurr_count(1'b1), .RedPixels(redoubleLiftED), .GrnPixels(greenLED), .GPIO_1);
	 
	 

	 
	 Snake snake_game (.clk(SYSTEM_CLOCK), .KEY, .SW, .LEDR, .GPIO_1, .greenLED, .redoubleLiftED);
	 
endmodule