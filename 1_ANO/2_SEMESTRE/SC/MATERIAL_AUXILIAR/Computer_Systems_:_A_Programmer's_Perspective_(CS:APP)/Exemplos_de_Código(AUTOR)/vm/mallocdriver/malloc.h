#ifndef __MALLOC_H_
#define __MALLOC_H_

/* $Id$ */

/*
 * Fall 00 - CS213 - Lab assignment 4 
 *
 */

#include <stdio.h>

extern int mm_init (void);
extern void *mm_malloc (size_t size);
extern void mm_free (void *ptr);
extern void *mm_realloc(void *ptr,size_t size);


/* Team information */
typedef struct {
    char *team;
    char *name1, *email1;
    char *name2, *email2;
} team_t;

extern team_t team;


#endif /* __MALLOC_H_ */

