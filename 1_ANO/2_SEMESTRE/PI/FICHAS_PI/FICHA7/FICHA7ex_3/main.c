/* Main function of the C program. */

#include <stdio.h>
#include "stack.h"

int main()
{
    Stack s1; int x;
    initStack (&s1); printf ("Stack inicializada\n");
    if (isEmptyS(&s1)) printf ("Stack está vazia\n");
    if (push (&s1,10)) printf ("Erro no push (%d)\n", 10); else printf ("push %d ok\n",10);
    if (push (&s1,20)) printf ("Erro no push (%d)\n", 20); else printf ("push %d ok\n",20);
    if (push (&s1,30)) printf ("Erro no push (%d)\n", 30); else printf ("push %d ok\n",30);
    if (pop (&s1,&x)) printf ("Erro no pop\n"); else printf ("pop %d ok\n",x);
    if (pop (&s1,&x)) printf ("Erro no pop\n"); else printf ("pop %d ok\n",x);
    if (push (&s1,40)) printf ("Erro no push (%d)\n", 40); else printf ("push %d ok\n",40);
    if (top (&s1,&x)) printf ("Erro no top\n"); else printf ("pop %d ok\n",x);
    

    
    return 0;
}

/*
void initStack (Stack *s);
int isEmptyS (Stack *s);
int push (Stack *s, int x);
int pop (Stack *s, int *x);
int top (Stack *s, int *x);


*/