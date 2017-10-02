`timescale 1ns/1ps

module PatternDetector2_tb;

	//Inputs
	reg [7:0] data; 
	reg reset_sync; 
	reg clk;
	reg ack;

	//Output
	wire found_pattern;
	
	PatternDetection2 p1(
		.data(data),
		.reset_sync(reset_sync),
		.clk(clk),
		.ack(ack),
		.found_pattern(found_pattern)
	);
	
	reg [7:0] a_data [0:31];
	int i = 0;
	
	initial $readmemb("input_data2.txt", a_data, 0,31);
	
	initial begin
		ack = 0;
		clk = 1;
		reset_sync = 0;
		#2;
		reset_sync = 1;
		ack = 1;
		#1000;
		$finish;
	end
	
	always @ (negedge clk) begin
		if(ack == 1 && i < 32 && reset_sync == 1) begin
			if (found_pattern == 0) begin
				data = a_data[i];
			end
			if(found_pattern == 1) begin
				ack = 0;
				#2;
				ack = 1;
				#1;
			end
			else begin
				if(ack == 1) begin
					i++;
				end
			end
		end
	end
	
	always #1 clk = ~clk;
	
endmodule
