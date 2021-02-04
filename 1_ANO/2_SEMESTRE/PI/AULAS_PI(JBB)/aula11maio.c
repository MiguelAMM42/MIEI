

int maiorAB (ABin a) {
  // recebe uma arvore NAO NULA e retorna o maior elemento
  while (a->dir != NULL)
     a = a->dir;
  return a->valor;
}

ABin removeMaior (ABin a) {
    ABin ant, pt;
    pt = a;
    while (pt->dir != NULL) {
      ant = pt;
      pt = pt->dir;
    }
    // pt tem o elemento a remover
    // pt esta a direita de ant
    // por isso todos os elementos acessíves de pt 
    // são maiores do que ant
    ant->dir = pt->esq;
    
    free (pt);
    
    return a;    
}

ABin removeMaior1 (ABin *sitio) {
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
      ;
    }
    return a;
}
