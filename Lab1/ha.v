`timescale 1ns / 1ps

// Author: 0816146 韋詠祥

module ha(input A, B, output S, C);

xor(S, A, B);
and(C, A, B);

endmodule
