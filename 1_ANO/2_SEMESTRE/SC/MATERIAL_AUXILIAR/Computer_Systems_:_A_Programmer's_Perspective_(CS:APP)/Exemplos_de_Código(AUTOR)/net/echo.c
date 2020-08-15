/*
 * echo - read and echo text lines until client closes connection
 */
/* $begin echo */
#include "csapp.h"

void echo(int connfd) 
{
    size_t n; 
    char buf[MAXLINE]; 

    while((n = Readline(connfd, buf, MAXLINE)) != 0) {
	printf("server received %d bytes\n", n);
	Writen(connfd, buf, n);
    }
}
/* $end echo */

