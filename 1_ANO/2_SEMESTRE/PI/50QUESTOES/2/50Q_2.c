#include <stdio.h>
#include <stdlib.h>

int main()
{
	int num, denom, soma;
    float media;
    denom = 0;
    soma = 0;
	printf("Comece a escrever os números para fazer média:\n");
    while(1) {
        scanf("%d", &num);
        if(num == 0) break;
        soma = soma + num;
        denom ++;
    }
    media = ((float)soma) / denom;
    printf("Média: %f\n", media);
	return 0;
}