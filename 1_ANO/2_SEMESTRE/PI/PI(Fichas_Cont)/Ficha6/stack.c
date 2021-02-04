#include <stdio.h>
#include <stdlib.h>
#include "Stack.h"

// Static stacks 

void SinitStack (SStack s){
	s->sp=0;
}

int  SisEmpty (SStack s){
	return (s->sp == 0);
}

int  Spush (SStack s, int x){
	int r = 0;
	if (s->sp == Max) r=1;
	else s->values[s->sp++] = x;

	return r;
}

int  Spop (SStack s, int *x) {
	int r=0;
	if (s->sp == 0) r=1;
	else *x = s->values[--s->sp];
	return r;
}

int  Stop (SStack s, int *x) {
	int r=0;
	if (s->sp == 0) r=1;
	else *x = s->values[s->sp - 1];
	return r;
}

void ShowSStack (SStack s){
    int i;
    printf ("%d Items: ", s->sp);
    for (i=s->sp-1; i>=0; i--) 
        printf ("%d ", s->values[i]);
    putchar ('\n');
}

// Stacks with dynamic arrays

int dupStack (DStack s) {
	int r = 0, i;
	int *t = malloc (2*s->size*sizeof(int));

	if (t == NULL) r = 1;
	else {
		for (i=0; i<s->size; i++) 
			t[i] = s->values[i];
		free (s->values);
		s->values = t;
		s->size*=2;
	}
	return r;
}

void DinitStack (DStack s) {
	s->size = 5; // arbitrary initial size
	s->sp = 0;
	s->values = malloc (s->size * sizeof(int));
}

int  DisEmpty (DStack s) {
	return (s->sp == 0);
}

int  Dpush (DStack s, int x){
	int r=0;
	if (s->sp == s->size) r = dupStack (s);
	if (r == 0) s->values[s->sp++] = x;
	return r;
}

int  Dpop (DStack s, int *x){
	int r=0;
	if (s->sp == 0) r=1;
	else *x = s->values[--s->sp];
	return r;
}

int  Dtop (DStack s, int *x){
	int r=0;
	if (s->sp == 0) r=1;
	else *x = s->values[s->sp - 1];
	return r;
}

void ShowDStack (DStack s){
    int i;
    printf ("%d Items: ", s->sp);
    for (i=s->sp-1; i>=0; i--) 
        printf ("%d ", s->values[i]);
    putchar ('\n');
}
