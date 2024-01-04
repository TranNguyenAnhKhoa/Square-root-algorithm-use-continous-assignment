module asyn_dff_en(
	input D, clk, En,
	output Q, PR, CLR
	);
	wire and1,and2,enb,or1;
	
	asyn_dff d1(.d(or1),
					.clk(clk), 
					.q(Q), 
					.pr(PR), 
					.clr(CLR)
				);

	assign and1 = D & En;
	assign and2 = D & ~En;
	assign or1 = and1 | and2;
	
endmodule

module asyn_dff(
	input d, clk, pr, clr,
	output q
	);
	wire or1,or2,or3,or4;
	
	assign or1 = ~pr | (d & clr & ~clk) | ~or2;
	assign or2 = ~or1 | (pr & ~clk & ~d) | ~clr;
	assign q = ~pr | (or1 & clk) | ~or4;
	assign or4 = ~q | (clk & or2) | ~clr;

	
endmodule