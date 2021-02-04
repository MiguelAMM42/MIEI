/* Main function of the C program. */

#include <stdio.h>
#include <stdlib.h>
#include "dlist.h"

int main()
{
    DLInt d1, d2;
    LInt l;
    
    int a[10] = {1,11,22,33,44,55,66,77,88,99} ;
    
    l = fromArray (a,5);
    d1 = fromLInt (l);
    printDLInt (d1);
    fim (&d1);
    printDLInt (d1);
    inicio (&d1);
    printDLInt (d1);
    freeLInt (l);
    l = fromArray (a+5,5);
    d2 = fromLInt (l);
    concat (&d1,d2);
    printDLInt (d1);
    freeDLInt (d1);
    freeLInt (l);
    return 0;
}