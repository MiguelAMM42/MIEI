#include <stdio.h>
#include <stdlib.h>

void desenha_linha(int num_linhas, int latual){
    char a;
    int m, nespacos;
    nespacos = ( 2 * num_linhas ) + 1 - 2 * latual;
    for ( m = 1; m <= nespacos; m++){
        printf(" ");
    } for ( a = 'A'; a < 65 + latual; a ++) {
        printf("%c ", a);
    } for ( a = 63 + latual ; a >= 65; a-- ){
        printf( "%c ", a);
    }
}

void imprime_triangulo(int num_linhas){
    int i;
    for ( i = 1; i <= num_linhas; i ++ ){
        desenha_linha( num_linhas, i );
        printf( "\n" );
    }
}

void imprime_losango(int num_linhas) {
    int i;
    imprime_triangulo( num_linhas );
    for ( i = num_linhas - 1; i >= 1; i--) {
        desenha_linha( num_linhas, i );
        printf( "\n" );
    }
}


void desenha_linha_hexagono(int c_lado, int latual){
    int i, nespacos, m;
    m = c_lado + ( 2 * ( latual - 1 ) ) ;
    nespacos = c_lado - latual + 1;
    for ( i = 1; i <= nespacos; i++ ) {
        printf( " " );
    } for ( i = 1; i <= m ; i++){
        if ( (i == 1) || (i == m  ) || (latual == 1) || (latual == m ) ){
            putchar( '#' );
        }else printf( " " );
    }
}



void imprime_hexagono(int c_lado){
    int i;
    for ( i = 1; i <= c_lado; i++ ){
        desenha_linha_hexagono( c_lado, i );
        printf( "\n" );
    } for ( i = c_lado - 1; i >= 1; i--){
        desenha_linha_hexagono( c_lado, i );
        printf( "\n" );
    }
}

