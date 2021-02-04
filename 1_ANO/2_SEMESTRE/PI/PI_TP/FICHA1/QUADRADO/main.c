#include <stdio.h>

int main() {
    int a, b, lado;
    printf("Diga o tamanho do quadrado: \n");
    scanf("%d", &lado);
    for(a = 0; a < lado; a++) {
        for (b = 0; b < lado; b++) {
            putchar('#');
        }
        putchar('\n');
    }
        return 0;
}