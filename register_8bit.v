module register_8bit(
   input [7:0] D,
	input clk, En,
	output [7:0] Q
	);
	genvar i;

	generate
		for(i=7; i>=0; i=i-1) begin: block1
			d_ffe dfe1(	.Q(Q[i]),
							.D(D[i]),
							.clk(clk),
							.en(En)
						);
		end
	endgenerate
endmodule
