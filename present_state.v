module present_state(clk, D, Q, CLR);
	input [3:0] D;
	input clk, CLR;
	output [3:0] Q;
	genvar i;
	
	generate
	for(i=3; i>=0; i=i-1) begin: df1
		asyn_dff df(.d(D[i]), 
						.clk(clk), 
						.q(Q[i]), 
						.pr(1'b1),
						.clr(CLR)
						);
	end
	endgenerate
endmodule
