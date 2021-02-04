#include <stdlib.h>

typedef struct entrada {
  char *palavra;
  int ocorr;
  struct entrada *prox;
} *Palavras;

#define HSIZE 5

typedef Palavras Dicionario[HSIZE];

unsigned int hash (char *pal, int s) {
  // cse.yorku.ca/~oz/hash.html
  int r;
  for (r=5381; *pal != '\0'; pal++)
    r = r*33 + *pal;
  return (r%s);
}

void initDic (Dicionario *d) {
  int i;
  for (i=0; i<HSIZE; i++) {
    (*d)[i] = NULL;
  }
}

int acrescenta (Dicionario *d, char *pal) {
  Palavras nova;
  int pos = hash(pal,HSIZE);
  Palavras *init = &((*d)[pos]);
  Palavras *aux = &((*d)[pos]);
  
  while (*aux != NULL && strcmp((*aux)->palavra,pal) != 0)
    aux = &((*aux)->prox);
  if (*aux == NULL) {
    nova = malloc(sizeof(struct entrada));
    nova->palavra = strdup(pal);
    nova->ocorr = 1;
  } else {
    nova = *aux;
    *aux = (*aux)->prox;
    nova->ocorr++;
  }
  nova->prox = *init;
  *init = nova;
  return nova->ocorr;
}

char *maisFreq (Dicionario d, int *c) {
  char *r = NULL;
  int m = 0;
  Palavras aux;
  int i;
  
  for (i=0; i<HSIZE; i++) {
    aux = d[i];
    while (aux != NULL) {
      if (aux->ocorr > m) {
        r = aux->palavra;
        m = aux->ocorr;
      }
      aux = aux->prox;
    }
  } 
  *c=m;
  return r;
}

int main() {
    Dicionario d; int c=0; char *p;
    initDic (&d);
    acrescenta (&d, "aaa");
    acrescenta (&d, "bbb");
    acrescenta (&d, "aaa");
    acrescenta (&d, "bb");
    acrescenta (&d, "aaa");
    acrescenta (&d, "bbb");
    p = maisFreq (d, &c);
    printf ("a palavra mais frequente (%d) é %s\n", c, p);
    return 0;
}