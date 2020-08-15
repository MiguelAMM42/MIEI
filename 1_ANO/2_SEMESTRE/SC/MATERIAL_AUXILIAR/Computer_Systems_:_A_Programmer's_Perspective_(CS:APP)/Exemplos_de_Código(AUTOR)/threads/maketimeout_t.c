/*
 * maketimeout_t: thread-safe but not reentrant
 */
/* $begin maketimeoutt */
#include "csapp.h"
struct timespec *maketimeout_u(int secs);

static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

struct timespec *maketimeout_t(int secs) 
{ 
    struct timespec *sp; /* shared */
    struct timespec *up = Malloc(sizeof(struct timespec)); /* unshared */
    
    Pthread_mutex_lock(&mutex);
    sp = maketimeout_u(secs);
    *up = *sp;    /* copy the shared struct to the unshared one */
    Pthread_mutex_unlock(&mutex);
    return up;
} 
/* $end maketimeoutt */
