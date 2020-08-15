/* 
 * echoservert.c - A concurrent echo server using threads
 */
/* $begin echoservertmain */
#include "csapp.h"

void echo_r(int connfd);
void *thread(void *vargp);

int main(int argc, char **argv) 
{
    int listenfd, *connfdp, port, clientlen;
    struct sockaddr_in clientaddr;
    pthread_t tid; 

    if (argc != 2) {
	fprintf(stderr, "usage: %s <port>\n", argv[0]);
	exit(0);
    }
    port = atoi(argv[1]);

    listenfd = open_listenfd(port);
    while (1) {
	clientlen = sizeof(clientaddr);
	connfdp = Malloc(sizeof(int));
	*connfdp = Accept(listenfd, (SA *) &clientaddr, &clientlen);
	Pthread_create(&tid, NULL, thread, connfdp);
    }
}

/* thread routine */
void *thread(void *vargp) 
{  
    int connfd = *((int *)vargp);

    Pthread_detach(pthread_self()); 
    Free(vargp);
    
    echo_r(connfd); /* reentrant version of echo() */
    Close(connfd);
    return NULL;
}
/* $end echoservertmain */
