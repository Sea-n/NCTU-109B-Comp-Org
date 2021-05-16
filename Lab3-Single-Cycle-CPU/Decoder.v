// Author: 0816146 韋詠祥

module Decoder(
	clk_i,
	instr_op_i,
	ALUOp_o,
	ALUSrc_o,
	Branch_o,
	BranchType_o,
	Jump_o,
	MemToReg_o,
	MemRead_o,
	MemWrite_o,
	RegWrite_o,
	RegDst_o,
);

// I/O ports
input clk_i;
input [6-1:0] instr_op_i;
output reg [3-1:0] ALUOp_o;
output reg [2-1:0] BranchType_o, MemToReg_o;
output reg ALUSrc_o, Branch_o, Jump_o;
output reg MemRead_o, MemWrite_o, RegWrite_o, RegDst_o;

// Main function
always @(instr_op_i) begin
	ALUOp_o      <=  instr_op_i[3:1];
	ALUSrc_o     <=  instr_op_i[3];
	Branch_o     <=  instr_op_i[2];
	BranchType_o <=  instr_op_i[5:1] == 5'b00010
		? (instr_op_i[0] ? 2'b11 : 2'b00)
		: (instr_op_i[1] ? 2'b01 : 2'b10);
	Jump_o       <=  instr_op_i != 6'b000010;
	MemToReg_o   <=  instr_op_i == 6'b100011 ? 2'b01 : 2'b00;  // 2'b10 ?
	MemRead_o    <=  instr_op_i == 6'b100011;
	MemWrite_o   <=  instr_op_i == 6'b101011;
	RegWrite_o   <= ~instr_op_i[2];
	RegDst_o     <= ~instr_op_i[3];
end

endmodule
