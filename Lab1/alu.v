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

input           clk;
input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             overflow;

reg Ai, Bi, cin;
reg [1:0] op;
reg [31:0] less;
wire [31:0] res, c_out;

genvar i;
	alu_top u0(.clk(clk), .src1_in(src1[0]), .src2_in(src2[0]), .less(less[0]), .A_invert(Ai),
.B_invert(Bi), .cin(1'b0), .operation(op), .result(res[0]), .cout(c_out[0]));
generate for (i=1; i<31; i=i+1)
	alu_top u1(.clk(clk), .src1_in(src1[i]), .src2_in(src2[i]), .less(less[i]), .A_invert(Ai),
.B_invert(Bi), .cin(c_out[i-1]), .operation(op), .result(res[i]), .cout(c_out[i]));
endgenerate
	alu_top u31(.clk(clk), .src1_in(src1[31]), .src2_in(src2[31]), .less(less[31]), .A_invert(Ai),
.B_invert(Bi), .cin(c_out[30]), .operation(op), .result(res[31]), .cout(cout));

// Since the checker evaluate answer in 0.5 clock after input, we should use
// blocking assignment (var = 0) instead of non-blocking one (var <= 0)
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		Ai = 1'b0;
		Bi = 1'b0;
		op = 2'b00;
		less = 32'b0;
	end else begin
		case (ALU_control)
			4'b0000: begin  // AND
				op = 2'b00;
				Ai = 1'b0;
				Bi = 1'b0;
				overflow = 1'b0;
			end
			4'b0001: begin  // OR
				op = 2'b01;
				Ai = 1'b0;
				Bi = 1'b0;
				overflow = 1'b0;
			end
			4'b0010: begin  // ADD
				op = 2'b10;
				Ai = 1'b0;
				Bi = 1'b0;
				overflow = 1'b0;
			end
			4'b1100: begin  // NOR
				op = 2'b01;
				Ai = 1'b0;
				Bi = 1'b0;
				overflow = 1'b0;
			end
			default: begin
				overflow = 1'b1;
			end
		endcase
	end
end

always @(res) begin
	if (ALU_control == 4'b1100)
		result = ~res;
	else
		result = res;
	zero = ~(|result);
end

endmodule
