#include <stdio.h>
#include <stdlib.h>
#include "listas.h"

LInt newLInt (int x, LInt xs){
	LInt r = malloc (sizeof (struct slist));
	r->valor = x;
	r->prox  = xs;
	return r;
}

LInt fromArray (int v[], int N){
	LInt r, *e = &r;
	int i;
	for (i=0; i<N; i++){
		*e = malloc(sizeof(struct slist));
		(*e)->valor = v[i];
		e = &((*e)->prox);
	}
	*e = NULL;
	return r;
}

void freeLInt (LInt l) {
	LInt tmp;
	while (l) {
		tmp=l; 
		l=l->prox;
		free (tmp);
	}
}

void printLInt (LInt l){
	while (l) {
		printf ("%d ", l->valor);
		l=l->prox;
	}
	putchar ('\n');
}