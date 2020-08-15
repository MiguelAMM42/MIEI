CC=gcc
CFLAGS=-Wall -O2
LEX = flex
LEXLIB = -lfl
YAS=./yas

.SUFFIXES:
.SUFFIXES: .c .s .o .ys .yo

files: asum.yo asum.yis asum.yuc

yas-grammar.c: yas-grammar.lex
	$(LEX) yas-grammar.lex
	mv lex.yy.c yas-grammar.c

isa.o: isa.c isa.h
	$(CC) $(CFLAGS) -c isa.c

yas.o: yas.c yas.h isa.h
	$(CC) $(CFLAGS) -c yas.c

yas: yas.o yas-grammar.c isa.o
	$(CC) $(CFLAGS) yas-grammar.c yas.o isa.o ${LEXLIB} -o yas

yis.o: yis.c isa.h
	$(CC) $(CFLAGS) -c yis.c

yis: yis.o isa.o
	$(CC) $(CFLAGS) yis.o isa.o -o yis

ucode.o: ucode.c uc.h
	$(CC) $(CFLAGS) -c ucode.c

ucheck.o: ucheck.c uc.h
	$(CC) $(CFLAGS) -c ucheck.c

ucas.o: ucas.c uc.h
	$(CC) $(CFLAGS) -c ucas.c

uc-grammar.c: uc-grammar.lex uc.h
	$(LEX) uc-grammar.lex
	mv lex.yy.c uc-grammar.c

uc-grammar.o: uc-grammar.c uc.h
	$(CC) $(CFLAGS) -c uc-grammar.c

ucheck: ucheck.o ucas.o uc-grammar.o ucode.o
	$(CC) $(CFLAGS) -o ucheck ucheck.o ucas.o uc-grammar.o ucode.o

yuc.o: yuc.c isa.h uc.h
	$(CC) $(CFLAGS) -c yuc.c

yuc: yuc.o ucode.o isa.o ucas.o uc-grammar.o
	$(CC) $(CFLAGS) -o yuc yuc.o ucode.o isa.o ucas.o uc-grammar.o

asum.yis: asum.yo
	./yis asum.yo > asum.yis

asum.yuc: asum.yo y86.uc
	./yuc asum.yo y86.uc > asum.yuc

.c.s:
	$(CC) $(CFLAGS) -S $*.c

.ys.yo:
	$(YAS) $*.ys

