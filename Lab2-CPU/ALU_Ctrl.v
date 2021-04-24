`timescale 1ns/1ps

// Author: 0816146 韋詠祥

module ALU_Ctrl(
	funct_i,
	ALUOp_i,
	ALUCtrl_o
);

// I/O ports
input [6-1:0] funct_i;
input [3-1:0] ALUOp_i;
output [4-1:0] ALUCtrl_o;

// Parameter

// Select exact operation
assign ALUCtrl_o[3] = 0;
assign ALUCtrl_o[2] = ALUOp_i[2] | ALUOp_i[1] | funct_i[1];
assign ALUCtrl_o[1] = ~funct_i[2];
assign ALUCtrl_o[0] = ALUOp_i[1] | (funct_i[3] ^ funct_i[0]);

endmodule
