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
output reg [2-1:0] ALUOp_o, BranchType_o, MemToReg_o;
output reg ALUSrc_o, Branch_o, Jump_o;
output reg MemRead_o, MemWrite_o, RegWrite_o, RegDst_o;

// Main function
always @(instr_op_i) begin
	Branch_o     <=  instr_op_i[2];
	BranchType_o <=  instr_op_i[5:1] == 5'b00010
		? (instr_op_i[0] ? 2'b11 : 2'b00)
		: (instr_op_i[1] ? 2'b01 : 2'b10);
	Jump_o       <=  instr_op_i != 6'b000010;
	MemToReg_o   <=  instr_op_i == 6'b100011 ? 2'b01 : 2'b00;  // 2'b10 ?
	MemRead_o    <=  instr_op_i == 6'b100011;
	MemWrite_o   <=  instr_op_i == 6'b101011;
end

always @(instr_op_i) begin
	casez (instr_op_i)
		6'b00001?: ALUOp_o <= 2'b00;  // j / jal ADD
		6'b000100: ALUOp_o <= 2'b01;  // beq SUB
		6'b00100?: ALUOp_o <= 2'b00;  // addi / addiu ADD
		6'b10?011: ALUOp_o <= 2'b00;  // lw / sw ADD
		default:   ALUOp_o <= 2'b10;
	endcase

	casez (instr_op_i)
		6'b001000: ALUSrc_o <= 1'b1;  // addi
		6'b10?011: ALUSrc_o <= 1'b1;  // lw / sw
		default:   ALUSrc_o <= 1'b0;
	endcase

	casez (instr_op_i)
		6'b001000: RegDst_o <= 1'b0;  // addi
		6'b100011: RegDst_o <= 1'b0;  // lw
		default:   RegDst_o <= 1'b1;
	endcase

	casez (instr_op_i)
		6'b000000: RegWrite_o <= 1;  // add
		6'b00100?: RegWrite_o <= 1;  // addi / addiu
		6'b100011: RegWrite_o <= 1;  // lw
		default:   RegWrite_o <= 0;
	endcase
end

endmodule
