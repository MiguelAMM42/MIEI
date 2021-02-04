#include <stdio.h>

int soma (int v[], int N){
    int i, soma;
    soma = 0;
    for ( i = 0 ; i < N; i++){
        soma = soma + v[i];
    }
    return soma;
}

int main() {
    int dim, i, n;
    int a[dim];
    printf("Diga o tamanho do vetor:\n");
    scanf ("%d", &dim);
    printf("Digite o array:\n");
    for ( i = 0; i < dim; i++){
        scanf("%d", &a[i]);
    }
    n = soma(a, dim);
    printf("A soma é: %d", n);
    return n;
}
