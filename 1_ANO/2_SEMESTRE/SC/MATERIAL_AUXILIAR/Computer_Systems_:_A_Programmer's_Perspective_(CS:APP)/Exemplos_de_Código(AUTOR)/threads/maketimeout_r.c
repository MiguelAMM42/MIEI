/*
 * maketimeout_r - reentrant and thread-safe
 */
/* $begin maketimeoutr */
#include "csapp.h"

struct timespec *maketimeout_r(struct timespec *tp, int secs) 
{ 
    struct timeval now; 

    gettimeofday(&now, NULL); 
    tp->tv_sec = now.tv_sec + secs; 
    tp->tv_nsec = now.tv_usec * 1000; 
    return tp; 
} 
/* $end maketimeoutr */
