CC = gcc
CFLAGS = -O2 -Wall
INC = ../include
LIB = ../lib

OBJS = clock.o fcyc.o csapp.o lsquare.o

targ: $(LIB)/libcsapp.a

# This file must be compiled with gcc due to embedded assembly
clock.o: clock.c $(INC)/clock.h
	gcc $(CFLAGS) -c clock.c -I$(INC)

fcyc.o: fcyc.c $(INC)/fcyc.h $(INC)/clock.h
	$(CC) $(CFLAGS) -c fcyc.c -I$(INC)

csapp.o: $(INC)/csapp.h csapp.c
	$(CC) $(CFLAGS) -c csapp.c -I$(INC)

lsquare.o: $(INC)/lsquare.h lsquare.c
	$(CC) $(CFLAGS) -c lsquare.c -I$(INC)

$(LIB)/libcsapp.a: $(OBJS)
	ar rcs $(LIB)/libcsapp.a $(OBJS)
