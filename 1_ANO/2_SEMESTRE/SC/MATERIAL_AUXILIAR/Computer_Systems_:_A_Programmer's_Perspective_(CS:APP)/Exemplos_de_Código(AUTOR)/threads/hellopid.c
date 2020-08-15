/* $begin hellopid */
#include "csapp.h"

void *thread(void *vargp);

int main() 
{
    pthread_t tid;

    printf("Hello from main thread!  tid:%ld pid:%d\n", 
	   pthread_self(), getpid());
    Pthread_create(&tid, NULL, thread, NULL);
    Pthread_join(tid, NULL);
    exit(0);
}

/* thread routine */
void *thread(void *vargp) 
{
    printf("Hello from child thread! tid:%ld pid:%d ppid:%d\n", 
	   pthread_self(), getpid(), getppid());
    return NULL;
}
/* $end hellopid */ 


