#include <stdlib.h>

typedef struct slista {
  int valor;
  struct slista *prox;
} *LInt;

LInt newLInt (int x, LInt xs){
  LInt l = malloc (sizeof (struct slista));
  if (l!=NULL) {
    l->valor = x;
    l->prox  = xs;
  }
  return l;
}

LInt LfromV (int v[], int N){
  int i;
  LInt r=NULL;
  
  for (i=N-1; i>=0; i--)
    r = newLInt (v[i],r);
  return r;
}

typedef struct abin {
  int valor;
  struct abin *esq, *dir;
} *ABin;

int length (LInt l) {
  int c = 0;
  while (l) {l = l->prox; c++;}
  return c;
}

ABin fromListAux (LInt l, int N) {
  int i;
  
  if (N == 0) return NULL;

  ABin esq = fromListAux(l,N/2);

  for (i=0;i<N/2;i++) l = l->prox;

  ABin dir = fromListAux(l->prox,N-N/2-1);
  
  ABin raiz = malloc (sizeof(struct abin));
  raiz->valor = l->valor;
  raiz->esq = esq;
  raiz->dir = dir;
  return raiz;
}

LInt fromListN (LInt l, int N, ABin *a){
  // constroi uma arvore (*a) de procura e equilibrada
  // a partir dos N primeiros elementos da lista l
  // retorna a lista dos restantes elementos

  if (N == 0) {
   *a = NULL;
    return l;
  }
  *a = malloc (sizeof(struct abin));
  l = fromListN(l,N/2,&(*a)->esq);
  (*a)->valor = l->valor;
  l = fromListN(l->prox,N-N/2-1,&(*a)->dir);  
  return l;
}

ABin fromList (LInt l){
  // constroi uma arvore binaria de procura equilibrada 
  // com os elementos da lista (ordenada) l
  ABin a;
  fromListN(l,length(l),&a);
  return a;
}



int main() {  
  int v[4] = {1, 2, 3, 4};
  LInt l = LfromV (v,4);
  ABin a = fromList (l);
}