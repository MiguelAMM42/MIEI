#ifndef __MEMLIB_H_
#define __MEMLIB_H_

/* $Id$ */

/*
 *  Papadimitriou Spiros
 *  spapadim@cs.cmu.edu
 *
 *  CS213 - Lab assignment 4
 *
 */

#include <unistd.h>


#define DSEG_MAX 20*1024*1024  /* 20 Mb */

extern char *dseg_lo, *dseg_hi;
extern long dseg_size;

extern int mem_init (void);
extern int mem_reinit (long size);
extern void *mem_sbrk (ptrdiff_t increment);
extern int mem_pagesize (void);
extern long mem_usage (void);

/*
 *  Tiankai Tu
 *  tutk@cs.cmu.edu
 *
 *  CS213 - 00 enhancement
 */

extern int mem_copy(char *from, char* to, int size);

#endif /* __MEMLIB_H_ */

