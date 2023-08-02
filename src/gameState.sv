
module gameState (clk, reset, lights, applePre, greenLED, redoubleLiftED);
	input logic clk, reset;
	input reg [15:0][15:0] lights, applePre;
	input reg[15:0][15:0] greenLED, redoubleLiftED;
	
	enum { state0, state1 } ns, ps;
	
	always_comb begin
		case (ps)
			state0: if (lights == '0) 
					ns = state1;
					else
					ns = state0;
					
			  state1: ns = state1;
		endirect_Case
	end
	
	always_ff @ (posedge clk) begin
		if (reset)
			ps <= state0;
		else 
			ps <= ns;
	end
	
	always_comb begin 
		if (ps == state1) 
			begin
			redoubleLiftED[00] = 16'b0000000000000000;
			redoubleLiftED[01] = 16'b0000000000000000;
			redoubleLiftED[02] = 16'b0111011101010110;
			redoubleLiftED[03] = 16'b0100010101110100;
			redoubleLiftED[04] = 16'b0101011101110110;
			redoubleLiftED[05] = 16'b0101010101010100;
			redoubleLiftED[06] = 16'b0111010101010110;
			redoubleLiftED[07] = 16'b0000000000000000;
			redoubleLiftED[08] = 16'b0111010101101110;
			redoubleLiftED[09] = 16'b0101010101001010;
			redoubleLiftED[10] = 16'b0101010101101110;
			redoubleLiftED[11] = 16'b0101001001001100;
			redoubleLiftED[12] = 16'b0111001001101010;
			redoubleLiftED[13] = 16'b0000000000000000;
			redoubleLiftED[14] = 16'b0000000000000000;
			redoubleLiftED[15] = 16'b0000000000000000;
			
			greenLED[00] = 16'b0000000000000000;
			greenLED[01] = 16'b0000000000000000;
			greenLED[02] = 16'b0111011101010110;
			greenLED[03] = 16'b0100010101110100;
			greenLED[04] = 16'b0101011101110110;
			greenLED[05] = 16'b0101010101010100;
			greenLED[06] = 16'b0111010101010110;
			greenLED[07] = 16'b0000000000000000;
			greenLED[08] = 16'b0111010101101110;
			greenLED[09] = 16'b0101010101001010;
			greenLED[10] = 16'b0101010101101110;
			greenLED[11] = 16'b0101001001001100;
			greenLED[12] = 16'b0111001001101010;
			greenLED[13] = 16'b0000000000000000;
			greenLED[14] = 16'b0000000000000000;
			greenLED[15] = 16'b0000000000000000;
			end
		else begin
			redoubleLiftED = applePre;
			greenLED = lights;
		end
	end
	
endmodule


