#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	int maior, num, segmaior;
	printf("Comece a escrever os números:\n");
    scanf("%d", &maior);
    while(1) {
        scanf("%d", &num);
        if(num == 0) break;
        if(num > maior) ((segmaior = maior) && (maior = num));
    }
    printf("2º. Maior: %d\n", segmaior);
	return 0;
}
