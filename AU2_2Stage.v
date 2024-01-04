// add/sub/max
module AU2_2Stage(
	input [7:0] A, B,
	input [1:0] sel,
	input clk,
	output [7:0] out
	);
	genvar i;
	wire [7:0] xor1, fa_out, sum_mux, a_mux, b_mux, m1_m2;
	wire or1, and1;
	wire [3:0] out_df;
	
	assign or1 = ~sum_mux[7] | out_df[3] | out_df[2];
	assign and1 = out_df[1] & out_df[0];
	
	assign xor1 = B ^ {8{sel[1]}};
	
	FA8bit fa1(.A(A[7:0]),
					.B(xor1[7:0]),
					.C_in(sel[1]),
					.sum(fa_out[7:0])
					);
	register_8bit df1(.D(fa_out[7:0]),
							.Q(sum_mux[7:0]),
							.clk(clk)
						);
	register_8bit df2(.D(A[7:0]),
							.Q(a_mux[7:0]),
							.clk(clk)
						);
	register_8bit df3(.D(B[7:0]),
							.Q(b_mux[7:0]),
							.clk(clk)
						);
	d_ff df_sel0(.D(sel[0]),
					 .Q(out_df[0]),
					 .clk(clk)
					);
	d_ff df_sel1(.D(sel[1]),
					 .Q(out_df[1]),
					 .clk(clk)
					);
	d_ff df_sel2(.D(~sel[0]),
					 .Q(out_df[3]),
					 .clk(clk)
					);
	d_ff df_sel3(.D(~sel[1]),
					 .Q(out_df[2]),
					 .clk(clk)
					);
	assign m1_m2 = and1 ? a_mux : sum_mux;
	assign out = or1 ? m1_m2 : b_mux;
endmodule
