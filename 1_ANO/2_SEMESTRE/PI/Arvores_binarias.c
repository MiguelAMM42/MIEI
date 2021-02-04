Àrvores binárias

#include <stdio.h>

typedef struct slist {
  int valor;
  struct slist * prox;
  } Nodo, *LInt;
  
typedef struct nodo {
  int valor;
  struct nodo *esq, *dir;
  } *ABin;
  
LInt cons (LInt l, int x)
{
 LInt nov = malloc (sizeof (struct slist));
 nov->valor = x;
 nov->prox = l;
 return nov;
}

ABin acr (ABin arv, int x)
{
  int res = 1;
  if (arv == NULL) 
      {
        arv = malloc (sizeof (struct nodo));
        arv->valor = x;
        arv->esq = NULL;
        arv->dir = NULL;
        return arv;
      }
  int atual = arv->valor;
  if (atual == x) return arv;
  else {
        
        if (atual > x) { (arv->dir) = (acr (arv->dir, x)); return arv;}
        else  {(arv->esq) = acr (arv->esq, x); 
                      return arv;}

        }
}
    
  

int main  ()
{
  ABin nov = NULL;
  nov = (acr (nov, 6));
  nov = acr (nov, 3);
  nov = acr (nov, 7);  
  nov = acr (nov, 1);
  nov = acr (nov, 10);

}