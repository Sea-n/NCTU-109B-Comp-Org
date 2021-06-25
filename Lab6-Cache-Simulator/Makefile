all: clean compile run pack

compile:
	g++ --std=c++14 -Wall -Wextra -Wconversion -o cache_simulator cache_simulator.cpp
	chmod u+x plot.py

run:
	./cache_simulator -f Trace1.txt -c 1 -b 32 -a 2
	./cache_simulator -f Trace.txt -c 8 -b 32 -a 2 -p 3
	./plot.py

clean:
	-rm cache_simulator
	-rm figure[12].png figure3-*.png

pack:
	7z a 0816146.zip cache_simulator.cpp Makefile plot.py report.pdf Trace.txt Trace1.txt
