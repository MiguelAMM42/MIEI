/* $begin barrier */
#include "csapp.h"

static pthread_mutex_t mutex;  
static pthread_cond_t cond;    

static int nthreads;           
static int barriercnt = 0;     

void barrier_init(int n) 
{
    nthreads = n;
    Pthread_mutex_init(&mutex, NULL);
    Pthread_cond_init(&cond, NULL);
}

void barrier() 
{
    Pthread_mutex_lock(&mutex);
    if (++barriercnt == nthreads) {
	barriercnt = 0;
	Pthread_cond_broadcast(&cond);
    }
    else 
	Pthread_cond_wait(&cond, &mutex);
    Pthread_mutex_unlock(&mutex);
}
/* $end barrier */
