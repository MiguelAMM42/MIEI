

ABin removeMaior (ABin *sitio) {
    // retorna o maior elemento e modifica a árvore
    ABin pt;
    while ((*sitio)->dir != NULL) {
      sitio = &((*sitio)->dir);;
    }
    pt = *sitio;
    *sitio = pt->esq; 
    return pt;    
}

ABin removeRaiz (ABin a) {
    // recebe uma arvore binaria de procura NAO NULA
    // retorna essa arvore (de procura) sem a raiz
    ABin tmp;
    if (a->esq == NULL) {
      tmp = a;
      a = a->dir;
      free (tmp);
    }
    else if (a->dir == NULL) {
      tmp = a;
      a = a->esq;
      free (tmp);
    }
    else {
      // ambas as sub-arvores sao NAO NULAS
      tmp = removeMaior (&(a->esq));
      tmp->esq = a->esq; tmp->dir = a->dir;
      free (a);
      a = tmp;
    }
    return a;
}

int removeA (ABin *e, int x) {
  // retorna 0 se remover
  // retorna 1 se o elemento x nao existe
  int r = 0;
  
  // procurar
  while (*e != NULL && (*e)->valor != x) 
      if ((*e)->valor > x)
           e = &((*e)->esq);
      else e = &((*e)->dir);
  
  if (*e == NULL) r = 1 ; // nao existe
  else *e = removeRaiz (*e);

  return r;  
}
