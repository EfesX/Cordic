module CORDIC_top (
	input [13:0] Xin,
	input [13:0] Yin,

	input clk,
	
	output [13:0] Q,
	output [13:0] I
);

	wire [15:0] angle;
	wire [1:0]  qrt;
	wire [1:0]  qrto;
	wire [13:0] Xo;
	wire [13:0] Yo;
	

	cordic_core    CORD    (Xin, Yin, angle, qrt, clk, Xo, Yo, qrto);
	select_quarter IQ_OUT  (Xo, Yo, qrto, clk, Q, I);
	step_control	ang_rot (clk, angle, qrt);
endmodule
