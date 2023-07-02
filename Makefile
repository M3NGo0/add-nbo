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
