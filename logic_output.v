module logic_output(
    input [3:0] Q,
    output en_R1, en_R2, en_R3, en_R4, en_R5,
    output bus1, bus6,
    output [1:0] bus2, bus3, bus4, bus5, bus7,
    output [1:0] sel_AU1, sel_AU2,
    output Done
);

    // Intermediate signals
    wire nQ3, nQ2, nQ1, nQ0;

    // NOT gates using assign statements
    assign nQ3 = ~Q[3];
    assign nQ2 = ~Q[2];
    assign nQ1 = ~Q[1];
    assign nQ0 = ~Q[0];

    // Combinational logic expressions using assign statements for outputs
    assign en_R1 = nQ3 & nQ2 & nQ0 | Q[2] & Q[1] & Q[0] | Q[3] & nQ2 & nQ1 & Q[0];
    assign en_R2 = nQ3 & Q[1] & Q[0] | Q[3] & Q[1] & nQ0 | nQ3 & nQ2 & nQ1 & nQ0;
    assign en_R3 = Q[3] & nQ0 | Q[3] & Q[2] | Q[2] & Q[1] & nQ0;
    assign en_R4 = Q[3] & Q[2] & Q[0] | Q[2] & Q[1] & nQ0;
    assign en_R5 = Q[3] & Q[2] & nQ0 | nQ3 & Q[2] & nQ1 & Q[0];

    assign bus1 = nQ3 & Q[2] & nQ1 | Q[2] & nQ1 & nQ0 | Q[3] & Q[1] & Q[0];
    assign {bus2, bus3} = {nQ3 & nQ2 & nQ1 & Q[0], Q[3] & nQ2 & nQ1 & nQ0};
    assign {bus4, bus5} = {Q[3] & nQ2 & Q[1] & Q[0], Q[2] & Q[1] & Q[0]};
    assign bus6 = Q[3] & nQ2 | Q[3] & nQ0 | Q[3] & Q[2] & Q[1];
    assign {bus7[1], bus7[0]} = {Q[2] & Q[1] & nQ0, Q[3] & Q[2] & Q[0]};
    
    assign {sel_AU1[1], sel_AU1[0]} = {Q[1] & Q[0], nQ3 & Q[2] | Q[2] & nQ0};
    assign {sel_AU2[1], sel_AU2[0]} = {Q[1], nQ2 & Q[1]};

    assign Done = Q[3] & Q[2] & Q[0];
endmodule
