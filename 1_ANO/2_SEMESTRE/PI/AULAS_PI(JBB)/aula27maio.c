#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct slist {
	char nome [100];
	struct slist *prox;
} *Lista;


Lista acrescentaL (Lista l, char *n){
	Lista pt, ant, novo;
	pt = l; ant = NULL;
	// procurar onde inserir
	while (pt!=NULL && strcmp (pt->nome,n) < 0) {
		ant = pt; pt = pt->prox;
	}
    
    if (pt == NULL || strcmp (pt->nome,n) != 0) {// n ainda não existe
     	novo = malloc (sizeof (struct slist));
    	strcpy (novo->nome, n);
    	// ligar para a frente
    	novo->prox = pt;
    	// ligar para trás 
    	if (ant == NULL) l = novo;
    	else ant->prox = novo;
    }
    return l;
}

void imprimeL (Lista l) {
	while (l!=NULL){
		printf ("%s\n", l->nome);
		l = l->prox;
	}
}

typedef struct flist {
	char nome [100];
	long int prox;
} Nodo;

// no endereço 0 está o endereco do primeiro nodo 
// fim da lista é 0

void acrescentaF (FILE *f, char *n){
	//assumir que o ficheiro está aberto para leitura/escrita
	long pt, ant, endNovo;
	ant = 0L;
	Nodo buf, novo;

	fseek (f, 0L, SEEK_SET);
	fread (&pt, sizeof(long) ,1, f);

	while (pt != 0L) {
        fseek (f, pt, SEEK_SET);
        fread (&buf, sizeof (Nodo), 1, f);
        if (strcmp (buf.nome, n) >= 0) break;
        ant = pt; pt = buf.prox;
	}
    if (pt == 0L || strcmp (buf.nome,n) != 0) {// n ainda não existe
       strcpy (novo.nome, n);
       novo.prox = pt;
       fseek (f, 0L, SEEK_END);
       endNovo = ftell(f); // guardo a posição do novo nodo
       fwrite (&novo, sizeof(Nodo), 1, f);
       if (ant == 0L) {
       	  // l = novo; inicio da lista vai mudar!!!
       	  fseek (f, 0L, SEEK_SET);
       	  fwrite(&endNovo, sizeof (long), 1, f);
       }
       else {
       	 // ant->prox = novo;
       	fseek(f, ant, SEEK_SET);
       	fread (&buf, sizeof(Nodo), 1, f);
       	buf.prox = endNovo;
        fseek(f, ant, SEEK_SET);
        // ou então fazendo: fseek(f, (-1) * sizeof(Nodo), SEEK_CUR);
       	fwrite (&buf, sizeof(Nodo), 1, f);
       }
       
    }
}

int main () {

	FILE *f;
	Lista l1;

	long x;

	l1 = NULL;
	l1 = acrescentaL (l1, "Maria");
	l1 = acrescentaL (l1, "Ana");
	l1 = acrescentaL (l1, "Rita");

	imprimeL (l1);

	f = fopen ("Lista", "r+");
	if (f == NULL) {
		f = fopen ("Lista", "w+");
		x = 0L;
		fwrite (&x, sizeof(long), 1, f);
	}

	acrescentaF (f, "Maria");
	acrescentaF (f, "Ana");
	acrescentaF (f, "Rita");

	fclose (f);

    
	return 0;
}
