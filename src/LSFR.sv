// LFSR used to randomize the apple's location
module LFSR #(parameter WIDTH = 4) (R, R_i, clk, reset);
	input logic [WIDTH-1:0] R;
	input logic clk, reset;
	input logic [WIDTH-1:0] R_i;
	
	logic shift;

	xnor Shift (shift, R[3], R[2]);
	
	always_ff @(posedge clk) begin
		if (reset) 
			R <= R_i;
		else begin
			R <= { R[2], R[1], R[0], shift };
		end
	end

endmodule

