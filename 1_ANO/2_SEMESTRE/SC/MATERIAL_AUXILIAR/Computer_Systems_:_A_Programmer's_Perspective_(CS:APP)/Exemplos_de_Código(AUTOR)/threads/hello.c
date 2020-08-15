/* 
 * hello.c - Pthreads "hello, world" program 
 */
/* $begin hello */
#include "csapp.h"

void *thread(void *vargp);

int main() 
{
    pthread_t tid;

    Pthread_create(&tid, NULL, thread, NULL);
    Pthread_join(tid, NULL);
    exit(0);
}

/* thread routine */
void *thread(void *vargp) 
{
    printf("Hello, world!\n"); 
    return NULL;
}
/* $end hello */
