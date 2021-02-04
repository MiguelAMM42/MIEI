#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int perguntaRandom ( int nfrases ) {
    int num;
    num = ( rand() %nfrases ) ;
    return num;
}

int errado ( int np ) {
    if ( np == 0 ) {
        printf("Está errado!\nTente novamente:\n");
    }if ( np == 1 ) {
        printf("Erraste!\nTenta lá outra vez...\n");
    }if ( np == 2 ) {
        printf("Not correct mon ami...\nSe acertares dou-te 1 rebuçado...\n");
    }if ( np == 3 ) {
        printf("Tenho tempo...Mas se quiseres acertar na próxima tentativa, aceito:\n");
    }if ( np == 4 ) {
        printf("Água mole em pedra dura tanto bate até que fura...Tenta lá furar:\n");
    }
}

int correto ( int np ){
    if ( np == 0 ) {
        printf("Correto!\n");
    }if ( np == 1 ) {
        printf("Muy bien. Sua excelência está correta!\n");
    }if ( np == 2 ) {
        printf("Not bad...Temos matemático!\n");
    }if ( np == 3 ) {
        printf("Parafraseando Cristina Ferreira:ESTÁ CERTO!!!\n");
    }if ( np == 4 ) {
        printf("Gosto que acertes, mas tenta lá acertar esta:\n");
    }
}

int perguntas (int n , int m , int a , int b , int np , int np2 , int np3, int nfrases) {
    n = rand() % 10 + 1;
    m = rand() % 10 + 1;
    nfrases = 5;
    a = m * n;
    printf("Quanto é %d vezes %d?\n", n, m);
    scanf("%d", &b);
    while (a != b) {
        np2 = perguntaRandom(nfrases);
        errado(np2);
        printf("Quanto é %d vezes %d?\n", n, m);
        scanf("%d", &b);
    } if (a == b) {
        np =  perguntaRandom(nfrases);
        correto(np);
    }
}

int main() {
    srand(time(NULL));
    int n, m , a , b , np , np2 , np3 , nfrases;
    while ( 1 ) {
        perguntas( n , m , a , b , np , np2 , np3 , nfrases );
    }
    return 0;
}


