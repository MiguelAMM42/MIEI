#include <stdio.h>

int main() {
    int a, b, lado;
    printf("Diga o tamanho do tabuleiro: \n");
    scanf("%d", &lado);
    for(a = 0; a < lado; a++) {
        for(int b = 0; b < lado; b++) {
            if((a + b) % 2) putchar('_');
            else putchar('#');
        }
        putchar('\n');
    }
    return 0;
}