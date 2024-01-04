module datapath(clk, i1, i2, en_R1, en_R2, en_R3, en_R4, en_R5, b1, b2, b3, b4, b5, b6, b7, sel_AU1, sel_AU2, Done, result);
//port
	input [7:0] i1, i2;
	// enable register
	input en_R1, en_R2, en_R3, en_R4, en_R5;
	// tristate
	input b1, b6;
	input [1:0] b2, b3, b4, b5, b7;
	// Done
	input clk, Done;
	// select AU function
	input [1:0] sel_AU1, sel_AU2;
	//result
	output [7:0] result;
	// bus
	wire [7:0] bus1, bus2, bus3, bus4, bus5, bus6, bus7;
	wire [7:0] R1_out, R2_out, R3_out, R4_out, R5_out,
				AU1_out, AU2_out, shift1_out, shift3_out;
	
	
	// ******** bus 1 ************
	assign bus1 = b1 ? R1_out : 8'bz;
	register_8bit R1(	.D(bus3[7:0]),
							.Q(R1_out[7:0]),
							.clk(clk),
							.En(en_R1)
						);
	
	// ******** bus 2 ************
	assign bus2 = b2[1] ? R1_out : 8'bz;
	assign bus2 = b2[0] ? R2_out : 8'bz;
	register_8bit R2(	.D(bus4[7:0]),
							.Q(R2_out[7:0]),
							.clk(clk),
							.En(en_R2)
						);
	assign shift3_out = AU1_out >> 3;
	assign shift1_out = AU1_out >> 1;

	// ******** bus 3 ************
	assign bus3 = b3[1] ? i1 : 8'bz;
	assign bus3 = b3[0] ? AU1_out : 8'bz;
	AU1_2Stage AU1(.A(bus1[7:0]), 
						.B(bus2[7:0]), 
						.sel(sel_AU1[1:0]), 
						.clk(clk), 
						.out(AU1_out[7:0])
						);
	
	// ******** bus 4 ************
	assign bus4 = b4[1] ? i2 : 8'bz;
	assign bus4 = b4[0] ? AU1_out : 8'bz;
	
	// ******** bus 5 ************
	assign bus5 = b5[1] ? R4_out : 8'bz;
	assign bus5 = b5[0] ? R5_out : 8'bz;
	register_8bit R4(	.D(AU1_out[7:0]),
							.Q(R4_out[7:0]),
							.clk(clk),
							.En(en_R4)
						);
	register_8bit R5(	.D(shift1_out[7:0]),
							.Q(R5_out[7:0]),
							.clk(clk),
							.En(en_R5)
						);
	
	// ******** bus 6 ************
	assign bus6 = b5 ? R3_out : 8'bz;
	register_8bit R3(	.D(bus7[7:0]),
							.Q(R3_out[7:0]),
							.clk(clk),
							.En(en_R3)
						);

	// ******** bus 7 ************
	assign bus7 = b7[1] ? shift3_out : 8'bz;
	assign bus7 = b7[0] ? AU2_out : 8'bz;
	
	AU2_2Stage AU2(.A(bus5[7:0]), 
						.B(bus6[7:0]), 
						.sel(sel_AU2[1:0]), 
						.clk(clk), 
						.out(AU2_out[7:0])
						);
	// ******** Done **************
	assign result = Done ? R3_out : 8'bz;

endmodule
