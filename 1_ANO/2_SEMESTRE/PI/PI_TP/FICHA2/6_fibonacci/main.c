#include <stdio.h>

int fib(int n);
int fib2(int n);

int main() {
    int num, ex;
    printf("Escolha o número:\n");
    scanf ( "%d", &num);
    printf("escolha o ex.\n");
    scanf("%d", &ex);
    switch(ex){
        case 1:
            printf("O Resultado é %d\n", fib(num));
            break;
        case 2:
            printf("O Resultado é %d\n", fib2(num));
            break;
        default:
            printf("Ex. desconhecido\n");
            break;

    }
    return 0;
}


int fib (int n) {
    if(n == 1 || n == 2) return 1;
    else return fib(n - 1) + fib(n - 2);
}

int fib2(int n) {
    int temp, acc1 = 1, acc2 = 1;
    for(int i = 3; i <= n; i++) {
        temp = acc2;
        acc2 += acc1;
        acc1 = temp;
    }
    return acc2;
}