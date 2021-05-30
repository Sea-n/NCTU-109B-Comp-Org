// Author: 0816146 韋詠祥

module Decoder(
	clk_i,
	instr_op_i,
	function_i,
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
input [6-1:0] instr_op_i, function_i;
output reg [2-1:0] ALUOp_o, BranchType_o, Jump_o, MemToReg_o, RegDst_o;
output reg ALUSrc_o, Branch_o;
output reg MemRead_o, MemWrite_o, RegWrite_o;

// Main function
always @(instr_op_i) begin
	Branch_o     <=  instr_op_i[5:2] == 4'b0001;
	BranchType_o <=  instr_op_i[5:1] == 5'b00010
		? (instr_op_i[0] ? 2'b11 : 2'b00)   // bne / beq
		: (instr_op_i[0] ? 2'b01 : 2'b10);  // bgtz / blez
	MemRead_o    <=  instr_op_i == 6'b100011;  // lw
	MemWrite_o   <=  instr_op_i == 6'b101011;  // sw
end

always @(instr_op_i, function_i) begin
	casez (instr_op_i)
		6'b00001?: ALUOp_o <= 2'b00;  // j / jal  ADD
		6'b000100: ALUOp_o <= 2'b01;  // beq  SUB
		6'b00100?: ALUOp_o <= 2'b00;  // addi / addiu  ADD
		6'b10?011: ALUOp_o <= 2'b00;  // lw / sw  ADD
		6'b001010: ALUOp_o <= 2'b11;  // slti  SLT
		default:   ALUOp_o <= 2'b10;
	endcase

	casez (instr_op_i)
		6'b0010??: ALUSrc_o <= 1'b1;  // addi / addiu / slti / sltiu
		6'b10?011: ALUSrc_o <= 1'b1;  // lw / sw
		default:   ALUSrc_o <= 1'b0;
	endcase

	casez (instr_op_i)
		6'b00001?: Jump_o <= 2'b00;  // j / jal
		6'b000000: casez (function_i)
			6'b001000: Jump_o <= 2'b10;  // jr / jalr
			default:   Jump_o <= 2'b01;
		endcase
		default:   Jump_o <= 2'b01;
	endcase

	casez (instr_op_i)
		6'b000011: MemToReg_o <= 2'b11;  // jal PC
		6'b100011: MemToReg_o <= 2'b01;  // lw  Data Memory
		default:   MemToReg_o <= 2'b00;  // ALU
	endcase

	casez (instr_op_i)
		6'b0010??: RegDst_o <= 2'b00;  // addi / addiu / slti / sltiu
		6'b100011: RegDst_o <= 2'b00;  // lw
		6'b000011: RegDst_o <= 2'b10;  // jal
		default:   RegDst_o <= 2'b01;
	endcase

	casez (instr_op_i)
		6'b000000: RegWrite_o <= 1;  // add
		6'b0010??: RegWrite_o <= 1;  // addi / addiu / slti / sltiu
		6'b100011: RegWrite_o <= 1;  // lw
		6'b000011: RegWrite_o <= 1;  // jal
		default:   RegWrite_o <= 0;
	endcase
end

endmodule
