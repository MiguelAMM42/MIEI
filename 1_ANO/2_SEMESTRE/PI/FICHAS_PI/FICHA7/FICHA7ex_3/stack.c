#include "stack.h"

void initStack (Stack *s) {
    (*s) = NULL;
}

int isEmptyS (Stack *s) {
    if (s==NULL) return 0;
    else return 1; //...
}

int push (Stack *s, int x){
    Stack tmp = malloc (sizeof(Stack));
    if (!tmp) return 1;
    tmp = *s;
    *s -> valor = x;
    *s -> prox = tmp;
    free(tmp);
    return 0;
}

int pop (Stack *s, int *x){
    //... ;
    if (!(*s))return 1;
    *s -> valor = prox;
    return 0;
}
int top (Stack *s, int *x){
    if (!(*s)) return 1;
    *x = s -> valor;
    //...
    return 0;
}
