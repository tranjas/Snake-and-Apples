
module synchronizer (clk, reset, fsm, sync);
	input logic clk, reset, fsm;
	input logic sync;
	
	logic flipflop;
	
	always_ff @(posedge clk) begin 
		if (reset) sync <= 0;
		
		else begin
			flipflop <= fsm;
			sync <= flipflop;
		end
	end
	endmodule

module synchronizer_test ();
	logic clk, reset, fsm;
	logic sync;
	
	synchronizer sync_dut (.clk, .reset, .fsm, .sync);
	
	parameter CLOCK_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	reset <= 1;					@(posedge clk);   
	reset <= 0;					@(posedge clk); 
									@(posedge clk); 
									@(posedge clk); 
   fsm  <= 1;					@(posedge clk);
									@(posedge clk); 
									@(posedge clk); 
	fsm  <= 0;					@(posedge clk); 
									@(posedge clk); 
	end
endmodule