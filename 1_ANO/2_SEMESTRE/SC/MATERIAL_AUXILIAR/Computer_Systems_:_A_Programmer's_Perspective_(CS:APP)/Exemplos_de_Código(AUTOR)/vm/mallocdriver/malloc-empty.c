/* $Id$ */

/*
 *  CS213 - Lab assignment 3
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>

#include "memlib.h"
#include "malloc.h"

team_t team = {
    /* Team name to be displayed on webpage */
    "",
    /* First member full name */
    "",
    /* First member email address */
    "",
    /* Second member full name (leave blank if none) */
    "",
    /* Second member email address (blank if none) */
    ""
};


int mm_init (void)
{
    return -1;
}

void *mm_malloc (size_t size)
{
    return NULL;
}

void mm_free (void *ptr)
{

}

void *mm_realloc(void *ptr,size_t size)
{
  return NULL;
}
