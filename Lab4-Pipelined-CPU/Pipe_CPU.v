`timescale 1ns / 1ps

// Author: 0816146 韋詠祥
// Repo: https://github.com/Sea-n/NCTU-109B-Comp-Org

module Pipe_CPU(
	clk_i,
	rst_i
);

// I/O port
input clk_i, rst_i;

// Internal Signles
wire ALU_zero, ALUSrc, Branch, Branch_sel;
wire MemRead, MemWrite, RegWrite;
wire [1:0] ALUOp, BranchType, Jump, MemToReg, RegDst;
wire [3:0] ALUCtrl;
wire [4:0] RDaddr;
wire [31:0] PC_in, PC_out, IM_out, DM_out, RDdata, RSdata, RTdata;
wire [31:0] SE_out, ALU_src2, ALU_out, Adder1_out, Adder2_out, Branch_out, shl1_out, shl2_out;
// IF stage
// ID stage
// EX stage
// MEM stage
// WB stage


// Instantiate modules
ProgramCounter PC(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.pc_in_i(PC_in),
	.pc_out_o(PC_out)
);

Instr_Memory IM(
	.pc_addr_i(PC_out),
	.instr_o(IM_out)
);

MUX_4to1 #(.size(5)) Mux_RegDst(
	.data0_i(IM_out[20:16]),
	.data1_i(IM_out[15:11]),
	.data2_i(5'd31),
	.data3_i(5'd0),
	.select_i(RegDst),
	.data_o(RDaddr)
);

MUX_4to1 #(.size(32)) Mux_MemToReg(
	.data0_i(ALU_out),
	.data1_i(DM_out),
	.data2_i(SE_out),
	.data3_i(Adder1_out),
	.select_i(MemToReg),
	.data_o(RDdata)
);

Reg_File Registers(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.RSaddr_i(IM_out[25:21]),
	.RTaddr_i(IM_out[20:16]),
	.RDaddr_i(RDaddr),
	.RDdata_i(RDdata),
	.RegWrite_i(RegWrite),
	.RSdata_o(RSdata),
	.RTdata_o(RTdata)
);

Decoder Decoder(
	.clk_i(clk_i),
	.instr_op_i(IM_out[31:26]),
	.function_i(IM_out[5:0]),
	.ALUOp_o(ALUOp),
	.ALUSrc_o(ALUSrc),
	.Branch_o(Branch),
	.BranchType_o(BranchType),
	.Jump_o(Jump),
	.MemToReg_o(MemToReg),
	.MemRead_o(MemRead),
	.MemWrite_o(MemWrite),
	.RegWrite_o(RegWrite),
	.RegDst_o(RegDst)
);

ALU_Ctrl AC(
	.funct_i(IM_out[5:0]),
	.ALUOp_i(ALUOp),
	.ALUCtrl_o(ALUCtrl)
);

Sign_Extend SE(
	.data_i(IM_out[15:0]),
	.data_o(SE_out)
);

MUX_2to1 #(.size(32)) Mux_ALUSrc(
	.data0_i(RTdata),
	.data1_i(SE_out),
	.select_i(ALUSrc),
	.data_o(ALU_src2)
);

ALU ALU(
	.src1_i(RSdata),
	.src2_i(ALU_src2),
	.ctrl_i(ALUCtrl),
	.result_o(ALU_out),
	.zero_o(ALU_zero)
);

Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALU_out),
	.data_i(RTdata),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.data_o(DM_out)
);

Shift_Left_Two_32 Shifter1(
	.data_i(IM_out),
	.data_o(shl1_out)
);

Shift_Left_Two_32 Shifter2(
	.data_i(SE_out),
	.data_o(shl2_out)
);

Adder Adder1(
	.src1_i(32'd4),
	.src2_i(PC_out),
	.sum_o(Adder1_out)
);

Adder Adder2(
	.src1_i(Adder1_out),
	.src2_i(shl2_out),
	.sum_o(Adder2_out)
);

MUX_2to1 #(.size(32)) Mux_PC_Branch(
	.data0_i(Adder1_out),
	.data1_i(Adder2_out),
	.select_i(Branch & Branch_sel),
	.data_o(Branch_out)
);

MUX_4to1 #(.size(1)) Mux_Branch(
	.data0_i(ALU_zero),
	.data1_i(~(ALU_out[31] | ALU_zero)),
	.data2_i(~ALU_out[31]),
	.data3_i(~ALU_zero),
	.select_i(BranchType),
	.data_o(Branch_sel)
);

MUX_4to1 #(.size(32)) Mux_PC_Jump(
	.data0_i({Adder1_out[31:28], shl1_out[27:0]}),
	.data1_i(Branch_out),
	.data2_i(RSdata),
	.data3_i(32'b0),
	.select_i(Jump),
	.data_o(PC_in)
);

// signal assignment

endmodule
