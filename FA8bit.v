module FA8bit(
    input [7:0] A, B,
    input C_in,
    output [7:0] sum,
    output C_out
);
	assign {C_out, sum} = A + B + C_in;
endmodule
