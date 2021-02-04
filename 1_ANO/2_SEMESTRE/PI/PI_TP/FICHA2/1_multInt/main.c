#include <stdio.h>

float multInt (int n, float m){
    int i;
    float r=0;
    for (i=0; i<n; i++){
      r = r + m;
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
