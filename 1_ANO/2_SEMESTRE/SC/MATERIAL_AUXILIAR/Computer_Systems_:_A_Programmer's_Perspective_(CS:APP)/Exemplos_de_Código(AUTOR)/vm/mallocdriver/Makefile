##############################################################################
##
##
##  GNU Makefile for 
##  Lab assignment 4 (CS213, Fall 2000)
##
##  Note:  You need to use 'gmake' instead of 'make'
##
##############################################################################

NAME=unknown
VERSION=1
GPROF=

ASSTDIR=/afs/cs.cmu.edu/academic/class/15213-f00/L4

# Uncomment only one of the following three:
DEFINES=-DLINUX
#DEFINES=-DALPHA
#DEFINES=

CC=gcc

#
# uncomment one of the two lines below
#
CFLAGS=-Wall $(GPROF) -g $(DEFINES)
#CFLAGS=-Wall -O2 $(DEFINES)
#
#
CPP=gcc -E

INCDIR=
LIBDIR=

LIBS=

OBJS=ftime.o memlib.o malloc.o driver.o dump.o

##############################################################################

all: all-target

ifeq (Makefile.depend, $(wildcard Makefile.depend))
include Makefile.depend
all-target: malloc
else
all-target: depend
	@echo Please run make once again!
endif

##############################################################################

malloc: $(OBJS)
	$(CC) $(CFLAGS) $(INCDIR) $(LIBDIR) $(OBJS) $(LIBS) -o malloc

.c.o:
	$(CC) $(CFLAGS) $(INCDIR) $(LIBDIR) -c -o $*.o $<

depend dep:
	@echo Generating dependencies...
	$(CPP) -M $(CPPFLAGS) $(INCDIR) *.c >Makefile.depend

edclean:
	-rm -f *.bak *~

clean: edclean
	-rm -f $(OBJS) core
	-rm -f Makefile.depend

nuke: clean
	-rm -f malloc

##############################################################################

handin:
	cp malloc.c $(ASSTDIR)/handin/malloc-$(NAME)-$(VERSION).c

update:
	cp malloc.c $(ASSTDIR)/web/submit/malloc-$(NAME).c





