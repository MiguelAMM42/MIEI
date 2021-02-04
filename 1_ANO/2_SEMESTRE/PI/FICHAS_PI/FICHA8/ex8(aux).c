#include <stdlib.h>

typedef struct entrada{
    char *palavra;
    int ocorr;
    struct entrada *prox;
} *Palavras;

typedef Palavras Dicionario;

int acrescenta (Dicionario *d, char *pal){
    Dicionario *aux = d;
    Dicionario prim = *d;
    Dicionario aux2;
    
    while (*d != NULL && strcmp ((*d)->palavra,pal) != 0) 
         d = &((*d)->prox);
         
    if (*d == NULL) {
      
        *aux = malloc (sizeof (struct entrada));
        (*aux)->palavra = strdup (pal);
        (*aux)->ocorr = 1;
        (*aux)->prox = prim;
        
    } else {
        (*d)->ocorr++;
        if (*d != prim) {
          aux2 = (*d)->prox;
          (*d)->prox = prim;
          *aux = *d;
          *d = aux2;
        }
    }

    return (*aux)->ocorr;
}

char *maisFreq (Dicionario d, int *c){
    char *r = NULL; int m=0;
    for (; d != NULL; d=d->prox)
      if (d->ocorr > m) {
        r = d->palavra; m = d->ocorr;
      }
    *c=m;
    return r;
}

int main() {
  Dicionario pals = NULL; int c=0; char *p;
  acrescenta (&pals, "aa");
  acrescenta (&pals, "cc");
  acrescenta (&pals, "bb");
  acrescenta (&pals, "aa");
  acrescenta (&pals, "aa");  
  p = maisFreq (pals, &c);
  return 0;
}