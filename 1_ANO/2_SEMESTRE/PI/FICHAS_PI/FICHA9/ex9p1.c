#include <stdlib.h>

typedef struct abin {
    char *pal;
    int ocorr;
    struct abin *esq, *dir;
} *Dicionario;

void initDic (Dicionario *d) {
  *d = NULL;
}

int acrescenta (Dicionario *d, char *pal) {
  while ((*d) != NULL && strcmp(pal,(*d)->pal) != 0) {
    if (strcmp(pal,(*d)->pal) > 0) {
      d = &((*d)->dir);
    } else {
      d = &((*d)->esq);
    }
  }
  if (*d == NULL) {
    *d = malloc(sizeof(struct abin));
    (*d)->pal = strdup(pal);
    (*d)->ocorr = 1;
    (*d)->esq = NULL;
    (*d)->dir = NULL;
  } else {
    (*d)->ocorr++; 
  }
  return (*d)->ocorr;
}

char *maisFreq (Dicionario d, int *c) {
  char *pd,*pe,*p;
  int md,me,m;
  if (d == NULL) {
    *c = 0;
    return NULL;
  }
  m = d->ocorr;
  p = d->pal;
  pd = maisFreq(d->dir,&md);
  if (md > m) {
    m = md;
    p = pd;
  }
  pe = maisFreq(d->esq,&me);
  if (me > m) {
    m = me;
    p = pe;
  }
  *c = m;
  return p;
}

int main() {
  Dicionario d; 
  int c; 
  char *p;
  initDic (&d);
  acrescenta (&d, "Braga");
  acrescenta (&d, "Porto");
  acrescenta (&d, "Aveiro");
  acrescenta (&d, "Braga");
  acrescenta (&d, "Braga");
  acrescenta (&d, "Porto");
  acrescenta (&d, "Viana");
  p = maisFreq (d, &c);
  printf ("a palavra mais frequente (%d) é %s\n", c, p);
  return 0;
}