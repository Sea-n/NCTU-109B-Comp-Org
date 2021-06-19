#include <iostream>
#include <string>
#include <cmath>
#include <cgetopt>

using namespace std;

struct cache_content {
	bool v;
	unsigned int tag;
	// unsigned int data[16];
};

const int K = 1024;

void simulate(int cache_size, int block_size, int asso, string& test_file_name){
	FILE *fp = fopen(test_file_name.c_str(), "r");  // read file

	if (!fp) {
		cout << "Test file doesn't exist\n";
		return;
	}

	unsigned int tag, index, x;

	int offset_bit = (int) log2(block_size);
	int index_bit = (int) log2(cache_size/block_size);
	int line = (cache_size >> offset_bit);

	cache_content *cache = new cache_content[line];
	cout << "cache line: " << line << endl;

	for (int j=0; j<line; j++)
		cache[j].v = false;

	while (fscanf(fp, "%x", &x) != EOF) {
		cout << hex << x << ' ';
		index = (x>>offset_bit) & (line-1);
		tag = x >> (index_bit+offset_bit);
		if (cache[index].v && cache[index].tag == tag) {
			cache[index].v = true;  // hit
		}
		else{
			cache[index].v = true;  // miss
			cache[index].tag = tag;
		}
	}
	fclose(fp);

	delete[] cache;
}

int main(int argc, char** argv) {
	string test_file_name;
	int cache_size = 4;
	int block_size = 16;
	int associativity = 1;
	int current_option;
	while ((current_option = getopt(argc, argv, "f:c:b:a:")) != EOF) {
		switch (current_option) {
			case 'f':
				test_file_name = string(optarg);
				break;
			case 'c':
				cache_size = atoi(optarg);
				break;
			case 'b':
				block_size = atoi(optarg);
				break;
			case 'a':
				associativity = atoi(optarg);
				break;
		}
	}

	// default simulate 4KB direct map cache with 16B blocks
	simulate(cache_size*K, block_size, associativity, test_file_name);
}
