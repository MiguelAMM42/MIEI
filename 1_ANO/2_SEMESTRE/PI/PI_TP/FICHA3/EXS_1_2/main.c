#include <stdio.h>
#include <stdlib.h>



/*
EX.1

A

 OUTPUT:
 1 1 4
 2 2 6
 3 3 8
 4 4 10
 5 5 12

B

 OUTPUT: 13

*/
void swapM (int *x, int *y);

int main () {
    int x = 3, y = 5;
    swapM (&x, &y);
    printf ("%d %d\n", x, y);
}

void swapM (int *x, int *y) {
    int temp = *x;
    *x = *y;
    *y = temp;
}