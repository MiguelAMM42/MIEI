#include <stdio.h>


int mdc (int a, int b) {
    int temp, ans;
    if(a < b) {
        temp = a;
        a = b;
        b = temp;
    }
    for(int i = 1; i <= b; i++) {
        if(a % i == 0 && b % i == 0) ans = i;
    }
    return ans;
}

int mdc2 (int a, int b) {
    while(a != 0 && b != 0) {
        if(a > b) a -= b;
        else if (b > a) b -= a;
        else return a;
    }
    if(a == 0) return b;
    else return a;
}


int mdc3 (int a, int b) {
    while(a != 0 && b != 0) {
        if(a > b) a %= b;
        else if (b > a) b %= a;
        else return a;
    }
    if(a == 0) return b;
    else return a;
}

int main() {
    int n, m, funcao, ans;
    printf("Quero o máximo divisor comum entre:\n");
    scanf("%d", &n);
    printf("e:\n");
    scanf("%d", &m);
    printf("Quero calcular com a função(Escolher entre 1/2/3):\n");
    scanf ("%d", &funcao);
    switch(funcao) {
        case 1: ans = mdc(n, m); break;
        case 2: ans = mdc2(n, m); break;
        case 3: ans = mdc3(n, m); break;
        default: printf("Erro! Função desconhecida: %d\n", funcao);
    }
    printf("A resposta é %d", ans);
    return 0;
}


