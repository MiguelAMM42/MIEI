/* 
 * beep - simple example to show that threads are independent flows
 */
#include "csapp.h"

void *thread(void *vargp);

char shared = 0;

int main() 
{
    pthread_t tid;

    Pthread_create(&tid, NULL, thread, NULL);
    while (shared == 0) {
	printf("BEEP\n");
	sleep(1);
    }
    Pthread_join(tid, NULL);
    printf("DONE\n");
    exit(0);
}

/* thread routine */
void *thread(void *vargp) 
{
    shared = getchar();
    return NULL;
}

