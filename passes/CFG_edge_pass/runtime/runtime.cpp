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

using namespace std;

#define MAX_BYTE_NUM 1024 * 1024 * 100
#define MAX_MAP_SIZE 1024 * 1024 * 100

bool hashmap[MAX_MAP_SIZE];

uint32_t Bbprofile_prev_loc;

extern "C"{
    #define BBNumber(X) PrintSth_##X

	char bbseq[MAX_BYTE_NUM];

	int bbindex = 0; 

	static void outputResult(){
		write(1, bbseq, bbindex);
	}


	void inline storeStr(const char* cur_str){

		if(bbindex + strlen(cur_str) >= MAX_BYTE_NUM){
			outputResult(); 
			bbindex = 0; 
		}

		strcpy(bbseq + bbindex, cur_str);
		bbindex += strlen(cur_str);	
		strcpy(bbseq + bbindex, "|");
		bbindex++;
	}

	void BBNumber(num)(int prev_loc_init, int cur_num){

		// here, check if it exists in hashmap
		if (hashmap[(prev_loc_init^cur_num) % MAX_MAP_SIZE] == false){

			std::string xor_s = std::to_string(prev_loc_init^cur_num);

			hashmap[(prev_loc_init^cur_num) % MAX_MAP_SIZE] = true;
	
			storeStr(xor_s.c_str());

		}

	}

	static void(*exit_output_result)()
	__attribute__((section(".fini_array"), used)) = outputResult;			
}
