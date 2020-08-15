CC = gcc

CSAPP_INC = ../include
CSAPP_SRC = ../src

CFLAGS = -Wall -O2 -I $(CSAPP_INC) -I .
LDLIBS = -lpthread

PROGS =	fragments.o\
	echoclient\
	echoserveri\
	echoserverp\
	echoservert\
	echoservers\
	hostinfo\
	cpstdin\
	cpfile\
	hex2dd\
	dd2hex\

all: $(CSAPP_SRC)/csapp.o $(PROGS)

$(PROGS): $(CSAPP_SRC)/csapp.o

$(CSAPP_SRC)/csapp.o: $(CSAPP_SRC)/csapp.c $(CSAPP_INC)/csapp.h

# these are the programs that need more than .o file
echoserveri: echoserveri.o echo.o
echoserverp: echoserverp.o echo.o
echoservert: echoservert.o echo_r.o

clean:
	rm -f $(PROGS) *.o *~
