#include <stdio.h>
#include <math.h>
int main( ) {
    int a, b, c;
    float s, area;
    printf("Introduza os comprimentos dos lados do triângulo!\n");
    scanf("%d %d %d", &a, &b, &c);
    s = (a + b + c) / 2.0;
    area = sqrt(s * (s - a) * (s - b) * (s - c));
    if ((fabs(b - c) < a) && (a < b + c) &&
        (fabs(a - c) < b) && (b < a + c) &&
        (fabs(b - a) < c) && (c < b + a)) {
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
    }
    else {
        printf("Não é um triângulo!\n");
        return 1;
    }
    return 0;
}
