#include <iostream>
#include <getopt.h>
#include <sstream>
#include <string>
#include <cmath>

#define K 1024

using namespace std;

void simulate(const int cache_size, const int block_size, const unsigned assoc, const string& testcase, const int prec);

int main(const int argc, char** argv) {
	int block_size = 16;
	int cache_size = 4;
	unsigned assoc = 1;
	string testcase;
	int prec = -1;
	int opt;
	while ((opt = getopt(argc, argv, "a:b:c:f:p:")) != EOF) {
		switch (opt) {
			case 'a':
				assoc = (unsigned) atoi(optarg);
				break;
			case 'b':
				block_size = atoi(optarg);
				break;
			case 'c':
				cache_size = atoi(optarg);
				break;
			case 'f':
				testcase = string(optarg);
				break;
			case 'p':
				prec = atoi(optarg);
				break;
		}
	}

	simulate(cache_size*K, block_size, assoc, testcase, prec);
}

struct cache_content {
	bool v;
	unsigned int tag, ts;
};

void simulate(const int cache_size, const int block_size, const unsigned assoc, const string& testcase, const int prec) {
	unsigned tag, base, x, k, old, cnt=0, cnt0=0;
	const int offset_bit = (int) log2(block_size);
	const int cache_bit = (int) log2(cache_size);
	const int index_bit = cache_bit - offset_bit;
	const int line = cache_size >> offset_bit;
	const int assoc_bit = (int) log2(assoc);
	FILE *fp = fopen(testcase.c_str(), "r");
	stringstream ss1, ss0;

	if (!fp) {
		cerr << "Test file '" << testcase << "' doesn't exist\n";
		return;
	}

	cache_content *cache = new cache_content[(size_t) line];

	for (int j=0; j<line; j++)
		cache[j].v = false;

	while (fscanf(fp, "%x", &x) != EOF) {
		base = ((x >> (offset_bit)) & (size_t) ((1 << (index_bit - assoc_bit)) - 1)) * assoc;
		tag = x >> (index_bit - assoc_bit + offset_bit);

		for (k=0; k<assoc; k++) {
			if (cache[base | k].v && cache[base | k].tag == tag) {
				cache[base | k].ts = cnt;
				ss1 << ", " << ++cnt;
				break;
			}
		}
		if (k != assoc)
			continue;

		ss0 << ", " << ++cnt;
		cnt0++;

		for (k=0; k<assoc; k++) {
			if (!cache[base | k].v) {
				cache[base | k].tag = tag;
				cache[base | k].v = true;
				cache[base | k].ts = cnt;
			}
		}
		if (k != assoc)
			continue;

		for (old=0, k=1; k<assoc; k++)
			if (cache[base | old].ts > cache[base | k].ts)
				old = k;

		cache[base | old].tag = tag;
		cache[base | old].ts = cnt;
	}
	fclose(fp);

	ss0.seekp(0, ss0.beg);  ss0 << ':';
	ss1.seekp(0, ss0.beg);  ss1 << ':';

	if (prec == -1) {
		cout << "Miss rate: " << (cnt0 * 100 / cnt) << "%\n";
		cout << "Hits instructions" << ss1.str() << '\n';
		cout << "Misses instructions" << ss0.str() << '\n';
	} else {
		double ans = cnt0 * 100 / (double) cnt;
		cout.precision(prec);
		cout << ans << '\n';
	}

	delete[] cache;
}
