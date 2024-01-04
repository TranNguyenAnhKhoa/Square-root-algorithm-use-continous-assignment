module SRA(
//Port
	input [7:0] In1, In2,
	input clk, Start, CLR,
	output [7:0] Out,
	output Done,
	output [7:0] state
);
//Wire
	// enable register
	wire en1, en2, en3, en4, en5;
	//bus
	wire b1, b6;
	wire [1:0] b2, b3, b4, b5, b7;
	//select
	wire [1:0] sel1, sel2;
	/////
	wire done;
//Logic

	datapath inst1(.clk(clk), 
						.i1(In1[7:0]), 
						.i2(In2[7:0]), 
						.en_R1(en1), 
						.en_R2(en2), 
						.en_R3(en3), 
						.en_R4(en4), 
						.en_R5(en5), 
						.b1(b1), 
						.b2(b2[1:0]), 
						.b3(b3[1:0]), 
						.b4(b4[1:0]), 
						.b5(b5[1:0]), 
						.b6(b6), 
						.b7(b7[1:0]), 
						.sel_AU1(sel1[1:0]), 
						.sel_AU2(sel2[1:0]), 
						.Done(done), 
						.result(Out[7:0]));

	controller inst2(	.Start(Start), 
							.clk(clk), 
							.en_R1(en1), 
							.en_R2(en2), 
							.en_R3(en3),
							.en_R4(en4), 
							.en_R5(en5), 
							.bus1(b1), 
							.bus2(b2[1:0]), 
							.bus3(b3[1:0]), 
							.bus4(b4[1:0]), 
							.bus5(b5[1:0]), 
							.bus6(b6), 
							.bus7(b7[1:0]), 
							.sel_AU1(sel1[1:0]), 
							.sel_AU2(sel2[1:0]), 
							.Done(done),
							.CLR(CLR),
							.present_out(state[3:0])
						);
	assign Done = done;
endmodule
