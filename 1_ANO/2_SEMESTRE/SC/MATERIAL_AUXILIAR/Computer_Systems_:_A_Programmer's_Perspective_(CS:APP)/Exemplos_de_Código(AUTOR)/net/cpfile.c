/* $begin cpfile */
#include "csapp.h"

#define DEF_MODE   S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH
#define DEF_UMASK  S_IWGRP|S_IWOTH

int main(int argc, char **argv) 
{
    int fdin, fdout, n;
    char buf[MAXBUF];

    if (argc != 2) {
	fprintf(stderr, "usage: %s <filename>\n", argv[0]);
	exit(0);
    }

    umask(DEF_UMASK);
    fdin = open(argv[1], O_RDONLY);
    fdout = Open("./foo", O_CREAT|O_TRUNC|O_WRONLY, DEF_MODE);

    /* copy fdin to fdout, MAXBUF bytes at a time */
    while((n = Readn(fdin, buf, MAXBUF)) != 0) 
	Writen(fdout, buf, n);

    Close(fdin);
    Close(fdout);

    exit(0);
}
/* $end cpfile */
