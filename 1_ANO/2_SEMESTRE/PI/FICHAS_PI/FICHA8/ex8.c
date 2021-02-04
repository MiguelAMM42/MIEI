#include <stdlib.h>
#include <string.h>

typedef struct entrada {
    char *palavra;
    int ocorr;
    struct entrada *prox;
} *Palavras;

typedef Palavras Dicionario;

void initDic (Dicionario *d) {
  *d = NULL; 
}

int acrescenta (Dicionario *d, char *pal) {
  Palavras aux; 
  while (*d != NULL && strcmp(pal,(*d)->palavra) > 0) {
    d = &((*d)->prox); 
  }
  if (*d == NULL || strcmp(pal,(*d)->palavra) < 0) {
    aux = *d;
    *d = malloc(sizeof(struct entrada));
    (*d)->palavra = strdup(pal);
    (*d)->ocorr = 1;
    (*d)->prox = aux;
  } else {
    (*d)->ocorr++;
  }
  return (*d)->ocorr;
}

char *maisFreq (Dicionario d, int *c) {
  char *pal = NULL;
  *c = 0;   
  while (d) {
    if (d->ocorr > *c) {
      *c = d->ocorr;
      pal = d->palavra;
    }
    d = d->prox;
  }
  return pal;
}

int main() {
  Dicionario d;
  char w[6];
  int x;
  initDic(&d);
  strcpy(w,"mundo");
  acrescenta(&d,w);
  strcpy(w,"ola");
  acrescenta(&d,w);
  strcpy(w,"nada");
  acrescenta(&d,w);

  strcpy(w,maisFreq(d,&x));
  printf("%s %d",w,x);
  
  return 0;
}