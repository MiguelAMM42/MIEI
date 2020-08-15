#include "csapp.h"

/* $begin argracederef */
void *thread(void *vargp) 
{  
    int connfd = *((int *)vargp);
    /* ... */
    return NULL;
}
/* $end argracederef */

void fragments()
{
    struct stat stat;
    int sockfd=0;

/* $begin sockaddrdef */
    typedef struct sockaddr SA;
/* $end sockaddrdef */

/* $begin fulldupopen */     
    FILE *fpin, *fpout;

    fpin = fdopen(sockfd, "r");
    fpout = fdopen(sockfd, "w");
/* $end fulldupopen */     

/* $begin fulldupclose */     
    fclose(fpin);
    fclose(fpout);
/* $end fulldupclose */     

/* $begin statcheck */
    if (S_ISREG(stat.st_mode) && (stat.st_mode & S_IRUSR))
        printf("This is a regular file that I can read\n");
/* $end statcheck */

/* $begin socketcall */
    sockfd = Socket(AF_INET, SOCK_STREAM, 0);
/* $end socketcall */


{
    int listenfd=0, clientlen, connfd;
    pthread_t tid;
    struct in_addr clientaddr;
/* $begin argrace */
    connfd = Accept(listenfd, (SA *) &clientaddr, &clientlen);
    Pthread_create(&tid, NULL, thread, &connfd);
/* $end argrace */
}

}

