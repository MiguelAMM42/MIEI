/* 
 * echoserverp.c - A concurrent echo server based on processes
 */
/* $begin echoserverpmain */
#include "csapp.h"

void echo(int connfd);

/* SIGCHLD signal handler */
void handler(int sig) 
{
    pid_t pid;
    int stat;
  
    while ((pid = waitpid(-1, &stat, WNOHANG)) > 0)
	;
    return;
}

int main(int argc, char **argv) 
{
    int listenfd, connfd, port, clientlen;
    struct sockaddr_in clientaddr;

    if (argc != 2) {
	fprintf(stderr, "usage: %s <port>\n", argv[0]);
	exit(0);
    }
    port = atoi(argv[1]);

    Signal(SIGCHLD, handler);

    listenfd = open_listenfd(port);
    while (1) {
	clientlen = sizeof(clientaddr);
	connfd = Accept(listenfd, (SA *) &clientaddr, &clientlen);
	if (Fork() == 0) { 
	    Close(listenfd); /* child closes its listening socket */
	    echo(connfd);    /* child services client */
	    Close(connfd);   /* child closes connection with client */
	    exit(0);         /* child exits */
	}
	Close(connfd); /* parent closes connected socket (important!) */
    }
}
/* $end echoserverpmain */
