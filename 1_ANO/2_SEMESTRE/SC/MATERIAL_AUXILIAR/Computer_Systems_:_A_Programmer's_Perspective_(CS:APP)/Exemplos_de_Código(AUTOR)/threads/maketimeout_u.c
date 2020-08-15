/*
 * maketimeout_u: not thread-safe
 */
/* $begin maketimeoutu */
#include "csapp.h"

struct timespec *maketimeout_u(int secs) 
{ 
    static struct timespec timespec;
    struct timeval now; 

    gettimeofday(&now, NULL); 
    timespec.tv_sec = now.tv_sec + secs; 
    timespec.tv_nsec = now.tv_usec * 1000; 
    return &timespec; 
} 
/* $end maketimeoutu */
