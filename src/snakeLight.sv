
module snakeLight (clk, reset, doubleLift, right_L, corners, upLeft, direct_C, direct_C_next, right_Corn, right_Corn_next, left_Corn, left_Corn_next, up_Corn, up_Corn_next, next_dir, size, curr_count, curr_next_count, green_on);
	input  logic clk, reset, doubleLift, right_L, corners, upLeft;
	input  reg [1:0] next_dir;
	input reg [5:0] size, direct_C, right_Corn, left_Corn, up_Corn;
	input reg [7:0] direct_C_next, right_Corn_next, left_Corn_next, up_Corn_next;
	
	input reg [5:0] curr_count; 
	input reg [7:0] curr_next_count;
	input logic green_on;
	
	reg [5:0] tempc;
	reg [7:0] tempc2;
	enum { state0, state1 } ns, ps;
	
	// note: 00 = up, 01 = left; 10 = right; 11 = down
	always_comb begin
		case (ps) 
			state0   : if (doubleLift & direct_C == 6'b000001 & direct_C_next == 8'b11111111 & next_dir == 2'b00 | right_L & right_Corn == 6'b000001 & right_Corn_next == 8'b11111111 & next_dir == 2'b01 |
							corners & left_Corn == 6'b000001 & left_Corn_next == 8'b11111111 & next_dir == 2'b10 | upLeft & up_Corn == 6'b000001 & up_Corn_next == 8'b11111111 & next_dir == 2'b11 ) begin
					      ns 	  = state1;
							tempc   = 6'b000001;
							tempc2  = 8'b00000000;
					  end
					  
					  else begin
							ns		  = state0;
							tempc   = 6'b000000;
							tempc2  = 8'b00000000;
					  end
	
			state1: if (curr_count <= size & curr_next_count < 8'b11111111) begin
							ns		  = state1;
							tempc   = curr_count;
							tempc2  = curr_next_count + 8'b00000001;
					   end
						
						else if (curr_count < size & curr_next_count == 8'b11111111) begin
							ns		  = state1;
							tempc   = curr_count + 6'b000001;
							tempc2  = 8'b00000000;
						end
						
						else if (curr_count == size & curr_next_count == 8'b11111111 & (doubleLift & direct_C == 6'b000001 & direct_C_next == 8'b11111111 & next_dir == 2'b00 | right_L & right_Corn == 6'b000001 & right_Corn_next == 8'b11111111 & next_dir == 2'b01 |
																						  corners & left_Corn == 6'b000001 & left_Corn_next == 8'b11111111 & next_dir == 2'b10 | upLeft & up_Corn == 6'b000001 & up_Corn_next == 8'b11111111 & next_dir == 2'b11 ) ) begin
							 ns	  = state1;
							 tempc  = 6'b000001;
							 tempc2 = 8'b00000000;
						end
						
						else begin
							ns 	  = state0;
							tempc   = 6'b000000;
							tempc2  = 8'b00000000;
						end
		endirect_Case
	end
	
	always_ff @ (posedge clk) begin
		if (reset) begin
			ps 	<= state0;
			curr_count <= 6'b000000;
			curr_next_count<= 8'b00000000;
		end
		
		else begin
			ps		<= ns;
			curr_count <= tempc;
			curr_next_count<= tempc2;
		end
	end
	
	assign green_on = (ps == state1);
	
endmodule
