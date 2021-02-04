#include <stdio.h>

void triangulo1(int n);
void triangulo2(int n);

int main() {
    int estilo, input;
    printf("Diga o argumento para o triângulo\n");
    scanf("%d", &input);
    printf("Diga o número referente ao estilo de triângulo que prefere\n");
    scanf("%d", &estilo);
    switch(estilo) {
        case 1:
            triangulo1(input);
            break;
        case 2:
            triangulo2(input);
            break;
        default:
            printf("Erro! Estilo desconhecido: %d\n", estilo);
    }

    return 0;
}

void triangulo1(int n) {
    for(int i = 1; i < 2 * n; i++) {
        for(int j = 1; j <= 2 * n - i; j++) {
            if(j <= i) putchar('#');
        }
        putchar('\n');
    }
}


void triangulo2(int n) {
    for(int i = 1; i <= n; i++) {
        int j = i - 1;
        for(int k = 0; k < n - 1 - j; k++) putchar(' ');
        for(int k = 0; k < 1 + 2 * j; k++) putchar('#');
        putchar('\n');
    }
}