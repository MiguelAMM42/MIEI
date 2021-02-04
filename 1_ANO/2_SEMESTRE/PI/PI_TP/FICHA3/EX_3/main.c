#include <stdio.h>

void swap (int v[], int i, int j) {
    int temp = v[i];
    v[i] = v[j];
    v[j] = temp;
}

int main() {
    int x [15] = {1,  2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15};
    int n = 1;
    int m = 6;
    int i;
    swap(x, n ,m);
    for (i=0; i <15 ;i++){
        printf("%d ", x[i]);
    }
    return 0;
}
