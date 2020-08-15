/*
 * echo_r - reentrant version of echo
 */
/* $begin echo_r */
#include "csapp.h"

void echo_r(int connfd) 
{
    size_t n; 
    char buf[MAXLINE]; 
    Rline rline;

    readline_rinit(connfd, buf, MAXLINE, &rline); 
    while((n = Readline_r(&rline)) != 0) {
	printf("server received %d bytes\n", n);
	Writen(connfd, buf, n);
    }
}
/* $end echo_r */

