#include <stdio.h>
#include <stdlib.h>
#include <string.h>



int trailingZ (unsigned int n) {
    if(n % 2) return 0;
    else return 1 + trailingZ(n / 2);
    // a função  trailingZ  calcula o número de bits a 0  no final da 
    // representação binária de um número (i.e., o expoente da maior 
    //  potência de 2 que é divisor desse número).
    return -1;
}