#include <stdio.h>


int maximum (int v[], int N, int *m) {
    if(N < 1) return 1;
    else {
        *m = v[0];
        for(int i = 0; i < N; i++) {
            if(v[i] > *m) {
                *m = v[i];
            }
        }
        return 0;
    }
}




int main() {
    printf("Hello, World!\n");
    return 0;
}
