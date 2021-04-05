`timescale 1ns / 1ps

// Author: 0816146 韋詠祥

module fa(input A, B, Cin, output S, Cout);

wire a, b, c;

ha had0(A, B, a, b);
ha had1(a, Cin, S, c);
or(Cout, b, c);

endmodule
