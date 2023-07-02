//main.cpp
#include <stdio.h>
#include "add_nbo.h"

int main(int argc,char *argv[]){
	char *filename = argv[1];
	char *filename2 = argv[2];

	uint32_t sum = add_nbo(filename,filename2);

	return sum;
}


