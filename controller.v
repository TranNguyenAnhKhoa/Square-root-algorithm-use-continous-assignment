module controller(
	//port
	input Start, clk,
	// enable register
	output en_R1, en_R2, en_R3, en_R4, en_R5,
	// enable bus
	output bus1, bus6,
	output [1:0] bus2, bus3, bus4, bus5, bus7,
	// Done
	output Done,
	// select AU function
	output [1:0] sel_AU1, sel_AU2,
	input CLR,
	output [3:0] present_out, next_out
);
	
	next_state nt(	.Start(Start), 
						.Q(present_out[3:0]), 
						.D(next_out[3:0])
					);
						
	present_state pt(	.clk(clk), 
							.D(next_out[3:0]), 
							.Q(present_out[3:0]),
							.CLR(CLR)
						);
							
	logic_output op(	.Q(present_out[3:0]),
							.en_R1(en_R1), 
							.en_R2(en_R2), 
							.en_R3(en_R3), 
							.en_R4(en_R4), 
							.en_R5(en_R5), 
							.bus1(bus1), 
							.bus2(bus2[1:0]), 
							.bus3(bus3[1:0]), 
							.bus4(bus4[1:0]), 
							.bus5(bus5[1:0]), 
							.bus6(bus6), 
							.bus7(bus7[1:0]), 
							.sel_AU1(sel_AU1[1:0]), 
							.sel_AU2(sel_AU2[1:0]), 
							.Done(Done)
						);
	
endmodule
