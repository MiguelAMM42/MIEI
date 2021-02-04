#include <stdio.h>
#include <stdlib.h>


typedef struct nodo {
  int valor;
  struct nodo *esq, *dir;
} *ABin;

// sizeof (ABin) = 8
// sizeof (struct nodo) = 4 + 8 + 8 = 20

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

int toArray (ABin a, int v[], int N) {
  int r=0;
  
  if (a != NULL && N>0) {
     r += toArray (a->esq, v+r, N-r);
     if (r < N) v[r++] = a->valor;
     r += toArray (a->dir, v+r, N-r);
  }
  return r;
}

int procuraR (int x, ABin a) {
  // a e uma árvore de procura
  // retorna True se x existe na árvore
  //         Falso no outro caso
  int r = 0; // ainda não encontrei
  
  if (a == NULL) ;
  else if (a->valor == x) r=1;
       else if (a->valor > x) 
               r = procuraR (x,a->esq);
            else // a->valor < x
               r = procuraR (x,a->dir);
  return r;
}

int procura1 (int x, ABin a) {
  // a e uma árvore de procura
  // retorna True se x existe na árvore
  //         Falso no outro caso
  int r = 0; // ainda não encontrei
  
  while (a != NULL && r == 0) {
      // pára quando (1) acaba a arvore (a==NULL)
      //             (2) encontramos x  (a->valor == x)
      if   (a->valor == x)    r = 1;
      else if (a->valor > x)  a = a->esq;
      else                    a = a->dir;
  }
  return r;
}

int procura (int x, ABin a) {
  // a e uma árvore de procura
  // retorna True se x existe na árvore
  //         Falso no outro caso
  int r = 0; // ainda não encontrei
  
  while (a != NULL && a->valor != x) {
      // pára quando (1) acaba a arvore (a==NULL)
      //             (2) encontramos x  (a->valor == x)
      if (a->valor > x)  a = a->esq;
      else               a = a->dir;
  }
  
  return (a!=NULL);
}

ABin insere (ABin a, int x) {
  // recebe uma arvore de procura a
  //        um inteiro x
  // devolve uma árvore de procura com os elementos de a e x
  if (a == NULL) {
     a = malloc (sizeof(struct nodo));
     
     a->valor = x;
     a->esq=a->dir= NULL;
  } 
  else if (a->valor > x)
            a->esq = insere (a->esq, x);
       else a->dir = insere (a->dir, x);
     
  return a;
}

int main () {

    int a[10] = {5, 10, 15, 20, 25, 30, 35, 40, 45, 50};
    
    int existe;

    ABin arv1 = fromArray (a, 5), arv2;
    
    //existe = procura (12, arv1);
    
    // toArray (arv1, b, 10);
    
    arv2 = insere (arv1, 18);
    

    return 0;
}