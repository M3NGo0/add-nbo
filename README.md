# add-nbo

```
syntax : add-nbo <file1> <file2>
sample : add-nbo a.bin b.bin

# example
$ echo -n -e \\x00\\x00\\x03\\xe8 > thousand.bin
$ echo -n -e \\x00\\x00\\x01\\xf4 > five-hundred.bin
$ ./add-nbo thousand.bin five-hundred.bin
1000(0x3e8) + 500(0x1f4) = 1500(0x5dc)

```


## add_nbo.h
```
#pragma once
#include <cstdint>

uint32_t add_nbo(char *filename,char *filename2);
```

## add_nbo.cpp
```
#include <stdio.h>
#include <stdint.h>
#include <arpa/inet.h>
#include "add_nbo.h"

uint32_t add_nbo(char *filename,char *filename2){
	FILE *fp1,*fp2;
	uint32_t thousand,fiveHundred;

	fp1 = fopen(filename,"rb");
	fp2 = fopen(filename2,"rb");

	if(fp1 == NULL | fp2 == NULL ) {
		printf("file not open");
		return 1;
	}
	if(fread(&thousand, sizeof(uint32_t), 1, fp1) != 1 || fread(&fiveHundred, sizeof(uint32_t), 1, fp2) != 1) {
        printf("file not read\n");
        return 1;
    	}
	
	fclose(fp1);
	fclose(fp2);


	thousand = ntohl(thousand);
	fiveHundred = ntohl(fiveHundred);

	uint32_t sum = thousand + fiveHundred;

	printf("%d(0x%x) + %d(0x%x) = %d(0x%x)\n", thousand, thousand, fiveHundred, fiveHundred, sum, sum);
	return sum;
}
```

## main.cpp
```
//main.cpp
#include <stdio.h>
#include "add_nbo.h"

int main(int argc,char *argv[]){
	char *filename = argv[1];
	char *filename2 = argv[2];

	uint32_t sum = add_nbo(filename,filename2);

	return sum;
}
```

## Makefile
```
#Makefile
all: add-nbo

add-nbo:add_nbo.o main.o
	g++ -o add-nbo add_nbo.o main.o

main.o: add_nbo.h main.cpp
	g++ -c -o main.o main.cpp

add_nbo.o: add_nbo.h add_nbo.cpp
	g++ -c -o add_nbo.o add_nbo.cpp

clean:
	rm -f add-nbo
	rm -f *.o
```
