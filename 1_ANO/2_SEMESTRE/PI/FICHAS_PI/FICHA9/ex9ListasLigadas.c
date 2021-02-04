DLInt newDLInt (int x, DLInt antes, DLInt depois){
    DLInt r = malloc (sizeof (struct dlista));
    
    if (r!=NULL) {
        r->valor = x;
        r->ant = antes; 
        r->prox = depois;
    }
    return r;
}

DLInt newDLInt2 (int x, DLInt antes, DLInt depois){
    DLInt r = malloc (sizeof (struct dlista));
    
    if (r!=NULL) {
        r->valor = x;
        r->ant = antes; 
        r->prox = depois;
    }
    if (depois)
        depois->ant = r;
        
    if (antes)
        antes->prox = r;
    
    return r;
}

//assumimos que recebemos as cabecas das listas
void concatAntes  (DLInt a, DLInt *d){
    // acrescenta a antes de *d
    DLInt a2 = a;
    
    while (a && a->prox) 
        a = a->prox;
    
    if (d) { 
        if (a) {
            a->prox = *d;
            (*d)->ant = a;
            *d = a2;
        }
    }
    else {
        *d = a2;
    }
}

//assumimos que nao recebemos as cabecas das listas
void concatDepois (DLInt *a, DLInt d){
    // acrescenta d depois de *a
    
    if (d) {
        while(*a && (*a)->prox) {
            a = &((*a)->prox);
        }
        
        while(d->ant) {
            d = d->ant;
        }
        
        if (*a) {
            (*a)->prox = d;
            d->ant = *a;
        }
        else
            *a = d;
    }
}

//assumir que não recebemos a cabeca da lista
int DLLength (DLInt l){
    // retorna o numero de elementos da lista
     if (!l) 
        return 0;
        
    while (l->ant) 
        l = l->ant;
        
    int elem = 1;
    while (l -> prox) {
        elem ++;
        l = l -> prox;
    }
    return elem;
}


int DLLength2 (DLInt l) {
    // retorna o numero de elementos da lista
    if (!l)
        return 0;
        
    DLInt ant = l;
    int r = 0;
    while (ant != NULL) {
        r++;
        ant = ant->ant;
    }
    while (l != NULL) {
        r++;
        l = l->prox;
    }
    return r-1;
}


void imprimeDL (DLInt l){
    // imprime os elementos de l
    while (l->prox) {
        printf("%d ", l->valor);
        l = l->prox;
    }
    printf("%d ", l->valor);
    printf("\n");
    while (l) {
        printf("%d ", l->valor);
        l = l->ant;
    }
    printf("\n");   
}