#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int bitsUm (int n){
    int r = 0;
    while(n > 0) {
        r += (n % 2);
        n /= 2;
    }
    return r;
}


int main()
{
	return 0;
}
