#include "csapp.h"

void fragments() 
{
/* $begin mutexinit */    
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
/* $end mutexinit */    

/* $begin condinit */    
    pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
/* $end condinit */    

/* $begin wait */    
   Pthread_mutex_lock(&mutex);
   Pthread_cond_wait(&cond, &mutex);	
   Pthread_mutex_unlock(&mutex);
/* $end wait */    

/* $begin signal */    
   Pthread_cond_signal(&cond);
/* $end signal */    

}
