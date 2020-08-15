/* 
 * timebomb - explodes if the user doesn't hit a key in 5 seconds
 */ 
/* $begin timebomb */
#include "csapp.h"

#define TIMEOUT 5

void *thread(void *vargp);
struct timespec *maketimeout(struct timespec *tp, int secs);

pthread_cond_t cond;
pthread_mutex_t mutex;
pthread_t tid;

int main() 
{
    int i, rc;
    struct timespec timeout;

    Pthread_cond_init(&cond, NULL);
    Pthread_mutex_init(&mutex, NULL);

    Pthread_mutex_lock(&mutex);
    Pthread_create(&tid, NULL, thread, NULL);
    for (i=0; i<TIMEOUT; i++) {
	printf("BEEP\n");
	rc = pthread_cond_timedwait(&cond, &mutex, 
				    maketimeout(&timeout, 1));
	if (rc != ETIMEDOUT) {
	    printf("WHEW!\n");
	    exit(0);
	}
    }
    printf("BOOM!\n");
    exit(0);
}

/* thread routine */
void *thread(void *vargp) 
{
    getchar();
    Pthread_mutex_lock(&mutex);
    Pthread_cond_signal(&cond);
    Pthread_mutex_unlock(&mutex);
    return NULL;
}
/* $end timebomb */
