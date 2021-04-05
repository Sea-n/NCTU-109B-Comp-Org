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
reg             cout;
reg             overflow;

reg Ai, Bi, cin;
reg [1:0] op;
reg [31:0] less;
wire [31:0] res, carry;

genvar i;
	alu_top u0(.clk(clk), .src1_in(src1[0]), .src2_in(src2[0]), .less(less[0]), .A_invert(Ai),
.B_invert(Bi), .cin(cin), .operation(op), .result(res[0]), .cout(carry[0]));
generate for (i=1; i<32; i=i+1)
	alu_top u1(.clk(clk), .src1_in(src1[i]), .src2_in(src2[i]), .less(less[i]), .A_invert(Ai),
.B_invert(Bi), .cin(carry[i-1]), .operation(op), .result(res[i]), .cout(carry[i]));
endgenerate

always @(ALU_control) begin
	op = {ALU_control[1], ALU_control[3] | ALU_control[0]};
	Ai = 1'b0;
	Bi = (ALU_control[3:1] == 3'b011) ? 1'b1 : 1'b0;
	cin = (ALU_control == 4'b0110) ? 1'b1 : 1'b0;
end

// TODO: handle overflow, edge cases
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		less = 32'b0;
	end else begin
		case (ALU_control)
			4'b0000: begin  // AND
				overflow = 1'b0;
			end
			4'b0001: begin  // OR
				overflow = 1'b0;
			end
			4'b0010: begin  // ADD
				overflow = 1'b0;
			end
			4'b0110: begin  // SUB
				overflow = 1'b0;
			end
			4'b0111: begin  // SLT
				overflow = 1'b0;
			end
			4'b1100: begin  // NOR
				overflow = 1'b0;
			end
			default: begin
				overflow = 1'b1;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (ALU_control == 4'b0111)  // SLT
		cout <= 1'b0;
	else
		cout <= carry[31];
end

always @(posedge clk) begin
	if (ALU_control == 4'b0111) begin  // SLT
		result[31:1] <= 31'b0;
		result[0] <= (src1[31] ^ src2[31]) ? src1[31] : ~carry[31];
	end else if (ALU_control == 4'b1100)  // NOR
		result <= ~res;
	else
		result <= res;
end

always @(result) begin
	zero = ~|result;
end

endmodule
