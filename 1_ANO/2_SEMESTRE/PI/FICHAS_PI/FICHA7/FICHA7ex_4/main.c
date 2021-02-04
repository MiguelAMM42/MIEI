/* Main function of the C program. */

#include <stdio.h>
#include "queue.h"

int main()
{
    Queue q1; int x;
    initQueue (&q1); printf ("Queue inicializada\n");
    if (isEmptyQ(&q1)) printf ("Queue está vazia\n");
    if (enqueue (&q1,10)) printf ("Erro no enqueue (%d)\n", 10); else printf ("enqueue %d ok\n",10);
    if (enqueue (&q1,20)) printf ("Erro no enqueue (%d)\n", 20); else printf ("enqueue %d ok\n",20);
    if (enqueue (&q1,30)) printf ("Erro no enqueue (%d)\n", 30); else printf ("enqueue %d ok\n",30);
    if (dequeue (&q1,&x)) printf ("Erro no dequeue\n"); else printf ("dequeue %d ok\n",x);
    if (dequeue (&q1,&x)) printf ("Erro no dequeue\n"); else printf ("dequeue %d ok\n",x);
    if (enqueue (&q1,40)) printf ("Erro no enqueue (%d)\n", 40); else printf ("enqueue %d ok\n",40);
    if (front (&q1,&x)) printf ("Erro no front\n"); else printf ("front %d ok\n",x);
    

    
    return 0;
}

/*
void initStack (Stack *s);
int isEmptyS (Stack *s);
int push (Stack *s, int x);
int pop (Stack *s, int *x);
int top (Stack *s, int *x);


*/