module mux2to1_8bit(
	input [7:0]A1, B0,
	input sel,
	output [7:0] C
	);
	assign C = sel ? A1 : B0;
endmodule
