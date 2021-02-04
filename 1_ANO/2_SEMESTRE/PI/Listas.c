Listas

typedef struct slist {
  int valor;
  struct slist * prox;
  } Nodo, *LInt;
  
LInt cons (LInt l, int x)
{
 LInt nov = malloc (sizeof (struct slist));
 nov->valor = x;
 nov->prox = l;
 return nov;
}

LInt tail (LInt l)
{
  LInt temp = l;
  l = l->prox;
  free (temp);
  return l;
}
LInt snoc (LInt l, int x)
{
  LInt * temp = &l;
  while (*temp != NULL) temp = &((*temp)->prox);
  LInt nov = malloc (sizeof (struct slist));
  nov->valor = x;
  nov->prox = NULL;
  *temp = nov;
  return l;
    
  }

int main  ()
{
  LInt prim = NULL;
  prim = cons (prim, 15);
  prim = cons (prim, 5);
  prim = cons (prim, 10);
  prim = snoc (prim, 20);
}







// i.

//Acrescenta elemento no inicio da lista

LInt cons (LInt l, int x) {
    LInt new = malloc(sizeof(Nodo));
    new->valor = x;
    new->prox = l;
    return new;
}





// ii.

//Remove o primeiro elemento de uma lista não vazia, libertando o correspondente espaço

LInt tail (LInt l) {
    LInt x = l == NULL ? NULL : l->prox;
    free(l);
    return x;
}





// iii.

//Remove o último elemento de uma lista não vazia, libertando o correspondente espaço

LInt init(LInt l) {
    if (l == NULL || l->prox == NULL)
        return NULL;
    LInt nextToEnd = l;
    LInt end = l->prox;
    while(end->prox != NULL) {
        nextToEnd = end;
        end = end->prox;
    }
    free(end);
    nextToEnd->prox = NULL;
    return l;
}




// iv.

//Acrescenta um elemento no final da lista

LInt snoc (LInt l, int x) {
    LInt end = l;
    while(end->prox != NULL) {
        end = end->prox;
    }
    LInt new = malloc(sizeof(Nodo));
    new->valor = x;
    new->prox = NULL;
    end->prox = new;
    return l;
}




// v.

//Acrescenta a lista b a a, retornando o inicio da lista resultante

LInt concat (LInt a, LInt b) {
    LInt endA = a;
    while(endA->prox != NULL) endA = endA->prox;
    endA->prox = b;
    return a;
}




//Faz reverse da lista

LInt reverse(LInt l) {
    LInt new = malloc(sizeof(Nodo));
    new->valor = l->valor;
    LInt end = l->prox;
    while(end != NULL) {
        new = cons(new,end->valor);
        end = end->prox;
    }
    return new;
}
