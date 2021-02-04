#include <stdio.h>

void pascal (int v[], int N) {
    if(N == 1) v[0] = 1;
    else {
        int prevLine[N - 1];
        pascal(prevLine,N-1);
        v[0] = 1;
        v[N - 1] = 1;
        for(int i = 1; i < N - 1; i++) {
            v[i] = prevLine[i - 1] + prevLine[i];
        }
    }
}

int main() {
    printf("Hello, World!\n");
    return 0;
}
