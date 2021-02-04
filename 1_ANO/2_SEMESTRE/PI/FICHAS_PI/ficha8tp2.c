#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define HSIZE 1000

typedef struct entrada{
	char *palavra;
	int ocorr;
	struct entrada *prox;
} *Palavras;

typedef Palavras Dicionario;

typedef Palavras DicionarioH[HSIZE];


unsigned int hash (char *pal, int s){
// http://www.cse.yorku.ca/~oz/hash.html 
	int r;
	for (r=5381; *pal != '\0'; pal++)
      	r = r*33 + *pal;
   	return (r%s);
}


void initDic (Dicionario *d) {
	*d = NULL;
}

void initDicH (DicionarioH d) {
	for (int i = 0; i < HSIZE; i++) {
		initDic(&d[i]);
	}
}


int acrescenta (Dicionario *d, char *pal) {
	Dicionario ant = NULL;
	int r = 1;
	while(*d != NULL && strcmp(pal, (*d)->palavra) > 0) {
		ant = *d;
		d = &((*d)->prox);
	}

	if (*d == NULL) {
		*d = malloc(sizeof(struct entrada));
		(*d)->palavra = strdup(pal);
		(*d)->ocorr = 1;
		(*d)->prox = NULL;
	}
	else if (strcmp(pal, (*d)->palavra) == 0) {
		(*d)->ocorr++;
		r = (*d)->ocorr;
	} 
	else { //(strcmp(pal, (*d)->palavra) < 0)
		Dicionario e = malloc(sizeof(struct entrada));
		e->palavra = strdup(pal);
		e->ocorr = 1;
		e->prox = *d;
		if (ant == NULL) {
			*d = e;
		} else {
			ant->prox = e;
		}
	}
	return r;
}

int acrescentaH(DicionarioH d, char *pal) {
	int h = hash(pal, HSIZE);

	return acrescenta(&(d[h]), pal);
}



/*
int f(int x)
x = 8


main{
	int y=5;
	f(y);
}


int f2(int *x)0x555
x = 0x444
*x = 5;


main {
	int y;
	f2(&y) &y=0x555
}
*/



void printd(Dicionario d) {
	while(d) {
		printf("%d |%s| ", d->ocorr, d->palavra);
		d = d->prox;
	}
	printf("\n");
}


void printdH(DicionarioH d) {
	for (int i = 0; i < HSIZE; i++)
	{
		if(d[i] != NULL) {
			printf("d[%d] ", i);
			printd(d[i]);
		}
	}
}


int main (int argc, char *argv[]){
  FILE *input;
  int r=0, count=0;
  char word[100];
  DicionarioH d;
  initDicH(d);
  if (argc==1) input=stdin;
  else input=fopen(argv[1],"r");
  if (input==NULL) r=1;
  else {
    while ((fscanf(input,"%s",word)==1)) {
    	acrescentaH(d, word);
      	count ++;
    }
    fclose (input);
    printdH(d);
    printf ("%d palavras\n", count);
  }
  return r;
}








