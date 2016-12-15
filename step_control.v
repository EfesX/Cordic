module step_control (
	input clk,
	
	output [15:0] Ang,
	output [1:0]  Qrt
);
	
	reg Ang = 0;
	reg Qrt = 0;
	
	reg TEST = 9'd256;
	
	reg [7:0] cnt = 0;

	always @(posedge clk) begin
	
	//cnt <= cnt + 1'b1;
	
		case (Qrt)
			2'b00: begin  if  (cnt == 6) begin Ang = (Ang + 9'd2); cnt <= 0; end else Ang = (Ang + 5'd15); 
						     if  (Ang >= (90 << 8)) begin Ang <= (90 << 8); Qrt <= 2'b01; end
				    end
			2'b01: begin  if  (cnt == 6) begin Ang = (Ang - 9'd2); cnt <= 0; end else Ang = (Ang - 5'd15); 
							  if  ((Ang == 0) || (Ang > (90 << 8))) begin Ang <= 0; Qrt <= 2'b10; end 
					 end
			2'b10: begin  if  (cnt == 6) begin Ang = (Ang + 9'd2); cnt <= 0; end else Ang = (Ang + 5'd15); 
							  if  (Ang >= (90 << 8)) begin Ang <= (90 << 8); Qrt <= 2'b11; end
					 end
			2'b11: begin  if  (cnt == 6) begin Ang = (Ang - 9'd2); cnt <= 0; end else Ang = (Ang - 5'd15); 
							  if  ((Ang == 0) || (Ang > (90 << 8))) begin Ang <= 0; Qrt <= 2'b00; end
					 end
		endcase
	end
endmodule
