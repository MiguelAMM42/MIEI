CC = gcc

CSAPP_INC = ../include
CSAPP_SRC = ../src

CFLAGS = -O2 -Wall -I $(CSAPP_INC) -I .
LDLIBS = -lpthread

FFORCE_CFLAGS = -fforce-mem -Wall -I $(CSAPP_INC)

# NOTE: we expect sharing.c to generate warnings
PROGS =	fragments.o\
	hellobug \
	hello\
	badcnt\
	goodcnt\
	prodcons\
	barrier.o\
	timebomb\
	race\
	norace\
	hellopid\
	forktime\
	threadtime\
	sharing\
	maketimeoutmain\
	rand\
	threadunsafe\

all: $(CSAPP_SRC)/csapp.o $(PROGS)

$(PROGS): $(CSAPP_SRC)/csapp.o 

$(CSAPP_SRC)/csapp.o: $(CSAPP_SRC)/csapp.c $(CSAPP_INC)/csapp.h

# these two programs are compiled with a flag that forces gcc
# to generate RISC-like load, modify, store code for the counter update
goodcnt: goodcnt.c 
	$(CC) $(FFORCE_CFLAGS) -o goodcnt goodcnt.c $(CSAPP_SRC)/csapp.o -lpthread

badcnt: badcnt.c
	$(CC) $(FFORCE_CFLAGS) -o badcnt badcnt.c $(CSAPP_SRC)/csapp.o -lpthread
	$(CC) $(FFORCE_CFLAGS) -S badcnt.c

# these are the programs that need more than one .o file
timebomb: timebomb.c maketimeout.c
maketimeoutmain: maketimeoutmain.c maketimeout_u.c maketimeout_t.c maketimeout_r.c

clean:
	rm -f $(PROGS) *.o *~
