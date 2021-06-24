all: compile run

compile:
	g++ --std=c++14 -Wall -Wextra -Wconversion -o cache_simulator direct_map_cache.cpp

run:
	./cache_simulator -f Trace1.txt -c 1 -b 32 -a 2
	./cache_simulator -f Trace.txt -c 8 -b 32 -a 2 -d 3
