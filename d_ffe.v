module d_ffe(
	input D, en, clk,
	output Q
	);
	wire and1, and2, n_en, or1;
	
	assign and1 = D & en;
	assign n_en = ~en;
	assign and2 = n_en & Q;
	assign or1 = and1 | and2;
	d_ff df1(.Q(Q),
				.D(or1),
				.clk(clk)
				);

endmodule

module d_ff(
	input D, clk,
	output Q
	);
	wire dlatch1;
	
	d_latch master(	.D(D), 
						.enable(~clk), 
						.Q(dlatch1)
					);
	d_latch slave(	.D(dlatch1),
						.enable(clk),
						.Q(Q)
					);
endmodule

module d_latch(
	input D, enable,
	output Q
	);
	wire nand1, nand2, Qn;
	
	assign nand1 = ~(D & enable);
	assign nand2 = ~(~D & enable);
	assign Q = ~(Qn & nand1);
	assign Qn = ~(nand2 & Q);
endmodule