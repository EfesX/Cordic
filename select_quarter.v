module select_quarter(
	input [13:0] Xin,
	input [13:0] Yin,
	input [1:0]  quart_in,
	
	input clk,
	
	output reg [13:0] Xout,
	output reg [13:0] Yout
	//output reg [1:0]  quart_out
);


	always @(posedge clk) begin
		case (quart_in)
			2'b00: begin  Xout <= 14'd8192 + Xin; Yout <= 14'd8192 + Yin; end
			2'b01: begin  Xout <= 14'd8192 - Xin; Yout <= 14'd8192 + Yin; end
			2'b10: begin  Xout <= 14'd8192 - Xin; Yout <= 14'd8192 - Yin; end
			2'b11: begin  Xout <= 14'd8192 + Xin; Yout <= 14'd8192 - Yin; end
		endcase
	end
endmodule
