#include <stdio.h>

float multInt (int n, float m){
    float r=0;
    while (n>0){
        if (n % 2 ){
            r += m;
        }
        n = n/2;
        m = m*2;
    }
    return r;
}

float main() {
    int n;
    float m, a;
    printf("Diga o número de vezes que quer multiplicar:\n");
    scanf("%d", &n);
    printf("Diga o número que quer multiplicar:\n");
    scanf("%f", &m);
    a = multInt (n, m);
    printf("O resultado é %f", a);
    return 0;
}

