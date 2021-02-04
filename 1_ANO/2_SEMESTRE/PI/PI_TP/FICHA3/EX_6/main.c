#include <stdio.h>

void quadrados (int q[], int N) {
    for(int i = 0; i < N; i++) {
        q[i] = (i+1)*(i+1);
    }
}

int main() {
    printf("Hello, World!\n");
    return 0;
}
