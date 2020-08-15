/* 
 * echoservers.c - A concurrent echo server based on select
 */
/* $begin echoserversmain */
#include "csapp.h"

typedef struct {
    int maxfd;         /* max descriptor in allset */   
    fd_set allset;     /* set of all active descriptors */
    fd_set rset;       /* subset of ready descriptors */
    int nready;        /* number of ready descriptors from select */   

    int maxi;                /* highwater index into client array */
    int client[FD_SETSIZE];  /* set of active connfd descriptors */
} pool;

void init_pool(int listenfd, pool *p);
void add_client(int connfd, pool *p);
void check_clients(pool *p);

int main(int argc, char **argv) 
{
    int listenfd, connfd, port, clientlen;
    struct sockaddr_in clientaddr;
    pool pool; 

    if (argc != 2) {
	fprintf(stderr, "usage: %s <port>\n", argv[0]);
	exit(0);
    }
    port = atoi(argv[1]);

    listenfd = open_listenfd(port);
    init_pool(listenfd, &pool); 
    while (1) {
	pool.rset = pool.allset;
	pool.nready = Select(pool.maxfd+1, &pool.rset, NULL, NULL, NULL);

	if (FD_ISSET(listenfd, &pool.rset)) { /* add new client */ 
	    clientlen = sizeof(clientaddr);
	    connfd = Accept(listenfd, (SA *)&clientaddr, &clientlen);
	    add_client(connfd, &pool);
	}
	check_clients(&pool); /* check existing clients */
    }
}
/* $end echoserversmain */

/* $begin init_pool */
void init_pool(int listenfd, pool *p) 
{
    int i;

    p->maxi = -1;        
    p->maxfd = listenfd; 
    for (i=0; i< FD_SETSIZE; i++)
	p->client[i] = -1; 
    FD_ZERO(&p->allset);
    FD_SET(listenfd, &p->allset);
}
/* $end init_pool */

/* $begin add_client */
void add_client(int connfd, pool *p) 
{
    int i;

    p->nready--;
    for (i=0; i<FD_SETSIZE; i++)
	if (p->client[i] < 0) {
	    p->client[i] = connfd;
	    break;
	}

    if (i == FD_SETSIZE)
	app_error("add_client errort: Too many clients");
      
    FD_SET(connfd, &p->allset);

    if (connfd > p->maxfd)
	p->maxfd = connfd; 
    if (i > p->maxi)
	p->maxi = i;  
}
/* $end add_client */

/* $begin check_clients */
void check_clients(pool *p) 
{
    int i, sockfd, n;
    char buf[MAXLINE]; 

    for (i=0; (i<=p->maxi) && (p->nready > 0); i++) {
	sockfd = p->client[i];
	if ((sockfd > 0) && (FD_ISSET(sockfd, &p->rset))) { 
	    p->nready--;
	    if ((n = Readline(sockfd, buf, MAXLINE)) != 0) {
		printf("server received %d bytes\n", n);
		Writen(sockfd, buf, n);
	    }
	    else { /* EOF */
		Close(sockfd);
		FD_CLR(sockfd, &p->allset);
		p->client[i] = -1;
	    }
	}
    }
}
/* $end check_clients */
