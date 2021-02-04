#include <stdio.h>
#include <stdlib.h>

typedef struct nodo {
  int valor;
  struct nodo *esq, *dir;
} *ABin;

typedef struct lista {
  int valor;
  struct lista *prox;
} *LInt;

ABin newABin (int r, ABin e, ABin d){
    ABin a = malloc (sizeof (struct nodo));
    
    a->valor = r;
    a->esq = e; a->dir = d;
    
    return a;
}

ABin fromArray (int v[], int N){
   ABin r = NULL, e, d;
   int m = N/2;
   
   if (N>0) {
     e = fromArray (v, m);
     d = fromArray (v+m+1, N-m-1);
     r = newABin (v[m], e, d);
   }
   return r;
}

int length (LInt l) {
   int r=0;
   
   while (l!=NULL) {
     r++;
     l=l->prox;
   }
   return r;
}

int size (ABin a) {
  int r=0;
  
  if (a!=NULL) {
    // r = 1 + size (a->esq) + size (a->dir);
    r++;
    r += size (a->esq);
    r += size (a->dir);
  }
  
  return r;
}

// int * toArray (ABin a){}  -- TPC

int toArray (ABin a, int v[], int N){
  // preenche no maximo N elementos do array v 
  // com os elementos de a
  // percorrer a arvore recursivamente
  // retorna o numero de elementos escritos no array
  int r = 0;
  if (a!=NULL) {
     r += toArray (a->esq,v+r,N-r); // escreve os elementos da esq
     v[r++] = a->valor; // escrever no array v a raiz da arvore
     r += toArray (a->dir,v+r,N-r); // escreve os elementos da dir
  }
  return r;
}

int main () {

    int a[10] = {10, 20, 30, 40, 50, 60, 70, 80, 90, 95}
      , b[10];
    int s;

    ABin arv = fromArray (a,4);
    
    toArray (arv, b, 10);
    return 0;
}