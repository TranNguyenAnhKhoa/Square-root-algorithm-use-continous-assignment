// abs/min/max
module AU1_2Stage(
	input [7:0] A, B,
	input [1:0] sel,
	input clk,
	output [7:0] out
	);
	wire [7:0] and1, b_m2, fa_df, a_m1, fa_m1, m1_m2;
	genvar i;
	wire [3:0] out_df;
	wire and2, and3, and4, or1;
	
	assign and1 = A & {8{sel[1]}} ;

	FA8bit fa1(	.A(and1[7:0]),
					.B(~B[7:0]),
					.C_in(1'b1),
					.sum(fa_df[7:0])
					);
	register_8bit df_a(.D(A[7:0]),
							 .Q(a_m1[7:0]),
							 .clk(clk)
					);
	register_8bit df_b(.D(B[7:0]),
							.Q(b_m2[7:0]),
							.clk(clk)
					);
	register_8bit df_sum(.D(fa_df[7:0]),
								.Q(fa_m1[7:0]),
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
					 .Q(out_df[2]),
					 .clk(clk)
					);
	d_ff df_sel3(.D(~sel[1]),
					 .Q(out_df[3]),
					 .clk(clk)
					);
	assign and2 = ~fa_m1[7] & out_df[3];
	assign and3 = out_df[0] & ~fa_m1[7];
	assign and4 = out_df[1] & out_df[2] & fa_m1[7];
	assign or1 = and2 | and3 | and4;
	
	assign m1_m2 = out_df[1] ? a_m1 : fa_m1;
	assign out = or1 ? m1_m2 : b_m2;
	
endmodule
