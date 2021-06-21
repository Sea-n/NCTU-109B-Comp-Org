all: run1

compile:
	iverilog -o cpu ALU.v ALU_Ctrl.v Adder.v Data_Memory.v Decoder.v \
		Forwarding.v Hazard.v Instr_Memory.v MUX_2to1.v MUX_4to1.v Pipe_CPU.v \
		Pipe_Reg.v ProgramCounter.v Reg_File.v Shift_Left_Two_32.v \
		Sign_Extend.v testbench.v

run1:
	cat testcase1.txt | tr -d ' ' | awk '/./' > testcase.txt
	@make run

run:
	perl -pe 's/(reg \[32\-1:0\] Instr_Mem \[0:)\d+\-1\];/$${1}'"$$(cat testcase.txt | wc -l | tr -d ' ')"'-1];/' -i Instr_Memory.v
	@make compile
	./cpu
	@echo

pack:
	7z a 0816146.zip ALU.v ALU_Ctrl.v Adder.v Data_Memory.v Decoder.v \
		Forwarding.v Hazard.v Instr_Memory.v MUX_2to1.v MUX_4to1.v Pipe_CPU.v \
		Pipe_Reg.v ProgramCounter.v Reg_File.v Shift_Left_Two_32.v \
		Sign_Extend.v testbench.v report.pdf
