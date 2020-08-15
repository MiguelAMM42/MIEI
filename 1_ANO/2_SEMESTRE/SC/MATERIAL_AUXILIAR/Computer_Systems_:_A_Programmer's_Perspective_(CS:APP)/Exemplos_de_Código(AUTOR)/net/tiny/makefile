CC = gcc
ARGS = -O2 -Wall -I ../../include

all: tiny

tiny: tiny.c ../../src/csapp.o
	$(CC) $(ARGS) -o tiny tiny.c ../../src/csapp.o -lpthread

clean:
	rm -f *.o tiny *~

