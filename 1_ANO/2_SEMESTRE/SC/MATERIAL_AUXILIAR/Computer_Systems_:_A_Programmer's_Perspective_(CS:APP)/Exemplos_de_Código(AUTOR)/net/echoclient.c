/*
 * echoclient.c - An echo client
 */
/* $begin echoclientmain */
#include "csapp.h"

int main(int argc, char **argv) 
{
    int clientfd, port;
    char *host, buf[MAXLINE];
  
    if (argc != 3) {
	fprintf(stderr, "usage: %s <host> <port>\n", argv[0]);
	exit(0);
    }
    host = argv[1];
    port = atoi(argv[2]);

    clientfd = open_clientfd(host, port);

    while (Fgets(buf, MAXLINE, stdin) != NULL) {
	Writen(clientfd, buf, strlen(buf));
	Readline(clientfd, buf, MAXLINE);
	Fputs(buf, stdout);
    }

    Close(clientfd);
    exit(0);
}
/* $end echoclientmain */
