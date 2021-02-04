#include <stdio.h>

void reverse(int n, int v[n]){
    int i, m, r;
    m = n - 1;
    r = 0
    for (i = 0; i <= m; i++){
        v[i] = v[m-i];
    }

}


int main() {
    int n = 5;
    int i, v[n];
    printf("Escreva 5 inteiros:\n ");
    for(i = 0; i < 5; ++i) {
        scanf("%d\n", &v[i]);
    }
    printf("Pela ordem inversa:\n ");
    reverse (n, v[n]);
    return 0;
}
