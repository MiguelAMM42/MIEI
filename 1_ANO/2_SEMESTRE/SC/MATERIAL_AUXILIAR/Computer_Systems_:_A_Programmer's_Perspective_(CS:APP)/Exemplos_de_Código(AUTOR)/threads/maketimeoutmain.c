/*
 * maketimeoutmain - driver for different maketime_* versions
 */
#include "csapp.h"

struct timespec *maketimeout_u(int secs);
struct timespec *maketimeout_t(int secs); 
struct timespec *maketimeout_r(struct timespec *tp, int secs);

int main() 
{
    struct timespec timespec;
    struct timespec *tuptr, *ttptr, *trptr;

    tuptr = maketimeout_u(5);
    ttptr = maketimeout_t(5);
    trptr = maketimeout_r(&timespec, 5);
    printf("utime: %ld:%ld  ttime: %ld:%ld  rtime: %ld:%ld\n",
	   tuptr->tv_sec, tuptr->tv_nsec,
	   ttptr->tv_sec, ttptr->tv_nsec,
	   trptr->tv_sec, trptr->tv_nsec);
    exit(0);
}
