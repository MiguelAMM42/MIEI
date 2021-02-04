#include <stdio.h>
#include <stdlib.h>

typedef struct nodo {
    int valor;
    struct nodo * prox;
} Nodo, *LInt;

LInt cons (int x, LInt xs){
    LInt r = malloc (sizeof (Nodo));
    r->valor = x; r->prox = xs;

    return r;
}
LInt fromArray (int v[], int N) {
    int i; LInt r = NULL;

    for (i=N-1; i>=0; i--)
        r = cons (v[i], r);
    return r;
}

void mergeV (int a[], int na, int b[], int nb){
   // a [0..na-1] esta ordenado
   // b [0..nb-1] esta ordenado
   // coloca em a um array ordenado com a e b
   int r [10]; // [na+nb];
   int ia, // para perc a
       ib, // para perc b
       ir; // para perc r
   ia = ib = ir = 0;
   while (ia < na && ib < nb) 
     if (a[ia] <= b[ib]) { r[ir] = a[ia]; ia++; ir++;}
     else { r[ir] = b[ib]; ib++; ir++;}
   // no final (ia < na && ib < nb) é falso
   // (ia == na || ib == nb) e verdadeiro
   if (ia < na)  while (ia<na) { r[ir] = a[ia]; ia++; ir++;}
   else while (ib<nb) { r[ir] = b[ib]; ib++; ir++;}
   for (ia=0; ia<ir; ia++) a[ia] = r [ia];
}

LInt mergeL (LInt a, LInt b) {
     LInt r,      // lista resultado
          ultima; // endereco do ultimo nodo ligado a r
     
     // inicializar r e ultima com o primeiro nodo
     if (a==NULL) return b;
     if (b==NULL) return a;
     
     if (a->valor <= b->valor) {
        r = ultima = a; a = a->prox;
     } else {
       r = ultima = b; b = b->prox;
     }
     
     while (a != NULL && b != NULL) 
        if (a->valor <= b->valor) {
          // acrescentar a a r
          ultima->prox = a;
          // avancar a e r
          a = a->prox; ultima = ultima->prox;
        }
        else {
          // acrescentar b a r
          ultima->prox = b;
          // avancar b e r
          b=b->prox; ultima=ultima->prox;
        }
     if (a == NULL) 
          ultima->prox=b;
     else ultima->prox=a;
     return r;
}

void mergeSort (int a[], int N) {
  int m;
  if (N>1) {
    m = N/2;
    mergeSort (a  , m  ); // ordena os primeiros m
    mergeSort (a+m, N-m); // ordena os seguintes
    mergeV (a,m,a+m,N-m);
  }
}

int main () {

    int a[10] = {10, 20, 30, 40, 50, 5, 7, 25, 34, 35};
    LInt l1 = fromArray (a, 4), l2 = fromArray (a+5,3), l3;
    l3 = mergeL(l1, l2);
    return 0;
}