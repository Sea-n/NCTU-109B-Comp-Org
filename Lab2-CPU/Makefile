all: compile run

compile:
	iverilog -o cpu ALU.v ALU_Ctrl.v Adder.v Decoder.v Instr_Memory.v \
		MUX_2to1.v ProgramCounter.v Reg_File.v Shift_Left_Two_32.v \
		Sign_Extend.v Simple_Single_CPU.v Test_Bench.v

run:
	./cpu

pack:
	7z a 0816146.zip ALU.v ALU_Ctrl.v Adder.v Decoder.v Instr_Memory.v \
		MUX_2to1.v ProgramCounter.v Reg_File.v Shift_Left_Two_32.v \
		Sign_Extend.v Simple_Single_CPU.v Test_Bench.v
