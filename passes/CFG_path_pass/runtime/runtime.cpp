#include <stdio.h>
#include <stdlib.h>
#include <iostream> 
#include <cstdint>
#include <vector>
#include <set>
#include <map>
#include <list> 
#include <iterator> 
#include <unistd.h>
#include <string.h>
#include <unordered_map>

using namespace std;

//#define MAX_BYTE_NUM 1024 * 1024 * 100
#define MAX_MAP_SIZE 1024 * 64 *8

int hashmap[MAX_MAP_SIZE] = {0};

int hash_res = 0;

uint32_t Bbprofile_prev_loc;

extern "C"{
    #define BBNumber(X) PrintSth_##X



/*MAP 1，2-3，4-7， 8-15， 16-31，32-63，63-127，128-255，256-Max: 

	Convert Decimal to Byte(Binary digit cap);

*/
	static unsigned char count_class_lookup8[] = {
		0,
		1,
		2,
		4,
		8,8,8,8,
		16,16,16,16,16,16,16,16,
		32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,
		64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,
		128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128
	};

	int hashint(int value){
		value *= 1664525;
		value += 1013904223;
		value ^= unsigned(value) >> 12;
		value ^= value << 25;
		value ^= unsigned(value) >> 27;
		value *= 1103515245;
		value += 12345;
		return value;
	}

/* Exit function:
	
	hash = hash ^ edge(index) ^ edge_count(after mapping)

*/
	static void outputResult(){

		for(size_t i = 0; i < sizeof(hashmap)/sizeof(hashmap[0]); ++i){

			if (hashmap[i] != 0){
				//Hash: map the index to a fixed ranom number in the 32 bit space
				//Also consider the value in the cell indicated by the index
				hash_res = hash_res ^ hashint(i)  ^  hashint(count_class_lookup8[hashmap[i] % 256]); 
			}
		
		}
 
		printf("PATHNUM%d\n", hash_res);
	}




/* edge:counts*/

	void BBNumber(num)(int prev_loc_init, int cur_num){
		//pre_BB ^ cur_BB to obtain cur_edge
		int cur_edge = prev_loc_init ^ cur_num;
		//edge counts
		++hashmap[cur_edge % MAX_MAP_SIZE];			
	
	}

	static void(*exit_output_result)()
	__attribute__((section(".fini_array"), used)) = outputResult;			
}
