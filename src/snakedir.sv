// takes synced inputs from synchronizer and forms a fsm for which direction the state1 input is,


module snake_direction (clk, reset, l, r, u, d, s_dir); 
	input logic clk, reset, l, r, u, d;
	input reg [1:0] s_dir;
	
	enum { up, left, right, down } ns, ps;
	// note: 00 = up, 01 = left; 10 = right; 11 = down
	
	always_comb begin
		case (ps)
			up: if (l & ~r) 		ns = left;
				 else if (r & ~l) ns = right;
				 else ns = up;
			
			left: if (u & ~d) 	ns = up;
				 else if (d & ~u) ns = down;
				 else ns = left;
			
			right: if (u & ~d) 	ns = up;
				 else if (d & ~u) ns = down;
				 else ns = right;
				
			down: if (l & ~r) 	ns = left;
				 else if (r & ~l) ns = right;
				 else ns = down;

		endirect_Case
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= up;
		else 
			ps <= ns;
	end
	
	assign s_dir = ps;
	
endmodule

module snake_direction_test ();
	logic clk, reset, l, r, u, d;
	reg [1:0] s_dir;
	
	snake_direction SDdut (.clk, .reset, .l, .r, .u, .d, .s_dir);
	
	parameter CLOCK_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
																	@(posedge clk);   
		reset <= 1;          				 				@(posedge clk);
		reset <= 0; l <= 0; r <= 0; u <= 0; d <= 0;  @(posedge clk);
						l <= 1; 									@(posedge clk);
								  r <= 1;						@(posedge clk);
						l <= 0; r <= 0;		 				@(posedge clk);
											 u <= 1;				@(posedge clk);
														d <= 1;	@(posedge clk);
								  r <= 1; u <= 0;	d <= 0;	@(posedge clk);
								  r <= 0;						@(posedge clk);
						l <= 1;			 						@(posedge clk);
																	@(posedge clk);
						l <= 0;								   @(posedge clk);
																	@(posedge clk);
																	@(posedge clk);

	end
endmodule