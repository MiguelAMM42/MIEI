#include <csapp.h>

void *thread(void *);

int main(int argc, char **argv) {
  int i, niters;
  pthread_t tid;

  if (argc != 2) {
    printf("usage: %s: <niters>\n", argv[0]);
    exit(0);
  }
  niters = atoi(argv[1]);

  for (i=0; i<niters; i++) {
    Pthread_create(&tid, NULL, thread, NULL);
    Pthread_join(tid, NULL);
  }
  exit(0);
}

void *thread(void *vargp) {
  return NULL;
}
