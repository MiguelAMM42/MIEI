#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	int maior, num;
	printf("Comece a escrever os números:\n");
    scanf("%d", &maior);
    while(1) {
        scanf("%d", &num);
        if(num == 0) break;
        if(num > maior) maior = num;
    }
    printf("Maior: %d\n", maior);
	return 0;
}