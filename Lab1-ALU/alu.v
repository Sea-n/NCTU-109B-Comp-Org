`timescale 1ns/1ps

// Author: 0816146 韋詠祥

module alu(
	clk,           // system clock              (input)
	rst_n,         // negative reset            (input)
	src1,          // 32 bits source 1          (input)
	src2,          // 32 bits source 2          (input)
	ALU_control,   // 4 bits ALU control input  (input)
	result,        // 32 bits result            (output)
	zero,          // 1 bit when the output is 0, zero must be set (output)
	cout,          // 1 bit carry out           (output)
	overflow       // 1 bit overflow            (output)
);

input clk, rst_n;
input [31:0] src1, src2;
input  [3:0] ALU_control;

output reg [31:0] result;
output reg cout, overflow;
output zero;

wire Ai, Bi, cin;
wire [1:0] op;
wire [31:0] res, carry;

/* Connecting submodule */
genvar i;
	alu_top u0(.clk(clk), .src1_in(src1[0]), .src2_in(src2[0]), .Ai(Ai),
.Bi(Bi), .cin(cin), .operation(op), .result(res[0]), .cout(carry[0]));
generate for (i=1; i<32; i=i+1)
	alu_top u1(.clk(clk), .src1_in(src1[i]), .src2_in(src2[i]), .Ai(Ai),
.Bi(Bi), .cin(carry[i-1]), .operation(op), .result(res[i]), .cout(carry[i]));
endgenerate

/* Set corresponding opcode for 1-bit ALU */
assign Ai = ALU_control[3];
assign Bi = ALU_control[2];
assign op = ALU_control[1:0];
assign cin = (ALU_control == 4'b0110) ? 1'b1 : 1'b0;

/* Aggregating results of 1-bit ALUs */
always @(posedge clk, negedge rst_n) begin
	if (~rst_n)
		result <= 32'b0;
	else begin
		if (ALU_control == 4'b0111) begin  // SLT
			result[31:1] <= 31'b0;
			result[0] <= (src1[31] ^ src2[31]) ? src1[31] : ~carry[31];
		end else
			result <= res;
	end
end

/* Generate ZCV flags */
assign zero = ~|result;

always @(posedge clk, negedge rst_n) begin
	if (~rst_n) begin
		cout <= 1'b0;
		overflow <= 1'b0;
	end else begin
		if (ALU_control[1:0] == 2'b10) begin  // ADD & SUB
			cout <= carry[31];
			overflow <= (src1[31] ^ src2[31] ^ ALU_control[2]) ? 1'b0 : src1[31] ^ res[31];
		end else begin
			cout <= (ALU_control == 4'b0111) ? 1'b0 : carry[31];  // SLT
			overflow <= 1'b0;
		end
	end
end

endmodule
