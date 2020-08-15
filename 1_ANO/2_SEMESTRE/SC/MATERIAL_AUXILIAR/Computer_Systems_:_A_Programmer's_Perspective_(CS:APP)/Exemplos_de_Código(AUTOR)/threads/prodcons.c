/* buf1.c - producer-consumer on a scalar variable */
/* $begin prodconsmain */
#include "csapp.h"

#define NITERS 5

void *producer(void *arg), *consumer(void *arg);

struct {
  int buf;           /* shared variable */
  sem_t full, empty; /* semaphores */
} shared;


int main() 
{
  pthread_t tid_producer, tid_consumer;

  /* initialize the semaphores */
  Sem_init(&shared.empty, 0, 1); 
  Sem_init(&shared.full,  0, 0);

  /* create threads and wait for them to finish */
  Pthread_create(&tid_producer, NULL, producer, NULL);
  Pthread_create(&tid_consumer, NULL, consumer, NULL);
  Pthread_join(tid_producer, NULL);
  Pthread_join(tid_consumer, NULL);
  
  exit(0);
}
/* $end prodconsmain */

/* $begin prodconsfuns */
/* producer thread */
void *producer(void *arg) 
{
  int i, item;

  for (i=0; i<NITERS; i++) {
    /* produce item */
    item = i;
    printf("produced %d\n", item);

    /* write item to buf */
    P(&shared.empty);
    shared.buf = item;
    V(&shared.full);
  }
  return NULL;
}

/* consumer thread */
void *consumer(void *arg) 
{
  int i, item;

  for (i=0; i<NITERS; i++) {
    /* read item from buf */
    P(&shared.full);
    item = shared.buf;
    V(&shared.empty);

    /* consume item */
    printf("consumed %d\n", item);
  }
  return NULL;
}
/* $end prodconsfuns */
