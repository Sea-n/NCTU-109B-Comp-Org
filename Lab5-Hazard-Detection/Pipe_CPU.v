`timescale 1ns / 1ps

// Author: 0816146 韋詠祥
// Repo: https://github.com/Sea-n/NCTU-109B-Comp-Org

module Pipe_CPU(
	clk_i,
	rst_i
);

// I/O port
input clk_i, rst_i;

// Internal signals
wire ALU_zero, ALU_zero_s4, Branch_sel;
wire [3:0] ALUCtrl;
wire [4:0] RSaddr, RTaddr, RSaddr_s3, RTaddr_s3, RSaddr_s4, RTaddr_s4;
wire [4:0] RDaddr, RDaddr_s4, RDaddr_s5;

wire [31:0] PC_in, PC_out, IM_out, IM_out_s2, IM_out_s3;
wire [31:0] RDdata, RDdata_s5, RSdata, RSdata_s3, RTdata, RTdata_s3;
wire [31:0] ALU_src0, ALU_src1, ALU_src2, ALU_src2_s4, ALU_out, ALU_out_s4, ALU_out_s5;
wire [31:0] Branch_out, shl1_out, shl2_out;
wire [31:0] Adder1_out, Adder1_out_s2, Adder1_out_s3, Adder1_out_s4, Adder2_out, Adder2_out_s4;
wire [31:0] SE_out, SE_out_s3, SE_out_s4, DM_out, DM_out_s5;

// Control signals
wire ALUSrc, Branch, MemRead, MemWrite, RegWrite;
wire ALUSrc_s3, Branch_s3, MemRead_s3, MemWrite_s3, RegWrite_s3;
wire Branch_s4, MemRead_s4, MemWrite_s4, RegWrite_s4, RegWrite_s5;
wire [1:0] ALUOp, BranchType, Jump, MemToReg, RegDst;
wire [1:0] ALUOp_s3, MemToReg_s3, RegDst_s3;
wire [1:0] MemToReg_s4, MemToReg_s5;

// Forwarding and Hazard Dection
wire Stall;
wire [1:0] ForwardA, ForwardB;


// Instruction Fetch stage
MUX_4to1 #(.size(1)) Mux_Branch(
	.data0_i(ALU_zero),
	.data1_i(~(ALU_out[31] | ALU_zero)),
	.data2_i(~ALU_out[31]),
	.data3_i(~ALU_zero),
	.select_i(BranchType),
	.data_o(Branch_sel)
);

MUX_2to1 #(.size(32)) Mux_PC_Branch(
	.data0_i(Adder1_out),
	.data1_i(Adder2_out),
	.select_i(Branch_s3 & Branch_sel),
	.data_o(Branch_out)
);

Shift_Left_Two_32 Shifter1(
	.data_i(IM_out_s2),
	.data_o(shl1_out)
);

MUX_4to1 #(.size(32)) Mux_PC_Jump(  // S2
	.data0_i({Adder1_out[31:28], shl1_out[27:0]}),
	.data1_i(Branch_out),
	.data2_i(RSdata),
	.data3_i(32'b0),
	.select_i(Jump),
	.data_o(PC_in)
);

ProgramCounter PC(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(Stall),
	.pc_in_i(PC_in),
	.pc_out_o(PC_out)
);

Instr_Memory IM(
	.pc_addr_i(PC_out),
	.instr_o(IM_out)
);

Adder Adder1(
	.src1_i(32'd4),
	.src2_i(PC_out),
	.sum_o(Adder1_out)
);

// Instruction Decode stage
Sign_Extend Sign_Extend(
	.data_i(IM_out_s2[15:0]),
	.data_o(SE_out)
);

Reg_File Registers(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.RSaddr_i(RSaddr),
	.RTaddr_i(RTaddr),
	.RDaddr_i(RDaddr_s5),
	.RDdata_i(RDdata_s5),
	.RegWrite_i(RegWrite_s5),
	.RSdata_o(RSdata),
	.RTdata_o(RTdata)
);

Decoder Decoder(
	.clk_i(clk_i),
	.instr_op_i(IM_out_s2[31:26]),
	.function_i(IM_out_s2[5:0]),
	.Stall_i(Stall),
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

Hazard Hazard(
	.RSaddr_i(RSaddr),
	.RTaddr_i(RTaddr),
	.RSaddr_s3_i(RSaddr_s3),
	.RTaddr_s3_i(RTaddr_s3),
	.RSaddr_s4_i(RSaddr_s4),
	.RTaddr_s4_i(RTaddr_s4),
	.Branch_i(Branch),
	.MemRead_i(MemRead),
	.Branch_s3_i(Branch_s3),
	.MemRead_s3_i(MemRead_s3),
	.MemRead_s4_i(MemRead_s4),
	.Stall_o(Stall)
);

// Execute stage
MUX_4to1 #(.size(5)) Mux_RegDst(
	.data0_i(IM_out_s3[20:16]),
	.data1_i(IM_out_s3[15:11]),
	.data2_i(5'd31),
	.data3_i(5'd0),
	.select_i(RegDst_s3),
	.data_o(RDaddr)
);

ALU_Ctrl ALU_Ctrl(
	.funct_i(IM_out_s3[5:0]),
	.ALUOp_i(ALUOp_s3),
	.ALUCtrl_o(ALUCtrl)
);

MUX_4to1 #(.size(32)) Mux_ALUSrc1(
	.data0_i(RSdata_s3),
	.data1_i(RDdata_s5),
	.data2_i(RDdata),
	.data3_i(RDdata),
	.select_i(ForwardA),
	.data_o(ALU_src1)
);

MUX_4to1 #(.size(32)) Mux_ALUSrc2(
	.data0_i(RTdata_s3),
	.data1_i(RDdata_s5),
	.data2_i(RDdata),
	.data3_i(RDdata),
	.select_i(ForwardB),
	.data_o(ALU_src2)
);

MUX_2to1 #(.size(32)) Mux_ALUSrc0(
	.data0_i(ALU_src2),
	.data1_i(SE_out_s3),
	.select_i(ALUSrc_s3),
	.data_o(ALU_src0)
);

ALU ALU(
	.src1_i(ALU_src1),
	.src2_i(ALU_src0),
	.ctrl_i(ALUCtrl),
	.result_o(ALU_out),
	.zero_o(ALU_zero)
);

Shift_Left_Two_32 Shifter2(
	.data_i(SE_out_s3),
	.data_o(shl2_out)
);

Adder Adder2(
	.src1_i(Adder1_out),
	.src2_i(shl2_out),
	.sum_o(Adder2_out)
);

Forwarding Forwarding(
	.RSaddr_i(RSaddr_s3),
	.RTaddr_i(RTaddr_s3),
	.RDaddr_s4_i(RDaddr_s4),
	.RDaddr_s5_i(RDaddr_s5),
	.RegWrite_s4_i(RegWrite_s4),
	.RegWrite_s5_i(RegWrite_s5),
	.ForwardA_o(ForwardA),
	.ForwardB_o(ForwardB)
);

// Memory access stage
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALU_out_s4),
	.data_i(ALU_src2_s4),
	.MemRead_i(MemRead_s4),
	.MemWrite_i(MemWrite_s4),
	.data_o(DM_out)
);

// Write Back stage
MUX_4to1 #(.size(32)) Mux_MemToReg(
	.data0_i(ALU_out_s4),
	.data1_i(DM_out),
	.data2_i(SE_out_s4),
	.data3_i(Adder1_out_s4),
	.select_i(MemToReg_s4),
	.data_o(RDdata)
);

// signal assignment
Pipe_Reg #(.size(1)) reg110(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i(ALU_zero),
	.data_o(ALU_zero_s4)
);

Pipe_Reg #(.size(5 * 2)) reg150(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({RDaddr, RDaddr_s4}),
	.data_o({RDaddr_s4, RDaddr_s5})
);

assign RSaddr = IM_out_s2[25:21];
assign RTaddr = IM_out_s2[20:16];
Pipe_Reg #(.size(5 * 2)) reg151(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({RSaddr, RTaddr}),
	.data_o({RSaddr_s3, RTaddr_s3})
);

Pipe_Reg #(.size(5 * 2)) reg152(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({RSaddr_s3, RTaddr_s3}),
	.data_o({RSaddr_s4, RTaddr_s4})
);

Pipe_Reg #(.size(32)) reg190(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(Stall),
	.data_i(IM_out),
	.data_o(IM_out_s2)
);

Pipe_Reg #(.size(32)) reg191(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i(IM_out_s2),
	.data_o(IM_out_s3)
);

Pipe_Reg #(.size(32 * 3)) reg192(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({RSdata, RTdata, RDdata}),
	.data_o({RSdata_s3, RTdata_s3, RDdata_s5})
);

Pipe_Reg #(.size(32 * 3)) reg193(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({ALU_out, ALU_out_s4, ALU_src2}),
	.data_o({ALU_out_s4, ALU_out_s5, ALU_src2_s4})
);

Pipe_Reg #(.size(32 * 4)) reg194(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({Adder1_out, Adder1_out_s2, Adder1_out_s3, Adder2_out}),
	.data_o({Adder1_out_s2, Adder1_out_s3, Adder1_out_s4, Adder2_out_s4})
);

Pipe_Reg #(.size(32 * 3)) reg195(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({SE_out, SE_out_s3, DM_out}),
	.data_o({SE_out_s3, SE_out_s4, DM_out_s5})
);

Pipe_Reg #(.size(1 * 5)) reg210(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({ALUSrc, Branch, MemRead, MemWrite, RegWrite}),
	.data_o({ALUSrc_s3, Branch_s3, MemRead_s3, MemWrite_s3, RegWrite_s3})
);

Pipe_Reg #(.size(1 * 5)) reg211(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({Branch_s3, MemRead_s3, MemWrite_s3, RegWrite_s3, RegWrite_s4}),
	.data_o({Branch_s4, MemRead_s4, MemWrite_s4, RegWrite_s4, RegWrite_s5})
);

Pipe_Reg #(.size(2 * 3)) reg220(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({ALUOp, MemToReg, RegDst}),
	.data_o({ALUOp_s3, MemToReg_s3, RegDst_s3})
);

Pipe_Reg #(.size(2 * 2)) reg221(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.keep_i(1'b0),
	.data_i({MemToReg_s3, MemToReg_s4}),
	.data_o({MemToReg_s4, MemToReg_s5})
);

endmodule
