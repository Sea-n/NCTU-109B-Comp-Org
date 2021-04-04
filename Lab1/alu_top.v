`timescale 1ns/1ps

module alu_top(
	clk,
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

input         clk;
input         src1_in;
input         src2_in;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

reg           result, cout;

wire          src1, src2;
wire          as, ac;
assign src1 = src1_in ^ A_invert;
assign src2 = src2_in ^ B_invert;

fa fad(.A(src1), .B(src2), .Cin(cin), .S(as), .Cout(ac));

// Intentionally use blocking assignment instead of non-blocking one
always @(posedge clk) begin
	case (operation)
		2'b00: begin
			result = src1 & src2;
			cout = 0;
		end
		2'b01: begin
			result = src1 | src2;
			cout = 0;
		end
		2'b10: begin
			result = as;
			cout = ac;
		end
		2'b11: begin
			result = 1;
			cout = 0;
		end
	endcase
end

endmodule
