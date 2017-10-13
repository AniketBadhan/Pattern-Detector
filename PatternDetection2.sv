`timescale 1ns/1ps

module PatternDetection2(
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
	} current_state;
	
	
	always @ (posedge clk, negedge reset_sync) begin
		if(!reset_sync) begin
			current_state <= RESET;
			found_pattern <= 1'b0;
		end
		else begin
			found_pattern <= 1'b0;
			case(current_state)
				RESET		:	begin
								if(reset_sync) begin
									if(ack == 1'b1 && data == 8'b01100010) begin
										current_state <= B1;
									end
									else begin
										current_state <= RESET;
									end
								end
								else begin
									current_state <= RESET;
								end
							end
				B1		:	begin
								if(data == 8'b01101111) begin
									current_state <= O;
								end
								else begin
									current_state <= RESET;
								end
							end
				O		: 	begin
								if(data == 8'b01101101) begin
									current_state <= M;
								end
								else begin
									current_state <= RESET;
								end
							end
				M		:	begin
								if(data == 8'b01100010) begin
									current_state <= B2;
									found_pattern <= 1'b1;
								end
								else begin
									current_state <= RESET;
									found_pattern <= 1'b0;
								end
							end
				B2		:	begin
								found_pattern <= 1'b1;
								if(ack == 1) begin
									current_state <= B2;
								end
								else begin
									current_state <= WAIT_ACK;
								end
							end
				WAIT_ACK	:	begin
								if(ack == 1'b0) begin
									current_state <= WAIT_ACK;
									found_pattern <= 1'b1;
								end
								else begin
									current_state <= RESET;
									found_pattern <= 1'b0;
								end
							end
				default		:	begin
								current_state <= RESET;
								found_pattern <= 1'b0;
							end
			
			endcase
		end
	end
	
	
endmodule
