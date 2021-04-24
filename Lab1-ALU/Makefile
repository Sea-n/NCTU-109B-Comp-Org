all: compile run

compile:
	iverilog -o alu ha.v fa.v alu_top.v alu.v testbench.v

run:
	python3 gen.py
	./alu

pack:
	7z a 0816146.zip ha.v fa.v alu_top.v alu.v testbench.v report.pdf
