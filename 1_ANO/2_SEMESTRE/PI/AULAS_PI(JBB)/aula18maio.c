#include <stdio.h>
#include <stdlib.h>


FILE * fopen (const char * restrict path, const char * restrict mode);

int main () {

	FILE * f;

	char c[100];
	int n;

    
    f = fopen ("abcd", "r"); // abrir para leitura

    if (f == NULL) printf ("ficheiro nao existente\n");
    else {
    	printf ("ficheiro existe\n");

    	for (n=0; fscanf (f,"%s", c) != EOF; n++)
    		;

    	printf ("palavras lidas: %d\n", n);
    }

    fclose (f);
    
	return 0;
}
