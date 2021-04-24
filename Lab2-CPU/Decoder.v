`timescale 1ns/1ps

// Author: 0816146 韋詠祥

module Decoder(
	instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
);

// I/O ports
input [6-1:0] instr_op_i;
output reg [3-1:0] ALU_op_o;
output reg RegWrite_o, ALUSrc_o, RegDst_o, Branch_o;

// Parameter

// Main function

endmodule
