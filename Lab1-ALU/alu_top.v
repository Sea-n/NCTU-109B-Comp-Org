`timescale 1ns/1ps

// Author: 0816146 韋詠祥

module alu_top(
	clk,
	src1_in,    //1 bit source 1 (input)
	src2_in,    //1 bit source 2 (input)
	Ai,         //1 bit A_invert (input)
	Bi,         //1 bit B_invert (input)
	cin,        //1 bit carry in (input)
	operation,  //operation      (input)
	result,     //1 bit result   (output)
	cout        //1 bit carry out(output)
);

input clk;
input src1_in, src2_in;
input Ai, Bi, cin;
input [2-1:0] operation;

output reg result, cout;

wire src1, src2;
wire as, ac;
assign src1 = src1_in ^ Ai;
assign src2 = src2_in ^ Bi;

fa fad(.A(src1), .B(src2), .Cin(cin), .S(as), .Cout(ac));

// Intentionally use blocking assignment instead of non-blocking one
always @(operation, src1, src2, as) begin
	case (operation)
		2'b00: result = src1 & src2;
		2'b01: result = src1 | src2;
		2'b10: result = as;
		2'b11: result = as;
	endcase
end

always @(operation, ac) begin
	cout = (operation[1] == 1'b1) ? ac : 1'b0;
end

endmodule
