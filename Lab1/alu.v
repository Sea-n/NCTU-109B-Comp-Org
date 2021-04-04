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

reg Ai, Bi;
reg [1:0] op;
reg [31:0] less, cin;
wire [31:0] res, c_out;

genvar i;
generate for (i=0; i<32; i=i+1)
	alu_top u0(src1[i], src2[i], less[i], Ai, Bi, cin[i], op, res[i], c_out[i]);
endgenerate

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		Ai <= 0;
		Bi <= 0;
		op <= 2'b00;
		cin <= 32'b0;
		less <= 32'b0;
	end else begin
		zero <= ~(|res);
		result <= res;

		case (ALU_control)
			4'b0000: begin
				op <= 2'b00;
				Ai <= 0;
				Bi <= 0;
				cout <= 0;
				overflow <= 0;
			end
			4'b0001: begin
				op <= 2'b01;
				Ai <= 0;
				Bi <= 0;
				cout <= 0;
				overflow <= 0;
			end
			default: begin
				overflow <= 1;
			end
		endcase

	end
end

endmodule
