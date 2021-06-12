all: run1 run2 run3

compile:
	iverilog -o cpu ALU.v ALU_Ctrl.v Adder.v Decoder.v Instr_Memory.v \
		MUX_2to1.v ProgramCounter.v Reg_File.v Shift_Left_Two_32.v \
		Sign_Extend.v Simple_Single_CPU.v Test_Bench.v

run1:
	cat testcase1.txt | tr -d ' ' | awk '/./' > testcase.txt
	@make run

run2:
	cat testcase2.txt | tr -d ' ' | awk '/./' > testcase.txt
	@make run

run3:
	cat testcase3.txt | tr -d ' ' | awk '/./' > testcase.txt
	@make run

run:
	perl -pe 's/(reg \[32\-1:0\] Instr_Mem \[0:)\d+\-1\];/$${1}'"$$(cat testcase.txt | wc -l | tr -d ' ')"'-1];/' -i Instr_Memory.v
	@make compile
	./cpu

pack:
	7z a 0816146.zip ALU.v ALU_Ctrl.v Adder.v Decoder.v Instr_Memory.v \
		MUX_2to1.v ProgramCounter.v Reg_File.v Shift_Left_Two_32.v \
		Sign_Extend.v Simple_Single_CPU.v Test_Bench.v report.pdf
