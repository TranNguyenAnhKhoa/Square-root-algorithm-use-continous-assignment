module next_state(
    input Start,
    input [3:0] Q,
    output [3:0] D
);

assign D[3] = (Q[3] & ~Q[2]) | (Q[3] & ~Q[0]) | (Q[2] & Q[1] & Q[0]);
assign D[2] = (Q[2] & ~Q[1]) | (Q[2] & ~Q[0]) | (~Q[2] & Q[1] & Q[0]);
assign D[1] = (~Q[1] & Q[0]) | (Q[1] & ~Q[0]);
assign D[0] = (Start & ~Q[0]) | (Q[1] & ~Q[0]) | (Q[2] & ~Q[0]) | (Q[3] & ~Q[0]) | (Q[3] & Q[2]);

endmodule