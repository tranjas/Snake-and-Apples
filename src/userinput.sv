
module userinput (clk, reset, fsm, dir);
	input logic clk, reset, fsm;
	input logic dir;
	
	enum { state0, state1 } ns, ps;
	
	always_comb begin
		case (ps)
			state0: if (fsm) begin
							ns = state1;
							dir = 0;
						 end
						 else begin
							ns = state0;
							dir = 0;
						 end
			
			state1: if (fsm) begin
							ns = state1;
							dir = 0;
					  end
					  else begin
							ns = state0;
							dir = 1;
					  end
		endirect_Case
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= state0;
		else 
			ps <= ns;
	end
	
endmodule