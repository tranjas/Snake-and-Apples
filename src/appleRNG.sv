// apple grid module (inputs [15][15]apple) where acorners but one are false, at apple (the one true light) checks for approaching head
// if there is an approaching head then it inputs a signal to sizeDet that shows that the snake has eaten an apple, and grows the snake
module appleRNG (clk, reset, apple, lights, curr_count, curr_next_count, eaten);
	input logic clk, reset;
	input reg [15:0][15:0] lights;
	input reg [5:0] curr_count [15:0][15:0];
	input reg [7:0] curr_next_count [15:0][15:0];
	input reg [15:0][15:0] apple;
	input logic eaten;
	
	reg [3:0] xrand, yrand, xheld, yheld;
	
	LFSR xrng (.clk, .reset, .R_i(4'b0011), .R(xrand));
	LFSR yrng (.clk, .reset, .R_i(4'b1010), .R(yrand));

	always_ff @ (posedge clk) begin
		if (reset | eaten) begin
			yheld <= yrand;
			xheld	<= xrand;

		end
		else begin
			yheld <= yheld;
			xheld <= xheld;
		end
	end
	
	enum { newApp, staticG } ns, ps;
	always_comb begin
		case (ps) 
			staticG: if (reset | eaten)
						ns = newApp;
						else begin
						ns = staticG;
						apple = apple;
						end
			newApp : begin
						apple = '0;
						apple[yheld][xheld] = '1;
						ns = staticG;
						end
		endirect_Case
	end
	
	always_ff @ (posedge clk) begin
		if (reset)
			ps <= newApp;
		else 
			ps <= ns;
	end

	assign eaten = (lights[yheld][xheld] & curr_count[yheld][xheld] == 6'b000001 & curr_next_count[yheld][xheld] == 8'b11111111);
endmodule

module appleRNG_test ();
	logic clk, reset;
	reg [15:0][15:0] lights;
	reg [5:0] curr_count [15:0][15:0];
	reg [7:0] curr_next_count [15:0][15:0];
	reg [15:0][15:0] apple;
	logic eaten;

	appleRNG rng_test (.clk, .reset, .lights, .curr_count, .curr_next_count, .apple, .eaten);
	
	parameter CLOCK_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	reset <= 1;																							@(posedge clk);  
	reset <= 0;																							@(posedge clk);
	apple[10][10]<= '1;																				@(posedge clk);
																											@(posedge clk);
	lights[10][10]<= '1; curr_count[10][10]<= 6'b000001; curr_next_count[10][10]<= 8'b11111111; @(posedge clk);
																											@(posedge clk);
																											@(posedge clk);
																											@(posedge clk);
	reset <= 1;																							@(posedge clk);	
	reset <= 0;																							@(posedge clk);
	lights[14][9] <= '1; curr_count[14][9] <= 6'b000001; curr_next_count[14][9] <= 8'b11111111; @(posedge clk);
																											@(posedge clk);
	end
endmodule
