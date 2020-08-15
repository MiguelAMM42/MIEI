#include "csapp.h"

void forktest(int niters);

int main(int argc, char **argv) 
{
    int i, rc, niters;

    if (argc != 2) {
	printf("usage: %s: <niters>\n", argv[0]);
	exit(0);
    }
    niters = atoi(argv[1]);

    for (i=0; i<niters; i++) {
	if ((rc = fork()) < 0)
	    unix_error("fork");
	if (rc == 0) /* child */
	    exit(0);
	else /* parent */
	    wait(NULL);
    }

    exit(0);
}
	

