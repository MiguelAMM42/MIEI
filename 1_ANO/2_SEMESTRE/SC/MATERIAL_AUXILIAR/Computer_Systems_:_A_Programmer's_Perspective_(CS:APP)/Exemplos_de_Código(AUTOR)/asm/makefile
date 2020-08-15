CC = gcc
CPP = cpp
ICS = ..
CFLAGS = -Wall -O2 

PROGS = abs.s\
	absdiff2-ans.s\
	align.s\
	arith.s\
	array.s\
	asmprobs-ans.s\
	bufattack.o\
	bufbomb\
	bufdemo\
        bufovf\
	branch\
	calleesave.s\
	cc.s\
	ctest.s\
	decimal5.s\
	decode1-ans.s\
	decode2-ans.s\
	dw.s\
	exchange.s\
	fcomp-O\
	fcomp-g\
	fcomp-mem\
	fcomp-ld\
	fib.s\
	fixarray.s\
	for.s\
	fp.s\
	fpfunct2-ans.s\
	fpgreater-ans.s\
	frame.s\
	fscale\
	muldiv.s\
	nodestruct.s\
	nodeunion.s\
	nodeuniontag.s\
	okmul\
	pointer\
	prog\
	rect.o\
	shift.s\
	simple-if.s\
	simple.s\
	struct2.s\
	structprob-ans.o\
	structure.s\
	swapadd.s\
	switch-ans.s\
	switch.s\
	switchprob2.s\
	switchbody-ans\
	union.s\
	union2.s\
	varprod-ans.s\
	while.s\


all: $(PROGS)


pointer: pointer.c
	$(CC) -Wall -O2 pointer.c -o pointer
	./pointer > pointer.s
	objdump -d pointer > pointer-exe.d

structprob-ans.o: structprob-ans.c
	$(CC) -Wall -O2 -S structprob-ans.c
	$(CC) -Wall -O2 -c structprob-ans.c
	objdump -d structprob-ans.o > structprob-ans-rel.d

switchbody-ans: switchbody-ans.c
	$(CC) -Wall -O2 -S switchbody-ans.c
	$(CC) -Wall -O2 -c switchbody-ans.c
	$(CC) -Wall -O2 -o switchbody-ans switchbody-ans.c
	objdump -d switchbody-ans.o > switchbody-ans-rel.d
	objdump -d switchbody-ans > switchbody-ans-exe.d

prog: code.c main.c
	$(CC) -Wall -O2 -S code.c
	$(CC) -Wall -O2 -c code.c
	$(CC) $(CFLAGS) -o prog code.o main.c
	objdump -d code.o > code-rel.d
	objdump -d prog > code-exe.d

branch: branch.c
	$(CC) -Wall -O2 -S branch.c
	$(CC) -Wall -O2 -c branch.c
	$(CC) -Wall -O2 -o branch branch.c
	objdump -d branch.o > branch-rel.d
	objdump -d branch > branch-exe.d

bufovf: bufovf.c
	$(CC) -Wall -O2 bufovf.c -o bufovf
	objdump -d bufovf > bufovf-exe.d

bufattack.defs: bufbomb bufattack.gdb
	gdb bufbomb -x bufattack.gdb | perl -ne 's/\$$/#define DEF/;s/=//; print;' | grep define > bufattack.defs

bufattack-rel.d: bufattack-proto.s bufattack.defs
	cat bufattack.defs bufattack-proto.s | $(CPP) -P -C > bufattack.sa
	$(CPP) -P bufattack.sa > bufattack.s
	$(CC) -c bufattack.s
	objdump -d bufattack.o > bufattack-rel.d

bufattack.txt: bufattack-rel.d
	grep ":" bufattack-rel.d | egrep -v "text|file" | perl -ne 's/^.*:\t//g;chomp;s/\t.*//g;s/[ \t]+/ /g;print;' > bufattack.txt

bufbomb: bufbomb.c
	$(CC) -Wall -O2 bufbomb.c -o bufbomb
	objdump -d bufbomb > bufbomb-exe.d

bufbomb-test: bufbomb.c
	$(CC) -Wall -O2 -DTEST_BUF bufbomb.c -o bufbomb-test

bufdemo: bufdemo.c
	$(CC) -Wall -O2 bufdemo.c -o bufdemo
	$(CC) -Wall -O2 -S bufdemo.c

okmul: okmul.c
	$(CC) -Wall -O2 -S okmul.c
	$(CC) -Wall -O2 -o okmul okmul.c

fscale: fscale.c
	$(CC) -Wall -O2 -S fscale.c
	$(CC) -Wall -O2 fscale.c -o fscale

fcomp-O: fcomp.c
	$(CC) -Wall -O2 fcomp.c -o fcomp-O
	./fcomp-O 10 | grep "test1" > fcomp-O.out

fcomp-g: fcomp.c
	$(CC) -Wall -g fcomp.c -o fcomp-g
	./fcomp-g 10 | grep "test1" > fcomp-g.out

fcomp-mem: fcomp.c
	$(CC) -Wall -O2 -mno-fp-ret-in-387 fcomp.c -o fcomp-mem
	./fcomp-mem 10 | egrep "test[12] " > fcomp-mem.out

fcomp-ld: fcomp.c
	$(CC) -Wall -O2 -mno-fp-ret-in-387 fcomp.c -o fcomp-ld
	./fcomp-ld 10 | grep "test3 " > fcomp-ld.out

.c.s:
	$(CC) $(CFLAGS) -S $*.c

.c.o:
	$(CC) $(CFLAGS) -c $*.c

clean:
	rm -f $(PROGS) *.o *~


