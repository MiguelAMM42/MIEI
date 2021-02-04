#include <stdlib.h>

typedef struct slist *LInt;

typedef struct slist {
  int valor;
  LInt prox;
} Nodo;

LInt cons (LInt l, int x) {
  LInt novo = malloc(sizeof(Nodo));
  novo->valor = x;
  novo->prox = l;
  return novo;
}

LInt concat (LInt a, LInt b) {
  LInt aux = a;

  if (a == NULL) return b;
  
  while (aux->prox != NULL) 
    aux = aux->prox;
    
  aux->prox = b;
  
  return a;
}

void concat1 (LInt *a, LInt b) {
  // *a = concat(*a,b);
  
  while (*a != NULL) {
    a = &((*a)->prox);
  }
  
  // *a deveria passar a apontar para a lista b
  // a contem o endereço do campo prox do último nó
  *a = b;
}

int main() {
  
  LInt a = NULL;
  LInt b = NULL;
  a = cons(a,3);
  a = cons(a,2);
  a = cons(a,1);
  b = cons(b,5);
  b = cons(b,4);
  
  concat1(&a,b);

  return 0;
}


#include <stdlib.h>

typedef struct {
  int numero;
  char nome[8];
  int nota;
} Aluno;

typedef struct slist {
  Aluno aluno;
  struct slist *prox;
} Nodo;

typedef Nodo *Turma;

int aprovados(Turma t) {
  int r = 0;
  while (t != NULL) {
    if ((t->aluno).nota >= 10) r++; 
    t = t->prox;
  }
  return r;
}

Aluno *procura (Turma t, int numero) {
  while (t) {
    if ((t->aluno).numero == numero) return &(t->aluno);
    if ((t->aluno).numero >  numero) break;
    t = t->prox;
  }
  return NULL;
}

int acrescentaAluno (Turma *t, Aluno a) {
  Nodo *novo = malloc(sizeof(Nodo));
  if (novo == NULL) return 1;
  novo->aluno = a;
  
  while ((*t) != NULL && ((*t)->aluno).numero < a.numero ) {  
    t = &((*t)->prox);
  }
  novo->prox = *t;
  *t = novo;
  
  return 0;
}

int main() {
  Turma t;
  Aluno *r;
  Aluno a = {2000,"Maria",9};
  t = malloc(sizeof(Nodo));
  (t->aluno).numero = 1000;
  strcpy((t->aluno).nome, "Manuel");
  (t->aluno).nota = 16;
  t->prox = NULL;
  acrescentaAluno(&t,a);
  r = procura(t,1000);
  r->nota = 17;
  
  return 0;
}
