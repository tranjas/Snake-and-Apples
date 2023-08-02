module Snake(clk, KEY, SW, LEDR, GPIO_1, greenLED, redoubleLiftED);
	input logic clk;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	input logic [9:0] LEDR;
	input logic [35:0] GPIO_1;
	
	input logic [15:0][15:0] greenLED, redoubleLiftED;


	logic [5:0] curr_counts [15:0][15:0];
	logic [7:0] curr_counts2[15:0][15:0];
	logic [15:0][15:0] lights, apple; 
	logic [3:0] synced;
	logic Right, Down, Up, Left;
	logic [1:0] snake_directionec;
	logic [5:0] size;
	logic apple_eatenaten;
	
	genvar s;
	generate
		for (s=0; s < 4; s++) begin : eachSync
			synchronizer syncs (.clk, .reset(SW[9]), .fsm(~KEY[s]), .sync(synced[s]));
		end
	endgenerate
	
	userinput right (.clk, .reset(SW[9]), .fsm(synced[0]), .dir(Right));
	userinput down  (.clk, .reset(SW[9]), .fsm(synced[1]), .dir(Down));
	userinput up    (.clk, .reset(SW[9]), .fsm(synced[2]), .dir(Up));
	userinput left  (.clk, .reset(SW[9]), .fsm(synced[3]), .dir(Left));	
	
	snake_direction Direc (.clk, .reset(SW[9]), .l(Left), .r(Right), .u(Up), .d(Down), .s_dir(snake_directionec));
	
	appleRNG applePlace (.clk, .reset(SW[9]), .lights, .curr_count(curr_counts), .curr_next_count(curr_counts2), .apple(apple), .eaten(apple_eatenaten));
	snake_Size Ssize (.clk, .reset(SW[9]), .apple_eaten(apple_eatenaten), .size);
	
	genvar x,y;
	generate
		for (x = 0; x < 16; x++) begin : eachRow
			for(y = 0; y < 16; y++) begin : eachCol
				if (x == 0 & y == 0) 
					snakeLight light (.clk, .reset(SW[9]), .doubleLift(lights[y + 1][x]), .right_L(1), .corners(lights[y][x + 1]), .upLeft(1), .direct_C(curr_counts[y + 1][x]), .right_Corn(6'b111111), .left_Corn(curr_counts[y][x + 1]), .up_Corn(6'b111111), .direct_C_next(curr_counts2[y + 1][x]), .right_Corn_next(8'b11111111), .left_Corn_next(curr_counts2[y][x + 1]), .up_Corn_next(8'b11111111), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else if (x == 0 & y == 15)
					snakeLight light (.clk, .reset(SW[9]), .doubleLift(1), .right_L(1), .corners(lights[y][x + 1]), .upLeft(lights[y - 1][x]), .direct_C(6'b111111), .right_Corn(6'b111111), .left_Corn(curr_counts[y][x + 1]), .up_Corn(curr_counts[y - 1][x]), .direct_C_next(8'b11111111), .right_Corn_next(8'b11111111), .left_Corn_next(curr_counts2[y][x + 1]), .up_Corn_next(curr_counts2[y - 1][x]), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
				
				else if (x == 15 & y == 0)
					snakeLight light (.clk, .reset(SW[9]), .doubleLift(lights[y + 1][x]), .right_L(lights[y][x - 1]), .corners(1), .upLeft(1), .direct_C(curr_counts[y + 1][x]), .right_Corn(curr_counts[y][x - 1]), .left_Corn(6'b111111), .up_Corn(6'b111111), .direct_C_next(curr_counts2[y + 1][x]), .right_Corn_next(curr_counts2[y][x - 1]), .left_Corn_next(8'b11111111), .up_Corn_next(8'b11111111), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else if (x == 15 & y == 15)
					snakeLight light (.clk, .reset(SW[9]), .doubleLift(1), .right_L(lights[y][x - 1]), .corners(1), .upLeft(lights[y - 1][x]), .direct_C(6'b111111), .right_Corn(curr_counts[y][x - 1]), .left_Corn(6'b111111), .up_Corn(curr_counts[y - 1][x]), .direct_C_next(8'b11111111), .right_Corn_next(curr_counts2[y][x - 1]), .left_Corn_next(8'b11111111), .up_Corn_next(curr_counts2[y - 1][x]), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else if (x == 0)
					snakeLight light (.clk, .reset(SW[9]), .doubleLift(lights[y + 1][x]), .right_L(1), .corners(lights[y][x + 1]), .upLeft(lights[y - 1][x]), .direct_C(curr_counts[y + 1][x]), .right_Corn(6'b111111), .left_Corn(curr_counts[y][x + 1]), .up_Corn(curr_counts[y - 1][x]), .direct_C_next(curr_counts2[y + 1][x]), .right_Corn_next(8'b11111111), .left_Corn_next(curr_counts2[y][x + 1]), .up_Corn_next(curr_counts2[y - 1][x]), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else if (x == 15)
					snakeLight light (.clk, .reset(SW[9]), .doubleLift(lights[y + 1][x]), .right_L(lights[y][x - 1]), .corners(1), .upLeft(lights[y - 1][x]), .direct_C(curr_counts[y + 1][x]), .right_Corn(curr_counts[y][x - 1]), .left_Corn(6'b111111), .up_Corn(curr_counts[y - 1][x]), .direct_C_next(curr_counts2[y + 1][x]), .right_Corn_next(curr_counts2[y][x - 1]), .left_Corn_next(8'b11111111), .up_Corn_next(curr_counts2[y - 1][x]), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else if (y == 0)
					snakeLight light (.clk, .reset(SW[9]), .doubleLift(lights[y + 1][x]), .right_L(lights[y][x - 1]), .corners(lights[y][x + 1]), .upLeft(1), .direct_C(curr_counts[y + 1][x]), .right_Corn(curr_counts[y][x - 1]), .left_Corn(curr_counts[y][x + 1]), .up_Corn(6'b111111), .direct_C_next(curr_counts2[y + 1][x]), .right_Corn_next(curr_counts2[y][x - 1]), .left_Corn_next(curr_counts2[y][x + 1]), .up_Corn_next(8'b11111111), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else if (y == 15)
					snakeLight light (.clk, .reset(SW[9]), .doubleLift(1), .right_L(lights[y][x - 1]), .corners(lights[y][x + 1]), .upLeft(lights[y - 1][x]), .direct_C(6'b111111), .right_Corn(curr_counts[y][x - 1]), .left_Corn(curr_counts[x + 1][y]), .up_Corn(curr_counts[y - 1][x]), .direct_C_next(8'b11111111), .right_Corn_next(curr_counts2[y][x - 1]), .left_Corn_next(curr_counts2[x + 1][y]), .up_Corn_next(curr_counts2[y - 1][x]), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else if (x == 9 & y == 7)
					snakeBase1 light (.clk, .reset(SW[9]), .doubleLift(lights[y + 1][x]), .right_L(lights[y][x - 1]), .corners(lights[y][x + 1]), .upLeft(lights[y - 1][x]), .direct_C(curr_counts[y + 1][x]), .right_Corn(curr_counts[y][x - 1]), .left_Corn(curr_counts[y][x + 1]), .up_Corn(curr_counts[y - 1][x]), .direct_C_next(curr_counts2[y + 1][x]), .right_Corn_next(curr_counts2[y][x - 1]), .left_Corn_next(curr_counts2[y][x + 1]), .up_Corn_next(curr_counts2[y - 1][x]), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else if (x == 9 & y == 8)
					snakeBase2 light (.clk, .reset(SW[9]), .doubleLift(lights[y + 1][x]), .right_L(lights[y][x - 1]), .corners(lights[y][x + 1]), .upLeft(lights[y - 1][x]), .direct_C(curr_counts[y + 1][x]), .right_Corn(curr_counts[y][x - 1]), .left_Corn(curr_counts[y][x + 1]), .up_Corn(curr_counts[y - 1][x]), .direct_C_next(curr_counts2[y + 1][x]), .right_Corn_next(curr_counts2[y][x - 1]), .left_Corn_next(curr_counts2[y][x + 1]), .up_Corn_next(curr_counts2[y - 1][x]), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else if (x == 9 & y == 9)
					snakeBase3 light (.clk, .reset(SW[9]), .doubleLift(lights[y + 1][x]), .right_L(lights[y][x - 1]), .corners(lights[y][x + 1]), .upLeft(lights[y - 1][x]), .direct_C(curr_counts[y + 1][x]), .right_Corn(curr_counts[y][x - 1]), .left_Corn(curr_counts[y][x + 1]), .up_Corn(curr_counts[y - 1][x]), .direct_C_next(curr_counts2[y + 1][x]), .right_Corn_next(curr_counts2[y][x - 1]), .left_Corn_next(curr_counts2[y][x + 1]), .up_Corn_next(curr_counts2[y - 1][x]), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
					
				else
					snakeLight light (.clk, .reset(SW[9]), .doubleLift(lights[y + 1][x]), .right_L(lights[y][x - 1]), .corners(lights[y][x + 1]), .upLeft(lights[y - 1][x]), .direct_C(curr_counts[y + 1][x]), .right_Corn(curr_counts[y][x - 1]), .left_Corn(curr_counts[y][x + 1]), .up_Corn(curr_counts[y - 1][x]), .direct_C_next(curr_counts2[y + 1][x]), .right_Corn_next(curr_counts2[y][x - 1]), .left_Corn_next(curr_counts2[y][x + 1]), .up_Corn_next(curr_counts2[y - 1][x]), .next_dir(snake_directionec), .size, .curr_count(curr_counts[y][x]), .curr_next_count(curr_counts2[y][x]), .green_on(lights[y][x]));
			end
		end
	endgenerate 
	
	//final module used to check whether game is sticorners ongoing, inputs final green and red arrays for display
	gameState status (.clk, .reset(SW[9]), .lights, .applePre(apple), .greenLED, .redoubleLiftED);
	
endmodule

module Snake_test ();
	logic clk;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	logic [9:0] LEDR;
	logic [35:0] GPIO_1;
	reg [15:0][15:0] greenLED, redoubleLiftED;
	
	Snake S_dut (.clk, .KEY, .SW, .LEDR, .GPIO_1, .greenLED, .redoubleLiftED);
	
	parameter CLOCK_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	SW[9] <= 1;														@(posedge clk);  
   SW[9] <= 0;														@(posedge clk);
	KEY[0] <= 0;													@(posedge clk);
	KEY[0] <= 1;													@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
   KEY[1] <= 0;													@(posedge clk);
	KEY[1] <= 1;													@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
   KEY[2] <= 0;													@(posedge clk);
	KEY[2] <= 1;													@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
	KEY[3] <= 0;													@(posedge clk);
	KEY[3] <= 1;													@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);

	end
endmodule



