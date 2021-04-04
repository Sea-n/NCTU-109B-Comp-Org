`timescale 1ns/1ps

module alu_top(
	src1_in,       //1 bit source 1 (input)
	src2_in,       //1 bit source 2 (input)
	less,       //1 bit less     (input)
	A_invert,   //1 bit A_invert (input)
	B_invert,   //1 bit B_invert (input)
	cin,        //1 bit carry in (input)
	operation,  //operation      (input)
	result,     //1 bit result   (output)
	cout       //1 bit carry out(output)
);

input         src1_in;
input         src2_in;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

reg           result;

wire          src1, src2;
assign src1 = src1_in ^ A_invert;
assign src2 = src2_in ^ B_invert;
assign cout = (operation == 2'b10) & src1 & src2;

always @(src1 or src2 or operation) begin
	case (operation)
		2'b00:
			result <= src1 & src2;
		2'b01:
			result <= src1 | src2;
		2'b10:
			result <= src1 ^ src2;
		2'b11:
			result <= 1;
	endcase
end

endmodule
