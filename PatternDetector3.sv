`timescale 1ns/1ps

module PatternDetector3(
	input [7:0] data, 
	input reset_sync, 
	input clk, 
	input ack, 
	output reg found_pattern
);

	enum reg [2:0]{
		RESET,
		B1,
		O,
		M,
		B2,
		WAIT_ACK
	} current_state, next_state;
	
	always @ (posedge clk, negedge reset_sync) begin
		if(!reset_sync) begin
			current_state <= RESET;
		end
		else begin
			current_state <= next_state;
		end
	end	
	
	always_comb begin
		case (current_state)
			RESET		:	begin
								if(ack == 1'b1 && data == 8'b01100010) begin
									next_state = B1;
								end
								else begin
									next_state = RESET;
								end
							end
			B1			:	begin
								if(data == 8'b01101111) begin
									next_state = O;
								end
								else begin
									next_state = RESET;
								end
							end
			O			:	begin
							if(data == 8'b01101101) begin
								next_state = M;
							end
							else begin
								next_state = RESET;
							end
						end
			M			:	begin
								if(data == 8'b01100010) begin
									next_state = B2;
								end
								else begin
									next_state = RESET;
								end
							end
			B2			:	begin
								if(ack == 0) begin
									next_state = WAIT_ACK;
								end
								else begin
									next_state = B2;
								end
							end
			WAIT_ACK:	begin
								if(ack == 0) begin
									next_state = WAIT_ACK;
								end
								else begin
									next_state = RESET;
								end
							end
			default	:	begin
								next_state = RESET;
							end						
		endcase
	end
	
	always @ (posedge clk, negedge reset_sync) begin
		if(!reset_sync) begin
			found_pattern <= 1'b0;
		end
		else begin
			case(next_state)
				RESET		:	begin
									found_pattern <= 1'b0;
								end
				B1			:	begin
									found_pattern <= 1'b0;
								end
				O			:	begin
									found_pattern <= 1'b0;
								end
				M			:	begin
									found_pattern <= 1'b0;
								end
				B2			:	begin
									found_pattern <= 1'b1;
								end
				WAIT_ACK	:	begin
									found_pattern <= 1'b1;
								end
				default	:	begin
									found_pattern <= 1'b0;
								end
			endcase
		end
	end
	
endmodule
