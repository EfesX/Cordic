`timescale 1ns / 1ns
module cordic;

reg clk = 0;


reg [13:0] Xq = 14'd4972;
reg [13:0] Yq = 0;

wire [13:0] I;
wire [13:0] Q;


CORDIC_top cord_top(Xq, Yq, clk, Q, I);


always #10 clk =~ clk;
initial begin #500000 $finish;  end

	initial begin
		$dumpfile("CORDIC/test/cord_graf.out");
      $dumpvars(0, cordic);
   end

	


initial $monitor(Q);

endmodule
