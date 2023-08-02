
// module used to increment size whenever an apple is eaten
module snake_Size (clk, reset, apple_eaten, size);
	input logic clk, reset, apple_eaten;
	input reg [5:0] size;
	
	always_ff @ (posedge clk) begin
		if (reset)
			size <= 6'b000011;
		else if (apple_eaten)
			size <= size + 6'b000001;
		else 
			size <= size;
	end
endmodule

module snake_Size_test ();
	logic clk, reset, apple_eaten;
	reg [5:0] size;
	
	snake_Size SD_dut (.clk, .reset, .apple_eaten, .size);
	
	parameter CLOCK_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	reset <= 1;		@(posedge clk);  
	reset <= 0;		@(posedge clk);  
	apple_eaten<= 1;    @(posedge clk);  
	apple_eaten<= 0;    @(posedge clk);
						@(posedge clk);  
						@(posedge clk);  
	apple_eaten<= 1;		@(posedge clk);  
						@(posedge clk);  

endmodule
