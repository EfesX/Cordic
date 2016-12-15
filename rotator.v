module rotator(
	input	[13:0] X_in,
	input [13:0] Y_in,
	input [15:0] Z_in,
	input [ 1:0] quart_in,
	
	input clk,
	//input reset,
	
	output reg [13:0] X_out,
	output reg [13:0] Y_out,
	output reg [15:0] Z_out,
	output reg [ 1:0] quart_out
);

	reg sigma = 0;
	reg [15:0] Z;

	parameter [3:0]  iteration = 0;
	parameter [15:0] tanangle = 0;

	//always@(posedge clk) begin
	/*	if (Z_in[15]) begin
			  Z <= ~Z_in;
			  Z <= Z + 1;
			  Z[15] <= 1;
		end
		
		else Z[15] <= 0;
	end
*/
	always @(posedge clk) begin
		
		quart_out <= quart_in;
	
		if (!Z_in[15]) begin
			X_out <= X_in - (Y_in >> iteration);
			Y_out <= Y_in + (X_in >> iteration);
			Z_out <= Z_in   - tanangle;
		end
		
		else if (Z_in[15]) begin
			X_out <= X_in + (Y_in >> iteration);
			Y_out <= Y_in - (X_in >> iteration);
			Z_out <= ~((~Z_in + 1)   - tanangle);
		end
	end
	
	//assign quart_out = quart_in;
	
endmodule
