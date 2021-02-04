#include <stdio.h>
#include "lista.h"

int main (){
    LInt l1, l2;

    l1=l2= NULL;

    l1 = cons (l1, 10);
    l1 = cons (l1, 20);
    l1 = cons (l1, 30);

    cons1 (&l2, 10);
    cons1 (&l2, 20);
    cons1 (&l2, 30);

    if (iguais (l1, l2)) printf ("sucesso\n");
    else printf ("alguma coisa correu mal\n");

    // acrescente outros testes às funções definidas

}


