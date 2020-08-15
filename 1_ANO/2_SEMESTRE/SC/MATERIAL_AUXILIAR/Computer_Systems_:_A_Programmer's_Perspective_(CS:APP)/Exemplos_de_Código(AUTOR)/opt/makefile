CC = gcc
GFLAGS = -pg 
INC = ../include
CFLAGS = -Wall -O2 -I. -I$(INC)
LIB = ../lib
LIBCSAPP = $(LIB)/libcsapp.a

PROGS = fragments.o\
	twiddle.o\
	swap.o\
	func.o\
	vsum.o\
	strfuns.o\
	inner.o\
	absval.o\
	max.o\
	deref.o\
	combine-ans.o\
	combineprod.o\
	combinesum.o\
	list\
	fact\
	copy\
	inneri\
	isbench\
	ipbench\
	dictionary\
#	lower-linear.out\
#	lower-exp.out\


all: $(PROGS)

# Driver programs that test various modules
copy: copy.o cpe.o $(LIBCSAPP)
	$(CC) $(CFLAGS) copy.o cpe.o $(LIBCSAPP) -o copy

lower-linear.out: lower
	./lower > lower-linear.out

lower-exp.out: lower
	./lower x > lower-exp.out

lower: lower.c $(LIBCSAPP)
	$(CC) $(CFLAGS) lower.c $(LIBCSAPP) -o lower

list: list.o  cpe.o $(LIBCSAPP)
	$(CC) $(CFLAGS)  list.o  cpe.o $(LIBCSAPP) -o list

fact: fact.o  cpe.o $(LIBCSAPP)
	$(CC) $(CFLAGS)  fact.o  cpe.o $(LIBCSAPP) -o fact

inneri: cpe.c $(INC)/lsquare.h cpe.h vec.h inner.h inner.c innerbench.c vec.c $(LIBCSAPP)
	$(CC) $(CFLAGS) -DINT  -o inneri inner.c innerbench.c vec.c \
	cpe.o  $(LIBCSAPP)
	#
	$(CC) $(CFLAGS) -c inner.c
	$(CC) $(CFLAGS) -S inner.c

isbench: cpe.o  cpe.h vec.h combine.h combine.c benchmark.c \
	vec.c $(LIBCSAPP)
	$(CC) $(CFLAGS) -DSUM -DINT -o isbench benchmark.c combine.c vec.c \
	cpe.o  $(LIBCSAPP)
	#
	$(CC) $(CFLAGS) -DSUM -DINT -S combinesum.c

ipbench: $(LIBCSAPP) cpe.o  cpe.h vec.h combine.h combine.c benchmark.c \
	vec.c combineprod.c
	$(CC) $(CFLAGS) -DPROD -DINT -o ipbench benchmark.c combine.c vec.c \
	cpe.o $(LIBCSAPP) 
	#
	$(CC) $(CFLAGS) -DPROD -DINT -S combineprod.c


absval.o: absval.c
	$(CC) $(CFLAGS) -c absval.c
	$(CC) $(CFLAGS) -S absval.c

deref.o: deref.c
	$(CC) $(CFLAGS) -c deref.c
	$(CC) $(CFLAGS) -S deref.c

combine-ans.o: combine-ans.c
	$(CC) $(CFLAGS) -c combine-ans.c
	$(CC) $(CFLAGS) -S combine-ans.c

options.o: options.c options.h
	$(CC) $(CFLAGS) -c options.c

dictionary: dictionary.c options.o
	$(CC) $(CFLAGS) dictionary.c options.o -o dictionary

dictionary-pg: dictionary.c options.c
	$(CC) $(CFLAGS) $(GFLAGS) dictionary.c options.c -o dictionary-pg

clean:
	rm -f $(PROGS) *.o *~



