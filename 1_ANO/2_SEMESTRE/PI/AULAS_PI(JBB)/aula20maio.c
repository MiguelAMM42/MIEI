#include <stdio.h>
#include <stdlib.h>

int main (int argc // numero de argumentos com que foi chamado
	     ,char *argv[] // argumentos do programa
	     ) {

	int i, n[10];

	FILE *f;

	if (argc == 2) {
       f = fopen (argv[1], "r");
       
       fread ( n // memoria a consultar
       	   	 , sizeof(int)
       	   	 , 10
       	   	 , f // ficheiro onde vai ser escrito
       	   	 );
       for (i=0; i<10; i++) 
       	   printf ("%d lido \n", n[i]);
       	
       fclose (f);
	}
    
	return 0;
}