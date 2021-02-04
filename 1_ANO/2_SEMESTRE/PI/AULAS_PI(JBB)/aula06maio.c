ABin insereR (ABin a, int x) {
  // recebe uma arvore de procura a
  //        um inteiro x
  // devolve uma árvore de procura com os elementos de a e x
  if (a == NULL) {
     a = malloc (sizeof(struct nodo));
     
     a->valor = x;
     a->esq=a->dir= NULL;
  } 
  else if (a->valor > x)
            a->esq = insereR (a->esq, x);
       else a->dir = insereR (a->dir, x);
     
  return a;
}

void insere (ABin *a, int x) {
  // recebe uma arvore de procura *a
  //        um inteiro x
  // devolve uma árvore de procura com os elementos de a e x

  // descobrir o sitio onde inserir
  while (*a != NULL) 
    // avançar
    if ((*a)->valor > x)
         a = &((*a)->esq);
    else a = &((*a)->dir);
  
  //actualizar
  *a = newABin (x,NULL,NULL);
}
