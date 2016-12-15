
module cordic_core(
	input [13:0] Xin,
	input [13:0] Yin,
	input [15:0] Zin,
	input [1:0]  quart_in,
	
	input clk,
	
	output [13:0] Xout,
	output [13:0] Yout,
	//output [15:0] Zout,
	output [1:0] quart_out
);	

		wire [13:0] X_w [0:15];
		wire [13:0] Y_w [0:15];
		wire [15:0] Z_w [0:15];

		wire [1:0] quart_w [0:15];
		
		function [15:0] tanangle;
			input [3:0] i;
			begin
				case(i)
					4'b0000:	tanangle = 14'd11526; 
					4'b0001:	tanangle	= 14'd6804;  
					4'b0010:	tanangle	= 14'd3595;  
					4'b0011:	tanangle = 14'd1825;  
					4'b0100:	tanangle = 14'd916;   
					4'b0101:	tanangle = 14'd458;   
					4'b0110:	tanangle	= 14'd229;   
					4'b0111:	tanangle = 14'd114;   
					4'b1000:	tanangle	= 14'd57;    
					4'b1001:	tanangle	= 14'd28;    
					4'b1010:	tanangle = 14'd14;
					4'b1011:	tanangle = 14'd7;
					4'b1100:	tanangle = 14'd3;
					4'b1101:	tanangle = 14'd2;
					4'b1110:	tanangle = 14'd1;
				endcase
			end
		endfunction


//====================================Подключение конвейера===================================================
		assign X_w[0] = Xin;
		assign Y_w[0] = Yin;
		assign Z_w[0] = Zin;

		assign Xout = X_w[15];
		assign Yout = Y_w[15];
		assign Zout = Z_w[15];
		
		assign quart_w[0] = quart_in;
		assign quart_out  = quart_w[15];
		
		genvar y;
		generate
			for(y = 0; y < 15; y = y + 1 ) begin
				rotator R(
					.clk(clk), 
					.X_in(X_w[y]), 
					.Y_in(Y_w[y]), 
					.Z_in(Z_w[y]), 
					.quart_in(quart_w[y]),
					.X_out(X_w[y+1]), 
					.Y_out(Y_w[y+1]), 
					.Z_out(Z_w[y+1]),
					.quart_out(quart_w[y+1])
				);
				defparam R.iteration = y;
				defparam R.tanangle  = tanangle(y);
			end
		endgenerate
//===============================================================================================================

endmodule
