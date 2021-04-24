`timescale 1ns/1ps

// Author: 0816146 韋詠祥

module Adder(
	src1_i,
	src2_i,
	sum_o
);

// I/O ports
input [32-1:0] src1_i;
input [32-1:0] src2_i;
output [32-1:0] sum_o;

// Main function
assign sum_o = src1_i + src2_i;

endmodule
