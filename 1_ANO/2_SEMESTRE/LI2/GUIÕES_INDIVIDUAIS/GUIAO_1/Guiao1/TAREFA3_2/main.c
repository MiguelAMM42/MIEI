#include <stdio.h>
#include <math.h>

void ordena(int *d, int *e, int *f) {
    if (*d < *e){
        int t = *e;
        *e = *d;
        *d = t;
    }
    if (*d < *f){
        int t = *f;
        *f = *d;
        *d = t;
    }
    if (*e < *f){
        int t = *f;
        *f = *d;
        *e = t;
    }
}

int main( ) {
    int a, b, c;
    float s, area;
    printf("Introduza os comprimentos dos lados do triângulo!\n");
    scanf("%d %d %d", &a, &b, &c);
    s = (a + b + c) / 2.0;
    area = sqrt(s * (s - a) * (s - b) * (s - c));
    ordena(&a, &b, &c);
    if ((fabs(b - c) < a) && (a < b + c) ) {
        printf("É um triângulo!\n");
        if ((a == b) && (b == c)) {
            printf("É um triângulo equilátero de área %f!\n", area);
        }else {
            if (((a == b) && (a != c)) || ((a == c) && (a != b)) || ((b == c) && (b != a))) {
                printf("É um triângulo isósceles de área %f!\n", area);
            } else {
                printf("É um triângulo escaleno de área %f!\n", area);
            }
        }
    }else {
        printf("Não é um triângulo!\n");
        return 1;
    }
    return 0;
}


