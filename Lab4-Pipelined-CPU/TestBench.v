`timescale 1ns / 1ps

// Author: 0816146 韋詠祥

`define CYCLE_TIME 10

module testbench;
reg clk, rst;

Pipe_CPU CPU(clk, rst);

always #(`CYCLE_TIME/2)
	clk = ~clk;

initial begin
	clk = 0;
	rst = 0;
	$dumpfile("debug.vcd");
	$dumpvars;

	#(`CYCLE_TIME) rst = 1;
	#(`CYCLE_TIME * 150)

	$display("PC = %d", CPU.PC.pc_out_o);

	$display("# Data Memory");
	$display("%d, %d, %d, %d, %d, %d, %d, %d", CPU.Data_Memory.memory[ 0], CPU.Data_Memory.memory[ 1], CPU.Data_Memory.memory[ 2], CPU.Data_Memory.memory[ 3], CPU.Data_Memory.memory[ 4], CPU.Data_Memory.memory[ 5], CPU.Data_Memory.memory[ 6], CPU.Data_Memory.memory[ 7]);
	$display("%d, %d, %d, %d, %d, %d, %d, %d", CPU.Data_Memory.memory[ 8], CPU.Data_Memory.memory[ 9], CPU.Data_Memory.memory[10], CPU.Data_Memory.memory[11], CPU.Data_Memory.memory[12], CPU.Data_Memory.memory[13], CPU.Data_Memory.memory[14], CPU.Data_Memory.memory[15]);
	$display("%d, %d, %d, %d, %d, %d, %d, %d", CPU.Data_Memory.memory[16], CPU.Data_Memory.memory[17], CPU.Data_Memory.memory[18], CPU.Data_Memory.memory[19], CPU.Data_Memory.memory[20], CPU.Data_Memory.memory[21], CPU.Data_Memory.memory[22], CPU.Data_Memory.memory[23]);
	$display("%d, %d, %d, %d, %d, %d, %d, %d", CPU.Data_Memory.memory[24], CPU.Data_Memory.memory[25], CPU.Data_Memory.memory[26], CPU.Data_Memory.memory[27], CPU.Data_Memory.memory[28], CPU.Data_Memory.memory[29], CPU.Data_Memory.memory[30], CPU.Data_Memory.memory[31]);

	$display("# Registers");
	$display("R0  =%d, R1  =%d, R2  =%d, R3  =%d, R4  =%d, R5  =%d, R6  =%d, R7  =%d", CPU.Registers.Reg_Bank[ 0], CPU.Registers.Reg_Bank[ 1], CPU.Registers.Reg_Bank[ 2], CPU.Registers.Reg_Bank[ 3], CPU.Registers.Reg_Bank[ 4], CPU.Registers.Reg_Bank[ 5], CPU.Registers.Reg_Bank[ 6], CPU.Registers.Reg_Bank[ 7]);
	$display("R8  =%d, R9  =%d, R10 =%d, R11 =%d, R12 =%d, R13 =%d, R14 =%d, R15 =%d", CPU.Registers.Reg_Bank[ 8], CPU.Registers.Reg_Bank[ 9], CPU.Registers.Reg_Bank[10], CPU.Registers.Reg_Bank[11], CPU.Registers.Reg_Bank[12], CPU.Registers.Reg_Bank[13], CPU.Registers.Reg_Bank[14], CPU.Registers.Reg_Bank[15]);
	$display("R16 =%d, R17 =%d, R18 =%d, R19 =%d, R20 =%d, R21 =%d, R22 =%d, R23 =%d", CPU.Registers.Reg_Bank[16], CPU.Registers.Reg_Bank[17], CPU.Registers.Reg_Bank[18], CPU.Registers.Reg_Bank[19], CPU.Registers.Reg_Bank[20], CPU.Registers.Reg_Bank[21], CPU.Registers.Reg_Bank[22], CPU.Registers.Reg_Bank[23]);
	$display("R24 =%d, R25 =%d, R26 =%d, R27 =%d, R28 =%d, R29 =%d, R30 =%d, R31 =%d", CPU.Registers.Reg_Bank[24], CPU.Registers.Reg_Bank[25], CPU.Registers.Reg_Bank[26], CPU.Registers.Reg_Bank[27], CPU.Registers.Reg_Bank[28], CPU.Registers.Reg_Bank[29], CPU.Registers.Reg_Bank[30], CPU.Registers.Reg_Bank[31]);

	$finish;
end

endmodule
