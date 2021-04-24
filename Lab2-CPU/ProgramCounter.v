`timescale 1ns/1ps

// Author: 0816146 韋詠祥

module ProgramCounter(
	clk_i,
	rst_i,
	pc_in_i,
	pc_out_o
);

// I/O ports
input clk_i;
input rst_i;
input [32-1:0] pc_in_i;
output reg [32-1:0] pc_out_o;

// Parameter

// Main function
always @(posedge clk_i) begin
	if(~rst_i)
		pc_out_o <= 0;
	else
		pc_out_o <= pc_in_i;
end

endmodule
